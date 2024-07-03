
_systemInit:

;Click_6DOF_IMU_PIC.c,45 :: 		void systemInit()
;Click_6DOF_IMU_PIC.c,47 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_INPUT );
	CLRF        FARG_mikrobus_gpioInit_bus+0 
	MOVLW       7
	MOVWF       FARG_mikrobus_gpioInit_pin+0 
	MOVLW       1
	MOVWF       FARG_mikrobus_gpioInit_direction+0 
	CALL        _mikrobus_gpioInit+0, 0
;Click_6DOF_IMU_PIC.c,48 :: 		mikrobus_i2cInit( _MIKROBUS1, &_C6DOFIMU_I2C_CFG[0] );
	CLRF        FARG_mikrobus_i2cInit_bus+0 
	MOVLW       __C6DOFIMU_I2C_CFG+0
	MOVWF       FARG_mikrobus_i2cInit_cfg+0 
	MOVLW       hi_addr(__C6DOFIMU_I2C_CFG+0)
	MOVWF       FARG_mikrobus_i2cInit_cfg+1 
	MOVLW       higher_addr(__C6DOFIMU_I2C_CFG+0)
	MOVWF       FARG_mikrobus_i2cInit_cfg+2 
	CALL        _mikrobus_i2cInit+0, 0
;Click_6DOF_IMU_PIC.c,49 :: 		mikrobus_logInit( _MIKROBUS2, 9600 );
	MOVLW       1
	MOVWF       FARG_mikrobus_logInit_port+0 
	MOVLW       128
	MOVWF       FARG_mikrobus_logInit_baud+0 
	MOVLW       37
	MOVWF       FARG_mikrobus_logInit_baud+1 
	MOVLW       0
	MOVWF       FARG_mikrobus_logInit_baud+2 
	MOVWF       FARG_mikrobus_logInit_baud+3 
	CALL        _mikrobus_logInit+0, 0
;Click_6DOF_IMU_PIC.c,50 :: 		Delay_100ms();
	CALL        _Delay_100ms+0, 0
;Click_6DOF_IMU_PIC.c,51 :: 		}
L_end_systemInit:
	RETURN      0
; end of _systemInit

_applicationInit:

;Click_6DOF_IMU_PIC.c,53 :: 		void applicationInit()
;Click_6DOF_IMU_PIC.c,55 :: 		c6dofimu_i2cDriverInit( (T_C6DOFIMU_P)&_MIKROBUS1_GPIO, (T_C6DOFIMU_P)&_MIKROBUS1_I2C, _C6DOFIMU_I2C_ADDR );
	MOVLW       __MIKROBUS1_GPIO+0
	MOVWF       FARG_c6dofimu_i2cDriverInit_gpioObj+0 
	MOVLW       hi_addr(__MIKROBUS1_GPIO+0)
	MOVWF       FARG_c6dofimu_i2cDriverInit_gpioObj+1 
	MOVLW       higher_addr(__MIKROBUS1_GPIO+0)
	MOVWF       FARG_c6dofimu_i2cDriverInit_gpioObj+2 
	MOVLW       __MIKROBUS1_I2C+0
	MOVWF       FARG_c6dofimu_i2cDriverInit_i2cObj+0 
	MOVLW       hi_addr(__MIKROBUS1_I2C+0)
	MOVWF       FARG_c6dofimu_i2cDriverInit_i2cObj+1 
	MOVLW       higher_addr(__MIKROBUS1_I2C+0)
	MOVWF       FARG_c6dofimu_i2cDriverInit_i2cObj+2 
	MOVLW       107
	MOVWF       FARG_c6dofimu_i2cDriverInit_slave+0 
	CALL        _c6dofimu_i2cDriverInit+0, 0
;Click_6DOF_IMU_PIC.c,56 :: 		Delay_100ms();
	CALL        _Delay_100ms+0, 0
;Click_6DOF_IMU_PIC.c,59 :: 		c6dofimu_writeData( _C6DOFIMU_CTRL1_XL, _C6DOFIMU_CTRL12_CONFIG );
	MOVLW       16
	MOVWF       FARG_c6dofimu_writeData_address+0 
	MOVLW       128
	MOVWF       FARG_c6dofimu_writeData_writeCommand+0 
	CALL        _c6dofimu_writeData+0, 0
;Click_6DOF_IMU_PIC.c,60 :: 		Delay_10ms();
	CALL        _Delay_10ms+0, 0
;Click_6DOF_IMU_PIC.c,61 :: 		c6dofimu_writeData( _C6DOFIMU_CTRL2_G, _C6DOFIMU_CTRL12_CONFIG );
	MOVLW       17
	MOVWF       FARG_c6dofimu_writeData_address+0 
	MOVLW       128
	MOVWF       FARG_c6dofimu_writeData_writeCommand+0 
	CALL        _c6dofimu_writeData+0, 0
