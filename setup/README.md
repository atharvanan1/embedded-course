# Setup

This will help you setup your linux system with appropriate tools. However, you must install docker first.

```
sudo apt-get install docker
WHOAMI=$(whoami)
sudo groupadd docker
sudo usermod -a -G docker ${WHOAMI}
```

Now, restart your computer or VM, and that should reinstate the group policies.

Execute the following:

```
./run-docker.sh
```

This will download `1.5GB` of docker container. So, make sure you have that much data tariff. 
This will also show you the status, as opposed to `build-docker.sh` script. Note that `build-docker.sh` 
is still present and was used to build this image.
