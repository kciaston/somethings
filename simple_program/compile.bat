ECHO ON
CALL "C:\Program Files (x86)\GNU Arm Embedded Toolchain\10 2021.07\bin\arm-none-eabi-as.exe" -mcpu=cortex-m3 -g startup.s -o startup.o
CALL "C:\Program Files (x86)\GNU Arm Embedded Toolchain\10 2021.07\bin\arm-none-eabi-gcc.exe" -c -mcpu=cortex-m3 -g main.c -o main.o
CALL "C:\Program Files (x86)\GNU Arm Embedded Toolchain\10 2021.07\bin\arm-none-eabi-ld.exe" -T stm32_flash.ld main.o startup.o -o program.elf
CALL "C:\Program Files (x86)\GNU Arm Embedded Toolchain\10 2021.07\bin\arm-none-eabi-objcopy.exe" -O binary program.elf program.bin
PAUSE