
Click_GNSS4_PIC_gnss4_configTimer:

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
; end of Click_GNSS4_PIC_gnss4_configTimer

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

;Click_GNSS4_PIC.c,51 :: 		void gnss4_default_handler( uint8_t *rsp, uint8_t *evArgs )
;Click_GNSS4_PIC.c,54 :: 		tmp = rsp;
	MOVF        FARG_gnss4_default_handler_rsp+0, 0 
	MOVWF       gnss4_default_handler_tmp_L0+0 
	MOVF        FARG_gnss4_default_handler_rsp+1, 0 
	MOVWF       gnss4_default_handler_tmp_L0+1 
;Click_GNSS4_PIC.c,56 :: 		mikrobus_logWrite( tmp, _LOG_TEXT );
	MOVF        FARG_gnss4_default_handler_rsp+0, 0 
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVF        FARG_gnss4_default_handler_rsp+1, 0 
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,57 :: 		if(*rsp == '$')
	MOVFF       FARG_gnss4_default_handler_rsp+0, FSR0
	MOVFF       FARG_gnss4_default_handler_rsp+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       36
	BTFSS       STATUS+0, 2 
	GOTO        L_gnss4_default_handler1
;Click_GNSS4_PIC.c,59 :: 		memset(&demoBuffer[0], 0, 500);
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
;Click_GNSS4_PIC.c,60 :: 		strcpy(demoBuffer, tmp);
	MOVLW       _demoBuffer+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_demoBuffer+0)
	MOVWF       FARG_strcpy_to+1 
	MOVF        gnss4_default_handler_tmp_L0+0, 0 
	MOVWF       FARG_strcpy_from+0 
	MOVF        gnss4_default_handler_tmp_L0+1, 0 
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;Click_GNSS4_PIC.c,61 :: 		}
L_gnss4_default_handler1:
;Click_GNSS4_PIC.c,62 :: 		}
L_end_gnss4_default_handler:
	RETURN      0
; end of _gnss4_default_handler

_systemInit:

;Click_GNSS4_PIC.c,64 :: 		void systemInit()
;Click_GNSS4_PIC.c,66 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
	CLRF        FARG_mikrobus_gpioInit_bus+0 
	MOVLW       1
	MOVWF       FARG_mikrobus_gpioInit_pin+0 
	CLRF        FARG_mikrobus_gpioInit_direction+0 
	CALL        _mikrobus_gpioInit+0, 0
;Click_GNSS4_PIC.c,67 :: 		mikrobus_uartInit( _MIKROBUS1, &_GNSS4_UART_CFG[0] );
	CLRF        FARG_mikrobus_uartInit_bus+0 
	MOVLW       __GNSS4_UART_CFG+0
	MOVWF       FARG_mikrobus_uartInit_cfg+0 
	MOVLW       hi_addr(__GNSS4_UART_CFG+0)
	MOVWF       FARG_mikrobus_uartInit_cfg+1 
	MOVLW       higher_addr(__GNSS4_UART_CFG+0)
	MOVWF       FARG_mikrobus_uartInit_cfg+2 
	CALL        _mikrobus_uartInit+0, 0
;Click_GNSS4_PIC.c,68 :: 		mikrobus_logInit( _MIKROBUS3, 9600 );
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
;Click_GNSS4_PIC.c,69 :: 		mikrobus_logWrite( " ---- System Init ---- ", _LOG_LINE);
	MOVLW       ?lstr1_Click_GNSS4_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr1_Click_GNSS4_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,70 :: 		}
L_end_systemInit:
	RETURN      0
; end of _systemInit

_applicationInit:

;Click_GNSS4_PIC.c,72 :: 		void applicationInit()
;Click_GNSS4_PIC.c,75 :: 		gnss4_configTimer();
	CALL        Click_GNSS4_PIC_gnss4_configTimer+0, 0
