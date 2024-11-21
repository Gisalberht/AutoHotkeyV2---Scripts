 #SingleInstance Force
#UseHook
;SetStoreCapsLockMode False ——> desactiva la funcion que recuerda el estado previo de capslock y que puede tener presendencia por encima del script.

; pasa que la primera pulsacion de 'tab + ctrl (capslock)' activa Capslock, las siguientes no, lo mismo pasa con RShift & LShift::CapsLock y LShift & RShift::CapsLock, que a la primera no se envia capslock, luego si, pero con estas no importa tanto, toca buscar una forma de que se ejecute constante o algo para que no se active capslock a la primera 'tab + ctrl (capslock) o desactivarlo, aunque afecte RShift & LShift::CapsLock y LShift & RShift::CapsLock.

RShift & LShift::CapsLock
LShift & RShift::CapsLock

CapsLock:: ;——> Capslock en pulsacion corta envia 'esc', en pulsacion larga envia 'ctrl' mas por la repeticion de teclas de windows es mejor no durar mucho tiempo en pulsacion y aunque 'ctrl + capslock' no envia nada, por lo que se puede pulsar por mas de un segundo a diferencia de otras teclas, pero si se demora mucho pude enviar 'Capslock' y colocar todo en mayusculas.  Más no se desactiva 'Capslock' definitivamente para poder usarlo cuando se necesite. SOLUCION ABAJO.
{
    StartTime :=A_TickCount
    KeyWait "CapsLock", "T0.201"
    ElapsedTime := A_TickCount - StartTime
    If (ElapsedTime < 200)
        {
            Send "{Esc}"
            Return
        }
        Send "{CtrlDown}"
        KeyWait "CapsLock"
        Send "{CtrlUp}"
        Return
}


;Solucion: si control esta activo al soltar capslock, desactivalo xd.

RShift & LShift::SetCapsLockState !GetKeyState("CapsLock", "T")
LShift & RShift::SetCapsLockState !GetKeyState("CapsLock", "T")

CapsLock:: ;——> Pulsacion corta envia 'esc', pulsacion larga 'Ctrl'.
{
    StartTime :=A_TickCount
    KeyWait "CapsLock", "T0.201"
    ElapsedTime := A_TickCount - StartTime
    If (ElapsedTime < 200)
        {
            Send "{Esc}"
            Return
        }
    Send "{CtrlDown}"
    KeyWait "CapsLock"
    Send "{CtrlUp}"
    estado_capslock := GetKeyState("CapsLock", "T")
    If (estado_capslock == 1)
    {
        SetCapsLockState !GetKeyState("CapsLock", "T")
        Return
    }
    Return
}
