


#include <string.h>
#include <stdint.h>
#include "eeprom.h"
#include "stm32h7xx_hal.h"
#include "stm32h7xx_hal_i2c.h"



extern I2C_HandleTypeDef hi2c1;


#define DEVICE_ADDRESS		(0xA0)
#define TIMEOUT_VALUE		(100U)


void eeprom_read(uint16_t address, uint8_t read_size, uint8_t *data, uint32_t buffer_size)
{
	HAL_I2C_Mem_Read(&hi2c1, DEVICE_ADDRESS, address, 2, data, read_size, TIMEOUT_VALUE);
}


void eeprom_write(uint16_t address, uint8_t *data, uint32_t size)
{
	HAL_I2C_Mem_Write(&hi2c1, DEVICE_ADDRESS, address, 2, data, size, TIMEOUT_VALUE);
}

