# FROM phusion/baseimage
FROM ubuntu:xenial

ENV UBUNTU_VER xenial
ENV TERM xterm-color
ENV JAVA_VER 8
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV SCALA_VERSION 2.12.10
ENV SCALA_TARBALL http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb  

# Install java
# RUN echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu $UBUNTU_VER main' > /etc/apt/sources.list.d/webupd8team-ubuntu-java.list && \
#     echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu $UBUNTU_VER main' > /etc/apt/sources.list.d/webupd8team-ubuntu-java-src.list && \
#     apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886 99E82A75642AC823 && \
#     apt-get update 

# get latests from repo
RUN apt-get update

RUN apt-get install -y locales openjdk-8-jdk

# RUN apt-get update && apt-get install -y software-properties-common sudo

# RUN add-apt-repository ppa:webupd8team/java -y && apt-get update

# RUN apt-get install --allow-change-held-packages --no-install-recommends sudo

# RUN echo oracle-java${JAVA_VER}-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections && \
#     apt-get install -y --allow-change-held-packages --no-install-recommends oracle-java${JAVA_VER}-installer oracle-java${JAVA_VER}-set-default oracle-java${JAVA_VER}-unlimited-jce-policy

RUN echo "==> Install curl helper tool..." && \  
# apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y curl

RUN echo "===> curling ${SCALA_TARBALL}" && \ 
curl -sSL $SCALA_TARBALL -o scala.deb

RUN echo "===> install Scala" && \  
dpkg -i scala.deb

RUN echo "===> clean up..." && \  
rm -f *.deb && \  
apt-get remove -y --auto-remove curl && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  

COPY . /root  
WORKDIR /root  

RUN java -version
RUN scala -version
RUN locale-gen en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
