;==================================================================
; SCRIPTS DE INICO CAMBIAR ENTRE LAYOUTS.
;==================================================================
;Descripcion: Permite cambiar entre layouts Dvorak y Qwerty con un scritp para cada uno.

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
`::Suspend

#SuspendExempt False
;-------------------
;   --- Atajos del mouse--- 
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
}

;   --- Insertar y quitar check de carpetas y mas..--- 
;==================================================================
#HotIf WinActive("ahk_class CabinetWClass")
; Al presionar 1
$1::
{
    Send("{F2}")          ; Presiona F2 para renombrar
    Sleep(50)             ; Pequeña pausa para que responda el sistema
    Send("{Home}")        ; Mueve el cursor al inicio del texto
    Send("✅ ")           ; Inserta el símbolo y un espacio
    Send("{Enter}")       ; Presiona Enter para guardar
}

; Al presionar 2
$2::
{
    Send("{F2}")          ; Presiona F2 para renombrar
    Sleep(50)             ; Pequeña pausa
    Send("{Home}")        ; Mueve el cursor al inicio del texto
    Send("{Delete 2}")    ; Borra los dos primeros caracteres (hacia la derecha)
    Send("{Enter}")       ; Presiona Enter para guardar
}
#HotIf