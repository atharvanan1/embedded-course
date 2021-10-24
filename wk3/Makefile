# Makefile for baremetal arm target
# Some aspects are borrowed from 
# https://github.com/bztsrc/raspi3-tutorial/blob/master/02_multicorec/Makefile.gcc

SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
CFLAGS = -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles

all: clean kernel.img

kernel.img: kernel.elf
	aarch64-elf-objcopy -O binary kernel.elf kernel.img

kernel.elf: start.o linker.ld $(OBJS)
	aarch64-elf-ld -nostdlib -nostartfiles start.o $(OBJS) -T linker.ld -o kernel.elf

%.o: %.c
	aarch64-elf-gcc $(CFLAGS) -c $< -o $@

start.o: start.S
	aarch64-elf-as start.S -o start.o

clean:
	rm -rf kernel.* *.o >/dev/null 2>/dev/null || true

run: kernel.img
	qemu-system-aarch64 -M virt -smp 4 -cpu cortex-a57 -m 128M -kernel kernel.img -nographic
