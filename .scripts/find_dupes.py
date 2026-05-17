#!/usr/bin/env python3
"""
Perceptual image duplicate finder.

For each group of duplicates:
  - Keeps the largest file (by byte size)
  - Moves all others to <root>/dupes/<relative/path/to/keeper_stem>/

Usage:
    python find_dupes.py <directory> [options]

Options:
    --threshold INT     Hamming distance threshold (default: 10)
    --algo ALGO         Hash algorithm: dhash, phash, ahash, whash (default: dhash)
    --recursive         Search subdirectories recursively
    --dry-run           Print what would happen without moving anything
    --feh               (requires --dry-run) Open each duplicate group in feh before proceeding
    --extensions LIST   Comma-separated extensions to scan (default: jpg,jpeg,png,webp,bmp,tiff,gif)
"""

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path
from itertools import combinations

try:
    from PIL import Image
    import imagehash
except ImportError:
    print("Missing dependencies. Install with:")
    print("  pip install Pillow imagehash")
    sys.exit(1)


ALGO_MAP = {
    "dhash": imagehash.dhash,
    "phash": imagehash.phash,
    "ahash": imagehash.average_hash,
    "whash": imagehash.whash,
}

DEFAULT_EXTENSIONS = {"jpg", "jpeg", "png", "webp", "bmp", "tiff", "gif"}

FEH_OPTS = [
    "-D", "-1",
    "--image-bg", "black",
    "--geometry", "1400x1000",
    "--scale-down",
    "-Z",
    "--auto-rotate",
]


def open_feh(images: list[Path]) -> None:
    cmd = ["/usr/bin/feh"] + FEH_OPTS + [str(p) for p in images]
    try:
        subprocess.run(cmd, check=False)
    except FileNotFoundError:
        print("  Warning: /usr/bin/feh not found. Skipping preview.")
    except KeyboardInterrupt:
        pass


def collect_images(directory: Path, recursive: bool, extensions: set[str]) -> list[Path]:
    pattern = "**/*" if recursive else "*"
    paths = []
    for p in directory.glob(pattern):
        if p.is_file() and p.suffix.lstrip(".").lower() in extensions:
            paths.append(p)
    return sorted(paths)


def compute_hashes(images: list[Path], hash_fn) -> dict[Path, imagehash.ImageHash]:
    hashes = {}
    failed = []
    total = len(images)
    for i, p in enumerate(images, 1):
        print(f"\r  Hashing {i}/{total} ...", end="", flush=True)
        try:
            hashes[p] = hash_fn(Image.open(p))
        except Exception as e:
            failed.append((p, str(e)))
    print()
    if failed:
        print(f"  Warning: failed to hash {len(failed)} file(s):")
        for p, err in failed:
            print(f"    {p}: {err}")
    return hashes


def find_duplicate_groups(
    hashes: dict[Path, imagehash.ImageHash], threshold: int
) -> list[list[Path]]:
    """
    Union-Find clustering: group images whose pairwise hamming distance <= threshold.
    O(n^2) comparisons — acceptable for typical photo libraries up to ~50k images.
    """
    paths = list(hashes.keys())
    parent = {p: p for p in paths}

    def find(x):
        while parent[x] != x:
            parent[x] = parent[parent[x]]
            x = parent[x]
        return x

    def union(x, y):
        parent[find(x)] = find(y)

    n = len(paths)
    comparisons = n * (n - 1) // 2
    print(f"  Comparing {n} images ({comparisons:,} pairs) ...")

    for a, b in combinations(paths, 2):
        if abs(hashes[a] - hashes[b]) <= threshold:
            union(a, b)

    groups: dict[Path, list[Path]] = {}
    for p in paths:
        root = find(p)
        groups.setdefault(root, []).append(p)

    return [g for g in groups.values() if len(g) > 1]


def dupe_dir_for(keeper: Path, root: Path) -> Path:
    """
    Compute the dupe folder path for a given keeper file.

    Structure: <root>/dupes/<relative/path/to/keeper_stem>/

    Examples (root = /photos):
      keeper /photos/image.jpg          -> /photos/dupes/image/
      keeper /photos/foo/bar/img.jpg    -> /photos/dupes/foo/bar/img/
    """
    rel = keeper.relative_to(root)          # e.g. foo/bar/img.jpg
    rel_stem = rel.parent / rel.stem        # e.g. foo/bar/img
    return root / "dupes" / rel_stem


