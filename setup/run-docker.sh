#! /bin/bash

pwd=$(dirname $0)
pwd=`realpath ${pwd}`

docker run -v ${pwd}:/data -it azzentys/robocon-embedded-course:1.0
