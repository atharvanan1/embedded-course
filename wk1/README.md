# Week 1 Practical


## Code organization

* Here we will design an ARM assembly program called `start.S`.

### start.S

Just loop infinitely at an address

## Instructions

### Prerequisites

* You will need to setup your system using instructions in `setup` folder.

* If you want to modify the program, you can modify the source files.
To run with docker container, you'll use `./run-docker.sh`. This will launch
another system (i.e. docker container) with all the necessary tools installed.

* You can modify and interact with the code from your linux machine or docker
container however you wish. 

### Instructions for Compiling:

1. Run `make`. This will compile the source code and pack it into `kernel.img` file.
This will generate `start.o`, `kernel.elf`, and `kernel.img`. We'll use `kernel.img`
and feed it into our machine below.

2. Run `make run`. This will launch qemu with an ARM machine using `cortex-a57` cpu.
You'll be able to see the assembly instructions that are being executed. This essentially
starts a virtual machine which is an ARM CPU. Have fun! :)
