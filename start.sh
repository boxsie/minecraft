#!/bin/sh

if [ "$(ls /minecraft/world)" ]; then
    echo "Minecraft world exitsts"
else
    echo "Downloading Minecraft world"
    gcloud auth activate-service-account --key-file ${GOOGLE_APPLICATION_CREDENTIALS}
    gsutil cp gs://${BUCKET_PATH}/${WORLD_ZIP} /minecraft/${WORLD_ZIP}
    gsutil cp gs://${BUCKET_PATH}/server.properties /minecraft/server.properties
    gsutil cp gs://${BUCKET_PATH}/whitelist.json /minecraft/whitelist.json

    unzip /minecraft/${WORLD_ZIP} -d /minecraft
fi

java -Xmx1024M -Xms1024M -XX:+UseG1GC -jar spigot-1.16.5.jar nogui