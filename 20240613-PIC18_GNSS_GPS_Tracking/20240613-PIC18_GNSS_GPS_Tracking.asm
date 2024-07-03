
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
L__Interrupt27:
	RETFIE      1
; end of _Interrupt

_gnss4_default_handler:

;20240613-PIC18_GNSS_GPS_Tracking.c,53 :: 		void gnss4_default_handler( uint8_t *rsp, uint8_t *evArgs )
;20240613-PIC18_GNSS_GPS_Tracking.c,56 :: 		tmp = rsp;
	MOVF        FARG_gnss4_default_handler_rsp+0, 0 
	MOVWF       gnss4_default_handler_tmp_L0+0 
	MOVF        FARG_gnss4_default_handler_rsp+1, 0 
	MOVWF       gnss4_default_handler_tmp_L0+1 
;20240613-PIC18_GNSS_GPS_Tracking.c,58 :: 		mikrobus_logWrite( tmp, _LOG_TEXT );
	MOVF        FARG_gnss4_default_handler_rsp+0, 0 
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVF        FARG_gnss4_default_handler_rsp+1, 0 
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,59 :: 		if(*rsp == '$')
	MOVFF       FARG_gnss4_default_handler_rsp+0, FSR0
	MOVFF       FARG_gnss4_default_handler_rsp+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       36
	BTFSS       STATUS+0, 2 
	GOTO        L_gnss4_default_handler1
;20240613-PIC18_GNSS_GPS_Tracking.c,61 :: 		memset(&demoBuffer[0], 0, 500);
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
;20240613-PIC18_GNSS_GPS_Tracking.c,62 :: 		strcpy(demoBuffer, tmp);
	MOVLW       _demoBuffer+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_demoBuffer+0)
	MOVWF       FARG_strcpy_to+1 
	MOVF        gnss4_default_handler_tmp_L0+0, 0 
	MOVWF       FARG_strcpy_from+0 
	MOVF        gnss4_default_handler_tmp_L0+1, 0 
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,63 :: 		}
L_gnss4_default_handler1:
;20240613-PIC18_GNSS_GPS_Tracking.c,64 :: 		}
L_end_gnss4_default_handler:
	RETURN      0
; end of _gnss4_default_handler

_systemInit:

;20240613-PIC18_GNSS_GPS_Tracking.c,66 :: 		void systemInit()
;20240613-PIC18_GNSS_GPS_Tracking.c,68 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
	CLRF        FARG_mikrobus_gpioInit_bus+0 
	MOVLW       1
	MOVWF       FARG_mikrobus_gpioInit_pin+0 
	CLRF        FARG_mikrobus_gpioInit_direction+0 
	CALL        _mikrobus_gpioInit+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,69 :: 		mikrobus_uartInit( _MIKROBUS1, &_GNSS4_UART_CFG[0] );
	CLRF        FARG_mikrobus_uartInit_bus+0 
	MOVLW       __GNSS4_UART_CFG+0
	MOVWF       FARG_mikrobus_uartInit_cfg+0 
	MOVLW       hi_addr(__GNSS4_UART_CFG+0)
	MOVWF       FARG_mikrobus_uartInit_cfg+1 
	MOVLW       higher_addr(__GNSS4_UART_CFG+0)
	MOVWF       FARG_mikrobus_uartInit_cfg+2 
	CALL        _mikrobus_uartInit+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,70 :: 		mikrobus_logInit( _MIKROBUS3, 9600 );
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
;20240613-PIC18_GNSS_GPS_Tracking.c,71 :: 		mikrobus_logWrite( " ---- System Init ---- ", _LOG_LINE);
	MOVLW       ?lstr1_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr1_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,72 :: 		}
L_end_systemInit:
	RETURN      0
; end of _systemInit

_applicationInit:

