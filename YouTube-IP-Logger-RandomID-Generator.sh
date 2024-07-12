#!/bin/bash

generate_random_id() {
    cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9-_ ' | head -c 11
}

fetch_logger_info() {
    API_KEY="Your_API_Key_Here"  # Replace with your actual API key
    VIDEO_ID=$(generate_random_id)

    echo "Generated Video ID: $VIDEO_ID"

    response=$(curl -s -X GET "https://api.c99.nl/iplogger?key=$API_KEY&action=viewloggers&type=youtube&token=$VIDEO_ID&json")

    success=$(echo "$response" | jq -r '.success')

    if [ "$success" = "true" ]; then
        video_url=$(echo "$response" | jq -r '.loggers[] | select(.type == "youtube") | .logger')
        logs_url=$(echo "$response" | jq -r '.loggers[] | select(.type == "youtube") | .logs')

        echo "Video URL: $video_url"
        echo "Logs URL: $logs_url"
    else
        echo "Error: Failed to fetch logger information. Check your API key and video ID."
    fi
}

fetch_logger_info

