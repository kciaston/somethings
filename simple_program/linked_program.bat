ECHO ON
CALL "C:\Program Files (x86)\GNU Arm Embedded Toolchain\10 2021.07\bin\arm-none-eabi-ld.exe" -o program -T stm32_flash.ld main.o
PAUSE