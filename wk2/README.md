# Week 2 Practical

## GCC Basics

GCC is a suite of programs that help you compile your C code (along with many other languages too, but we don't care about that right now - [GCC Supported Languages](https://gcc.gnu.org/onlinedocs/gcc/G_002b_002b-and-GCC.html#:~:text=1%20Programming%20Languages%20Supported%20by%20GCC&text=GCC%20is%20an%20integrated%20distribution,multiple%20meanings%20in%20common%20use.)).

GCC has different variants for different architectures and different EABI 
(Embedded Application Binary Interface). EABI is the way assembly langugage
information is arranged and communicated (like return values of a function).

For your information, we'll deal with none-eabi (Bare Metal Program) and 
linux-eabi (Linux Program). As talked about in wk2 class, Bare Metal Programs
don't need any additional information on how to execute - we just have to jump
to the address like we did in `start.S` -> we jumped to `main`.

List of gcc variants useful to us:

`gcc` - generic linux eabi variant that will run on x86 systems and compile for x86 systems

`arm-none-eabi-gcc` - ARM32 Bare Metal Compiler will run on x86 systems and compile for ARM32 systems
that will "just-run" on an ARM32 CPU

`arm-linux-eabi-gcc` - ARM32 Linux Compiler will run on x86 systems and compile for ARM32 systems
that are running Linux Operating System. This will include some boilerplate code for Linux process
management and scheduling.

`aarch64-none-eabi-gcc` or `aarch64-elf-gcc` - ARM64 Bare Metal Compiler will run on x86 systems and
compile for ARM64 systems that will "just-run" on an ARM64 CPU

`aarch64-linux-eabi-gcc` - ARM64 Linux Compiler will run on x86 systems and compile for ARM64 systems
that are running Linux Operating System. This will include some boilerplate code Linux process
management and scheduling.

To use gcc with it's various stages:

To run preprocessor:
```
gcc -E source_file.c > source_file.i
```

This outputs a text file with all macros expanded.


To run preprocessor and compiler:
```
gcc -S source_file.c -o source_file.S
```

This outputs a text file with assembly instructions. This is
where most of the syntax checking will happen.

To run preprocessor, compiler, and assembler:
```
gcc -c source_file.c -o source_file.o
```

This outputs an ELF file with binary information packed along with
header information about MACHINE, DATA, etc.

To run preprocessor, compiler, assembler, and linker:
```
gcc source_file.c -o source_file.exe
```

This outputs an executable file with binary information packed along 
with **all** addresses referenced. A complete program.

To get binary only information for our platform (ARM64):
```
objcopy -O binary source_file.exe -o source_file.bin
```

NOTE: all these commands shall be prefixed with `aarch64-elf` for bare metal
ARM64 systems. `arm-none-eabi` for bare metal ARM32 systems. And so on...


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
