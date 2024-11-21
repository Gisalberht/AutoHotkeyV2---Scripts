#SingleInstance Force
#UseHook

;//Nota*: Desactivar 'Win + L' y desinstalar 'Windows Game Bar' si es posible, si no usar metodos para saltar la prescedencia de esos atajos, como: 
;l::
	; {
	; 	Send "{RWin Up}"
	; 	Sleep 10
	; 	Send "="
	; 	KeyWait "l"
	; 	Send "{RWin Up}"
	; 	Return
	; }//


; RWin:: ;——> para evitar el menu de inicio
; 	{
; 		KeyWait "RWin"
; 		Return
; 	} 

RWin::Send "{Blind}{vkE8}" ;con elprefijo tilde '~' no funciona

; Seccion de simbolos variados
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

	::;::a
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
