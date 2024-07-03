#line 1 "D:/Armando/OneDrive/PROJECTS/2024/2024-06-13 - PIC18 GNSS GPS Tracking, Accelerometer and Magnetometer/6. CODE/20240613-PIC18_GNSS_GPS_Tracking/20240613-PIC18_GNSS_GPS_Tracking.c"
#line 1 "d:/armando/onedrive/projects/2024/2024-06-13 - pic18 gnss gps tracking, accelerometer and magnetometer/6. code/20240613-pic18_gnss_gps_tracking/click_gnss4_types.h"
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
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdbool.h"



 typedef char _Bool;
#line 1 "d:/armando/onedrive/projects/2024/2024-06-13 - pic18 gnss gps tracking, accelerometer and magnetometer/6. code/20240613-pic18_gnss_gps_tracking/click_gnss4_config.h"
#line 1 "d:/armando/onedrive/projects/2024/2024-06-13 - pic18 gnss gps tracking, accelerometer and magnetometer/6. code/20240613-pic18_gnss_gps_tracking/click_gnss4_types.h"
#line 3 "d:/armando/onedrive/projects/2024/2024-06-13 - pic18 gnss gps tracking, accelerometer and magnetometer/6. code/20240613-pic18_gnss_gps_tracking/click_gnss4_config.h"
const uint32_t _GNSS4_TIMER_LIMIT = 5;
const uint16_t _GNSS4_BUF_WARNING = 192;
const uint8_t _GNSS4_POLL_ENABLE = 1;
const uint8_t _GNSS4_CALLBACK_ENABLE = 0;

const uint32_t _GNSS4_UART_CFG[ 1 ] =
{
 9600
};
#line 1 "d:/armando/onedrive/projects/2024/2024-06-13 - pic18 gnss gps tracking, accelerometer and magnetometer/6. code/20240613-pic18_gnss_gps_tracking/click_gnss4_timer.h"
#line 1 "d:/armando/onedrive/projects/2024/2024-06-13 - pic18 gnss gps tracking, accelerometer and magnetometer/6. code/20240613-pic18_gnss_gps_tracking/click_gnss4_types.h"
#line 11 "d:/armando/onedrive/projects/2024/2024-06-13 - pic18 gnss gps tracking, accelerometer and magnetometer/6. code/20240613-pic18_gnss_gps_tracking/click_gnss4_timer.h"
uint32_t timerCounter = 0;

static void gnss4_configTimer()
{
 T1CON = 0x01;
 TMR1IF_bit = 0;
 TMR1H = 0xC1;
 TMR1L = 0x80;
 TMR1IE_bit = 1;
 INTCON = 0xC0;
}

void Interrupt()
{
 if (TMR1IF_bit != 0)
 {
 TMR1IF_bit = 0;
 TMR1H = 0xC1;
 TMR1L = 0x80;

 gnss4_tick();
 timerCounter++;
 }
}
#line 1 "d:/armando/onedrive/projects/2024/2024-06-13 - pic18 gnss gps tracking, accelerometer and magnetometer/6. code/20240613-pic18_gnss_gps_tracking/click_6dof_imu_types.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"
#line 1 "d:/armando/onedrive/projects/2024/2024-06-13 - pic18 gnss gps tracking, accelerometer and magnetometer/6. code/20240613-pic18_gnss_gps_tracking/click_6dof_imu_config.h"
#line 1 "d:/armando/onedrive/projects/2024/2024-06-13 - pic18 gnss gps tracking, accelerometer and magnetometer/6. code/20240613-pic18_gnss_gps_tracking/click_6dof_imu_types.h"
#line 4 "d:/armando/onedrive/projects/2024/2024-06-13 - pic18 gnss gps tracking, accelerometer and magnetometer/6. code/20240613-pic18_gnss_gps_tracking/click_6dof_imu_config.h"
const uint32_t _C6DOFIMU_I2C_CFG[ 1 ] =
{
 100000
};
#line 28 "D:/Armando/OneDrive/PROJECTS/2024/2024-06-13 - PIC18 GNSS GPS Tracking, Accelerometer and Magnetometer/6. CODE/20240613-PIC18_GNSS_GPS_Tracking/20240613-PIC18_GNSS_GPS_Tracking.c"
uint8_t pFlag = 0;
uint8_t dispFlag = 0;


char demoBuffer[ 500 ] = {0};


char demoCommand[ 16 ] = "$GNGGA";


char *pLat;
char *pLong;
char *pAlt;
char rspCom[ 50 ] = {0};


int16_t accelX;
int16_t accelY;
int16_t accelZ;
int16_t gyroX;
int16_t gyroY;
int16_t gyroZ;
float temperature;
uint8_t temp[2] = {0};
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


void IMU_Task();


void main()
{

 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );




 mikrobus_uartInit( _MIKROBUS1, &_GNSS4_UART_CFG[0] );
 mikrobus_logInit( _MIKROBUS3, 9600 );
 mikrobus_logWrite( " ---- System Init ---- ", _LOG_LINE);


 gnss4_configTimer();


 gnss4_uartDriverInit(( const uint8_t* )&_MIKROBUS1_GPIO, ( const uint8_t* )&_MIKROBUS1_UART);
 gnss4_coreInit( gnss4_default_handler, 1500 );


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

 gnss4_process();



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


 if(pFlag == 2 && dispFlag == 1)
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





void IMU_Task()
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
