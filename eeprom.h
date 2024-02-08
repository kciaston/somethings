/*
 * eeprom.h
 *
 *  Created on: Feb 8, 2024
 *      Author: szifu
 */

#ifndef EEPROM_EEPROM_H_
#define EEPROM_EEPROM_H_

#include <stdint.h>



void eeprom_init(void);
void eeprom_read(uint16_t address, uint8_t read_size, uint8_t *data, uint32_t buffer_size);
void eeprom_write(uint16_t address, uint8_t *data, uint32_t size);


#endif /* EEPROM_EEPROM_H_ */
