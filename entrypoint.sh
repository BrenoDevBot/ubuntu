#!/bin/bash
sleep 3
cd /home/container
if [ -f "/home/container/mta-server-arm64" ]; then
    echo "To update mtasa. Please delete mta-server-arm64."
    MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
    echo ":/home/container$ ${MODIFIED_STARTUP}"
    set -e
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)
    exec ${MODIFIED_STARTUP} -n -t -u
  else 
    echo "Updating mtasa. Please do not kill this process."
    wget https://nightly.mtasa.com/multitheftauto_linux_arm64-1.5.9-rc-21243.tar.gz -P /home/container
    tar -xf /home/container/multitheftauto_linux_arm64-1.5.9-rc-21243.tar.gz -C /home/container
    rm -f /home/container/multitheftauto_linux_arm64-1.5.9-rc-21243.tar.gz
    echo "Done updating mtasa. Starting..";
    MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
    echo ":/home/container$ ${MODIFIED_STARTUP}"
    set -e
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)
    exec ${MODIFIED_STARTUP} -n -t -u
fi
