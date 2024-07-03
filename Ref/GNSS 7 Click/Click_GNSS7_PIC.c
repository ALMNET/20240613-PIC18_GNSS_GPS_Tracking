/*
Example for GNSS7 Click

    Date          : dec 2019.
    Author        : Katarina Perendic

Test configuration PIC :
    
    MCU             : P18F87K22
    Dev. Board      : EasyPIC PRO v7
    PIC Compiler ver : v7.6.0.0

---

Description :

The application is composed of three sections :

- System Initialization - Initializes all necessary GPIO pins, UART used for
the communcation with GSM module and UART used for infromation logging
- Application Initialization - Initializes driver, power on module and sends few
command for the default module configuration
- Application Task - running in parallel core state machine and checks for call flag. 
If call detected parser will hang up call.

Additional Functions :

All additional functions such as timer initialization and default handler. 

Notes GPS:

- The GPS module returns data in the form of NMEA responses
- For example, we used the GGA response

- $GNGGA,123519,4807.038,N,01131.000,E,1,08,0.9,545.4,M,46.9,M,,*47

For parsing, use the GPS Parser function to send the following form of arguments:
The name of the NMEA response that you want to parse, the position of the data that you need.
As a response - you will get a separate buffer with the requested data

*/

#include "Click_GNSS7_types.h"
#include "Click_GNSS7_config.h"
#include "Click_GNSS7_timer.h"

uint8_t p_flag = 0;
uint8_t disp_flag = 0;
char demo_buf[ 500 ] = {0};
char demo_cmd[ 16 ] = "$GNGGA";

void gnss7_default_handler( uint8_t *rsp, uint8_t *ev_args )
{
    char *tmp;
    tmp = rsp;

    //mikrobus_logWrite( tmp, _LOG_TEXT );
        
    if( *rsp == '$' )
    {
        memset( &demo_buf[ 0 ], 0, 500 );
        strcpy( demo_buf, tmp );
    }
}

void system_init ( )
{
    mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_AN_PIN, _GPIO_OUTPUT );
    mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_PWM_PIN, _GPIO_INPUT );
    mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_INPUT );
    mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
    mikrobus_uartInit( _MIKROBUS1, &GNSS7_UART_CFG[0] );

    mikrobus_logInit( _LOG_USBUART, 38400 );
    
    RC1IE_bit    = 1;
    RC1IF_bit    = 0;
    PEIE_bit     = 1;
    GIE_bit      = 1;

    Delay_ms( 100 );
}

void application_init ( )
{
    // TIMER INIT
    gnss7_config_timer( );

    // DRIVER INIT
    gnss7_uart_driver_init( (gnss7_obj_t)&_MIKROBUS1_GPIO, (gnss7_obj_t)&_MIKROBUS1_UART );
    gnss7_core_init( gnss7_default_handler, 1500 );

    // MODULE POWER ON
    gnss7_module_power( 1 );
        
    Delay_ms( 5000 );
    timer_cnt = 0;
}

void application_task ( )
{
    char *p_lat;
    char *p_long;
    char *p_alt;
    char rsp_com[ 50 ] = {0};

    gnss7_process( );

    if ( timer_cnt > 5000 )
    {
        p_flag++;
        if ( p_flag > 2 )
        {
            p_flag = 0;
        }
        timer_cnt = 0;
        disp_flag = 1;
    }

    if ( ( p_flag == 0 ) && ( disp_flag == 1) )
    {
        mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE );
        p_lat = gnss7_gps_parser( &demo_buf[ 0 ], &demo_cmd[ 0 ], 2 );

        if ( p_lat == 0 )
        {
            mikrobus_logWrite( " Latitude : No data available!", _LOG_LINE );
        }
        else
        {
            strcpy( &rsp_com[ 0 ], p_lat );
            mikrobus_logWrite( " Latitude : ", _LOG_TEXT );
            mikrobus_logWrite( rsp_com, _LOG_LINE );
        }
        disp_flag = 0;
        mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE );
    }

    if ( ( p_flag == 2 ) && ( disp_flag == 1) )
    {
        mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE );
        p_alt = gnss7_gps_parser( &demo_buf[ 0 ], &demo_cmd[ 0 ], 9 );
        if ( p_alt == 0 )
        {
            mikrobus_logWrite( " Altitude : No data available!", _LOG_LINE );
        }
        else
        {
            strcpy( &rsp_com[ 0 ], p_alt );
            mikrobus_logWrite( " Altitude : ", _LOG_TEXT );
            mikrobus_logWrite( rsp_com, _LOG_LINE );
        }
        disp_flag = 0;
        mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE );
    }

    if ( ( p_flag == 1 ) && ( disp_flag == 1 ) )
    {
        mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE );
        p_long = gnss7_gps_parser( &demo_buf[ 0 ], &demo_cmd[ 0 ], 4 );
        if ( p_long == 0 )
        {
            mikrobus_logWrite( " Longitude : No data available!", _LOG_LINE );
        }
        else
        {
            strcpy( &rsp_com[ 0 ], p_long );
            mikrobus_logWrite( " Longitude : ", _LOG_TEXT );
            mikrobus_logWrite( rsp_com, _LOG_LINE );
        }
        disp_flag = 0;
        mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE );
    }
}

void main ( )
{
    system_init( );
    application_init( );

    for ( ; ; )
    {
        application_task( );
    }
}

void interrupt()
{
    char tmp;
    if ( RC1IF_bit == 1 )
    {
        tmp = UART1_Read( );
        gnss7_putc( tmp );
    }
}