;Scripts de inicio de AHK: Dvorak/Mouse/Programas
;—————————————————————————————————————————————————————
	;Descripcion: Script que permite utiliar un teclado 60% convencional, como un teclado 40% con sistema de capas, usando la distribucion Dvorak.
	
	;Cambios: Corrigiendo distribucion de simbolos para usar mas la mano izquierda y Añadiendo teclas de función.

	#SingleInstance Force
	#UseHook
	;#NoTrayIcon
	
	#SuspendExempt
	
	;Libera las teclas modificadoras en caso aparezcan como pulsadas.
	`::
	 {
		Send "{Shift Up}"
			Send "{Ctrl Up}"
			Send "{Alt Up}"
		Send "{RWin Up}"
		Send "{LWin Up}" 
		Return
	}
	
	;Desactiva ciertas teclas del script en caso que el emulador de BrawlStars se este ejecutando en primer plano y viceversa.
	#space::Return
	
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
			}
	
	;Modificaciones para la capa principal Dvorak - Español. 
	;—————————————————————————————————————————————————————
			h::r
			r::h
			/::BackSpace
			Browser_Home::LWin
			Escape::LWin
	
	;Fijar ventana - no recuertdo al autor, pero mis creditos para el o ella.
	;—————————————————————————————————————————————————————
	
	!p:: {                          ; Alt + t
	Title_When_On_Top := "Pin: "       ; Cambia el titulo de la ventana fijada a "Pin: + nombre de ventana."
	t := WinGetTitle("A") ;obtener titulo de ventana.
	ExStyle := WinGetExStyle(t) ;obtener estilo extendido de ventana y guardarlo eh "ExStyle"
	If (ExStyle & 0x8) {            ; 0x8 is WS_EX_TOPMOST, Si el estilo de mi ventana "t" es "siempre visible"
			WinSetAlwaysOnTop 0, t      ; Apague y elimine Title_When_On_Top (al precionar !p)
			WinSetTitle (RegExReplace(t, Title_When_On_Top)), t ;restablece el titulo
			}
	Else {
			WinSetAlwaysOnTop 1, t      ; encienda y añada Title_When_On_Top
			WinSetTitle Title_When_On_Top t, t ;establece el titulo "Pin"
			}
	}
	
	;Enmascaramiento de las teclas de Windows.
	;—————————————————————————————————————————————————————
	LWin::Send "{Blind}{vkE8}" ; Tecla de activacion de la capa de acentos.
	RWin::Send "{Blind}{vkE8}" ;Tecla  activacion de la capa de simbolos.
	
	#SuspendExempt False
	
	;Atajos y modificaciones para el mouse.
	;—————————————————————————————————————————————————————
		XButton1::Enter
		XButton2::^v
	
	;Modifiaciones '-' para 'Enter' y 'Ctrl'.
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
		^-::^Enter ; xd ahora '-' envia este hotkey por la repeticion de teclas jajaja. Actualizacion: se corrigio este error, no se como.
	
	;Modifiaciones de 'Capslock' para 'Esc' y 'Ctrl'.
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
	
	;Modificaciones de 'Tab' para activacion de la capa de numeros.
	;—————————————————————————————————————————————————————
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
				Return
		 }
	
	;Modificaciones de 'Space' para activacion de las capas de movimiento.
	;—————————————————————————————————————————————————————
		ElapsedTime := 0 ;Para el limite de entrada a la capa de movimiento.
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
	
	;Seccion de acentos español/ingles/aleman: Lwin.
	;—————————————————————————————————————————————————————
		#HotIf GetKeyState("RWin", "P")
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
	
	;Seccion de simbolos variados: Rwin.
	;—————————————————————————————————————————————————————
		#HotIf GetKeyState("LWin", "P")
		{
			'::"
			,::send "{<}"
			.::send "{>}"
			p::send "{@}"
			y::send "{#}"
			f::send "{¿}"
			g::send "{?}"
			c::send "{\}"
			r::send "{^}"
			l::
			{
				Send "{RWin Up}"
				Sleep 10
				Send "{``}"
				KeyWait "l"
				Send "{RWin Up}"
				Return
			}
	
			a::send "{(}"
			o::send "{)}"
			e::send "{{}"
			u::send "{}}"
			i::send "{%}"
			d::send "{|}"
			h::send "{_}"
			t::send "{—}"
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
	
	;Seccion de movimiento de mouse virtual con teclado: Space -	Scrolllock.
	;—————————————————————————————————————————————————————
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
	
	;Seccion de movimiento con flechas de desplazamiento: Space.
	;—————————————————————————————————————————————————————
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
			v::#^Left
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
	
	;Seccion de numeros y modificadores: Tab.
	;—————————————————————————————————————————————————————
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
		}