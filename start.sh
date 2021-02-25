#!/bin/sh

gcloud auth activate-service-account --key-file ${GOOGLE_APPLICATION_CREDENTIALS}

gsutil cp gs://${BUCKET_PATH}/${WORLD_ZIP} /minecraft/${WORLD_ZIP}

unzip /minecraft/${WORLD_ZIP} -d /minecraft

java -Xmx1024M -Xms1024M -XX:+UseG1GC -jar spigot-1.16.5.jar nogui