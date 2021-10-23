#! /bin/bash

scriptdir="$(dirname `realpath ${BASH_SOURCE[0]}`)"

docker build $@ \
    -t robocon-embedded-course:1.0 ${scriptdir}/docker