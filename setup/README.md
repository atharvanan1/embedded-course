# Setup

This will help you setup your linux system with appropriate tools. However, you must install docker first.

```
sudo apt-get install docker
WHOAMI=$(whoami)
sudo groupadd docker
sudo usermod -a -G docker ${WHOAMI}
```

Now, logout and log back in to reevaluate the group policy

Execute the following:

```
./build-docker.sh
./run-docker.sh
```
