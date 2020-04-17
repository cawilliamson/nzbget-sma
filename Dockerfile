FROM linuxserver/nzbget:latest

RUN apk add ffmpeg git

RUN git clone --depth=1 https://github.com/mdhiggins/sickbeard_mp4_automator.git /mp4-automator

RUN pip install --upgrade pip setuptools
RUN pip install -r /mp4-automator/setup/requirements.txt
