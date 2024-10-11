# Operating System Based on Xv6 (RISC-V)

Small time-sharing OS which provides multithreading and memory allocation based on the Risc-V architecture, emulated by QEMU emulator.
This was a school project at the Faculty Of Electrical Engineering in Belgrade, Serbia for the year 2023/2024.

## Dependencies

   1.) Risc-V toolchain and QEMU emulator:
         
         sudo pacman -U https://archive.archlinux.org/packages/r/riscv64-linux-gnu-gcc/riscv64-linux-gnu-gcc-8.3.0-1-x86_64.pkg.tar.xz
         sudo pacman -U https://archive.archlinux.org/packages/r/riscv64-linux-gnu-binutils/riscv64-linux-gnu-binutils-2.32-1-x86_64.pkg.tar.xz
         sudo pacman -S qemu-full qemu-base make

   2.) Prevent pacman from updating the RISC-V packages. Add the following lines to your /etc/pacman.conf file:

      IgnorePkg = riscv64-linux-gnu-gcc
      IgnorePkg = riscv64-linux-gnu-binutils

## Debugging setup

Install:

      sudo pacman -S riscv64-elf-gdb

## Starting the program

- To run the project, use the following command:

      make qemu

## Debugging guide

...