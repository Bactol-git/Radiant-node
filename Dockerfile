FROM ubuntu:22.04

LABEL maintainer="Bactol" name="Radiant Node" version="0.1"

# Update image and get dependencies
RUN apt update -y && apt upgrade -y && apt-get install build-essential cmake git libboost-chrono-dev \
	libboost-filesystem-dev libboost-test-dev libboost-thread-dev libevent-dev libminiupnpc-dev \ 
	libssl-dev libzmq3-dev help2man ninja-build python3 libdb-dev libdb++-dev -y \ 
	&& apt-get clean autoclean && apt-get autoremove

# Clone git repo and build the node	
RUN git clone https://github.com/radiantblockchain/radiant-node.git \
    && cd radiant-node/ && mkdir build && cd build && cmake -GNinja .. -DBUILD_RADIANT_WALLET=OFF -DBUILD_RADIANT_QT=OFF && ninja \
    && cp src/radiant* /usr/local/bin/ && mkdir ~/.radiant && touch ~/.radiant/radiant.conf \
    && bash -c "echo rpcuser=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)>> ~/.radiant/radiant.conf" \
    && bash -c "echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)>> ~/.radiant/radiant.conf" \
    && bash -c "echo listen=1 >> ~/.radiant/radiant.conf" && bash -c "echo server=1 >> ~/.radiant/radiant.conf" && bash -c "echo daemon=1 >> ~/.radiant/radiant.conf" \
    && bash -c "echo maxconnections=16 >> ~/.radiant/radiant.conf" && cd

# Create script that starts radiantd and then sleeps to keep a process running and keep the container alive    
RUN touch start.sh && echo '#!/bin/sh' | cat > start.sh && sh -c "echo 'radiantd && sleep infinity' >> start.sh"
RUN chmod +x start.sh

CMD ./start.sh
