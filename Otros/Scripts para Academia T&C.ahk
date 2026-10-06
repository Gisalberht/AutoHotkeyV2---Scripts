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