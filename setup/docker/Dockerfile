FROM ubuntu:20.04 AS robocon-embedded-course-build

# Needed for tzdata related installs
ENV DEBIAN_FRONTEND="noninteractive"
ENV TZ="America/Denver"

RUN apt-get update && \
    apt-get install -y \
    wget tar gcc g++ \
    make \
    bison \
    m4 \
    libgmp-dev \
    flex \
    build-essential \
    autoconf \
    zlib1g-dev \
    file \
    texinfo

RUN mkdir -p /usr/src/app

ADD setup.sh /usr/src/app

RUN /usr/src/app/setup.sh

FROM ubuntu:20.04 AS robocon-embedded-course

# Needed for tzdata related installs
ENV DEBIAN_FRONTEND="noninteractive"
ENV TZ="America/Denver"

RUN apt-get update && \
    apt-get install -y \
    wget tar gcc g++ \
    make \
    build-essential \
    file \
    qemu-system-arm

RUN mkdir -p /usr/local/cross-compiler

COPY --from=robocon-embedded-course-build /usr/local/cross-compiler/ /usr/local/cross-compiler/

RUN echo PATH=$PATH:/usr/local/cross-compiler/bin >> ~/.bashrc

RUN mkdir -p /data

WORKDIR /data

ENTRYPOINT [ "/bin/bash" ]