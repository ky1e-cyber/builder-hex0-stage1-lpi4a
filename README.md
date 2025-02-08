# [!!!] LICHEE PI 4A BAREMETAL RUN DOESN'T WORK YET

# Builder-hex0 LPi4A

## About

Learn about builder-hex0 [here](https://github.com/ironmeld/builder-hex0).

This is a proof-of-concept builder-hex0-stage1 port for Lichee Pi 4A RISC-V board developed by my team during RISC-V Winter School 2025.

## Build

If your cross toolchain prefix differs from `riscv64-elf-` (or you're building on RISC-V natively), set your prefix by

```
$ export CROSS_COMPILE=<your-prefix->
```

### Build image for Lichee Pi 4A

```console
$ make image_lpi4a
```

### Build image for QEMU virt

```console
$ make image_qemu
```

### Manual build

1. Build ELF file
```console
$ <preifx>-gcc -march=rv64gc\
			   -nostdlib\
			   -ffreestanding\
			   -Ttext 0\
			   ./src/stage1.S -o stage1.elf
```
2. Objcopy ELF's .text into raw binary
```console
$ <prefix>-objcopy -O binary stage1.elf stage1.bin
```
3. Cat `stage1.bin` and payload for your platform (`payload_lpi4a.hex0` or `payload_qemu.hex0`)

```console
$ cat stage1.bin <payload>.hex0 > image_<platform>.bin
```

## Running

### On Lichee Pi 4A board

1. Set boot select DIP switch to SD Card boot mode.

2. Load image to SD Card (should be zero-ed at least for 1.5 MB)
```console
$ dd if=image_lpi4a.bin of=<SD Card>
```

3. Insert SD Card and power-on the board

### On QEMU RISC-V virt

```console
$ qemu-system-riscv64 -M virt -bios image_qemu.bin
```
