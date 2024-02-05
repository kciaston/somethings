#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */



typedef struct
{
	char *ptr;
	uint32_t size;
	char *next;
}param_t;


typedef struct
{
	char *command;
	uint32_t size;
	char *params;
}command_t;


bool get_param(char *str, param_t *out_param)
{
	uint32_t length = strlen(str);
	
	for(uint32_t i = 0; i < length; i++)
	{
		if(str[i] == ' ')
		{
			out_param->ptr = str;
			out_param->size = i;
			if(length > i)
			{
				out_param->next = &str[i + 1];
			}
			else
			{
				out_param->next = NULL;
			}
			str[i] = '\0';
			break;
		}
		else if((str[i] == '\0') || (str[i] == '\r'))
		{
			out_param->ptr = str;
			out_param->size = i;
			out_param->next = NULL;
			break;
		}
	}
}


char test[] = "ethset 192.168.1.10 255.255.255.0 192.168.1.1\r";
char test_2[] = "192.168.1.10 255.255.255.0 192.168.1.1\r";


param_t param_tab[10];
char *command;


void get_command(char *str, command_t *out_command)
{
	int32_t length = strlen(str);
	
	for(uint32_t i = 0; i < length; i++)
	{
		if(str[i] == ' ')
		{
			out_command->command = str;
			out_command->size = i;
			if(length > i)
			{
				out_command->params = &str[i + 1];
			}
			else
			{
				out_command->params = NULL;
			}
			str[i] = '\0';
			break;
		}
		else if((str[i] == '\0') || (str[i] == '\r'))
		{
			out_command->command = str;
			out_command->size = i;
			out_command->params = NULL;
			break;
		}
	}		
}


typedef struct
{
	char *digit;
	uint32_t size;
	char *next;
}digit_t;


void get_digit(char *str, uint32_t len, digit_t *digit)
{
	for(uint32_t i = 0; i < len; i++)
	{
		if(str[i] == '.')
		{
			str[i] = '\0';
			digit->digit = str;
			digit->size = i;
			if(len > i)
			{
				digit->next = &str[i + 1];
			}
			else
			{
				digit->next = NULL;
			}
			break;
		}
		else if(str[i] == '\0')
		{
			digit->digit = str;
			digit->size = i;
			digit->next = NULL;
			break;
		}
	}
}


uint8_t convert_str_to_int(char *str)
{
	int32_t result = atoi(str);
	
	return (uint8_t)result;
}


void view_digit(digit_t *digit)
{
	printf("Digit view ------------------------------------\n\r");
	printf("digit: %s\n\r", digit->digit);
	printf("size: %u\n\r", digit->size);
	printf("next: %s\n\r", digit->next);
	printf("-----------------------------------------------\n\r");
}


void convert_str_ip_to_tab(char *str, uint32_t len, uint8_t *ip)
{
	char str_ip[16];
	digit_t digit;
	
	strcpy(str_ip, str);
	
	get_digit(str_ip, len, &digit);
	ip[0] = convert_str_to_int(digit.digit);
//	view_digit(&digit);
	
	
	get_digit(digit.next, len, &digit);
	ip[1] = convert_str_to_int(digit.digit);
//	view_digit(&digit);
	
	
	get_digit(digit.next, len, &digit);
	ip[2] = convert_str_to_int(digit.digit);
//	view_digit(&digit);
	
	get_digit(digit.next, len, &digit);
	ip[3] = convert_str_to_int(digit.digit);
//	view_digit(&digit);
}


void view_ip_tab(uint8_t *ip)
{
	printf("IP tab view ------------------------------------------\n\r");
	printf("ip: %u.%u.%u.%u\n\r", ip[0], ip[1], ip[2], ip[3]);
	printf("------------------------------------------------------\n\r");
}


void view_param_struct(param_t *param)
{
	printf("param: %s\n\r", param->ptr);
	printf("size: %u\n\r", param->size);
	printf("next: %s\n\r", param->next);
	printf("\n\r");
}


int main(int argc, char *argv[]) 
{
	command_t command;
	
	get_command(test, &command);
	
	printf("command: %s\n\r", command.command);
	printf("size: %u\n\r", command.size);
	printf("params: %s\n\r", command.params);
	
	
	param_t param;
	uint32_t param_index = 0;
	
	if(command.params != NULL)
	{
		char *str = command.params;
		
		for(uint32_t i = 0; i < 10; i++)
		{
			get_param(str, &param);
						
			
			
			param_tab[param_index] = param;
			param_index++;
			
			if(param.next == NULL)
			{
				break;
			}
			else
			{
			 	str = param.next;
			}					
		}
	}
	else
	{
		printf("params no exist");
	}
	
	printf("\n\r");
	uint8_t ip[4];
	
//	view_param_struct(&param_tab[0]);
	convert_str_ip_to_tab(param_tab[0].ptr, param_tab[0].size, ip);
	view_ip_tab(ip);
	
//	view_param_struct(&param_tab[1]);
	convert_str_ip_to_tab(param_tab[1].ptr, param_tab[1].size, ip);
	view_ip_tab(ip);
	
//	view_param_struct(&param_tab[2]);
	convert_str_ip_to_tab(param_tab[2].ptr, param_tab[2].size, ip);
	view_ip_tab(ip);
	
	return 0;
}
