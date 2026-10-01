;==================================================================
; SCRIPTS DE INICO PARA QWERTY, MOUSE Y TECLADO
;==================================================================
;Descripcion: Script que permite utiliar un teclado convencional, como un teclado 40% con sistema de capas, usando la distribucion Qwerty convertida a Dvorak.



;                       --- Directivas ---
;==================================================================
	#SingleInstance Force
	#UseHook True

	#InputLevel 1
	A_MaxHotkeysPerInterval := 200  ; Evita que AHK bloquee el script si escribes muy rápido
	SendMode "Input"          ; Envía las teclas de la forma más rápida e ininterrumpida posible


;              --- Mostrar Icono en la bandeja ---
;==================================================================
	SetTimer ShowIcon, 6000
	ShowIcon() {
		A_IconHidden := false
		SetTimer ShowIcon, 0
	}
					
#SuspendExempt
;   --- Suspender script --- 
;==================================================================
|::Suspend
/*{
    Suspend -1  ; Alterna (toggle) el estado de suspensión del script

    if A_IsSuspended {
        ToolTip "Desactivado"
        SetTimer () => ToolTip(), -500  ; Oculta el ToolTip después de 500 ms sin pausar la ejecución
    } else {
        ToolTip "Activado"
        SetTimer () => ToolTip(), -500
    }
}*/

;          --- Liberar teclas modificadoras + 'Reload' ---
;==================================================================
/*`::
	{
		Send "{Shift Up}"
		Send "{Ctrl Up}"
		Send "{Alt Up}"
		Send "{RWin Up}"
		Send "{LWin Up}" 
		Return
	}*/
	
; `::Reload
;`::Suspend
;Enter::Ctrl
;\::Tab
;=::Tab
;RControl::RAlt




;          --- Fijar ventana: autor desconocido ---
;==================================================================
	
/*!p:: {
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
}*/


#SuspendExempt False
;-------------------

;       --- Cadenas rapidas Interrapidisimo --- bb
;==================================================================


;       --- Enmascaramiento de las teclas de Windows ---
;==================================================================

/*LAlt::{ ; Tecla de activacion de la capa de acentos.
	Send "{Blind}{vkE8}"
	KeyWait "LAlt"
	Send "{LAlt Up}"
	Return
 }*/
<^>!RAlt::Return ;Tecla  activacion de la capa de simbolos.
/**RAlt::
{
    Send "{Blind}{vkE8}"
    KeyWait "RAlt"
    Send "{RAlt Up}"
    Return
}*/
	
	
	;           --- CAPA PRINCIPAL QWERTY A DVORAK EN ESPAÑOL --- 
	;==================================================================
	q::'
	w::,
	e::.
	r::p
	t::y
	y::f
	u::g
	i::c
	o::h
	p::l

	SC01A::BackSpace
	

	a::a
	s::o
	d::e
	f::u
	g::i
	h::d
	j::r
	k::t
	l::n
	ñ::s

	{::Enter

	z::;
	x::q
	c::j
	v::k
	b::x
	n::b
	m::m
	,::w
	.::v
	-::z 
	
	/*LCtrl::Lwin
	LWin::{
		Send "{LAlt Down}"
		KeyWait "LWin"
		Send "{LAlt Up}"
		Return
	}*/


;        --- Atajos y modificaciones para el mouse ---
;==================================================================
;probar: raise down, click hagan algo.
;XButton1::Enter
;XButton2::^v


;        --- Modifiaciones '-' para 'Enter' y 'Ctrl' ---
;==================================================================
/*-:: ;--> Pulsacion corta envia 'enter', pulsacion larga 'Ctrl' (maximo un segundo).
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
	^-::^Enter*/
	
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
/*Tab::
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
}*/
			
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
/*#HotIf GetKeyState("LAlt", "P")
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

}*/

;           --- 'RAlt' para simbolos variados ---
;==================================================================
#HotIf GetKeyState("RAlt", "P")
{
	q::"
	w::send "{<}"
	e::send "{>}"
	r::send "{@}"
	t::send "{#}"
	y::send "{``}"
	u::send "{|}"
	i::send "{\}"
	o::send "{^}"
	p::
	{
			Send "{RAlt Up}"
			Sleep 10
			Send "{%}"
			KeyWait "p"
			Send "{RAlt Up}"
			Return
	}

	a::send "{_}"
	s::send "{—}"
	d::send "{{}"
	f::send "{(}"
	g::send "{¿}"
	h::send "{?}"
	j::send "{)}"
	k::send "{}}"
	l::send "{[}"
	{::send "{]}"

	z::send "{:}" 
	x::send "{$}"
	c::send "{&}"
	v::send "{=}"
	b::send "{¡}"
	n::send "{!}"
	m::send "{~}"
	,::send "{°}"
	.::send "{·}"
	;-/::send "{}"
}

;        --- Mouse virtual: Space +	Scrolllock ---
;==================================================================
/*#HotIf GetKeyState("Space", "P") and GetKeyState("ScrollLock", "T")
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
}*/

;     --- 'Space' para capa de movimiento/desplazamiento ---
;==================================================================
#HotIf GetKeyState("Space", "P") and ElapsedTime => 200
{
	/*;Desplazamiento
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
	z::#^Right*/
	
	;Atajos y modificaciones
	;[::BackSpace
	
	q::^z
	w::^c
	e::^v
	r::#v
	
	a::^y
	s::Enter
	d::Delete
	f::BackSpace

	l::ñ
	+l::Ñ
	
	;x::PrintScreen
	;v::AppsKey
	b::^x
	
	/*b:: ;Activar y desactivar 'Scrolllock'
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
	}*/
}

;      --- 'Tab' para pad numérico + modificadoras ---
;==================================================================
/*#HotIf GetKeyState("Tab", "P")
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
}*/

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