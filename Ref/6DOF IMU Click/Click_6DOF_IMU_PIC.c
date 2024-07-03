/*
Example for 6DOF_IMU Click

    Date          : Aug 2018.
    Author        : Nenad Filipovic

Test configuration PIC :
    
    MCU             : P18F87K22
    Dev. Board      : EasyPIC PRO v7
    PIC Compiler ver : v7.2.0.0

---

Description :

The application is composed of three sections :

- System Initialization - Initializes I2C, set INT pin as input.
- Application Initialization - Initialization driver enable's - I2C, initialize LSM6DS33 and start write log.
- Application Task - (code snippet) This is a example which demonstrates the use of 6DOF IMU Click board.
     Measured accel and gyro coordinates (X,Y,Z) and temperature in degrees C are being sent to the uart where you can track their changes.
     All data logs on usb uart for every 1 sec.

Additional Functions :

- UART
- Conversions

*/

#include "Click_6DOF_IMU_types.h"
#include "Click_6DOF_IMU_config.h"

int16_t accelX;
int16_t accelY;
int16_t accelZ;
int16_t gyroX;
int16_t gyroY;
int16_t gyroZ;
float temperature;
uint8_t temp[2]    = {0};
char logText[ 15 ] = {0};

void systemInit()
{
    mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_INPUT );
    mikrobus_i2cInit( _MIKROBUS1, &_C6DOFIMU_I2C_CFG[0] );
    mikrobus_logInit( _MIKROBUS2, 9600 );
    Delay_100ms();
}

void applicationInit()
{
    c6dofimu_i2cDriverInit( (T_C6DOFIMU_P)&_MIKROBUS1_GPIO, (T_C6DOFIMU_P)&_MIKROBUS1_I2C, _C6DOFIMU_I2C_ADDR );
    Delay_100ms();

    /* Initializes */
    c6dofimu_writeData( _C6DOFIMU_CTRL1_XL, _C6DOFIMU_CTRL12_CONFIG );
    Delay_10ms();
    c6dofimu_writeData( _C6DOFIMU_CTRL2_G, _C6DOFIMU_CTRL12_CONFIG );
    Delay_10ms();
    c6dofimu_writeData( _C6DOFIMU_CTRL3_C, _C6DOFIMU_CTRL3_C_CONFIG );
    Delay_10ms();
    /* Start write log */
    mikrobus_logWrite("      Accel            Gyro           Temp. °C",_LOG_LINE);
    mikrobus_logWrite("---------------------------------------------------------", _LOG_LINE);
}

void applicationTask()
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

void main()
{
    systemInit();
    applicationInit();

    while (1)
    {
            applicationTask();
    }
}