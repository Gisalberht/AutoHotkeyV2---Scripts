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

#SuspendExempt False
;-------------------

;     --- Enmascaramientos ---
;==================================================================
LAlt::return ;--> Para capa de movimiento/desplazamiento 
~LButton::Return ;--> Mantiene uso normal del clic
~RButton::Return ;--> Mantiene uso normal del clic

;     --- Acciones con el mouse ---
;==================================================================
/*LButton & RButton:: ;-> Copiar
{
		Send "^c"
		MostrarToolTip("Copiado")
}

RButton & LButton:: ;--> Pegar
{
	Send "^v"
	MostrarToolTip("Pegado")
}*/

LButton & RButton:: ;-> Seleccionar todo + Copiar
{
    Send "^a"
    Sleep 50       ; Pequeña pausa para asegurar que el sistema procese la selección
    Send "^c"
    MostrarToolTip("Copiado")
}

RButton & LButton:: ;--> Seleccionar todo + Borrar + Pegar
{
    Send "^a"
    Sleep 50
    Send "{Delete}"
    Sleep 50
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
;#HotIf GetKeyState("LAlt", "P") ;and ElapsedTime => 200
;{
	<!CapsLock::Esc
	
	<!q:: ;--> mostrar guia
	{
    Send "{Tab 7}{Enter}{Tab 3}{Enter}"
	}
	<!w::^c ;--> copiar
	<!e::^v ;--> pegar
	<!r::#v ;--> portapapeles
	;t:: ;--> 
	
	<!a:: ;--> Imprimir guia
	{
    Send "{Tab 3}{Enter}"
	}
	<!s::!F4 ;--> cerrar ventana
	<!d::^a ;--> seleccina texto
	<!f::BackSpace ;--> retroceder
	<!g::Enter ;--> entrar
	
	<!z:: ;--> Alt + V: Fuerza la ventana activa a un tamaño vertical (ej. 450px de ancho por 900px de alto)
	{
			; Obtiene el ID de la ventana activa
			hwnd := WinExist("A")
			
			; Quita el estado maximizado si lo tiene
			WinRestore(hwnd)
			
			; Redimensiona: X=100, Y=50, Ancho=480, Alto=950
			WinMove(100, 50, 480, 950, hwnd)
	} 
	;x:: ;--> 
	;c:: ;--> 
	;v:: ;--> 
	<!b::^b ;--> buscar
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
	
;}

 ;--- Remapeo teclas padnumerico ---
;==================================================================
;$NumpadSub::Send "{Backspace}"
;SC04A::Backspace