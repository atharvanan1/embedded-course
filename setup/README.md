# Setup

This will help you setup your linux system with appropriate tools. However, you must install docker first.

```
sudo apt-get install docker
WHOAMI=$(whoami)
sudo usermod -a -G docker ${WHOAMI}
```

Execute the following:

```
./build-docker.sh
./run-docker.sh
```
