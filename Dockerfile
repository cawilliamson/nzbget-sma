FROM linuxserver/nzbget:latest

RUN apk add ffmpeg git py-pip

RUN git clone --depth=1 https://github.com/mdhiggins/sickbeard_mp4_automator.git /mp4-automator

RUN pip install --upgrade enum34 pip setuptools
RUN pip install -r /mp4-automator/setup/requirements.txt

RUN find /mp4-automator -type d -exec chmod 777 {} ;\
RUN find /mp4-automator -type f -exec chmod 666 {} ;\