;Click_GNSS4_PIC.c,78 :: 		gnss4_uartDriverInit((T_GNSS4_P)&_MIKROBUS1_GPIO, (T_GNSS4_P)&_MIKROBUS1_UART);
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
;Click_GNSS4_PIC.c,79 :: 		gnss4_coreInit( gnss4_default_handler, 1500 );
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
;Click_GNSS4_PIC.c,82 :: 		gnss4_hfcEnable( 1 );
	MOVLW       1
	MOVWF       FARG_gnss4_hfcEnable_hfcState+0 
	CALL        _gnss4_hfcEnable+0, 0
;Click_GNSS4_PIC.c,83 :: 		gnss4_modulePower( 1 );
	MOVLW       1
	MOVWF       FARG_gnss4_modulePower_powerState+0 
	CALL        _gnss4_modulePower+0, 0
;Click_GNSS4_PIC.c,85 :: 		Delay_ms( 5000 );
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
;Click_GNSS4_PIC.c,86 :: 		timerCounter = 0;
	CLRF        _timerCounter+0 
	CLRF        _timerCounter+1 
	CLRF        _timerCounter+2 
	CLRF        _timerCounter+3 
;Click_GNSS4_PIC.c,87 :: 		}
L_end_applicationInit:
	RETURN      0
; end of _applicationInit

_applicationTask:

;Click_GNSS4_PIC.c,89 :: 		void applicationTask()
;Click_GNSS4_PIC.c,94 :: 		char rspCom[ 50 ] = {0};
	MOVLW       ?ICSapplicationTask_rspCom_L0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICSapplicationTask_rspCom_L0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICSapplicationTask_rspCom_L0+0)
	MOVWF       TBLPTRU 
	MOVLW       applicationTask_rspCom_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(applicationTask_rspCom_L0+0)
	MOVWF       FSR1H 
	MOVLW       50
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;Click_GNSS4_PIC.c,97 :: 		gnss4_process();
	CALL        _gnss4_process+0, 0
;Click_GNSS4_PIC.c,99 :: 		if(timerCounter > 5000)
	MOVF        _timerCounter+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__applicationTask32
	MOVF        _timerCounter+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__applicationTask32
	MOVF        _timerCounter+1, 0 
	SUBLW       19
	BTFSS       STATUS+0, 2 
	GOTO        L__applicationTask32
	MOVF        _timerCounter+0, 0 
	SUBLW       136
L__applicationTask32:
	BTFSC       STATUS+0, 0 
	GOTO        L_applicationTask3
;Click_GNSS4_PIC.c,101 :: 		pFlag++;
	INCF        _pFlag+0, 1 
;Click_GNSS4_PIC.c,102 :: 		if(pFlag > 2)
	MOVF        _pFlag+0, 0 
	SUBLW       2
	BTFSC       STATUS+0, 0 
	GOTO        L_applicationTask4
;Click_GNSS4_PIC.c,104 :: 		pFlag = 0;
	CLRF        _pFlag+0 
;Click_GNSS4_PIC.c,105 :: 		}
L_applicationTask4:
;Click_GNSS4_PIC.c,106 :: 		timerCounter = 0;
	CLRF        _timerCounter+0 
	CLRF        _timerCounter+1 
	CLRF        _timerCounter+2 
	CLRF        _timerCounter+3 
;Click_GNSS4_PIC.c,107 :: 		dispFlag = 1;
	MOVLW       1
	MOVWF       _dispFlag+0 
;Click_GNSS4_PIC.c,108 :: 		}
L_applicationTask3:
;Click_GNSS4_PIC.c,110 :: 		if(pFlag == 0 && dispFlag == 1)
	MOVF        _pFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_applicationTask7
	MOVF        _dispFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_applicationTask7
L__applicationTask24:
;Click_GNSS4_PIC.c,112 :: 		mikrobus_logWrite( "  ", _LOG_LINE);
	MOVLW       ?lstr2_Click_GNSS4_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr2_Click_GNSS4_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,113 :: 		mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
	MOVLW       ?lstr3_Click_GNSS4_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr3_Click_GNSS4_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,114 :: 		pLat = gnss4_parser(&demoBuffer[0], &demoCommand[0], 2);
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
	MOVWF       applicationTask_pLat_L0+0 
	MOVF        R1, 0 
	MOVWF       applicationTask_pLat_L0+1 
