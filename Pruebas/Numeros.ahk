;Capas para distribucion Dvorak 40% ingles - español - aleman
#SingleInstance Force
#UseHook
;#NoTrayIcon

;Tecla de activacion de capa.
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

	;Atajos y teclas especiales (revisar que hacen aqui)
	e::Shift
	u::Ctrl
	o::Alt
}