;20240613-PIC18_GNSS_GPS_Tracking.c,74 :: 		void applicationInit()
;20240613-PIC18_GNSS_GPS_Tracking.c,77 :: 		gnss4_configTimer();
	CALL        20240613_45PIC18_GNSS_GPS_Tracking_gnss4_configTimer+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,80 :: 		gnss4_uartDriverInit((T_GNSS4_P)&_MIKROBUS1_GPIO, (T_GNSS4_P)&_MIKROBUS1_UART);
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
;20240613-PIC18_GNSS_GPS_Tracking.c,81 :: 		gnss4_coreInit( gnss4_default_handler, 1500 );
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
;20240613-PIC18_GNSS_GPS_Tracking.c,84 :: 		gnss4_hfcEnable( 1 );
	MOVLW       1
	MOVWF       FARG_gnss4_hfcEnable_hfcState+0 
	CALL        _gnss4_hfcEnable+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,85 :: 		gnss4_modulePower( 1 );
	MOVLW       1
	MOVWF       FARG_gnss4_modulePower_powerState+0 
	CALL        _gnss4_modulePower+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,87 :: 		Delay_ms( 5000 );
	MOVLW       2
	MOVWF       R10, 0
	MOVLW       150
	MOVWF       R11, 0
	MOVLW       216
	MOVWF       R12, 0
	MOVLW       8
	MOVWF       R13, 0
L_applicationInit2:
	DECFSZ      R13, 1, 1
	BRA         L_applicationInit2
	DECFSZ      R12, 1, 1
	BRA         L_applicationInit2
	DECFSZ      R11, 1, 1
	BRA         L_applicationInit2
	DECFSZ      R10, 1, 1
	BRA         L_applicationInit2
	NOP
;20240613-PIC18_GNSS_GPS_Tracking.c,88 :: 		timerCounter = 0;
	CLRF        _timerCounter+0 
	CLRF        _timerCounter+1 
	CLRF        _timerCounter+2 
	CLRF        _timerCounter+3 
;20240613-PIC18_GNSS_GPS_Tracking.c,89 :: 		}
L_end_applicationInit:
	RETURN      0
; end of _applicationInit

_applicationTask:

;20240613-PIC18_GNSS_GPS_Tracking.c,91 :: 		void applicationTask()
;20240613-PIC18_GNSS_GPS_Tracking.c,96 :: 		}
L_end_applicationTask:
	RETURN      0
; end of _applicationTask

_main:

;20240613-PIC18_GNSS_GPS_Tracking.c,100 :: 		void main()
;20240613-PIC18_GNSS_GPS_Tracking.c,102 :: 		systemInit();
	CALL        _systemInit+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,103 :: 		applicationInit();
	CALL        _applicationInit+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,110 :: 		while (1)
L_main3:
;20240613-PIC18_GNSS_GPS_Tracking.c,113 :: 		gnss4_process();
	CALL        _gnss4_process+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,115 :: 		if(timerCounter > 5000)
	MOVF        _timerCounter+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVF        _timerCounter+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVF        _timerCounter+1, 0 
	SUBLW       19
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVF        _timerCounter+0, 0 
	SUBLW       136
L__main33:
	BTFSC       STATUS+0, 0 
	GOTO        L_main5
;20240613-PIC18_GNSS_GPS_Tracking.c,117 :: 		pFlag++;
	INCF        _pFlag+0, 1 
;20240613-PIC18_GNSS_GPS_Tracking.c,118 :: 		if(pFlag > 2)
	MOVF        _pFlag+0, 0 
	SUBLW       2
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;20240613-PIC18_GNSS_GPS_Tracking.c,120 :: 		pFlag = 0;
	CLRF        _pFlag+0 
;20240613-PIC18_GNSS_GPS_Tracking.c,121 :: 		}
L_main6:
;20240613-PIC18_GNSS_GPS_Tracking.c,122 :: 		timerCounter = 0;
	CLRF        _timerCounter+0 
	CLRF        _timerCounter+1 
	CLRF        _timerCounter+2 
	CLRF        _timerCounter+3 
;20240613-PIC18_GNSS_GPS_Tracking.c,123 :: 		dispFlag = 1;
	MOVLW       1
	MOVWF       _dispFlag+0 
;20240613-PIC18_GNSS_GPS_Tracking.c,124 :: 		}
L_main5:
;20240613-PIC18_GNSS_GPS_Tracking.c,126 :: 		if(pFlag == 0 && dispFlag == 1)
	MOVF        _pFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
	MOVF        _dispFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
