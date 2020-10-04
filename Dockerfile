# 智慧宅繼電器控制MQTT服務伺服器
FROM ubuntu:bionic

# 安裝好Ubuntu後需要的動作
RUN apt-get update
# 設定預設語系和編碼為UTF-8
# https://stackoverflow.com/questions/28405902/how-to-set-the-locale-inside-a-debian-ubuntu-docker-container
# https://medium.com/@adsl8212/%E5%A6%82%E4%BD%95%E4%BF%AE%E6%94%B9docker-container%E5%85%A7%E7%9A%84%E8%AA%9E%E7%B3%BB-b3a0cef0b810
RUN apt install locales && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
    python3-rpi.gpio python3-pip python3-setuptools \
    python3 python3-dev \
    g++

# bdist_wheel必要套件
RUN pip3 install wheel

# Flask伺服器
RUN pip3 install \
    Flask Flask-Bootstrap Flask-MQTT Flask-SocketIO

# relay硬體控制
RUN pip3 install pi-plates spidev

RUN python3 --version

COPY ./example.py /app/app.py
EXPOSE 5000

CMD [ "python3", "-u", "/app/app.py" ]