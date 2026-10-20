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

;   --- Funciones --- 
;==================================================================
MostrarToolTip(mensaje) ; Función auxiliar para mostrar/ocultar tooltip
{
	ToolTip mensaje
	SetTimer () => ToolTip(), -800  ; Oculta el ToolTip después de 800 ms
}

;   --- Atajos del mouse --- 
;==================================================================
MButton:: ;--> Copiar
{
    Click 1
    Sleep 50
    Send "^a"
    Sleep 50
    Send "^c"
    MostrarToolTip("Copiado")
}

; Esperar segundo clic, si no mandar RButton.
RButton::
{
    KeyWait "RButton"
    if (A_PriorKey == "RButton")
    {
        Click "Right" ; Clic derecho normal al soltar
    }
}

RButton & LButton:: ; --> Acciones segun numero de clics
{
    static clicCount := 0
    clicCount++
    
    ; Contador de clics
    if (clicCount == 1)
    {
        SetTimer(EjecutarAccion, -250) ; 250 milisegundos de margen para el entre clic
    }
    
    EjecutarAccion()
    {
        if (clicCount == 1) ; --> Reemplazar contenido.
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
        else if (clicCount >= 2) ; --> Impresion directa
        {
            Send "{Tab}"
            Sleep 100
            Send "{Tab}"
            Sleep 100
            Send "{Tab}"
            Sleep 100
            Send "{Tab}"
            Sleep 100
            Send "{Tab}"
            Sleep 100
            Send "{Tab}"
            Sleep 100
            Send "{Tab}"
            Sleep 100
            Send "{Enter}"

            Sleep 150
            
            Send "{Tab}"
            Sleep 100
            Send "{Tab}"
            Sleep 100
            Send "{Tab}"
            Sleep 100
            Send "{Enter}"

            Sleep 150
                    
            Send "{Tab}"
            Sleep 100
            Send "{Tab}"
            Sleep 100
            Send "{Tab}"
            Sleep 100
            Send "{Enter}"

            Sleep 150
            
            Send "{Tab}"
            Sleep 100
            Send "{Tab}"
            Sleep 100
            Send "{Tab}"
            Sleep 100
            Send "{Enter}"
        }
        clicCount := 0 ; Reinicia el contador para la próxima vez
    }
}

 ;--- Remapeo teclas padnumerico ---
;==================================================================
NumpadDiv::Backspace
NumpadMult::Tab
NumLock::
{
    Send "^a"
    Sleep 50
    Send "^c"
    Sleep 50
    MostrarToolTip("Copiado")
    Sleep 100  
    Send "{Enter}"
}

PGUP:: ;--> Mostrar guia
{
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Enter}"

    Sleep 150
    
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Enter}"
}

PGDN:: ;--> Imprimir guia
{
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Enter}"
    
    Sleep 150
    
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Enter}"
}

End:: ;--> Impresion directa
{
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Enter}"

    Sleep 150
    
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Enter}"

    Sleep 150
            
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Enter}"

    Sleep 150
    
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Enter}"
}

Home::!F4 ;--> Cerrar ventana

;   --- Version de las FNum--- 
;==================================================================
F1:: ;--> Mostrar guia
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
F2:: ;--> Imprimir guia
{
    Send "{Tab}"
    Sleep 150
    Send "{Tab}"
    Sleep 150
    Send "{Tab}"
    Sleep 150
    Send "{Enter}"
    Sleep 150
    Send "{Tab}"
    Sleep 150
    Send "{Tab}"
    Sleep 150
    Send "{Tab}"
    Sleep 150
    Send "{Enter}"
}
F3:: ;--> Impresion directa
{
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Enter}"

    Sleep 150
    
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Enter}"

    Sleep 150
            
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Enter}"

    Sleep 150
    
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Tab}"
    Sleep 100
    Send "{Enter}"
}

F4::!F4 ;--> Cerrar ventana