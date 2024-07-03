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

#include "Click_6DOF_IMU_types.h"
#include "Click_6DOF_IMU_config.h"

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

// GNSS4 Variables
char *pLat;
char *pLong;
char *pAlt;
char rspCom[ 50 ] = {0};

// 6DOF IMU Variables
int16_t accelX;
int16_t accelY;
int16_t accelZ;
int16_t gyroX;
int16_t gyroY;
int16_t gyroZ;
float temperature;
uint8_t temp[2]    = {0};
char logText[ 15 ] = {0};



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

// Prototypes
void IMU_Task();


void main()
{
    // Mikrobus Init
    mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
    
    //mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_INPUT );
    //mikrobus_i2cInit( _MIKROBUS1, &_C6DOFIMU_I2C_CFG[0] );
    
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
    
    while(1)
    {
        IMU_Task();
    }
  

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



void IMU_Task()
{
    c6dofimu_readAccel( &accelX, &accelY, &accelZ );
    Delay_1sec();
    c6dofimu_readGyro(  &gyroX,  &gyroY, &gyroZ );
    Delay_1sec();
    temperature = c6dofimu_readTemperature();
    Delay_1sec();

    mikrobus_logWrite( " Accel X :", _LOG_TEXT );
    IntToStr( accelX, logText );
    mikrobus_logWrite( logText, _LOG_TEXT );
    mikrobus_logWrite( "  |  ", _LOG_TEXT );
    mikrobus_logWrite( " Gyro X :", _LOG_TEXT );
    IntToStr( gyroX, logText );
    mikrobus_logWrite( logText, _LOG_TEXT );
    mikrobus_logWrite( "  *", _LOG_TEXT );
    mikrobus_logWrite( "*****************", _LOG_LINE );

    mikrobus_logWrite( " Accel Y :", _LOG_TEXT );
    IntToStr( accelY, logText );
    mikrobus_logWrite( logText, _LOG_TEXT );
    mikrobus_logWrite( "  |  ", _LOG_TEXT );
    mikrobus_logWrite( " Gyro Y :", _LOG_TEXT );
    IntToStr( gyroY, logText );
    mikrobus_logWrite( logText, _LOG_TEXT );
    mikrobus_logWrite( "  *  ", _LOG_TEXT );
    mikrobus_logWrite( "Temp.:", _LOG_TEXT );
    IntToStr( temperature, logText );
    mikrobus_logWrite( logText, _LOG_TEXT );
    mikrobus_logWrite( "° *  ", _LOG_LINE );

    mikrobus_logWrite( " Accel Z :", _LOG_TEXT );
    IntToStr( accelZ, logText );
    mikrobus_logWrite( logText, _LOG_TEXT );
    mikrobus_logWrite( "  |  ", _LOG_TEXT );
    mikrobus_logWrite( " Gyro Z :", _LOG_TEXT );
    IntToStr( gyroZ, logText );
    mikrobus_logWrite( logText, _LOG_TEXT );
    mikrobus_logWrite( "  *", _LOG_TEXT );
    mikrobus_logWrite( "*****************", _LOG_LINE );

    mikrobus_logWrite("---------------------------------------------------------", _LOG_LINE);

    Delay_1sec();
}


/* -------------------------------------------------------------------------- */