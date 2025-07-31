#!/bin/bash

# Fetch weather data from wttr.in
location=$(cat /run/secrets/weather/location) # Replace with your location or dynamic location logic
weather_emoji=$(curl -s --connect-timeout 5 "wttr.in/$location?format=%c" 2>/dev/null | xargs)
weather_data=$(curl -s --connect-timeout 5 "wttr.in/$location?format=j1" 2>/dev/null)

# Check if curl failed or returned empty/invalid data
if [ $? -ne 0 ] || [ -z "$weather_emoji" ] || [ -z "$weather_data" ] || ! echo "$weather_data" | jq -e . >/dev/null 2>&1; then
    echo "{\"text\": \"Weather unavailable\", \"tooltip\": \"Failed to fetch weather data\", \"location\": \"$location\"}"
    exit 0
fi

# Extract relevant fields
temp=$(echo "$weather_data" | jq -r '.current_condition[0].temp_C')
condition=$(echo "$weather_data" | jq -r '.current_condition[0].weatherDesc[0].value')
humidity=$(echo "$weather_data" | jq -r '.current_condition[0].humidity')

# Format the main display text
text="$weather_emoji ${temp}°C"

# Format the tooltip summary
tooltip="$location: $condition $weather_emoji, ${temp}°C, Humidity: $humidity%"

# Output JSON with text, tooltip, and location
echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"location\": \"$location\"}"
