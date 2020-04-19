FROM ubuntu:18.04

WORKDIR /usr/

# Install essential components
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install build-essential
RUN apt-get -y install libssl-dev
RUN apt-get -y install wget

# Install CMake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.17.1/cmake-3.17.1.tar.gz
RUN tar -xzvf cmake-3.17.1.tar.gz

WORKDIR /usr/cmake-3.17.1/

RUN ./bootstrap
RUN make install

WORKDIR /usr/

RUN rm -rf ./cmake-3.17.1/
RUN rm -rf ./cmake-3.17.1.tar.gz

# Install Boost 1.69
WORKDIR /usr/include/

RUN wget https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.gz
RUN tar -zxvf boost_1_69_0.tar.gz

WORKDIR /usr/include/boost_1_69_0/

RUN ./bootstrap.sh
RUN ./b2

WORKDIR /usr/include

RUN rm -rf ./boost_1_69_0.tar.gz

# Install Boost 1.72
WORKDIR /usr/include/

RUN wget https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.gz
RUN tar -zxvf boost_1_72_0.tar.gz

WORKDIR /usr/include/boost_1_72_0/

RUN ./bootstrap.sh
RUN ./b2

WORKDIR /usr/include

RUN rm -rf ./boost_1_72_0.tar.gz

# Set environment variables
ENV BOOST_ROOT_1_69_0=/usr/include/boost_1_69_0/
ENV BOOST_ROOT_1_72_0=/usr/include/boost_1_72_0/

# Change working directory in the end
WORKDIR /usr/