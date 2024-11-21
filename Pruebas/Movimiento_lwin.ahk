#SingleInstance Force
#UseHook

LWin::
 {
	KeyWait "LWin"
	if GetKeyState("Shift")
 	{
 	    Send "{Shift Up}"
 	}
 	if GetKeyState("Ctrl")
 	{
 	    Send "{Ctrl Up}"
 	}
  	Return
 }

;Seccion de Movimiento con flechas de desplazamiento
 #HotIf GetKeyState("LWin", "P")
 {
 ;Desplazamiento
 	h::Left    
 	n::Right
 	c::Up
 	t::Down
 	g::Home
 	r::End
 	l::
 	{
 	Send "{PgUp}"
 	KeyWait "l"
 	Send "{LWin Up}"
 	Return
 	}
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
  		m::ScrollLock
  	 	#HotIf GetKeyState("LWin", "P") and GetKeyState("ScrollLock", "T")
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
  		 		l::
  		 		{
  		 		Send "{WheelUp}"
  		 		KeyWait "l"
  		 		Send "{LWin Up}"
  		 		Return
  		 		}
 }