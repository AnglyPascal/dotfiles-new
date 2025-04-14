#!/usr/bin/env python3

import requests
from datetime import date

# Change this to your actual location
CITY = "Oxford"
COUNTRY = "United Kingdom"
METHOD = 3

url = f"https://api.aladhan.com/v1/timingsByCity?city={CITY}&country={COUNTRY}&method={METHOD}"

try:
    response = requests.get(url, timeout=5)
    data = response.json()

    if data['code'] == 200:
        timings = data['data']['timings']
        print("Fajr:    ", timings['Fajr'])
        print("Dhuhr:   ", timings['Dhuhr'])
        print("Asr:     ", timings['Asr'])
        print("Maghrib: ", timings['Maghrib'])
        print("Isha:    ", timings['Isha'])
    else:
        print("Failed to fetch prayer times")

except Exception as e:
    print("Error:", e)