L__main24:
;20240613-PIC18_GNSS_GPS_Tracking.c,128 :: 		mikrobus_logWrite( "  ", _LOG_LINE);
	MOVLW       ?lstr2_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr2_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,129 :: 		mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
	MOVLW       ?lstr3_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr3_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,130 :: 		pLat = gnss4_parser(&demoBuffer[0], &demoCommand[0], 2);
	MOVLW       _demoBuffer+0
	MOVWF       FARG_gnss4_parser_dataIn+0 
	MOVLW       hi_addr(_demoBuffer+0)
	MOVWF       FARG_gnss4_parser_dataIn+1 
	MOVLW       _demoCommand+0
	MOVWF       FARG_gnss4_parser_command+0 
	MOVLW       hi_addr(_demoCommand+0)
	MOVWF       FARG_gnss4_parser_command+1 
	MOVLW       2
	MOVWF       FARG_gnss4_parser_dataPos+0 
	CALL        _gnss4_parser+0, 0
	MOVF        R0, 0 
	MOVWF       _pLat+0 
	MOVF        R1, 0 
	MOVWF       _pLat+1 
;20240613-PIC18_GNSS_GPS_Tracking.c,132 :: 		if(pLat == 0)
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main34
	MOVLW       0
	XORWF       R0, 0 
L__main34:
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
;20240613-PIC18_GNSS_GPS_Tracking.c,134 :: 		mikrobus_logWrite( " Latitude : No data available!", _LOG_LINE);
	MOVLW       ?lstr4_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr4_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,135 :: 		}
	GOTO        L_main11
L_main10:
;20240613-PIC18_GNSS_GPS_Tracking.c,138 :: 		strcpy(&rspCom[0], pLat);
	MOVLW       _rspCom+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_rspCom+0)
	MOVWF       FARG_strcpy_to+1 
	MOVF        _pLat+0, 0 
	MOVWF       FARG_strcpy_from+0 
	MOVF        _pLat+1, 0 
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,139 :: 		mikrobus_logWrite( " Latitude : ", _LOG_TEXT);
	MOVLW       ?lstr5_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr5_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,140 :: 		mikrobus_logWrite(rspCom, _LOG_LINE);
	MOVLW       _rspCom+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_rspCom+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,141 :: 		}
L_main11:
;20240613-PIC18_GNSS_GPS_Tracking.c,142 :: 		dispFlag = 0;
	CLRF        _dispFlag+0 
;20240613-PIC18_GNSS_GPS_Tracking.c,143 :: 		mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
	MOVLW       ?lstr6_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr6_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,144 :: 		}
L_main9:
;20240613-PIC18_GNSS_GPS_Tracking.c,146 :: 		if(pFlag == 2 &&  dispFlag == 1)
	MOVF        _pFlag+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
	MOVF        _dispFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
L__main23:
;20240613-PIC18_GNSS_GPS_Tracking.c,148 :: 		mikrobus_logWrite( "  ", _LOG_LINE);
	MOVLW       ?lstr7_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr7_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,149 :: 		mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
	MOVLW       ?lstr8_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr8_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,150 :: 		pAlt = gnss4_parser(&demoBuffer[0], &demoCommand[0], 9);
	MOVLW       _demoBuffer+0
	MOVWF       FARG_gnss4_parser_dataIn+0 
	MOVLW       hi_addr(_demoBuffer+0)
	MOVWF       FARG_gnss4_parser_dataIn+1 
	MOVLW       _demoCommand+0
	MOVWF       FARG_gnss4_parser_command+0 
	MOVLW       hi_addr(_demoCommand+0)
	MOVWF       FARG_gnss4_parser_command+1 
	MOVLW       9
	MOVWF       FARG_gnss4_parser_dataPos+0 
	CALL        _gnss4_parser+0, 0
	MOVF        R0, 0 
	MOVWF       _pAlt+0 
	MOVF        R1, 0 
	MOVWF       _pAlt+1 
;20240613-PIC18_GNSS_GPS_Tracking.c,151 :: 		if(pAlt == 0)
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main35
	MOVLW       0
	XORWF       R0, 0 
L__main35:
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
;20240613-PIC18_GNSS_GPS_Tracking.c,153 :: 		mikrobus_logWrite( " Altitude : No data available!", _LOG_LINE);
	MOVLW       ?lstr9_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr9_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,154 :: 		}
	GOTO        L_main16