;Click_GNSS4_PIC.c,116 :: 		if(pLat == 0)
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__applicationTask33
	MOVLW       0
	XORWF       R0, 0 
L__applicationTask33:
	BTFSS       STATUS+0, 2 
	GOTO        L_applicationTask8
;Click_GNSS4_PIC.c,118 :: 		mikrobus_logWrite( " Latitude : No data available!", _LOG_LINE);
	MOVLW       ?lstr4_Click_GNSS4_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr4_Click_GNSS4_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,119 :: 		}
	GOTO        L_applicationTask9
L_applicationTask8:
;Click_GNSS4_PIC.c,122 :: 		strcpy(&rspCom[0], pLat);
	MOVLW       applicationTask_rspCom_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(applicationTask_rspCom_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVF        applicationTask_pLat_L0+0, 0 
	MOVWF       FARG_strcpy_from+0 
	MOVF        applicationTask_pLat_L0+1, 0 
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;Click_GNSS4_PIC.c,123 :: 		mikrobus_logWrite( " Latitude : ", _LOG_TEXT);
	MOVLW       ?lstr5_Click_GNSS4_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr5_Click_GNSS4_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,124 :: 		mikrobus_logWrite(rspCom, _LOG_LINE);
	MOVLW       applicationTask_rspCom_L0+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(applicationTask_rspCom_L0+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,125 :: 		}
L_applicationTask9:
;Click_GNSS4_PIC.c,126 :: 		dispFlag = 0;
	CLRF        _dispFlag+0 
;Click_GNSS4_PIC.c,127 :: 		mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
	MOVLW       ?lstr6_Click_GNSS4_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr6_Click_GNSS4_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,128 :: 		}
L_applicationTask7:
;Click_GNSS4_PIC.c,130 :: 		if(pFlag == 2 &&  dispFlag == 1)
	MOVF        _pFlag+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_applicationTask12
	MOVF        _dispFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_applicationTask12
L__applicationTask23:
;Click_GNSS4_PIC.c,132 :: 		mikrobus_logWrite( "  ", _LOG_LINE);
	MOVLW       ?lstr7_Click_GNSS4_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr7_Click_GNSS4_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,133 :: 		mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
	MOVLW       ?lstr8_Click_GNSS4_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr8_Click_GNSS4_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,134 :: 		pAlt = gnss4_parser(&demoBuffer[0], &demoCommand[0], 9);
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
	MOVWF       applicationTask_pAlt_L0+0 
	MOVF        R1, 0 
	MOVWF       applicationTask_pAlt_L0+1 
;Click_GNSS4_PIC.c,135 :: 		if(pAlt == 0)
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__applicationTask34
	MOVLW       0
	XORWF       R0, 0 
L__applicationTask34:
	BTFSS       STATUS+0, 2 
	GOTO        L_applicationTask13
;Click_GNSS4_PIC.c,137 :: 		mikrobus_logWrite( " Altitude : No data available!", _LOG_LINE);
	MOVLW       ?lstr9_Click_GNSS4_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr9_Click_GNSS4_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,138 :: 		}
	GOTO        L_applicationTask14
L_applicationTask13:
;Click_GNSS4_PIC.c,141 :: 		strcpy(&rspCom[0], pAlt);
	MOVLW       applicationTask_rspCom_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(applicationTask_rspCom_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVF        applicationTask_pAlt_L0+0, 0 
	MOVWF       FARG_strcpy_from+0 
	MOVF        applicationTask_pAlt_L0+1, 0 
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;Click_GNSS4_PIC.c,142 :: 		mikrobus_logWrite( " Altitude : ", _LOG_TEXT);
	MOVLW       ?lstr10_Click_GNSS4_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr10_Click_GNSS4_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,143 :: 		mikrobus_logWrite(rspCom, _LOG_LINE);
	MOVLW       applicationTask_rspCom_L0+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(applicationTask_rspCom_L0+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,144 :: 		}
L_applicationTask14:
;Click_GNSS4_PIC.c,145 :: 		dispFlag = 0;
	CLRF        _dispFlag+0 
;Click_GNSS4_PIC.c,146 :: 		mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
	MOVLW       ?lstr11_Click_GNSS4_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr11_Click_GNSS4_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,147 :: 		}
