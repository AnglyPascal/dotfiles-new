#!/usr/bin/env python3

import requests
from datetime import datetime, timedelta

# Location settings
CITY = "Oxford"
COUNTRY = "United Kingdom"
METHOD = 3
SCHOOL = 0

# Conky color tags
DEFAULT_COLOR = "${color}"
HIGHLIGHT_CURRENT = "${color2}"  # yellow
HIGHLIGHT_NEXT = "${color3}"  # orange

# Order of prayers
PRAYER_ORDER = ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"]


def get_datetime_today(time_str):
    """Parses a time string and returns a datetime object for today."""
    h, m = map(int, time_str.split(':'))
    now = datetime.now()
    return now.replace(hour=h, minute=m, second=0, microsecond=0)


try:
    url = f"https://api.aladhan.com/v1/timingsByCity?city={CITY}&country={COUNTRY}&method={METHOD}&school={SCHOOL}"
    response = requests.get(url, timeout=5)
    data = response.json()

    if data['code'] != 200:
        print("Failed to fetch prayer times")
        exit()

    timings = data['data']['timings']
    now = datetime.now()

    # Build a list of prayer name → datetime pairs
    prayers = [(name, get_datetime_today(timings[name]))
               for name in PRAYER_ORDER]

    # Handle wraparound from Isha to next day's Fajr
    fajr_time_tomorrow = prayers[0][1] + timedelta(days=1)
    prayers.append(("Fajr_next", fajr_time_tomorrow))

    isha_time_yesterday = prayers[4][1] - timedelta(days=1)
    prayers.insert(0, ("Isha_prev", isha_time_yesterday))

    # Find current and next prayer
    current_idx = None
    for i in range(len(prayers) - 1):
        start = prayers[i][1]
        end = prayers[i + 1][1]
        if start <= now < end:
            current_idx = i
            break

    if current_idx is None:
        exit()

    current_idx = 4 if current_idx == 0 else current_idx - 1
    next_idx = 0 if current_idx == 4 else current_idx + 1

    # Print with colors
    for i, (name, dt) in enumerate(prayers[1:-1]):  # exclude Fajr_next
        color = DEFAULT_COLOR
        font = ""
        default_font = "${font Share Tech Mono:size=12}"
        if i == current_idx:
            color = HIGHLIGHT_CURRENT
        elif i == next_idx:
            color = HIGHLIGHT_NEXT
            font = "${font Share Tech Mono:bold:size=14}"
        print(f"{color}{name:<9} {font}{dt.strftime('%H:%M')}{default_font}")

    print(DEFAULT_COLOR)  # Reset to default

except Exception as e:
    print("Error:", e)
