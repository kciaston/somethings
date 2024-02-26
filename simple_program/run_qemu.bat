ECHO ON
CALL "C:\Program Files\qemu\qemu-system-arm.exe" -cpu cortex-m0 -M stm32vldiscovery -kernel Blinky.bin -nographic
PAUSE