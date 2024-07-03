
20240613_45PIC18_GNSS_GPS_Tracking_gnss4_configTimer:

;click_gnss4_timer.h,13 :: 		static void gnss4_configTimer()
;click_gnss4_timer.h,15 :: 		T1CON	 = 0x01;
	MOVLW       1
	MOVWF       T1CON+0 
;click_gnss4_timer.h,16 :: 		TMR1IF_bit	 = 0;
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;click_gnss4_timer.h,17 :: 		TMR1H	 = 0xC1;
	MOVLW       193
	MOVWF       TMR1H+0 
;click_gnss4_timer.h,18 :: 		TMR1L	 = 0x80;
	MOVLW       128
	MOVWF       TMR1L+0 
;click_gnss4_timer.h,19 :: 		TMR1IE_bit	 = 1;
	BSF         TMR1IE_bit+0, BitPos(TMR1IE_bit+0) 
;click_gnss4_timer.h,20 :: 		INTCON	 = 0xC0;
	MOVLW       192
	MOVWF       INTCON+0 
;click_gnss4_timer.h,21 :: 		}
L_end_gnss4_configTimer:
	RETURN      0
; end of 20240613_45PIC18_GNSS_GPS_Tracking_gnss4_configTimer

_Interrupt:

;click_gnss4_timer.h,23 :: 		void Interrupt()
;click_gnss4_timer.h,25 :: 		if (TMR1IF_bit != 0)
	BTFSS       TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
	GOTO        L_Interrupt0
;click_gnss4_timer.h,27 :: 		TMR1IF_bit = 0;
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;click_gnss4_timer.h,28 :: 		TMR1H	 = 0xC1;
	MOVLW       193
	MOVWF       TMR1H+0 
;click_gnss4_timer.h,29 :: 		TMR1L	 = 0x80;
	MOVLW       128
	MOVWF       TMR1L+0 
;click_gnss4_timer.h,31 :: 		gnss4_tick();
	CALL        _gnss4_tick+0, 0
;click_gnss4_timer.h,32 :: 		timerCounter++;
	MOVLW       1
	ADDWF       _timerCounter+0, 1 
	MOVLW       0
	ADDWFC      _timerCounter+1, 1 
	ADDWFC      _timerCounter+2, 1 
	ADDWFC      _timerCounter+3, 1 
;click_gnss4_timer.h,33 :: 		}
L_Interrupt0:
;click_gnss4_timer.h,34 :: 		}
L_end_Interrupt:
L__Interrupt29:
	RETFIE      1
; end of _Interrupt

_gnss4_default_handler:

;20240613-PIC18_GNSS_GPS_Tracking.c,56 :: 		void gnss4_default_handler( uint8_t *rsp, uint8_t *evArgs )
;20240613-PIC18_GNSS_GPS_Tracking.c,59 :: 		tmp = rsp;
	MOVF        FARG_gnss4_default_handler_rsp+0, 0 
	MOVWF       gnss4_default_handler_tmp_L0+0 
	MOVF        FARG_gnss4_default_handler_rsp+1, 0 
	MOVWF       gnss4_default_handler_tmp_L0+1 
;20240613-PIC18_GNSS_GPS_Tracking.c,61 :: 		mikrobus_logWrite( tmp, _LOG_TEXT );
	MOVF        FARG_gnss4_default_handler_rsp+0, 0 
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVF        FARG_gnss4_default_handler_rsp+1, 0 
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,62 :: 		if(*rsp == '$')
	MOVFF       FARG_gnss4_default_handler_rsp+0, FSR0
	MOVFF       FARG_gnss4_default_handler_rsp+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       36
	BTFSS       STATUS+0, 2 
	GOTO        L_gnss4_default_handler1
;20240613-PIC18_GNSS_GPS_Tracking.c,64 :: 		memset(&demoBuffer[0], 0, 500);
	MOVLW       _demoBuffer+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_demoBuffer+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       244
	MOVWF       FARG_memset_n+0 
	MOVLW       1
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,65 :: 		strcpy(demoBuffer, tmp);
	MOVLW       _demoBuffer+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_demoBuffer+0)
	MOVWF       FARG_strcpy_to+1 
	MOVF        gnss4_default_handler_tmp_L0+0, 0 
	MOVWF       FARG_strcpy_from+0 
	MOVF        gnss4_default_handler_tmp_L0+1, 0 
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,66 :: 		}
L_gnss4_default_handler1:
;20240613-PIC18_GNSS_GPS_Tracking.c,67 :: 		}
L_end_gnss4_default_handler:
	RETURN      0
; end of _gnss4_default_handler

_main:

