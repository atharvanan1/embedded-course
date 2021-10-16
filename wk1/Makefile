# Makefile for baremetal arm target
#

all: clean kernel.img

kernel.img: kernel.elf
	aarch64-elf-objcopy -O binary kernel.elf kernel.img

kernel.elf: start.o linker.ld
	aarch64-elf-ld -nostdlib -nostartfiles start.o -T linker.ld -o kernel.elf

start.o: start.S
	aarch64-elf-as start.S -o start.o

clean:
	rm -rf kernel.* *.o >/dev/null 2>/dev/null || true

run: kernel.img
	qemu-system-aarch64 -M virt -cpu cortex-a57 -m 128M -kernel kernel.img -d in_asm -nographic
