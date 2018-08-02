FROM nodered/node-red-docker:rpi

USER root

WORKDIR /usr/src/node-red

# ---- ZWAVE ----

# Install latest OpenZwave library
RUN apt-get update
RUN apt-get -y install libudev-dev iproute2
RUN	mkdir -pv /usr/src/
RUN git clone https://github.com/OpenZWave/open-zwave.git /usr/src/open-zwave
RUN cd /usr/src/open-zwave && make && make install
ENV LD_LIBRARY_PATH /usr/local/lib
RUN ldconfig /usr/local/lib

# User configuration directory volume
EXPOSE 1880

# Environment variable holding file path for flows configuration
ENV FLOWS=flows.json

CMD ["npm", "start", "--", "--userDir", "/data"]
