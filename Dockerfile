FROM python:3.10-slim
RUN apt-get update && apt-get install -y ffmpeg curl && pip install --upgrade yt-dlp
WORKDIR /app
COPY newtab_cookies.txt /app/newtab_cookies.txt
CMD url=$(yt-dlp --cookies /app/newtab_cookies.txt --geo-bypass --no-check-certificate -f "best" -g "http://www.youtube.com/watch?v=IQgM5PYvRYA") && \
    ffmpeg -re -i "$url" -c:v libx264 -preset ultrafast -b:v 1500k -maxrate 1500k -bufsize 3000k -f flv "rtmp://a.rtmp.youtube.com/live2/q12g-s6wc-0y03-0ua5-6e6p"
