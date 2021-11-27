FROM ubuntu:focal as builder

RUN apt update && \
    apt install -y curl && \
    curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh --output get.sh && \
    chmod a+x ./get.sh && \
    ./get.sh


FROM ubuntu:focal

# Arguments
ARG DEBIAN_FRONTEND=noninteractive
ARG USER_ID
ARG GROUP_ID
ARG INSTALL_GAMEDIG=false

# Install dependencies
RUN dpkg --add-architecture i386 && \
	apt update && \
    apt install -y nano \
    			   python3 \
    			   libx11-6 \
    			   libxext6 \
    			   curl \
    			   wget \
    			   file \
    			   tar \
    			   bzip2 \
    			   gzip \
    			   unzip \
    			   bsdmainutils \
    			   python \
    			   util-linux \
    			   ca-certificates \
    			   binutils \
    			   bc \
    			   jq \
    			   tmux \
    			   netcat \
    			   lib32gcc1 \
    			   lib32stdc++6 && \
    rm -rf /var/lib/apt/lists/*

# Install Gamedig (optional): https://docs.linuxgsm.com/requirements/gamedig?_ga=2.245166405.1118399954.1637934271-78951660.1637934271
RUN if [[ "$arg" = true ]] ; then \
		echo "Todo: install Gamedig" ; \
	else \
		echo "Gamedig will not be installed!" \
	; fi

# Define unreal user
RUN addgroup --gid $GROUP_ID unreal
RUN adduser --home /home/unreal/ --shell /bin/bash --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID unreal
RUN chown -R unreal /home/unreal && \
	chgrp -R unreal /home/unreal && \
    adduser unreal sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER unreal
RUN mkdir -p /home/unreal/ut99/ && chown -R unreal /home/unreal/ut99 && chgrp -R unreal /home/unreal/ut99/

# Define working directory
WORKDIR /home/unreal/ut99

# Download LinuxGSM for UT99
RUN wget -O linuxgsm.sh https://linuxgsm.sh && \
	chmod a+x linuxgsm.sh && \
	bash linuxgsm.sh ut99server

# Install LinuxGSM for UT99
RUN chmod a+x ut99server && \
	./ut99server auto-install

# Expose ports
EXPOSE 7777/tcp
EXPOSE 7777/udp
EXPOSE 7778/tcp
EXPOSE 7778/udp
EXPOSE 7779/tcp
EXPOSE 7779/udp
EXPOSE 8075/tcp
EXPOSE 8075/udp
EXPOSE 8076/tcp
EXPOSE 8076/udp
EXPOSE 8077/tcp
EXPOSE 8077/udp
EXPOSE 28900/tcp
EXPOSE 28900/udp
EXPOSE 28901/tcp
EXPOSE 28901/udp
EXPOSE 28902/tcp
EXPOSE 28902/udp
EXPOSE 8080/tcp

USER root
COPY --from=builder /usr/local/bin/filebrowser /filebrowser
RUN mkdir -p -m 777 /config
COPY ./entrypoint.sh entrypoint.sh
RUN chmod a+x entrypoint.sh && chown unreal:unreal entrypoint.sh
USER unreal
RUN pwd && whoami && ls -lah

# Run the server
CMD ["./ut99server", "start"]
ENTRYPOINT ./entrypoint.sh