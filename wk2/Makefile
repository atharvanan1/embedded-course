# Makefile for baremetal arm target
#

SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
CFLAGS = -Wall -O0 -ffreestanding -nostdinc -nostdlib -nostartfiles

all: clean kernel.img

start.o: start.S
	arm-none-eabi-gcc $(CFLAGS) -c start.S -o start.o

%.o: %.c
	arm-none-eabi-gcc $(CFLAGS) -c $< -o $@

kernel.img: start.o $(OBJS)
	arm-none-eabi-ld -nostdlib -nostartfiles start.o $(OBJS) -T linker.ld -o kernel.elf
	arm-none-eabi-objcopy -O binary kernel.elf kernel.img

clean:
	rm kernel.* *.o >/dev/null 2>/dev/null || true

run: kernel.img
	qemu-system-arm -M virt -m 128M -kernel kernel.img -d in_asm -nographic
