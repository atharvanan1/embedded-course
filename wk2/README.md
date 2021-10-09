# Week 1 Practical

* Here we will design a simple program to make the ARM core loop infinitely

* You will need `arm-none-eabi-gcc` for this, which can be installed by 
  `gcc-arm-none-eabi` package in Ubuntu 20.04. It will probably the same for
  other versions too

* You will need `qemu-system-arm` for this, which will emulate your system
  which will contain `virt` arm core. Start address for this is 0x10000. Make
  sure we reflect that in our list.

* Here are all the ARM cpus supported by QEMU - 
[Platform/ARM](https://wiki.qemu.org/Documentation/Platforms/ARM)

