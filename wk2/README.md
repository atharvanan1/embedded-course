# Week 2 Practical


## Code organization
* Here we will design an ARM assembly program called `start.S`, and `main.c`.

### start.S

This will be initialize Stack Pointer, make sure only core-0 executes the rest of the code.
core-0 goes onto initializing the bss region. BSS region holds "uninitialized 
variables that are globally visible" -> doesn't mean global variables, but static
variables. Then this code will attempt to jump to `main` address.

### main.c

This will be a simple program. Since, we don't need any standard input-output,
we won't need to include `stdio.h` or anything else. This program will loop 
in a while(1) loop.

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

2. Run `make run`. This will launch qemu with an ARM machine using `cortex-a57` cpu.
You'll be able to see the assembly instructions that are being executed.
