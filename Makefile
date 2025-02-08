CROSS_COMPILE ?= riscv64-elf-

all: image_lpi4a image_qemu

image_lpi4a: image_lpi4a.bin

image_qemu: image_qemu.bin

image_lpi4a.bin: stage1.bin
	cat stage1.bin payload_lpi4a.hex0 > image_lpi4a.bin

image_qemu.bin: stage1.bin
	cat stage1.bin payload_qemu.hex0 > image_qemu.bin

stage1.bin:
	$(CROSS_COMPILE)gcc -march=rv64gc\
					-nostdlib\
					-ffreestanding\
					-Ttext 0\
					./src/stage1.S -o stage1.elf
	$(CROSS_COMPILE)objcopy -O binary stage1.elf stage1.bin	

clean:
	rm -f image_lpi4a.bin image_qemu.bin stage1.bin stage1.elf
