;Capas para distribucion Dvorak 40% ingles - español - aleman
#SingleInstance Force
#UseHook
;#NoTrayIcon

;—————————————————————————————————————————————————————
;Capa 1: Capa principal
;—————————————————————————————————————————————————————
;Modificaciones
	h::r
	r::h
	/::BackSpace
	;Esc::LWin
	Browser_Home::LWin

	;Modifiaciones y usos para la tecla enter - control
	;—————————————————————————————————————————————————————
	-:: ;Pulsacion corta envia 'enter', pulsacion larga 'Ctrl' (maximo un segundo).
	{
	    StartTime :=A_TickCount
	    KeyWait "-", "T0.18"
	    ElapsedTime := A_TickCount - StartTime
	    If (ElapsedTime < 180) 
	        { 
	            Send "{Enter}"
	            Return
	        }
	        Send "{CtrlDown}"
	        KeyWait "-"
	        Send "{CtrlUp}"
	        Return
	}

	+_::+Enter
	^-::^Enter ; xd ahora '-' envia este hotkey por la repeticion de teclas jajaja.
	

	;Modifiaciones y usos para la tecla escape - control
	;—————————————————————————————————————————————————————

	RShift & LShift::SetCapsLockState !GetKeyState("CapsLock", "T")
	LShift & RShift::SetCapsLockState !GetKeyState("CapsLock", "T")

	CapsLock:: ;——> Pulsacion corta envia 'esc', pulsacion larga 'Ctrl'.
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
        KeyWait "CapsLock"
        Send "{CtrlUp}"
        estado_capslock := GetKeyState("CapsLock", "T")
        If (estado_capslock == 1)
        {
        	SetCapsLockState !GetKeyState("CapsLock", "T")
        	Return
        }
        Return
	}


;Capas de números, movimiento, simbolos, mouse, funcion, multimedia y acentos.
;—————————————————————————————————————————————————————
LWin::Send "{Blind}{vkE8}" ; Tecla de activacion de la capa de acentos.
RWin::Send "{Blind}{vkE8}" ;Tecla  activacion de la capa de simbolos.

Tab:: ;Tecla que activa la capa de números.
  {	
  	StartTime := A_TickCount 
  	KeyWait "Tab" , "T0.2"
	ElapsedTime := A_TickCount - StartTime
  	If (ElapsedTime < 190)
	  	{
	  		Send "{Tab}"
	   		Return 
	    } 
	   	ElapsedTime := A_TickCount - StartTime  
	   	KeyWait "Tab"  
			If GetKeyState("Shift")
				{
				    Send "{Shift Up}"
				}
		 	If GetKeyState("Ctrl")
				{
				    Send "{Ctrl Up}"
				}
		 	If GetKeyState("Alt")
				{
				    Send "{Alt Up}"
				}
			Return
   }

ElapsedTime := 0 ;Para el limite de entrada a la capa de movimiento.
Space:: ;Tecla de activación de la capa de movimiento y mouse.
  {
  	StartTime := A_TickCount 
  	KeyWait "Space", "T0.2" 
  	global ElapsedTime := A_TickCount - StartTime
  	If (ElapsedTime < 190)
	  	{
	  		Send "{Space}"
	   		Return
	   	} 
	   	ElapsedTime := A_TickCount - StartTime
	   	KeyWait "Space" 
			If GetKeyState("Shift")
				{
				    Send "{Shift Up}"
				}
		 	If GetKeyState("Ctrl")
				{
				    Send "{Ctrl Up}"
				}
		 	If GetKeyState("Alt")
				{
				    Send "{Alt Up}"
				}
			ElapsedTime := 0
			Return
   }

;Capa de acentos internacionales español -	 ingles -	aleman.
#HotIf GetKeyState("LWin", "P")
{
	;Acentos del español
	a::á
	o::ó
	e::é
	u::ú
	i::í
	n::ñ

	+a::Á
	+o::Ó
	+e::É
	+u::Ú
	+i::Í
	+n::Ñ

	;Acentos del aléman
	'::ä
	,::ö
	p::ü
	s::ß

	+'::Ä
	+,::Ö
	+p::Ü
	+s::ẞ
}

