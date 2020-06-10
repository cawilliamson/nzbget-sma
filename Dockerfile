FROM linuxserver/nzbget:latest

# install dependencies
RUN apk add curl git python2

# install pip2
RUN curl https://bootstrap.pypa.io/get-pip.py -o /var/tmp/get-pip.py
RUN python2 /var/tmp/get-pip.py
RUN rm -f /var/tmp/get-pip.py

# install mp4-automator
RUN git clone --depth=1 https://github.com/mdhiggins/sickbeard_mp4_automator.git /mp4-automator

# install mp4-automator dependencies
RUN pip2 install --upgrade enum34 setuptools
RUN pip2 install -r /mp4-automator/setup/requirements.txt

# fix mp4-automator permissions
RUN find /mp4-automator -type d -exec chmod 777 {} \;
RUN find /mp4-automator -type f -exec chmod 666 {} \;

# install ffmpeg
RUN wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz -O /var/tmp/ffmpeg.tar.xz && \
  tar -xJf /var/tmp/ffmpeg.tar.xz -C /usr/local/bin --strip-components 1 && \
  chgrp users /usr/local/bin/ffmpeg && \
  chgrp users /usr/local/bin/ffprobe && \
  chmod g+x /usr/local/bin/ffmpeg && \
  chmod g+x /usr/local/bin/ffprobe && \
  rm -rf /var/tmp/ffmpeg.tar.xz

# symlink autoprocess config
RUN rm -f /mp4-automator/config/autoProcess.ini && \
  ln -sf /config/autoProcess.ini /mp4-automator/config/autoProcess.ini