;Click_6DOF_IMU_PIC.c,62 :: 		Delay_10ms();
	CALL        _Delay_10ms+0, 0
;Click_6DOF_IMU_PIC.c,63 :: 		c6dofimu_writeData( _C6DOFIMU_CTRL3_C, _C6DOFIMU_CTRL3_C_CONFIG );
	MOVLW       18
	MOVWF       FARG_c6dofimu_writeData_address+0 
	MOVLW       4
	MOVWF       FARG_c6dofimu_writeData_writeCommand+0 
	CALL        _c6dofimu_writeData+0, 0
;Click_6DOF_IMU_PIC.c,64 :: 		Delay_10ms();
	CALL        _Delay_10ms+0, 0
;Click_6DOF_IMU_PIC.c,66 :: 		mikrobus_logWrite("      Accel            Gyro           Temp. °C",_LOG_LINE);
	MOVLW       ?lstr1_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr1_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,67 :: 		mikrobus_logWrite("---------------------------------------------------------", _LOG_LINE);
	MOVLW       ?lstr2_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr2_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,68 :: 		}
L_end_applicationInit:
	RETURN      0
; end of _applicationInit

_applicationTask:

;Click_6DOF_IMU_PIC.c,70 :: 		void applicationTask()
;Click_6DOF_IMU_PIC.c,72 :: 		c6dofimu_readAccel( &accelX, &accelY, &accelZ );
	MOVLW       _accelX+0
	MOVWF       FARG_c6dofimu_readAccel_accelX+0 
	MOVLW       hi_addr(_accelX+0)
	MOVWF       FARG_c6dofimu_readAccel_accelX+1 
	MOVLW       _accelY+0
	MOVWF       FARG_c6dofimu_readAccel_accelY+0 
	MOVLW       hi_addr(_accelY+0)
	MOVWF       FARG_c6dofimu_readAccel_accelY+1 
	MOVLW       _accelZ+0
	MOVWF       FARG_c6dofimu_readAccel_accelZ+0 
	MOVLW       hi_addr(_accelZ+0)
	MOVWF       FARG_c6dofimu_readAccel_accelZ+1 
	CALL        _c6dofimu_readAccel+0, 0
;Click_6DOF_IMU_PIC.c,73 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_6DOF_IMU_PIC.c,74 :: 		c6dofimu_readGyro(  &gyroX,  &gyroY, &gyroZ );
	MOVLW       _gyroX+0
	MOVWF       FARG_c6dofimu_readGyro_gyroX+0 
	MOVLW       hi_addr(_gyroX+0)
	MOVWF       FARG_c6dofimu_readGyro_gyroX+1 
	MOVLW       _gyroY+0
	MOVWF       FARG_c6dofimu_readGyro_gyroY+0 
	MOVLW       hi_addr(_gyroY+0)
	MOVWF       FARG_c6dofimu_readGyro_gyroY+1 
	MOVLW       _gyroZ+0
	MOVWF       FARG_c6dofimu_readGyro_gyroZ+0 
	MOVLW       hi_addr(_gyroZ+0)
	MOVWF       FARG_c6dofimu_readGyro_gyroZ+1 
	CALL        _c6dofimu_readGyro+0, 0
;Click_6DOF_IMU_PIC.c,75 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_6DOF_IMU_PIC.c,76 :: 		temperature = c6dofimu_readTemperature();
	CALL        _c6dofimu_readTemperature+0, 0
	MOVF        R0, 0 
	MOVWF       _temperature+0 
	MOVF        R1, 0 
	MOVWF       _temperature+1 
	MOVF        R2, 0 
	MOVWF       _temperature+2 
	MOVF        R3, 0 
	MOVWF       _temperature+3 
