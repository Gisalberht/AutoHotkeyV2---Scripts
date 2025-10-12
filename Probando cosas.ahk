;==================================================================
; SCRIPTS DE INICO PARA DVORAK, MOUSE Y TECLADO
;==================================================================
;Descripcion: Script que permite utiliar un teclado 60% convencional, como un teclado 40% con sistema de capas, usando la distribucion Dvorak.



;                       --- Directivas ---
;==================================================================
	#SingleInstance Force
	#UseHook


;              --- Mostrar Icono en la bandeja ---
;==================================================================
	SetTimer ShowIcon, 6000
	ShowIcon() {
		A_IconHidden := false
		SetTimer ShowIcon, 0
	}
					
#SuspendExempt
;-------------

;   --- Cambiar distribución a QWERTY y suspender script --- 
;==================================================================
Esc:: ; -> toca empezar siempre desde Dvorak.
{
	Send "#{space}"
	Sleep 200
	Suspend
	return
}

;          --- Liberar teclas modificadoras + 'Reload' ---
;==================================================================
4::
	{
		Send "{Shift Up}"
		Send "{Ctrl Up}"
		Send "{Alt Up}"
		Send "{RWin Up}"
		Send "{LWin Up}" 
		Return
	}
	
`::Suspend
Enter::Ctrl
\::Tab
=::Tab
RControl::RAlt

3::Reload


;          --- Fijar ventana: autor desconocido ---
;==================================================================
	
!p:: {
	Title_When_On_Top := "Pin: " ;--> cambia el titulo de la ventana fijada a "Pin: + nombre de ventana."
	t := WinGetTitle("A") ;--> obtener titulo de ventana.
	ExStyle := WinGetExStyle(t) ;--> obtener estilo extendido de ventana y guardarlo eh "ExStyle"
	If (ExStyle & 0x8) { ;--> 0x8 es WS_EX_TOPMOST, Si el estilo de mi ventana "t" es "siempre visible"
		WinSetAlwaysOnTop 0, t ;--> apaga y elimina Title_When_On_Top (al precionar !p)
	WinSetTitle (RegExReplace(t, Title_When_On_Top)), t ;--> restablece el titulo
	}
	Else {
		WinSetAlwaysOnTop 1, t ;--> encienda y añada Title_When_On_Top
		WinSetTitle Title_When_On_Top t, t ;--> establece el titulo "Pin"
	}
}


#SuspendExempt False
;-------------------

;       --- Enmascaramiento de las teclas de Windows ---
;==================================================================

LAlt::return  ;{ ; Tecla de activacion de la capa de acentos.
; 	Send "{Blind}{vkE8}"
; 	KeyWait "LAlt" 
; 	Send "{LAlt Up}"
; 	Return
;  } 
 RAlt::{ ;Tecla  activacion de la capa de simbolos.
	 Send "{Blind}{vkE8}"
	 KeyWait "RAlt"
	 Send "{RAlt Up}"
	 Return
	} 
	
	
	;           --- CAPA PRINCIPAL DVORAK EN ESPAÑOL --- 
	;==================================================================
	h::r
	r::h
	/::BackSpace
	LCtrl::Lwin
	LWin::{
		Send "{LAlt Down}"
		KeyWait "LWin"
		Send "{LAlt Up}"
		Return
	}


;        --- Atajos y modificaciones para el mouse ---
;==================================================================
XButton1::Enter
XButton2::^v


;        --- Modifiaciones '-' para 'Enter' y 'Ctrl' ---
;==================================================================
-:: ;--> Pulsacion corta envia 'enter', pulsacion larga 'Ctrl' (maximo un segundo).
; --> Volvio el problema de la repeticion.
{
	StartTime :=A_TickCount
	KeyWait "-", "T0.18"
	ElapsedTime := A_TickCount - StartTime
	If (ElapsedTime < 180) 
		{ 
			Send "{Enter}"
			Return
		}
		Send "{Ctrl Down}"
		KeyWait "-"
		Send "{Ctrl Up}"
		Return
	}
	;----------
	+_::+Enter
	^-::^Enter
	
;      --- Modifiaciones de 'Capslock' para 'Esc' y 'Ctrl' ---
;==================================================================
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
	Send "{Ctrl Down}"
	KeyWait "CapsLock"
	Send "{Ctrl Up}"
	estado_capslock := GetKeyState("CapsLock", "T")
	If (estado_capslock == 1)
		{
			SetCapsLockState !GetKeyState("CapsLock", "T")
			Return
		}
	Return
}
		
;           --- 'Tab' para la capa de numeros ---
;==================================================================
Tab::
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
	Send "{Tab Up}"
	Return
}
			
;     --- 'Space' para las capas de movimiento ---
;==================================================================
ElapsedTime := 0 ;--> Para el limite de entrada a la capa de movimiento.
Space::
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
	
;      --- 'LAlt' para acentos español/ingles/aleman ---
;==================================================================
;ESTA LA OPCION DE USAR UN CONMUTADOR PARA CAMBIAR ENTRE CAPAS.
#HotIf GetKeyState("LAlt", "P")
{
	/* RAlt= {
		conmutador
	}
		if (Ralt=1) {
	*/
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
	/* } */ 

	/*
	if (Ralt=2) {
		acentos en aleman, y asi sucesivamente
		}

		Ralt= capa base '0'
		return

		CLARO: tambien esta la opcion del modificador + tecla. 
		¡¡Tambien se puede usar las telas "',.p" para cambiar de idioma en vez de Ralt
	*/
}
#HotIf 

;           --- 'RAlt' para simbolos variados ---
;==================================================================
#HotIf GetKeyState("RAlt", "P")
{
	'::"
	,::send "{<}"
	.::send "{>}"
	p::send "{@}"
	y::send "{#}"
	f::send "{``}"
	g::send "{|}"
	c::send "{\}"
	r::send "{^}"
	l::
	{
		Send "{RAlt Up}"
		Sleep 10
		Send "{%}"
		KeyWait "l"
		Send "{RAlt Up}"
		Return
	}
	
	a::send "{_}"
	o::send "{—}"
	e::send "{{}"
	u::send "{(}"
	i::send "{¿}"
	d::send "{?}"
	h::send "{)}"
	t::send "{}}"
	n::send "{[}"
	s::send "{]}"
	
	`;::send "{:}"
	q::send "{$}"
	j::send "{&}"
	k::send "{=}"
	x::send "{¡}"
	b::send "{!}"
	m::send "{~}"
	w::send "{°}"
	v::send "{·}"
	;z::send "{}"
}

