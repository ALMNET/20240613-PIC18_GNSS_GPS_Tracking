#line 1 "D:/Armando/OneDrive/PROJECTS/2024/2024-06-13 - PIC18 GNSS GPS Tracking, Accelerometer and Magnetometer/6. CODE/6DOF IMU Click/Click_6DOF_IMU_PIC.c"
#line 1 "d:/armando/onedrive/projects/2024/2024-06-13 - pic18 gnss gps tracking, accelerometer and magnetometer/6. code/6dof imu click/click_6dof_imu_types.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;



typedef signed char int_fast8_t;
typedef signed int int_fast16_t;
typedef signed long int int_fast32_t;


typedef unsigned char uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned long int uint_fast32_t;


typedef signed int intptr_t;
typedef unsigned int uintptr_t;


typedef signed long int intmax_t;
typedef unsigned long int uintmax_t;
#line 1 "d:/armando/onedrive/projects/2024/2024-06-13 - pic18 gnss gps tracking, accelerometer and magnetometer/6. code/6dof imu click/click_6dof_imu_config.h"
#line 1 "d:/armando/onedrive/projects/2024/2024-06-13 - pic18 gnss gps tracking, accelerometer and magnetometer/6. code/6dof imu click/click_6dof_imu_types.h"
#line 4 "d:/armando/onedrive/projects/2024/2024-06-13 - pic18 gnss gps tracking, accelerometer and magnetometer/6. code/6dof imu click/click_6dof_imu_config.h"
const uint32_t _C6DOFIMU_I2C_CFG[ 1 ] =
{
 100000
};
#line 35 "D:/Armando/OneDrive/PROJECTS/2024/2024-06-13 - PIC18 GNSS GPS Tracking, Accelerometer and Magnetometer/6. CODE/6DOF IMU Click/Click_6DOF_IMU_PIC.c"
int16_t accelX;
int16_t accelY;
int16_t accelZ;
int16_t gyroX;
int16_t gyroY;
int16_t gyroZ;
float temperature;
uint8_t temp[2] = {0};
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
 c6dofimu_i2cDriverInit( ( const uint8_t* )&_MIKROBUS1_GPIO, ( const uint8_t* )&_MIKROBUS1_I2C, _C6DOFIMU_I2C_ADDR );
 Delay_100ms();


 c6dofimu_writeData( _C6DOFIMU_CTRL1_XL, _C6DOFIMU_CTRL12_CONFIG );
 Delay_10ms();
 c6dofimu_writeData( _C6DOFIMU_CTRL2_G, _C6DOFIMU_CTRL12_CONFIG );
 Delay_10ms();
 c6dofimu_writeData( _C6DOFIMU_CTRL3_C, _C6DOFIMU_CTRL3_C_CONFIG );
 Delay_10ms();

 mikrobus_logWrite("      Accel            Gyro           Temp. °C",_LOG_LINE);
 mikrobus_logWrite("---------------------------------------------------------", _LOG_LINE);
}

void applicationTask()
{
 c6dofimu_readAccel( &accelX, &accelY, &accelZ );
 Delay_1sec();
 c6dofimu_readGyro( &gyroX, &gyroY, &gyroZ );
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
