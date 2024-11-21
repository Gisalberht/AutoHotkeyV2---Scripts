;Capas para distribucion Dvorak 40% ingles - español - aleman
#SingleInstance Force
#UseHook
;#NoTrayIcon

;————————————————————————————————————————————————————————————————————
;Capa 1: Capa principal —————> Mover a Power Toys que lo hace de base.
;————————————————————————————————————————————————————————————————————
;Modificaciones
	h::r
	r::h
	/::BackSpace
	-:: ;——> - = Enter. Pulsacion corta envia 'enter', pulsacion larga 'Ctrl'
	{
	    StartTime :=A_TickCount
	    KeyWait "-", "T0.14"
	    ElapsedTime := A_TickCount - StartTime
	    If (ElapsedTime < 120)
	        {
	            Send "{Enter}"
	            Return
	        }
	        Send "{CtrlDown}"
	        KeyWait "-"
	        Send "{CtrlUp}"
	        Return
	}
	
	CapsLock:: ;Pulsacion corta envia 'esc', pulsacion larga 'Ctrl'
	{
	    StartTime :=A_TickCount
	    KeyWait "CapsLock", "T0.201"
	    ElapsedTime := A_TickCount - StartTime
	    If (ElapsedTime < 200)
	        {
	            Send "{Esc}"
	            Return
	        }
	        Send "{CtrlDown}"
	        ElapsedTime2 := A_TickCount - StartTime
            ToolTip ElapsedTime2
	        KeyWait "CapsLock"
	        ;ElapsedTime2 := A_TickCount - StartTime
            ;ToolTip ElapsedTime2
	        Send "{CtrlUp}"
	        Return
	}

	;Esc::LWin
	Browser_Home::LWin

	;RShift & LShift::CapsLock
	;LShift & RShift::CapsLock

	; variable := 1
; 1:: ;Conmutador para LDPlayer.
; {
; 	If (variable == 1)
;    {
;    	global variable := 0
;    	ToolTip "Comutar A"
;    	Sleep 500
;    	ToolTip
;    	Return
;    }
; 	Else
;    {
;    	variable := 1
;    	ToolTip "Comutar B"
;    	Sleep 500
;    	ToolTip
;    	Return
;    }
; }

; #HotIf WinActive("ahk_class LDPlayerMainFrame") and variable == 0
; {
; 		LButton::g
; 		!LButton::LButton
; 		Return
; }
; #HotIf