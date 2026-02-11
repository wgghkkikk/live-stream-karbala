name: Live Stream Karbala
on:
  workflow_dispatch:
jobs:
  stream:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Install FFmpeg
        run: sudo apt-get update && sudo apt-get install -y ffmpeg

      - name: Start Live
        run: |
          while true; do
            current_time=$(date +%H:%M)
            # 1. أذان الظهر (12:15 - 12:30) مع كص أول دقيقتين ومسح اللوجو
            if [[ "$current_time" > "12:15" && "$current_time" < "12:30" ]]; then
              ffmpeg -re -i dhur.mp4 -t 120 -vf "delogo=x=10:y=10:w=150:h=60" -c:v libx264 -preset ultrafast -b:v 2000k -c:a aac -f flv "rtmp://a.rtmp.youtube.com/live2/q12g-s6wc-0y03-0ua5-6e6p"
            # 2. أذان المغرب
            elif [[ "$current_time" > "18:00" && "$current_time" < "18:30" ]]; then
              ffmpeg -re -i maghrib.mp4 -c:v libx264 -preset ultrafast -b:v 2000k -c:a aac -f flv "rtmp://a.rtmp.youtube.com/live2/q12g-s6wc-0y03-0ua5-6e6p"
            # 3. دعاء الصباح
            elif [[ "$current_time" > "07:00" && "$current_time" < "09:00" ]]; then
              ffmpeg -re -i sabah.mp4 -c:v libx264 -preset ultrafast -b:v 2000k -c:a aac -f flv "rtmp://a.rtmp.youtube.com/live2/q12g-s6wc-0y03-0ua5-6e6p"
            # 4. البث العام (الوقت الحالي - ليل)
            else
              ffmpeg -re -i main_live.mp4 -c:v libx264 -preset ultrafast -b:v 2000k -c:a aac -f flv "rtmp://a.rtmp.youtube.com/live2/q12g-s6wc-0y03-0ua5-6e6p"
            fi
            sleep 5
          done
