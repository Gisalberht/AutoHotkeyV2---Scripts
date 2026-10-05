;==================================================================
;SCRIPTS PARA INTERRAPIDISIMO
;==================================================================
;Descripcion: mejor flujo de trabajo en tareas repetitivas.

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
;   --- Suspender script --- 
;==================================================================
|::Suspend
1::Reload

#SuspendExempt False
;-------------------

;     --- Enmascaramientos ---
;==================================================================
LAlt::return ;--> Para capa de movimiento/desplazamiento 
~LButton::Return ;--> Mantiene uso normal del clic
~RButton::Return ;--> Mantiene uso normal del clic

;     --- Acciones con el mouse ---
;==================================================================
LButton & RButton:: ;-> Copiar
{
		Send "^c"
		MostrarToolTip("Copiado")
}

RButton & LButton:: ;--> Pegar
{
	Send "^v"
	MostrarToolTip("Pegado")
}

MostrarToolTip(mensaje) ;--> Funcion auxiliar para mostrar/ocultar tooltip
{
	ToolTip mensaje
	SetTimer () => ToolTip(), -800  ; Oculta el ToolTip después de 800 ms sin pausar el script
}

;     --- 'LAlt' para capa de movimiento/desplazamiento ---
;==================================================================
#HotIf GetKeyState("LAlt", "P") ;and ElapsedTime => 200
{
	CapsLock::Esc
	
	q::^z ;--> deshacer
	w::^c ;--> copiar
	e::^v ;--> pegar
	r::#v ;--> portapapeles
	;t:: ;--> 
	
	a::^y ;--> rehacer
	s::^p ;--> imprimir
	d::Delete ;--> suprimir
	f::BackSpace ;--> retroceder
	g::Enter ;--> entrar
	
	;z:: ;--> 
	;x:: ;--> 
	;c:: ;--> 
	;v:: ;--> 
	b::^b ;--> buscar
	 ;x::PrintScreen ;--> 
	
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
	
}

 ;--- Remapeo teclas padnumerico ---
;==================================================================
;$NumpadSub::Send "{Backspace}"
;SC04A::Backspace