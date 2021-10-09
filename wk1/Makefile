# Makefile for baremetal arm target
#

all: clean kernel.img

kernel.img: kernel.elf
	arm-none-eabi-objcopy -O binary kernel.elf kernel.img

kernel.elf: start.o linker.ld
	arm-none-eabi-ld -nostdlib -nostartfiles start.o -T linker.ld -o kernel.elf

start.o: start.S
	arm-none-eabi-as start.S -o start.o

clean:
	rm kernel.* *.o >/dev/null 2>/dev/null || true

run:
	qemu-system-arm -M virt -kernel kernel.img -d in_asm -nographic
