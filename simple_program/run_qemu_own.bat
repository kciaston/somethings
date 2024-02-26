ECHO ON
CALL "G:\Projekty\qemu_oryg\qemu\build\qemu-system-arm.exe" -cpu cortex-m3 -M stm32vldiscovery -kernel program.bin -nographic
PAUSE