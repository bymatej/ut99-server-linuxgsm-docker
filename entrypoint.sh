#!/bin/bash

echo "Starting LinuxGMS..."
./ut99server start &
echo "Starting fileserver..."
/filebrowser --port=8080 --address=0.0.0.0 --database=/config/filebrowser.db --root=/home/unreal/ut99/ &
echo "Running this container forever..."
tail -f /dev/null