;Seccion de simbolos variados
#HotIf GetKeyState("RWin", "P")
{
	;Simbolos
	'::"
	,::send "{<}"
	.::send "{>}"
	p::send "{@}"
	y::send "{#}"
	f::send "{$}"
	g::send "{%}"
	c::send "{&}"
	r::send "{^}"
	l::
	{
		Send "{RWin Up}"
		Sleep 10
		Send "="
		KeyWait "l"
		Send "{RWin Up}"
		Return
	}

	a::send "{_}"
	o::send "{—}"
	e::send "{(}"
	u::send "{)}"
	i::send "{¿}"
	d::send "{?}"
	h::send "{{}"
	t::send "{}}"
	n::send "{[}"
	s::send "{]}"

	::;::send "{:}"
	q::send "{\}"
	j::send "{|}"
	k::send "{°}"
	x::send "{¡}"
	b::send "{!}"
	m::send "{~}"
	w::send "{·}"
	;v::send "{}"
	;z::send "{}"
}

;Seccion de Movimiento con flechas de desplazamiento
#HotIf GetKeyState("Space", "P") and ElapsedTime => 200
{
	;Desplazamiento
	h::Left    
	n::Right
	c::Up
	t::Down
	g::Home
	r::End
	l::PgUp
 	s::PgDn

;Atajos y modificaciones
	/::BackSpace
	f::Delete
	d::Insert
	'::^z
	,::^c
	.::^v
	p::#v
	a::^y
	x::^x
	e::Shift
	u::Ctrl
	o::Alt
 	q::PrintScreen
	k::AppsKey   

 	;Seccion de movimiento de mouse virtual con teclado 
 		b:: ;——>ScrolLock
 		{  
 			estado_actual_scrollock := GetKeyState("ScrollLock", "T")
 			SetScrollLockState !estado_actual_scrollock  
 			if (estado_actual_scrollock == 1) 
 			{  
 			   ToolTip "Modo Teclado"
 			   Sleep 300
 			   ToolTip
 			} 
 			else
 			{
 			   ToolTip "Modo Mouse" 
 			   Sleep 300
 			   ToolTip
 			}
 		}
 	 	#HotIf GetKeyState("Space", "P") and GetKeyState("ScrollLock", "T")
 			; Teclas de desplazamiento para mover el cursor del mouse velocidad baja.
 		 		c::MouseMove 0, -10, 0, "R"   ; Mover hacia arriba
 		 		t::MouseMove 0, 10, 0, "R"   ; Mover hacia abajo
 		 		h::MouseMove -10, 0, 0, "R"   ; Mover hacia la izquierda
 		 		n::MouseMove 10, 0, 0, "R"   ; Mover hacia la derecha
 		 		
 			; Teclas de desplazamiento para mover el cursor del mouse velocidad baja.
 		 		^c::MouseMove 0, -50, 0, "R"   ; Mover hacia arriba
 		 		^t::MouseMove 0, 50, 0, "R"   ; Mover hacia abajo
 		 		^h::MouseMove -50, 0, 0, "R"   ; Mover hacia la izquierda
 		 		^n::MouseMove 50, 0, 0, "R"   ; Mover hacia la derecha

 			; Teclas de desplazamiento para mover el cursor del mouse velocidad baja.
 		 		+c::MouseMove 0, -2, 0, "R"   ; Mover hacia arriba
 		 		+t::MouseMove 0, 2, 0, "R"   ; Mover hacia abajo
 		 		+h::MouseMove -2, 0, 0, "R"   ; Mover hacia la izquierda
 		 		+n::MouseMove 2, 0, 0, "R"   ; Mover hacia la derecha

 		 	;Bototes y scroll del mouse.	
 		 		g::Send "{LButton}" ; ——> de repente dejo de funcionar y ahora...
 		 		r::Send "{RButton}" ; ——> ... no se si no coloco send no funciona
 		 		w::MButton
 		 		z::WheelRight
 		 		v::WheelLeft
 		 		s::WheelDown
 		 		l::WheelUp
}

;Capa de números y modificadores.
#HotIf GetKeyState("Tab", "P")
{
	;Numeros del numpad.	
	b::Numpad0
	m::Numpad1
	w::Numpad2
	v::Numpad3
	h::Numpad4
	t::Numpad5
	n::Numpad6
	g::Numpad7
	c::Numpad8
	r::Numpad9

	;Simbolos del numpad.
	f::+
	d::-
	l::*
	s::/
	z::=

	;Atajos y teclas especiales (revisar que hacen aqui 'ctrl y shift')
	e::Shift
	u::Ctrl
	o::Alt
}
