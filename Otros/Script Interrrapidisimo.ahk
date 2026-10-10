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
;LAlt::return ;--> Para capa de movimiento/desplazamiento 


RButton:: ;--> Al presionar RButton solo, se espera a ver si lo sueltas o presionas otra tecla
{
    KeyWait "RButton"
    if (A_PriorKey == "RButton")
    {
        Click "Right" ; Clic derecho normal al soltar
    }
}

~LButton::Return
/*LButton:: ;--> Espera siguiente accion, si no hay, envia Lbutton.
; Tiene problemas con el resaltado.
{
    KeyWait "LButton"
    if (A_PriorKey == "LButton")
    {
        Click "Left" ; Clic izquierdo normal al soltar
    }
}*/

LButton & RButton:: ;-> Seleccionar todo + Copiar
{
		Click 1
		Sleep 50
    Send "^a"
    Sleep 50       ; Pequeña pausa para asegurar que el sistema procese la selección
    Send "^c"
    MostrarToolTip("Copiado")
}

RButton & LButton:: ;--> Seleccionar todo + Borrar + Pegar
{
    Click 1
		Sleep 50
		Send "^a"
    Sleep 50
    Send "{Delete}"
    Sleep 50
    Send "^v"
    MostrarToolTip("Reemplazado")
}

MostrarToolTip(mensaje) ; Función auxiliar para mostrar/ocultar tooltip
{
	ToolTip mensaje
	SetTimer () => ToolTip(), -800  ; Oculta el ToolTip después de 800 ms
}


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

;Tenia fallos sin KeyWait.




;     --- 'LAlt' para capa de movimiento/desplazamiento ---
;==================================================================
;#HotIf GetKeyState("LAlt", "P") ;and ElapsedTime => 200
;{
	<!CapsLock::Esc
	
	/*<!q:: ;--> mostrar guia
	{
    Send "{Tab 7}{Enter}{Tab 3}{Enter}"
	}*/
	<!q:: ;--> mostrar guía con pausas para PC lenta
{
    Send "{Tab}"
    Sleep 150
    Send "{Tab}"
    Sleep 150
    Send "{Tab}"
    Sleep 150
    Send "{Tab}"
    Sleep 150
    Send "{Tab}"
    Sleep 150
    Send "{Tab}"
    Sleep 150
    Send "{Tab}"
    Sleep 150
    Send "{Enter}"
    Sleep 200
    Send "{Tab}"
    Sleep 150
    Send "{Tab}"
    Sleep 150
    Send "{Tab}"
    Sleep 150
    Send "{Enter}"
}
	
	<!w::^c ;--> copiar
	<!e::^v ;--> pegar
	<!r::#v ;--> portapapeles
	;t:: ;--> 
	
	/*<!a:: ;--> Imprimir guia
	{
    Send "{Tab 3}{Enter}"
	}*/
	<!a:: ;--> Imprimir guia con pausas para PC lenta
	{
		Send "{Tab}"
    Sleep 150
    Send "{Tab}"
    Sleep 150
    Send "{Tab}"
    Sleep 150
    Send "{Enter}"
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
; NumpadDiv (la tecla / del pad numérico) envía Backspace
NumpadDiv::Backspace

; NumpadMult (la tecla * del pad numérico) envía Tab
NumpadMult::Tab



/* ; probar clic copiar, doble clic pegar.
   --- Atajos del mouse--- 
;==================================================================
~LButton::Return ;--> Mantiene uso normal del clic

; Al presionar RButton solo, se espera a ver si lo sueltas o presionas otra tecla
RButton::
{
    KeyWait "RButton"
    if (A_PriorKey == "RButton")
    {
        Click "Right" ; Clic derecho normal al soltar
    }
}

; Combinación: Mantener RButton y presionar LButton (Maneja un clic o doble clic)
RButton & LButton::
{
    static clicCount := 0
    clicCount++
    
    ; Si es el primer clic, esperamos un momento corto para ver si hay un segundo clic
    if (clicCount == 1)
    {
        SetTimer(EjecutarAccion, -250) ; 250 milisegundos de margen para el doble clic
    }
    
    EjecutarAccion()
    {
        if (clicCount >= 2) ; <-- ACCIÓN PARA DOBLE CLIC (Envía ^+v)
        {
            Click 2
            Sleep 50
            Send "^e"
            Sleep 50
            Send "{Delete}"
            Sleep 50
            Send "^+v"           ; Pega sin formato limpio
            MostrarToolTip("Pegado sin Formato")
        }
        else if (clicCount == 1) ; <-- ACCIÓN PARA UN SOLO CLIC (Envía ^v)
        {
            Click 2
            Sleep 50
            Send "^e"
            Sleep 50
            Send "{Delete}"
            Sleep 50
            Send "^v"          ; Pega normal (con formato original)
            MostrarToolTip("Pegado")
        }
        clicCount := 0 ; Reinicia el contador para la próxima vez
    }
}

MostrarToolTip(mensaje) ; Función auxiliar para mostrar/ocultar tooltip
{
	ToolTip mensaje
	SetTimer () => ToolTip(), -800  ; Oculta el ToolTip después de 800 ms
}*/

