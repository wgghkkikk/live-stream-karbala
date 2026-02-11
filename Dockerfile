name: Test Stream
on:
  workflow_dispatch:
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: sudo apt-get install -y ffmpeg
      - run: |
          ffmpeg -re -i "main_live.mp4" -c:v libx264 -preset ultrafast -b:v 2000k -f flv "rtmp://a.rtmp.youtube.com/live2/q12g-s6wc-0y03-0ua5-6e6p"
