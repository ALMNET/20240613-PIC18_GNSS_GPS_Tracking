/*
Notes :

- The GPS module returns data in the form of NMEA responses
- For example, we used the GGA response

- $GPGGA,123519,4807.038,N,01131.000,E,1,08,0.9,545.4,M,46.9,M,,*47

For parsing, use the GPS Parser function to send the following form of arguments:
The name of the NMEA response that you want to parse, the position of the data 
that you need.
As a response - you will get a separate buffer with the requested data

*/

#include "Click_GNSS4_types.h"
#include "Click_GNSS4_config.h"
#include "Click_GNSS4_timer.h"

////////////////////////////////////////////////////////////////////////////////
///////////////////////////// GLOBAL VARIABLES /////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// Timing Flags
uint8_t pFlag = 0;
uint8_t dispFlag = 0;

// Buffer
char demoBuffer[ 500 ] = {0};

// Basic default AT Command
char demoCommand[ 16 ] = "$GNGGA";


char *pLat;
char *pLong;
char *pAlt;
char rspCom[ 50 ] = {0};



void gnss4_default_handler( uint8_t *rsp, uint8_t *evArgs )
{
    char *tmp;
    tmp = rsp;

    mikrobus_logWrite( tmp, _LOG_TEXT );
    if(*rsp == '$')
    {
        memset(&demoBuffer[0], 0, 500);
        strcpy(demoBuffer, tmp);
    }
}


void main()
{
    // Mikrobus Init
    mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
    mikrobus_uartInit( _MIKROBUS1, &_GNSS4_UART_CFG[0] );
    mikrobus_logInit( _MIKROBUS3, 9600 );
    mikrobus_logWrite( " ---- System Init ---- ", _LOG_LINE);

    // TIMER INIT
    gnss4_configTimer();

    // DRIVER INIT
    gnss4_uartDriverInit((T_GNSS4_P)&_MIKROBUS1_GPIO, (T_GNSS4_P)&_MIKROBUS1_UART);
    gnss4_coreInit( gnss4_default_handler, 1500 );

    // MODULE POWER ON
    gnss4_hfcEnable( 1 );
    gnss4_modulePower( 1 );

    Delay_ms( 5000 );
    timerCounter = 0;
  

    while (1)
    {
      // CORE STATE MACHINE
      gnss4_process();
      
      // GNSS4 General Delay and Flag conditioner (Could be improved in the
      // future)
      if(timerCounter > 5000)
      {
        pFlag++;
        if(pFlag > 2)
        {
            pFlag = 0;
        }
        timerCounter = 0;
        dispFlag = 1;
      }

      // Check timming condition for Latitud Read
      if(pFlag == 0 && dispFlag == 1)
      {
        mikrobus_logWrite( "  ", _LOG_LINE);
        mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
        pLat = gnss4_parser(&demoBuffer[0], &demoCommand[0], 2);

        if(pLat == 0)
        {
            mikrobus_logWrite( " Latitude : No data available!", _LOG_LINE);
        }
        else
        {
            strcpy(&rspCom[0], pLat);
            mikrobus_logWrite( " Latitude : ", _LOG_TEXT);
            mikrobus_logWrite(rspCom, _LOG_LINE);
        }
        dispFlag = 0;
        mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
      }

      // Check timming condition for Altitude Read
      if(pFlag == 2 &&  dispFlag == 1)
      {
        mikrobus_logWrite( "  ", _LOG_LINE);
        mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
        pAlt = gnss4_parser(&demoBuffer[0], &demoCommand[0], 9);
        if(pAlt == 0)
        {
            mikrobus_logWrite( " Altitude : No data available!", _LOG_LINE);
        }
        else
        {
            strcpy(&rspCom[0], pAlt);
            mikrobus_logWrite( " Altitude : ", _LOG_TEXT);
            mikrobus_logWrite(rspCom, _LOG_LINE);
        }
        dispFlag = 0;
        mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
      }

      // Check timming condition for Longitude Read
      if(pFlag == 1 && dispFlag == 1)
      {
        mikrobus_logWrite( "  ", _LOG_LINE);
        mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
        pLong = gnss4_parser(&demoBuffer[0], &demoCommand[0], 4);
        if(pLong == 0)
        {
            mikrobus_logWrite( " Longitude : No data available!", _LOG_LINE);
        }
        else
        {
            strcpy(&rspCom[0], pLong);
            mikrobus_logWrite( " Longitude : ", _LOG_TEXT);
            mikrobus_logWrite(rspCom, _LOG_LINE);
        }
        dispFlag = 0;
        mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
      }
    }
}

/* -------------------------------------------------------------------------- */