;20240613-PIC18_GNSS_GPS_Tracking.c,73 :: 		void main()
;20240613-PIC18_GNSS_GPS_Tracking.c,76 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
	CLRF        FARG_mikrobus_gpioInit_bus+0 
	MOVLW       1
	MOVWF       FARG_mikrobus_gpioInit_pin+0 
	CLRF        FARG_mikrobus_gpioInit_direction+0 
	CALL        _mikrobus_gpioInit+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,81 :: 		mikrobus_uartInit( _MIKROBUS1, &_GNSS4_UART_CFG[0] );
	CLRF        FARG_mikrobus_uartInit_bus+0 
	MOVLW       __GNSS4_UART_CFG+0
	MOVWF       FARG_mikrobus_uartInit_cfg+0 
	MOVLW       hi_addr(__GNSS4_UART_CFG+0)
	MOVWF       FARG_mikrobus_uartInit_cfg+1 
	MOVLW       higher_addr(__GNSS4_UART_CFG+0)
	MOVWF       FARG_mikrobus_uartInit_cfg+2 
	CALL        _mikrobus_uartInit+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,82 :: 		mikrobus_logInit( _MIKROBUS3, 9600 );
	MOVLW       2
	MOVWF       FARG_mikrobus_logInit_port+0 
	MOVLW       128
	MOVWF       FARG_mikrobus_logInit_baud+0 
	MOVLW       37
	MOVWF       FARG_mikrobus_logInit_baud+1 
	MOVLW       0
	MOVWF       FARG_mikrobus_logInit_baud+2 
	MOVWF       FARG_mikrobus_logInit_baud+3 
	CALL        _mikrobus_logInit+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,83 :: 		mikrobus_logWrite( " ---- System Init ---- ", _LOG_LINE);
	MOVLW       ?lstr1_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr1_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,86 :: 		gnss4_configTimer();
	CALL        20240613_45PIC18_GNSS_GPS_Tracking_gnss4_configTimer+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,89 :: 		gnss4_uartDriverInit((T_GNSS4_P)&_MIKROBUS1_GPIO, (T_GNSS4_P)&_MIKROBUS1_UART);
	MOVLW       __MIKROBUS1_GPIO+0
	MOVWF       FARG_gnss4_uartDriverInit_gpioObj+0 
	MOVLW       hi_addr(__MIKROBUS1_GPIO+0)
	MOVWF       FARG_gnss4_uartDriverInit_gpioObj+1 
	MOVLW       higher_addr(__MIKROBUS1_GPIO+0)
	MOVWF       FARG_gnss4_uartDriverInit_gpioObj+2 
	MOVLW       __MIKROBUS1_UART+0
	MOVWF       FARG_gnss4_uartDriverInit_uartObj+0 
	MOVLW       hi_addr(__MIKROBUS1_UART+0)
	MOVWF       FARG_gnss4_uartDriverInit_uartObj+1 
	MOVLW       higher_addr(__MIKROBUS1_UART+0)
	MOVWF       FARG_gnss4_uartDriverInit_uartObj+2 
	CALL        _gnss4_uartDriverInit+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,90 :: 		gnss4_coreInit( gnss4_default_handler, 1500 );
	MOVLW       _gnss4_default_handler+0
	MOVWF       FARG_gnss4_coreInit_defaultHdl+0 
	MOVLW       hi_addr(_gnss4_default_handler+0)
	MOVWF       FARG_gnss4_coreInit_defaultHdl+1 
	MOVLW       FARG_gnss4_default_handler_rsp+0
	MOVWF       FARG_gnss4_coreInit_defaultHdl+2 
	MOVLW       hi_addr(FARG_gnss4_default_handler_rsp+0)
	MOVWF       FARG_gnss4_coreInit_defaultHdl+3 
	MOVLW       220
	MOVWF       FARG_gnss4_coreInit_defaultWdog+0 
	MOVLW       5
	MOVWF       FARG_gnss4_coreInit_defaultWdog+1 
	MOVLW       0
	MOVWF       FARG_gnss4_coreInit_defaultWdog+2 
	MOVWF       FARG_gnss4_coreInit_defaultWdog+3 
	CALL        _gnss4_coreInit+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,93 :: 		gnss4_hfcEnable( 1 );
	MOVLW       1
	MOVWF       FARG_gnss4_hfcEnable_hfcState+0 
	CALL        _gnss4_hfcEnable+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,94 :: 		gnss4_modulePower( 1 );
	MOVLW       1
	MOVWF       FARG_gnss4_modulePower_powerState+0 
	CALL        _gnss4_modulePower+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,96 :: 		Delay_ms( 5000 );
	MOVLW       2
	MOVWF       R10, 0
	MOVLW       150
	MOVWF       R11, 0
	MOVLW       216
	MOVWF       R12, 0
	MOVLW       8
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	DECFSZ      R10, 1, 1
	BRA         L_main2
	NOP
;20240613-PIC18_GNSS_GPS_Tracking.c,97 :: 		timerCounter = 0;
	CLRF        _timerCounter+0 
	CLRF        _timerCounter+1 
	CLRF        _timerCounter+2 
	CLRF        _timerCounter+3 
;20240613-PIC18_GNSS_GPS_Tracking.c,99 :: 		while(1)
L_main3:
;20240613-PIC18_GNSS_GPS_Tracking.c,101 :: 		IMU_Task();
	CALL        _IMU_Task+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,102 :: 		}
	GOTO        L_main3
;20240613-PIC18_GNSS_GPS_Tracking.c,184 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_IMU_Task:

