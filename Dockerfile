name: Stream To YouTube
on:
  workflow_dispatch:
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      - name: Start Live Stream
        run: |
          sudo apt update && sudo apt install -y ffmpeg
          # ملاحظة: استبدل الرابط اللي تحت برابط البث المباشر الفعلي للعتبة
          ffmpeg -re -i "https://اسم_رابط_البث_المباشر/playlist.m3u8" -c:v libx264 -preset ultrafast -b:v 1500k -c:a aac -b:a 128k -f flv "rtmp://a.rtmp.youtube.com/live2/q12g-s6wc-0y03-0ua5-6e6p"
