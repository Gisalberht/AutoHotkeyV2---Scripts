;==================================================================
; SCRIPTS DE INICO CAMBIAR ENTRE LAYOUTS.
;==================================================================
;Descripcion: Permite cambiar entre layouts Dvorak y Qwerty con un scritp para cada uno.

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
/*`::
	{
		Send "{Shift Up}"
		Send "{Ctrl Up}"
		Send "{Alt Up}"
		Send "{RWin Up}"
		Send "{LWin Up}" 
		Return
	}*/
	
3::Reload
`::Suspend
Enter::Ctrl
\::Alt
=::Tab
RControl::RAlt

;               --- Suspender en BrawlStars ---
;==================================================================
/*#space::Return

SetTimer BrawlStars, 500
	BrawlStars()
	{
		if WinActive("ahk_class Qt5154QWindowIcon")
		{
			Suspend true
		}
		else
		{
			Suspend false
		}
		Return
	}*/


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

LAlt::{ ; Tecla de activacion de la capa de acentos.
	Send "{Blind}{vkE8}"
	KeyWait "LAlt"
	Send "{LAlt Up}"
	Return
 } 
 RAlt::{ ;Tecla  activacion de la capa de simbolos.
	 Send "{Blind}{vkE8}"
	 KeyWait "RAlt"
	 Send "{RAlt Up}"
	 Return
	} 
		
	;           --- CAPA PRINCIPAL DVORAK EN ESPAÑOL --- 
	;==================================================================
	SC24::SC18 ;J > O = H > R en Dvorak
	SC18::SC24 ;O > J = R > H en Dvorak
	SC1A::BackSpace
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

	;mantener precionado Lalt y usar Ralt como conmutador de capas de idiomas
	/* RAlt= {
		conmutador
	}
		if (Ralt=1) {
			acentos en español
	}
	if (Ralt=2) {
		acentos en aleman
		}

		y asi sucesivamente...
		
		Ralt=0 --> capa base, para salir y reiniciar
		return

		o puede tener autosave para cambiar la capa de acentos base.
-------------
		CLARO: tambien esta la opcion del modificador + tecla. 
		mantener presionado Lalt e ir tocando la tecla hasta optener el acento deseado
		y luego soltar para que salga el simbolo, es mas practico, con cuadro de seleccion de acentos.

		¡¡Tambien se puede usar las telas "',.p" para cambiar de idioma en vez de Ralt, pero esto solo sirve en dvorak, habría que cambiarlo para cada distro a menos que se usen los scancodes.
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
}

;           --- 'RAlt' para simbolos variados ---
;==================================================================
#HotIf GetKeyState("RAlt", "P")
{
	SC10::" ;Q
	SC11::send "{<}"  ;W
	SC12::send "{>}"  ;E
	SC13::send "{@}"  ;R
	SC14::send "{#}"  ;T
	SC15::send "{``}" ;Y
	SC16::send "{|}"  ;U
	SC17::send "{\}"  ;I
	SC18::send "{^}"  ;O
	SC19::send "%"    ;P
	/*{
		Send "{RAlt Up}"
		Sleep 10
		Send "{%}"
		KeyWait "l"
		Send "{RAlt Up}"
		Return
	}*/
	
	SC1E::send "{_}" ;A
	SC1F::send "{—}" ;S
	SC20::send "{{}" ;D
	SC21::send "{(}" ;F
	SC22::send "{¿}" ;G
	SC23::send "{?}" ;H
	SC24::send "{)}" ;J
	SC25::send "{}}" ;K
	SC26::send "{[}" ;L
	SC27::send "{]}" ;; o Ñ
	
	SC2C::send "{:}" ;Z
	SC2D::send "{$}" ;X
	SC2E::send "{&}" ;C
	SC2F::send "{=}" ;V
	SC30::send "{¡}" ;B
	SC31::send "{!}" ;N
	SC32::send "{~}" ;M
	SC33::send "{°}" ;,
	SC34::send "{·}" ;.
	;SC35::send "{}" ;/ o -
}

;        --- Mouse virtual: Space +	Scrolllock ---
;==================================================================
#HotIf GetKeyState("Space", "P") and GetKeyState("ScrollLock", "T")
{
	;Teclas de desplazamiento para mover el cursor del mouse velocidad baja.
	+SC17::MouseMove 0, -2, 0, "R"   ;I -> Mover hacia arriba
	+SC25::MouseMove 0, 2, 0, "R"   ;K -> Mover hacia abajo
	+SC24::MouseMove -2, 0, 0, "R"   ;J -> Mover hacia la izquierda
	+SC26::MouseMove 2, 0, 0, "R"   ;L -> Mover hacia la derecha
	
	;Teclas de desplazamiento para mover el cursor del mouse velocidad media.
	SC17::MouseMove 0, -10, 0, "R"   ;I -> Mover hacia arriba
	SC25::MouseMove 0, 10, 0, "R"   ;K -> Mover hacia abajo
	SC24::MouseMove -10, 0, 0, "R"   ;J -> Mover hacia la izquierda
	SC26::MouseMove 10, 0, 0, "R"   ;L -> Mover hacia la derecha
	
	;Teclas de desplazamiento para mover el cursor del mouse velocidad alta.
	^SC17::MouseMove 0, -50, 0, "R"   ;I -> Mover hacia arriba
	^SC25::MouseMove 0, 50, 0, "R"   ;K -> Mover hacia abajo
	^SC24::MouseMove -50, 0, 0, "R"   ;J -> Mover hacia la izquierda
	^SC26::MouseMove 50, 0, 0, "R"   ;L -> Mover hacia la derecha
	
	;Bototes y scroll del mouse.	
	SC16::LButton   	;U
	SC18::RButton 		;O
	SC33::MButton 		;,
	SC35::WheelRight  ;/ o -
	SC34::WheelLeft 	;.
	SC27::WheelDown   ;; o Ñ
	SC19::WheelUp     ;P
}

;     --- 'Space' para capa de movimiento/desplazamiento ---
;==================================================================
#HotIf GetKeyState("Space", "P") and ElapsedTime => 200
{
	;Desplazamiento
	SC24::Left 				;J
	SC26::Right 			;L
	SC017::Up 				;I
	SC25::Down 				;K
	SC16::Home 				;U
	SC18::End 				;O
	SC19::PgUp 				;P
	SC27::PgDn 				;; o Ñ
	SC32::#^Left 			;M
	;SC33:: 					;,
	;SC34:: 					;.
	SC35::#^Right 		;/ o -
	
	;Atajos y modificaciones
	SC1A::BackSpace   ;´--> sirve en Qwerty para dejar libre la tilde para los acentos.
	SC15::Delete      ;Y
	SC23::Insert      ;H
	SC10::^z 					;Q
	SC11::^c 					;W
	SC12::^v 					;E
	SC13::#v 					;R
	SC1E::^y 					;A
	SC30::^x 					;B
	SC20::Shift 			;D
	SC21::Ctrl        ;F
	SC1F::Alt         ;S
	SC2D::PrintScreen ;X
	SC2F::AppsKey     ;V
	
	SC31:: ; N -> Activar y desactivar 'Scrolllock'
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
	SC31::Numpad0 ;N
	SC32::Numpad1 ;M
	SC33::Numpad2 ;,
	SC34::Numpad3 ;.
	SC24::Numpad4 ;J
	SC25::Numpad5 ;K
	SC26::Numpad6 ;L
	SC16::Numpad7 ;U
	SC17::Numpad8 ;I
	SC18::Numpad9 ;O
	
	;Simbolos del numpad.
	SC15::+       ;Y
	SC23::-       ;H
	SC19::* 			;P
	SC27::/ 			;; o Ñ
	SC35::= 			;/ o -
	
	;Atajos y teclas especiales
	SC20::Shift 	;D
	SC21::Ctrl 		;F
	SC1F::Alt 		;S
	
	SC22::% 			;G
	SC30::× 			;B
	SC14::÷ 			;T
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