;20240613-PIC18_GNSS_GPS_Tracking.c,190 :: 		void IMU_Task()
;20240613-PIC18_GNSS_GPS_Tracking.c,192 :: 		c6dofimu_readAccel( &accelX, &accelY, &accelZ );
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
;20240613-PIC18_GNSS_GPS_Tracking.c,193 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,194 :: 		c6dofimu_readGyro(  &gyroX,  &gyroY, &gyroZ );
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
;20240613-PIC18_GNSS_GPS_Tracking.c,195 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,196 :: 		temperature = c6dofimu_readTemperature();
	CALL        _c6dofimu_readTemperature+0, 0
	MOVF        R0, 0 
	MOVWF       _temperature+0 
	MOVF        R1, 0 
	MOVWF       _temperature+1 
	MOVF        R2, 0 
	MOVWF       _temperature+2 
	MOVF        R3, 0 
	MOVWF       _temperature+3 
;20240613-PIC18_GNSS_GPS_Tracking.c,197 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,199 :: 		mikrobus_logWrite( " Accel X :", _LOG_TEXT );
	MOVLW       ?lstr17_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr17_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,200 :: 		IntToStr( accelX, logText );
	MOVF        _accelX+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _accelX+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _logText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,201 :: 		mikrobus_logWrite( logText, _LOG_TEXT );
	MOVLW       _logText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,202 :: 		mikrobus_logWrite( "  |  ", _LOG_TEXT );
	MOVLW       ?lstr18_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr18_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,203 :: 		mikrobus_logWrite( " Gyro X :", _LOG_TEXT );
	MOVLW       ?lstr19_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr19_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,204 :: 		IntToStr( gyroX, logText );
	MOVF        _gyroX+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _gyroX+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _logText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,205 :: 		mikrobus_logWrite( logText, _LOG_TEXT );
	MOVLW       _logText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,206 :: 		mikrobus_logWrite( "  *", _LOG_TEXT );
	MOVLW       ?lstr20_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr20_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,207 :: 		mikrobus_logWrite( "*****************", _LOG_LINE );
	MOVLW       ?lstr21_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr21_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,209 :: 		mikrobus_logWrite( " Accel Y :", _LOG_TEXT );
	MOVLW       ?lstr22_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr22_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,210 :: 		IntToStr( accelY, logText );
	MOVF        _accelY+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _accelY+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _logText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,211 :: 		mikrobus_logWrite( logText, _LOG_TEXT );
	MOVLW       _logText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,212 :: 		mikrobus_logWrite( "  |  ", _LOG_TEXT );
	MOVLW       ?lstr23_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr23_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,213 :: 		mikrobus_logWrite( " Gyro Y :", _LOG_TEXT );
	MOVLW       ?lstr24_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr24_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,214 :: 		IntToStr( gyroY, logText );
	MOVF        _gyroY+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _gyroY+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _logText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,215 :: 		mikrobus_logWrite( logText, _LOG_TEXT );
	MOVLW       _logText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,216 :: 		mikrobus_logWrite( "  *  ", _LOG_TEXT );
	MOVLW       ?lstr25_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr25_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,217 :: 		mikrobus_logWrite( "Temp.:", _LOG_TEXT );
	MOVLW       ?lstr26_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr26_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,218 :: 		IntToStr( temperature, logText );
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
;20240613-PIC18_GNSS_GPS_Tracking.c,219 :: 		mikrobus_logWrite( logText, _LOG_TEXT );
	MOVLW       _logText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,220 :: 		mikrobus_logWrite( "° *  ", _LOG_LINE );
	MOVLW       ?lstr27_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr27_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,222 :: 		mikrobus_logWrite( " Accel Z :", _LOG_TEXT );
	MOVLW       ?lstr28_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr28_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,223 :: 		IntToStr( accelZ, logText );
	MOVF        _accelZ+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _accelZ+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _logText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,224 :: 		mikrobus_logWrite( logText, _LOG_TEXT );
	MOVLW       _logText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,225 :: 		mikrobus_logWrite( "  |  ", _LOG_TEXT );
	MOVLW       ?lstr29_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr29_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,226 :: 		mikrobus_logWrite( " Gyro Z :", _LOG_TEXT );
	MOVLW       ?lstr30_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr30_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,227 :: 		IntToStr( gyroZ, logText );
	MOVF        _gyroZ+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _gyroZ+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _logText+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,228 :: 		mikrobus_logWrite( logText, _LOG_TEXT );
	MOVLW       _logText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_logText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,229 :: 		mikrobus_logWrite( "  *", _LOG_TEXT );
	MOVLW       ?lstr31_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr31_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,230 :: 		mikrobus_logWrite( "*****************", _LOG_LINE );
	MOVLW       ?lstr32_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr32_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,232 :: 		mikrobus_logWrite("---------------------------------------------------------", _LOG_LINE);
	MOVLW       ?lstr33_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr33_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,234 :: 		Delay_1sec();
	CALL        _Delay_1sec+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,235 :: 		}
L_end_IMU_Task:
	RETURN      0
; end of _IMU_Task