L_applicationTask12:
;Click_GNSS4_PIC.c,149 :: 		if(pFlag == 1 && dispFlag == 1)
	MOVF        _pFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_applicationTask17
	MOVF        _dispFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_applicationTask17
L__applicationTask22:
;Click_GNSS4_PIC.c,151 :: 		mikrobus_logWrite( "  ", _LOG_LINE);
	MOVLW       ?lstr12_Click_GNSS4_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr12_Click_GNSS4_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,152 :: 		mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
	MOVLW       ?lstr13_Click_GNSS4_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr13_Click_GNSS4_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,153 :: 		pLong = gnss4_parser(&demoBuffer[0], &demoCommand[0], 4);
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
	MOVWF       applicationTask_pLong_L0+0 
	MOVF        R1, 0 
	MOVWF       applicationTask_pLong_L0+1 
;Click_GNSS4_PIC.c,154 :: 		if(pLong == 0)
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__applicationTask35
	MOVLW       0
	XORWF       R0, 0 
L__applicationTask35:
	BTFSS       STATUS+0, 2 
	GOTO        L_applicationTask18
;Click_GNSS4_PIC.c,156 :: 		mikrobus_logWrite( " Longitude : No data available!", _LOG_LINE);
	MOVLW       ?lstr14_Click_GNSS4_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr14_Click_GNSS4_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,157 :: 		}
	GOTO        L_applicationTask19
L_applicationTask18:
;Click_GNSS4_PIC.c,160 :: 		strcpy(&rspCom[0], pLong);
	MOVLW       applicationTask_rspCom_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(applicationTask_rspCom_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVF        applicationTask_pLong_L0+0, 0 
	MOVWF       FARG_strcpy_from+0 
	MOVF        applicationTask_pLong_L0+1, 0 
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;Click_GNSS4_PIC.c,161 :: 		mikrobus_logWrite( " Longitude : ", _LOG_TEXT);
	MOVLW       ?lstr15_Click_GNSS4_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr15_Click_GNSS4_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,162 :: 		mikrobus_logWrite(rspCom, _LOG_LINE);
	MOVLW       applicationTask_rspCom_L0+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(applicationTask_rspCom_L0+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,163 :: 		}
L_applicationTask19:
;Click_GNSS4_PIC.c,164 :: 		dispFlag = 0;
	CLRF        _dispFlag+0 
;Click_GNSS4_PIC.c,165 :: 		mikrobus_logWrite( " ---------------------------------------- ", _LOG_LINE);
	MOVLW       ?lstr16_Click_GNSS4_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr16_Click_GNSS4_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_GNSS4_PIC.c,166 :: 		}
L_applicationTask17:
;Click_GNSS4_PIC.c,167 :: 		}
L_end_applicationTask:
	RETURN      0
; end of _applicationTask

_main:

;Click_GNSS4_PIC.c,169 :: 		void main()
;Click_GNSS4_PIC.c,171 :: 		systemInit();
	CALL        _systemInit+0, 0
;Click_GNSS4_PIC.c,172 :: 		applicationInit();
	CALL        _applicationInit+0, 0
;Click_GNSS4_PIC.c,174 :: 		while (1)
L_main20:
;Click_GNSS4_PIC.c,176 :: 		applicationTask();
	CALL        _applicationTask+0, 0
;Click_GNSS4_PIC.c,177 :: 		}
	GOTO        L_main20
;Click_GNSS4_PIC.c,178 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
