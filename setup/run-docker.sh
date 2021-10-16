#! /bin/bash

pwd=$(dirname $0)
pwd=`realpath ${pwd}`

docker run -v ${pwd}:/data -it robocon-embedded-course
