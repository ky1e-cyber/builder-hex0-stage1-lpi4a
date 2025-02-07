#!/bin/bash

riscv64-elf-as ./src/stage1.s -o stage1.o &&
  riscv64-elf-ld -Ttext 0 stage1.o -o stage1.elf &&
  riscv64-elf-objcopy -O binary stage1.elf stage1.bin

rm -f stage1.o stage1.elf
