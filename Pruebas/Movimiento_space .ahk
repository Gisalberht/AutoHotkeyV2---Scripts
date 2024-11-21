#SingleInstance Force
#UseHook

; Nota: al ser un scritp la pulsacion de 'space' es mas lenta que el de las demas teclas como las letras, por lo que en pulsaciones rapidas de 'space' y luego una 'letra', se puede llegar a enviar la 'letra' antes de enviar 'space'. En ocasiones mas raras se puede enviar la 'letra' entre 'space' provacando un 'space' antes y despues de la 'letra'. No se muy bien porque pasa esto. Por lo que tocaria optizar la velocidad de envio de space o reducir la de las letras para mayor comodidad.
ElapsedTime := 0
Space:: 
  {
  	StartTime := A_TickCount 
  	KeyWait "Space", "T0.2" ; es posible que sea necesario colocar mas de 180. Pero la barrera de los 10 ms lo dificulta.
  	global ElapsedTime := A_TickCount - StartTime
  	If (ElapsedTime < 190)
	  	{
	  		Send "{Space}"
	  		ToolTip ElapsedTime
	   		Return 
	   	} 
	   	ElapsedTime := A_TickCount - StartTime  
	   	ToolTip ElapsedTime
	   	KeyWait "Space"  
			If GetKeyState("Shift")
				{
				    Send "{Shift Up}"
				}
		 	If GetKeyState("Ctrl")
				{
				    Send "{Ctrl Up}"
				}
			ElapsedTime := 0 
			;ToolTip ElapsedTime 
			Return
   }

Enter:: ; permite saber si la variable es global.
{
	ToolTip ElapsedTime " iniciada"
	Return
} 


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
	 	q::PrintScreen
		k::AppsKey   

	 	;Seccion de movimiento de mouse virtual con teclado 
	 		;ScrollLockState
	 		b::
	 		{  
	 			estado_actual_scrollock := GetKeyState("ScrollLock", "T")
	 			SetScrollLockState !estado_actual_scrollock  
	 			if (estado_actual_scrollock == 1) 
	 			{  
	 			   ToolTip "Modo Teclado"
	 			   Sleep 500
	 			   ToolTip
	 			} 
	 			else
	 			{
	 			   ToolTip "Modo Mouse" 
	 			   Sleep 500
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

