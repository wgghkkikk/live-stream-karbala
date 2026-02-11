name: Live Stream Karbala
on:
  workflow_dispatch:
jobs:
  stream:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Install FFmpeg
        run: sudo apt-get update && sudo apt-get install -y ffmpeg

      - name: Run Stream Script
        run: |
          while true; do
            # توقيت بغداد (UTC+3)
            current_time=$(date -u -d "+3 hours" +%H:%M)
            echo "Current Time in Baghdad: $current_time"

            if [[ "$current_time" > "12:15" && "$current_time" < "12:30" ]]; then
              FILE="dhur.mp4"
              # كص أول دقيقتين ومسح لوجو باب الرجاء
              ffmpeg -re -i "$FILE" -t 120 -vf "delogo=x=10:y=10:w=150:h=60" -c:v libx264 -preset ultrafast -b:v 2500k -c:a aac -f flv "rtmp://a.rtmp.youtube.com/live2/q12g-s6wc-0y03-0ua5-6e6p"
            elif [[ "$current_time" > "18:00" && "$current_time" < "18:30" ]]; then
              FILE="maghrib.mp4"
              ffmpeg -re -i "$FILE" -c:v libx264 -preset ultrafast -b:v 2500k -c:a aac -f flv "rtmp://a.rtmp.youtube.com/live2/q12g-s6wc-0y03-0ua5-6e6p"
            elif [[ "$current_time" > "07:00" && "$current_time" < "09:00" ]]; then
              FILE="sabah.mp4"
              ffmpeg -re -i "$FILE" -c:v libx264 -preset ultrafast -b:v 2500k -c:a aac -f flv "rtmp://a.rtmp.youtube.com/live2/q12g-s6wc-0y03-0ua5-6e6p"
            else
              FILE="main_live.mp4"
              ffmpeg -re -i "$FILE" -c:v libx264 -preset ultrafast -b:v 2500k -c:a aac -f flv "rtmp://a.rtmp.youtube.com/live2/q12g-s6wc-0y03-0ua5-6e6p"
            fi
            sleep 5
          done
