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
3::Reload
`::Suspend

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

; 	RAlt:: {
;     Send "{Blind}{RAlt Down}"  ; Mantén presionado RAlt real
;     KeyWait "RAlt"
;     Send "{RAlt Up}"
;     Return
; }


;      --- 'LAlt' para acentos español/ingles/aleman ---
;==================================================================
;ESTA LA OPCION DE USAR UN CONMUTADOR PARA CAMBIAR ENTRE CAPAS.
#HotIf GetKeyState("LAlt", "P")
{
	;Zona de pruebas: 

	;Acentos del español
	a::send "{á}"
	o::send "{ó}"
	e::send "{é}"
	u::send "{ú}"
	i::í
	n::ñ
	
	/*+a::Á
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
	+s::ẞ*/
}

;           --- 'RAlt' para simbolos variados ---
;==================================================================
#HotIf GetKeyState("RAlt", "P")
{
	SC10::send "{`"}" ;Q - '
	SC11::send "{<}"  ;W - ,
	SC12::send "{>}"  ;E - .
	SC13::send "{@}"  ;R - P
	SC14::send "{#}"  ;T - Y
	SC15::send "{``}" ;Y - F
	SC16::send "{|}"  ;U - G
	SC17::send "{\}"  ;I - C
	SC18::send "{^}"  ;O - R (H in this script)
	SC19::send "{%}"  ;P - L
	
	VK41::send "{_}" ;A - A
	SC1F::send "{—}" ;S - O
	SC20::send "{{}" ;D - E
	VK55::send "{(}" ;F - U
	SC22::send "{¿}" ;G - I
	SC23::send "{?}" ;H - D
	SC24::send "{)}" ;J - H (R in this script)
	SC25::send "{}}" ;K - T
	SC26::send "{[}" ;L - N
	SC27::send "{]}" ;;/Ñ - S
	
	SC2C::send "{:}" ;Z - ;
	SC2D::send "{$}" ;X - Q
	SC2E::send "{&}" ;C - J
	SC2F::send "{=}" ;V - K
	SC30::send "{¡}" ;B - X
	SC31::send "{!}" ;N - B
	SC32::send "{~}" ;M - M
	SC33::send "{°}" ;, - W
	SC34::send "{·}" ;. - V
	;SC35::send "{}" ;/ o - Z
}