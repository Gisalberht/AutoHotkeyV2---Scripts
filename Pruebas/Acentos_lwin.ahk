;Capas para distribucion Dvorak 40% ingles - español - aleman
#SingleInstance Force
#UseHook

LWin::Send "{Blind}{vkE8}" ; enmascara el menu inicio al enviar una asignacion vacia.

; LWin:: ;——> para evitar el menu de inicio
;  {
; 	KeyWait "LWin"
; 	Return
;  } 

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