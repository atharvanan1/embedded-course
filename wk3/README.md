# Week 3 Practical

## Code organization
* Here we will design an ARM assembly program called `start.S`, and C program 
`main.c`.

### start.S

This will be initialize Stack Pointer, make sure only core-0 executes the rest 
of the code. core-0 goes onto initializing the bss region. BSS region holds 
"uninitialized  variables that are globally visible" -> doesn't mean global 
variables, but static variables. Then this code will attempt to jump to 
`main` address.

### main.c

This program will define functions to be used for following:
1. setup_uart - helps setup UART peripheral on the `virt` machine
2. putch - asks UART peripheral to send a character
3. getch - asks UART peripheral to receive a character
4. puts - prints a string using putch function

along with `main` function which orchestrates the sequence and functions

### uart.h

Holds register addresses for UART peripherals

Here, I'll talk about the design choice made there and why.

1. For peripheral program to be modular and flexible with use-cases, we abstract
UART peripheral address. Hence, we are using UART_BASE as our macro controlling 
that.

```
#define UART_BASE               0x09000000
```

Added UART_BASE helps us easily redefine it and change our code to reflect a 
different device with similar UART peripheral registers. Traditionally, these
will be from the same family. As talked during the lecture, STM32F4 series is
a single family and using UART_BASE helps us reuse most of the code across
the whole family.

**Where do you find the UART_BASE address?**
For real-world devices, **Techinal Reference Manual** -> **Memory Map** section. 

For qemu-based device (device we are using), you'll find it in 
hardware implementation file - [virt.c](https://github.com/qemu/qemu/blob/386b2a5767f7642521cd07930c681ec8a6057e60/hw/arm/virt.c#L130)

2. To make it easier to read, we use <REGISTER_NAME>_OFFSET. This helps us easily
align with the datasheet and adds onto the modular setup we started to build using
UART_BASE when we define <REGISTER_NAME>_ADDRESS. Note that this isn't a design I
came up with, this is to be found in different vendor code for different MCUs.

**How do we know the OFFSET of a register or which registers exist?**
For real-world devices, **Technical Reference Manual** -> **GO to peripheral 
section** (In our case, currently it's UART). Here, you'll find detailed description
about how the peripheral works along with register map for that peripheral with 
offsets and bit descriptions.

For qemu-based device, we are using `virt` which is based on basic ARM peripherals.
Hence, I found that if we refer to [Primecell UART implementation](https://developer.arm.com/documentation/ddi0183/g) 
from ARM we should be good.

3. const variables are used to provide a data interface to these registers.

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
