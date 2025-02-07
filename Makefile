CROSS_COMPILE ?= riscv64-elf-

all: image

image: image.bin

image.bin: stage1.bin payload.hex0
	cat stage1.bin payload.hex0 > image.bin

stage1.bin: src/stage1.S
	$(CROSS_COMPILE)gcc -march=rv64gc\
					-nostdlib\
					-ffreestanding\
					-Ttext 0\
					./src/stage1.S -o stage1.elf
	$(CROSS_COMPILE)objcopy -O binary stage1.elf stage1.bin
	
payload.hex0: src/payload.S
	$(CROSS_COMPILE)gcc -march=rv64gc\
					-nostdlib\
					-ffreestanding\
					-Ttext 0 \
					./src/payload.S -o payload.elf	
	$(CROSS_COMPILE)objcopy -O binary payload.elf payload.bin
	./bin-to-hex0.sh payload.bin payload.hex0

clean:
	rm -f image.bin stage1.bin stage1.elf payload.hex0 payload.bin payload.elf