;        --- Mouse virtual: Space +	Scrolllock ---
;==================================================================
#HotIf GetKeyState("Space", "P") and GetKeyState("ScrollLock", "T")
{
	;Teclas de desplazamiento para mover el cursor del mouse velocidad baja.
	+c::MouseMove 0, -2, 0, "R"   ; Mover hacia arriba
	+t::MouseMove 0, 2, 0, "R"   ; Mover hacia abajo
	+h::MouseMove -2, 0, 0, "R"   ; Mover hacia la izquierda
	+n::MouseMove 2, 0, 0, "R"   ; Mover hacia la derecha
	
	;Teclas de desplazamiento para mover el cursor del mouse velocidad media.
	c::MouseMove 0, -10, 0, "R"   ; Mover hacia arriba
	t::MouseMove 0, 10, 0, "R"   ; Mover hacia abajo
	h::MouseMove -10, 0, 0, "R"   ; Mover hacia la izquierda
	n::MouseMove 10, 0, 0, "R"   ; Mover hacia la derecha
	
	;Teclas de desplazamiento para mover el cursor del mouse velocidad alta.
	^c::MouseMove 0, -50, 0, "R"   ; Mover hacia arriba
	^t::MouseMove 0, 50, 0, "R"   ; Mover hacia abajo
	^h::MouseMove -50, 0, 0, "R"   ; Mover hacia la izquierda
	^n::MouseMove 50, 0, 0, "R"   ; Mover hacia la derecha
	
	;Bototes y scroll del mouse.	
	g::LButton
	r::RButton
	w::MButton
	z::WheelRight
	v::WheelLeft
	s::WheelDown
	l::WheelUp
}

;     --- 'Space' para capa de movimiento/desplazamiento ---
;==================================================================
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
	m::#^Left
	;w::
	;v::
	z::#^Right
	
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
	
	b:: ;Activar y desactivar 'Scrolllock'
	{  
		estado_actual_scrollock := GetKeyState("ScrollLock", "T")
		SetScrollLockState !estado_actual_scrollock  
		if (estado_actual_scrollock == 1) 
			{  
				ToolTip "Modo Teclado"
				Sleep 	500
				ToolTip
			} 
		else
			{
				ToolTip "Modo Mouse" 
				Sleep 	500
				ToolTip
			}
	}
}

;      --- 'Tab' para pad numérico + modificadoras ---
;==================================================================
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
	
	;Atajos y teclas especiales
	e::Shift
	u::Ctrl
	o::Alt
	
	i::%
	x::×
	y::÷
}

;          --- 'Tecla/s' para teclas de función ---
;==================================================================

;      --- 'Tecla/s' para emojis ---
;==================================================================
;PUEDO USAR UN CONMUTADOR PARA ALTERNAR ENTRE CAPAS. 

;      --- 'Navegacion total con teclado ---
;==================================================================
;con tecla 'Tab' 'Alt' y lo que necesite. 

;      --- Capara alternar simbolos pares ---
;==================================================================
/*La idea tener un boton que active la opcion de que al precionar un
 simbolo como "¿", este me devuelva su par "?" y me posicione dentro de este*/

 ;      --- Capa como "Emmet" pero para el teclado ---
;==================================================================
/*Que permita cosas como 😂*4 = 😂😂😂😂 o :smile*4 = 😂😂😂😂 y así ; ademas la capacidad de crear un "lorem ipsum donde sea"*/ 