def move_duplicates(
    groups: list[list[Path]], root: Path, dry_run: bool, use_feh: bool
) -> None:
    total_moved = 0
    total_freed = 0
    total_groups = len(groups)

    for i, group in enumerate(groups, 1):
        keeper = max(group, key=lambda p: p.stat().st_size)
        dupes = [p for p in group if p != keeper]

        dupe_dir = dupe_dir_for(keeper, root)

        print(f"\n  Group {i}/{total_groups}")
        print(f"  KEEP:  {keeper}  ({keeper.stat().st_size:,} bytes)")
        print(f"  DIR:   {dupe_dir}")
        for d in dupes:
            size = d.stat().st_size
            dest = dupe_dir / d.name
            if dest.exists():
                stem, suffix = d.stem, d.suffix
                counter = 1
                while dest.exists():
                    dest = dupe_dir / f"{stem}_{counter}{suffix}"
                    counter += 1
            print(f"  MOVE:  {d}  ({size:,} bytes)  ->  {dest}")
            total_moved += 1
            total_freed += size

        if use_feh:
            print(f"  Opening feh for group {i}/{total_groups} (close feh to continue) ...")
            open_feh([keeper] + dupes)

        if not dry_run:
            dupe_dir.mkdir(parents=True, exist_ok=True)
            for d in dupes:
                dest = dupe_dir / d.name
                if dest.exists():
                    stem, suffix = d.stem, d.suffix
                    counter = 1
                    while dest.exists():
                        dest = dupe_dir / f"{stem}_{counter}{suffix}"
                        counter += 1
                shutil.move(str(d), str(dest))

    print(f"\n{'[DRY RUN] ' if dry_run else ''}Summary:")
    print(f"  Duplicate groups : {total_groups}")
    print(f"  Files moved      : {total_moved}")
    print(f"  Space reclaimable: {total_freed / 1024 / 1024:.2f} MB")


def main():
    parser = argparse.ArgumentParser(
        description="Find and quarantine perceptual image duplicates."
    )
    parser.add_argument("directory", type=Path, help="Directory to scan")
    parser.add_argument(
        "--threshold", type=int, default=10,
        help="Hamming distance threshold (default: 10). Lower = stricter."
    )
    parser.add_argument(
        "--algo", choices=ALGO_MAP.keys(), default="dhash",
        help="Perceptual hash algorithm (default: dhash)"
    )
    parser.add_argument(
        "--recursive", action="store_true",
        help="Scan subdirectories recursively"
    )
    parser.add_argument(
        "--dry-run", action="store_true",
        help="Simulate without moving any files"
    )
    parser.add_argument(
        "--feh", action="store_true",
        help="(requires --dry-run) Open each duplicate group in feh. Close feh to advance to the next group."
    )
    parser.add_argument(
        "--extensions", type=str, default=None,
        help="Comma-separated file extensions to scan (default: jpg,jpeg,png,webp,bmp,tiff,gif)"
    )
    args = parser.parse_args()

    if args.feh and not args.dry_run:
        print("Error: --feh requires --dry-run.")
        sys.exit(1)

    if not args.directory.is_dir():
        print(f"Error: '{args.directory}' is not a valid directory.")
        sys.exit(1)

    root = args.directory.resolve()

    extensions = (
        set(args.extensions.lower().split(","))
        if args.extensions
        else DEFAULT_EXTENSIONS
    )

    print(f"Scanning : {root}")
    print(f"Algorithm: {args.algo}  |  Threshold: {args.threshold}  |  Recursive: {args.recursive}")
    if args.dry_run:
        print(f"Mode     : DRY RUN (no files will be moved){' + feh preview' if args.feh else ''}")
    print()

    print("Step 1/3: Collecting images ...")
    images = collect_images(root, args.recursive, extensions)
    print(f"  Found {len(images)} image(s)")

    if len(images) < 2:
        print("Not enough images to compare. Exiting.")
        sys.exit(0)

    print("\nStep 2/3: Computing perceptual hashes ...")
    hashes = compute_hashes(images, ALGO_MAP[args.algo])

    print("\nStep 3/3: Finding duplicate groups ...")
    groups = find_duplicate_groups(hashes, args.threshold)
    print(f"  Found {len(groups)} duplicate group(s)")

    if not groups:
        print("\nNo duplicates found.")
        sys.exit(0)

    print("\nProcessing duplicates ...")
    move_duplicates(groups, root=root, dry_run=args.dry_run, use_feh=args.feh)

    if args.dry_run:
        print("\nRe-run without --dry-run to actually move files.")


if __name__ == "__main__":
    main()