L_main15:
;20240613-PIC18_GNSS_GPS_Tracking.c,157 :: 		strcpy(&rspCom[0], pAlt);
	MOVLW       _rspCom+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_rspCom+0)
	MOVWF       FARG_strcpy_to+1 
	MOVF        _pAlt+0, 0 
	MOVWF       FARG_strcpy_from+0 
	MOVF        _pAlt+1, 0 
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,158 :: 		mikrobus_logWrite( " Altitude : ", _LOG_TEXT);
	MOVLW       ?lstr10_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr10_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,159 :: 		mikrobus_logWrite(rspCom, _LOG_LINE);
	MOVLW       _rspCom+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_rspCom+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,160 :: 		}
L_main16:
;20240613-PIC18_GNSS_GPS_Tracking.c,161 :: 		dispFlag = 0;
	CLRF        _dispFlag+0 
;20240613-PIC18_GNSS_GPS_Tracking.c,162 :: 		mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
	MOVLW       ?lstr11_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr11_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,163 :: 		}
L_main14:
;20240613-PIC18_GNSS_GPS_Tracking.c,165 :: 		if(pFlag == 1 && dispFlag == 1)
	MOVF        _pFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main19
	MOVF        _dispFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main19
L__main22:
;20240613-PIC18_GNSS_GPS_Tracking.c,167 :: 		mikrobus_logWrite( "  ", _LOG_LINE);
	MOVLW       ?lstr12_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr12_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,168 :: 		mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
	MOVLW       ?lstr13_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr13_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,169 :: 		pLong = gnss4_parser(&demoBuffer[0], &demoCommand[0], 4);
	MOVLW       _demoBuffer+0
	MOVWF       FARG_gnss4_parser_dataIn+0 
	MOVLW       hi_addr(_demoBuffer+0)
	MOVWF       FARG_gnss4_parser_dataIn+1 
	MOVLW       _demoCommand+0
	MOVWF       FARG_gnss4_parser_command+0 
	MOVLW       hi_addr(_demoCommand+0)
	MOVWF       FARG_gnss4_parser_command+1 
	MOVLW       4
	MOVWF       FARG_gnss4_parser_dataPos+0 
	CALL        _gnss4_parser+0, 0
	MOVF        R0, 0 
	MOVWF       _pLong+0 
	MOVF        R1, 0 
	MOVWF       _pLong+1 
;20240613-PIC18_GNSS_GPS_Tracking.c,170 :: 		if(pLong == 0)
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main36
	MOVLW       0
	XORWF       R0, 0 
L__main36:
	BTFSS       STATUS+0, 2 
	GOTO        L_main20
;20240613-PIC18_GNSS_GPS_Tracking.c,172 :: 		mikrobus_logWrite( " Longitude : No data available!", _LOG_LINE);
	MOVLW       ?lstr14_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr14_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,173 :: 		}
	GOTO        L_main21
L_main20:
;20240613-PIC18_GNSS_GPS_Tracking.c,176 :: 		strcpy(&rspCom[0], pLong);
	MOVLW       _rspCom+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_rspCom+0)
	MOVWF       FARG_strcpy_to+1 
	MOVF        _pLong+0, 0 
	MOVWF       FARG_strcpy_from+0 
	MOVF        _pLong+1, 0 
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,177 :: 		mikrobus_logWrite( " Longitude : ", _LOG_TEXT);
	MOVLW       ?lstr15_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr15_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,178 :: 		mikrobus_logWrite(rspCom, _LOG_LINE);
	MOVLW       _rspCom+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_rspCom+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,179 :: 		}
L_main21:
;20240613-PIC18_GNSS_GPS_Tracking.c,180 :: 		dispFlag = 0;
	CLRF        _dispFlag+0 
;20240613-PIC18_GNSS_GPS_Tracking.c,181 :: 		mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
	MOVLW       ?lstr16_20240613_45PIC18_GNSS_GPS_Tracking+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr16_20240613_45PIC18_GNSS_GPS_Tracking+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;20240613-PIC18_GNSS_GPS_Tracking.c,182 :: 		}
L_main19:
;20240613-PIC18_GNSS_GPS_Tracking.c,183 :: 		}
	GOTO        L_main3
;20240613-PIC18_GNSS_GPS_Tracking.c,184 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
