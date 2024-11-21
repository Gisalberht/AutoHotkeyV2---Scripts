#SingleInstance Force
#UseHook

;——> - = Enter
-:: ; No encontre como vencer la repeticion de teclas de windows, por lo que se cuenta con '1 segundo' para ser usado como Ctrl, antes de que falle y empice a repetir. 

;A LO MEJOR SE PUEDE SUPERAR ENVIANDO vkE8 DESPUES DE CTRL DOWN Y ANTES DEL KEYWAIT "-"
{
    Send "{Blind}{vkE8}"
    StartTime :=A_TickCount
    KeyWait "-", "T0.14"
    ElapsedTime := A_TickCount - StartTime
    If (ElapsedTime < 120)
        {
            ;ToolTip ElapsedTime
            ;MsgBox "hola"
            Send "{Enter}"
            Return
        }
        ;KeyWait "-"
        ;ElapsedTime2 := A_TickCount - StartTime
        ;ToolTip ElapsedTime2
        ;ToolTip "adios"

        ;Send "{CtrlDown}"
        ;ToolTip "amigo"
        ;Sleep 3000



        Send "{CtrlDown}"
        ;Sleep 50
        KeyWait "-"
       ; ToolTip "salé"
        ;Sleep 3000
        Send "{CtrlUp}"
        Return
}
