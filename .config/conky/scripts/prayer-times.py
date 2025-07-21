#!/usr/bin/env python3

import requests
from datetime import datetime, timedelta

# Location settings
CITY = "Dhaka"
COUNTRY = "Bangladesh"
METHOD = 3  # Calculation method

# Conky color tags
DEFAULT_COLOR = "${color}"
HIGHLIGHT_CURRENT = "${color2}"  # yellow
HIGHLIGHT_NEXT = "${color3}"  # orange

# Order of entries (Asr1 = Shafi, Asr2 = Hanafi)
PRAYER_ORDER = [
    "Fajr", "Sunrise", "Dhuhr", "Asr S", "Asr H", "Maghrib", "Isha"
]


def get_datetime_today(time_str):
    """Parses a time string and returns a datetime object for today."""
    h, m = map(int, time_str.split(":"))
    now = datetime.now()
    return now.replace(hour=h, minute=m, second=0, microsecond=0)


def fetch_timings(school):
    """Fetches prayer timings from the API for a given school (0=Shafi, 1=Hanafi)."""
    url = (f"https://api.aladhan.com/v1/timingsByCity"
           f"?city={CITY}&country={COUNTRY}&method={METHOD}&school={school}")
    response = requests.get(url, timeout=5)
    data = response.json()
    if data["code"] != 200:
        raise ValueError("Failed to fetch prayer times")
    return data["data"]["timings"]


try:
    timings_shafi = fetch_timings(school=0)
    timings_hanafi = fetch_timings(school=1)
    now = datetime.now()

    # Build combined timings
    prayer_times = {
        "Fajr": get_datetime_today(timings_shafi["Fajr"]),
        "Sunrise": get_datetime_today(timings_shafi["Sunrise"]),
        "Dhuhr": get_datetime_today(timings_shafi["Dhuhr"]),
        "Asr S": get_datetime_today(timings_shafi["Asr"]),
        "Asr H": get_datetime_today(timings_hanafi["Asr"]),
        "Maghrib": get_datetime_today(timings_shafi["Maghrib"]),
        "Isha": get_datetime_today(timings_shafi["Isha"]),
    }

    # Handle wraparound
    fajr_next = prayer_times["Fajr"] + timedelta(days=1)
    isha_prev = prayer_times["Isha"] - timedelta(days=1)

    prayers = [("Isha_prev", isha_prev)]
    prayers += [(name, prayer_times[name]) for name in PRAYER_ORDER]
    prayers.append(("Fajr_next", fajr_next))

    # Find current and next prayer/event
    next_prayer = 0
    while next_prayer < len(prayers) - 1:
        if prayers[next_prayer][1] > now:
            break
        next_prayer += 1

    next_prayer -= 1
    curr_prayer = (next_prayer - 1) % len(prayer_times)

    # Output
    for i, (name,
            dt) in enumerate(prayers[1:-1]):  # skip Isha_prev and Fajr_next
        color = DEFAULT_COLOR
        font = ""
        default_font = "${font Share Tech Mono:size=12}"
        if i == curr_prayer:
            color = HIGHLIGHT_CURRENT
        elif i == next_prayer:
            color = HIGHLIGHT_NEXT
            font = "${font Share Tech Mono:bold:size=14}"
        print(f"{color}{name:<9} {font}{dt.strftime('%H:%M')}{default_font}")

    print(DEFAULT_COLOR)  # Reset

except Exception as e:
    print("Error")
