;==================================================================
;SCRIPTS PARA INTERRAPIDISIMO
;==================================================================
;Descripcion: mejor flujo de trabajo en tareas repetitivas.

;                       --- DIRECTIVAS ---
;==================================================================
#SingleInstance Force
#UseHook

;              --- MOSTRAR ICONO EN LA BANDEJA ---
;==================================================================
SetTimer ShowIcon, 6000
ShowIcon() {
    A_IconHidden := false
    SetTimer ShowIcon, 0
}
					
;                   --- SUSPENCION DE SCRIPT --- 
;==================================================================
#SuspendExempt
|::Suspend

#SuspendExempt False
;-------------------

;                         --- FUNCIONES --- 
;==================================================================
;Función auxiliar para mostrar/ocultar tooltip
MostrarToolTip(mensaje) {
	ToolTip mensaje
	SetTimer () => ToolTip(), -800  ; Oculta el ToolTip después de 800 ms
}

;Funcion para mostrar guia
MostrarGuia() {
    Click 1
    Sleep 50
    Send "^a"
    Sleep 50
    Send "{Delete}"
    Sleep 50
    Send "^v"
    MostrarToolTip("Reemplazado")
    Sleep 200
    ;Secuencia de 7 Tabs
    Loop 7 {
        Send "{Tab}"
        Sleep 100
    }
    Send "{Enter}"
    Sleep 150
    ;Secuencia de 3 Tabs
    Loop 3 {
        Send "{Tab}"
        Sleep 100
    }
    Send "{Enter}"
}

;Funcion para imprimir guia
ImprimirGuia() {
    ;Secuencia de 3 Tabs
    Loop 3 {
        Send "{Tab}"
        Sleep 100
    }
    Send "{Enter}"
    ; Secuencia de 3 Tabs
    Loop 3 {
        Send "{Tab}"
        Sleep 100
    }
    Send "{Enter}"
}

;Funcion para reemplazar texto
ReemplazarTexto() {
    Click 1
    Sleep 50
    Send "^a"
    Sleep 50
    Send "{Delete}"
    Sleep 50
    Send "^v"
    MostrarToolTip("Reemplazado")
}


;                   --- ATAJOS DEL MOUSE --- 
;==================================================================
RButton:: ;--> Enmascaramiento de RButton.
{
    KeyWait "RButton"
    if (A_PriorKey == "RButton")
    {
        Click "Right" ; Clic derecho normal al soltar
    }
}

MButton:: ;--> Copiar
{
    Click 1
    Sleep 50
    Send "^a"
    Sleep 50
    Send "^c"
    MostrarToolTip("Copiado")
}

RButton & LButton::
{ReemplazarTexto()
}


;         --- CONTROL DE GUIAS VERSION DE LAS HOTIF --- 
;==================================================================

#HotIf WinActive("ahk_exe PosWPF.Cliente.exe")
RButton & LButton::
{
    ReemplazarTexto()
    Sleep 200
    MostrarGuia()
}

/*RButton:: ;--> Probar a ver
{
    ImprimirGuia()
}*/
#HotIf

#HotIf WinActive("añadir clase ahk_exe PosWPF.Cliente.exe")
RButton & LButton::
{ImprimirGuia()
}
#HotIf


;       --- CONTROL DE GUIAS VERSION DEL TECLADO NUMERICO ---
;==================================================================
NumpadDiv::Backspace
NumpadMult::Tab
NumpadDot::
{
    Send "{WheelDown}"
    Sleep 50
    Send "{WheelDown}"
    Sleep 50
    Send "{WheelDown}"
    Sleep 50
    Send "{WheelDown}"
}
NumpadEnter::
{
    Send "^a"
    Sleep 50
    Send "^c"
    Sleep 50
    MostrarToolTip("Copiado")
    Sleep 100
    Send "{Enter}"
}
PGUP::
{MostrarGuia()
}
PGDN::
{ImprimirGuia()
}
Home::!F4 ;--> Cerrar ventana


;           --- CONTROL DE GUIAS VERSION DE LAS FNUM --- 
;==================================================================
F1::
{MostrarGuia()
}
F2::
{ImprimirGuia()
}
F4::!F4 ;--> Cerrar ventana