;Click_6DOF_IMU_PIC.c,77 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_6DOF_IMU_PIC.c,79 :: 		mikrobus_logWrite( " Accel X :", _LOG_TEXT );
	MOVLW       ?lstr3_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr3_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,80 :: 		IntToStr( accelX, logText );
	MOVF        _accelX+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _accelX+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _logText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Click_6DOF_IMU_PIC.c,81 :: 		mikrobus_logWrite( logText, _LOG_TEXT );
	MOVLW       _logText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,82 :: 		mikrobus_logWrite( "  |  ", _LOG_TEXT );
	MOVLW       ?lstr4_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr4_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,83 :: 		mikrobus_logWrite( " Gyro X :", _LOG_TEXT );
	MOVLW       ?lstr5_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr5_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,84 :: 		IntToStr( gyroX, logText );
	MOVF        _gyroX+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _gyroX+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _logText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Click_6DOF_IMU_PIC.c,85 :: 		mikrobus_logWrite( logText, _LOG_TEXT );
	MOVLW       _logText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,86 :: 		mikrobus_logWrite( "  *", _LOG_TEXT );
	MOVLW       ?lstr6_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr6_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,87 :: 		mikrobus_logWrite( "*****************", _LOG_LINE );
	MOVLW       ?lstr7_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr7_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,89 :: 		mikrobus_logWrite( " Accel Y :", _LOG_TEXT );
	MOVLW       ?lstr8_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr8_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,90 :: 		IntToStr( accelY, logText );
	MOVF        _accelY+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _accelY+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _logText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Click_6DOF_IMU_PIC.c,91 :: 		mikrobus_logWrite( logText, _LOG_TEXT );
	MOVLW       _logText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,92 :: 		mikrobus_logWrite( "  |  ", _LOG_TEXT );
	MOVLW       ?lstr9_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr9_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,93 :: 		mikrobus_logWrite( " Gyro Y :", _LOG_TEXT );
	MOVLW       ?lstr10_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr10_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,94 :: 		IntToStr( gyroY, logText );
	MOVF        _gyroY+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _gyroY+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _logText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Click_6DOF_IMU_PIC.c,95 :: 		mikrobus_logWrite( logText, _LOG_TEXT );
	MOVLW       _logText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,96 :: 		mikrobus_logWrite( "  *  ", _LOG_TEXT );
	MOVLW       ?lstr11_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr11_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,97 :: 		mikrobus_logWrite( "Temp.:", _LOG_TEXT );
	MOVLW       ?lstr12_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr12_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,98 :: 		IntToStr( temperature, logText );
	MOVF        _temperature+0, 0 
	MOVWF       R0 
	MOVF        _temperature+1, 0 
	MOVWF       R1 
	MOVF        _temperature+2, 0 
	MOVWF       R2 
	MOVF        _temperature+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _logText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Click_6DOF_IMU_PIC.c,99 :: 		mikrobus_logWrite( logText, _LOG_TEXT );
	MOVLW       _logText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,100 :: 		mikrobus_logWrite( "° *  ", _LOG_LINE );
	MOVLW       ?lstr13_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr13_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,102 :: 		mikrobus_logWrite( " Accel Z :", _LOG_TEXT );
	MOVLW       ?lstr14_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr14_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,103 :: 		IntToStr( accelZ, logText );
	MOVF        _accelZ+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _accelZ+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _logText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Click_6DOF_IMU_PIC.c,104 :: 		mikrobus_logWrite( logText, _LOG_TEXT );
	MOVLW       _logText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,105 :: 		mikrobus_logWrite( "  |  ", _LOG_TEXT );
	MOVLW       ?lstr15_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr15_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,106 :: 		mikrobus_logWrite( " Gyro Z :", _LOG_TEXT );
	MOVLW       ?lstr16_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr16_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,107 :: 		IntToStr( gyroZ, logText );
	MOVF        _gyroZ+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _gyroZ+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _logText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Click_6DOF_IMU_PIC.c,108 :: 		mikrobus_logWrite( logText, _LOG_TEXT );
	MOVLW       _logText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,109 :: 		mikrobus_logWrite( "  *", _LOG_TEXT );
	MOVLW       ?lstr17_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr17_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,110 :: 		mikrobus_logWrite( "*****************", _LOG_LINE );
	MOVLW       ?lstr18_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr18_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,112 :: 		mikrobus_logWrite("---------------------------------------------------------", _LOG_LINE);
	MOVLW       ?lstr19_Click_6DOF_IMU_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr19_Click_6DOF_IMU_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_6DOF_IMU_PIC.c,114 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;Click_6DOF_IMU_PIC.c,115 :: 		}
L_end_applicationTask:
	RETURN      0
; end of _applicationTask

_main:

;Click_6DOF_IMU_PIC.c,117 :: 		void main()
;Click_6DOF_IMU_PIC.c,119 :: 		systemInit();
	CALL        _systemInit+0, 0
;Click_6DOF_IMU_PIC.c,120 :: 		applicationInit();
	CALL        _applicationInit+0, 0
;Click_6DOF_IMU_PIC.c,122 :: 		while (1)
L_main0:
;Click_6DOF_IMU_PIC.c,124 :: 		applicationTask();
	CALL        _applicationTask+0, 0
;Click_6DOF_IMU_PIC.c,125 :: 		}
	GOTO        L_main0
;Click_6DOF_IMU_PIC.c,126 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
