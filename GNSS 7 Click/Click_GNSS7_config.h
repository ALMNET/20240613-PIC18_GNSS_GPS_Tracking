#include "Click_GNSS7_types.h"

const uint32_t GNSS7_TIMER_LIMIT      = 5;	    // 5 ticks
const uint16_t GNSS7_BUF_WARNING      = 192;	// 192 bytes activate warning
 
const uint8_t  GNSS7_CALLBACK_ENABLE  = 0;	    // calback disabled

const uint32_t GNSS7_UART_CFG[ 1 ] = 
{
	38400
};
