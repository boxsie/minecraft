FROM adoptopenjdk/openjdk11:debian-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
                git \
                openssh-client \
                build-essential \
                gnupg \
                ca-certificates \
                curl \
                wget \
                apt-transport-https \
                zip \
                unzip \
        && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    apt-get update && apt-get install -y \
        google-cloud-sdk

WORKDIR /minecraft

ENV BT_JAR BuildTools.jar
ENV BT_URL -O $BT_JAR https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

RUN wget $BT_URL
RUN chmod +x $BT_JAR

RUN java -jar $BT_JAR

COPY ./ ./
RUN chmod +x start.sh

CMD ./start.sh