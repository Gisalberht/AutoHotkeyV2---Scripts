#a::WindowPreview("A")
 
#Requires AutoHotkey v2.0
#DllLoad dwmapi
 
/**
 * Creates a preview window of a window
 * - drag to pan
 * - scroll to zoom
 * - click to restore original window
 */
class WindowPreview extends Gui {
 
    Ratio => this.SrW/this.SrH
 
    __New(win) {
        this.HwndSource := WinExist(win)
        super.__New("+AlwaysOnTop +ToolWindow +Resize", WinGetTitle(this.HwndSource), this)
        this.BackColor := 0x1a1a1a
        this.Thumbnail := Thumbnail(this, this.HwndSource, true)
        WinGetPos(&sourceX, &sourceY, &sourceW, &sourceH, this.HwndSource)
 
        initialHeight := 400
        iW := initialHeight * sourceW/sourceH
        iH := initialHeight
        iX := sourceX + sourceW - iW - 30
        iY := sourceY + sourceH - iH - 50
        this.Show("x" iX " y" iY " w" iW " h" iH)
 
        ; screen to client coords
        POINT := Buffer(8, 0)
        NumPut("int", sourceX, POINT, 0), NumPut("int", sourceY, POINT, 4)
        DllCall("ScreenToClient", "ptr", this.HwndSource, "ptr", POINT)
        sourceX := NumGet(POINT, 0, "int")
        sourceY := NumGet(POINT, 4, "int")
 
        this.SrX := sourceX
        this.SrY := sourceY
        this.SrW := sourceW
        this.SrH := sourceH
        this.FillAll := true
 
        this.GetClientPos(,,&guiW, &guiH)
        WinGetClientPos(,,&sourceW, &sourceH, this.HwndSource)
        this.Thumbnail.SetSourceRegion(0, 0, sourceW, sourceH)
        this.Thumbnail.SetThumbRegion(0,0, guiW, guiH)
        this.Events := {
            LBUTTONDOWN:ObjBindMethod(this, "WM_LBUTTONDOWN"),
            MOUSEWHEEL:ObjBindMethod(this, "WM_MOUSEWHEEL")
        }
        OnMessage(0x201,  this.Events.LBUTTONDOWN)
        OnMessage(0x020A, this.Events.MOUSEWHEEL)
        this.OnEvent("Close", "GuiClose")
        this.OnEvent("Size", "GuiSize")
    }
    WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) {
        if hwnd != this.hwnd
            return
        MouseGetPos(&oX, &oY)
        static MouseState := "Click"
        while GetKeyState("LButton", "P") {
            MouseGetPos(&X, &Y)
            if oX = X && oY = Y
                continue
            if Abs(X - oX) > 4 || Abs(Y - oY) > 4 {
                MouseState := "Move"
                break
            }
            sleep 1
        }
        if MouseState = "Click" {
            WinActivate this.HwndSource
            return
        }
        if MouseState = "Move" {
            MouseGetPos &lmX, &lmY
            lXg := this.SrX, lYg := this.SrY
            while GetKeyState("LButton", "P") {
                MouseGetPos(&mX, &mY)
                ; do nothing if mouse hasn't moved
                if lmX = mX && lmY = mY
                    continue
                this.Thumbnail.GetSourceSize(&sourceW, &sourceH)
                this.GetClientPos(,,&guiW, &guiH)
 
                guiRatio := guiW/guiH
                limit := 100
 
                ; prevent dragging too far.
                xLeft := Max(-this.Srw + limit, -this.srh * guiRatio + limit)
                xdiff := mx - lmx
                this.SrX := Min(Max(xLeft, this.SrX - xdiff), SourceW-limit)
 
                yUp := Max(-this.SrH + limit, -this.srw / guiRatio + limit)
                ydiff := my - lmy
                this.Sry := Min(Max(yUp, this.SrY - ydiff), SourceH-limit)
 
                thumbW := Max(guiH * this.Ratio, guiW)
                thumbH := Max(guiW / this.Ratio, guiH)
                this.Thumbnail.SetSourceRegion(this.SrX, this.SrY, this.SrW, this.SrH)
                lmx := mx, lmy := my
                sleep 1
            }
        }
        MouseState := "Click"
    }
    WM_MOUSEWHEEL(wParam, lParam, msg, hwnd) {
        if hwnd != this.hwnd
            return
 
        this.GetClientPos(,,&guiW, &guiH)
 
        wheel := Integer((wParam << 32 >> 48) / 120)
 
        restoreX := this.SrX
        restoreY := this.Sry
        restoreW := this.SrW
        restoreH := this.SrH
 
        multiplier := 10
        this.SrX += wheel * multiplier
        this.SrY += wheel * multiplier
        this.SrW -= wheel * multiplier * 2
        this.SrH -= wheel * multiplier * 2
        this.Thumbnail.GetSourceSize(&sourceW, &sourceH)
 
        ; prevent zooming in too close
        if this.SrW/sourceW < 0.08
        || this.SrH/sourceH < 0.08 {
            this.SrX := restoreX
            this.SrY := restoreY
            this.SrW := restoreW
            this.SrH := restoreH
            return
        }
 
        if this.SrW > sourceW
        && this.SrH > sourceH {
            this.SrX := restoreX
            this.SrW := SourceW
            this.SrY := restoreY
            this.srH := SourceH
        }
 
        this.FillAll := (this.SrW = sourceW && this.SrH = sourceH)
 
        this.Thumbnail.SetSourceRegion(this.SrX, this.SrY, this.SrW, this.SrH)
 
        thumbW := Max(guiH * this.Ratio, guiW)
        thumbH := Max(guiW / this.Ratio, guiH)
 
        this.Thumbnail.SetThumbRegion(0, 0, thumbW, thumbH)
    }
    GuiClose() {
        OnMessage 0x201, this.Events.LBUTTONDOWN, 0
        OnMessage 0x020A, this.Events.MOUSEWHEEL, 0
        this.Events := ""
    }
    GuiSize(MinMax, guiW, guiH) {
        if this.FillAll {
            this.Thumbnail.GetSourceSize(&sourceW, &sourceH)
            this.Thumbnail.SetSourceRegion(0, 0, sourceW, sourceH)
            thumbW := Min(guiH * this.Ratio, guiW)
            thumbH := Min(guiW / this.Ratio, guiH)
            ThumbX := 0 + (guiW - thumbW)/2
            ThumbY := 0 + (guiH - thumbH)/2
            this.Thumbnail.SetThumbRegion(ThumbX, ThumbY, ThumbW, ThumbH)
        } else {
            thumbW := Max(guiH * this.Ratio, guiW)
            thumbH := Max(guiW / this.Ratio, guiH)
            this.Thumbnail.SetThumbRegion(0,0,thumbW,thumbH)
        }
    }
}
 
; https://www.autohotkey.com/boards/viewtopic.php?p=432779#p432779
class Thumbnail {
 
    __New(hGui, hSource:=WinExist("A"), clientOnly:=false) {
 
        this.ClientOnly := clientOnly
        hSource := WinExist(hSource)
        hGui := WinExist(hGui)
        if hSource {
            if DllCall("dwmapi\DwmRegisterThumbnail", "Ptr", hGui, "Ptr", hSource, "Ptr*", &hThumbnailId := 0, "HRESULT")
                throw Error("DwmRegisterThumbnail failed")
            this.hwndSource := hSource
            this.Gui := hGui
            this.ThumbnailID := hThumbnailId
        }
    }
    __Delete() {
        if this.HasProp('ThumbnailID')
            DllCall("Dwmapi\DwmUnregisterThumbnail", "ptr", this.ThumbnailID)
    }
    GetSourceSize(&width, &height) {
        Size := Buffer(8, 0)
        if DllCall("dwmapi.dll\DwmQueryThumbnailSourceSize", "Uint", this.ThumbnailID, "Ptr", Size) {
            return false
        }
        width := NumGet(Size, 0, "int")
        height := NumGet(Size, 4, "int")
    }
    SetSourceRegion(X, Y, W, H) {
        ; DWM_TNP_RECTSOURCE
        this.SetRegion(0x2, X, Y, W, H)
    }
    SetThumbRegion(X, Y, W, H) {
        ; DWM_TNP_RECTDESTINATION
        this.SetRegion(0x1, X, Y, W, H)
    }
    SetRegion(flag, X, Y, W, H) {
        clientOnly := this.ClientOnly
        static DWM_TNP_SOURCECLIENTAREAONLY := 0x10
        , DWM_TNP_RECTDESTINATION := 0x1
        , DWM_TNP_RECTSOURCE := 0x2
        DWM_THUMBNAIL_PROPERTIES := Buffer(48, 0)
        flags := flag | DWM_TNP_SOURCECLIENTAREAONLY*(flag = DWM_TNP_RECTSOURCE)
        NumPut( "uint", flags     , DWM_THUMBNAIL_PROPERTIES)
        NumPut( "int" , X         , DWM_THUMBNAIL_PROPERTIES , 4 + 16*(flag = DWM_TNP_RECTSOURCE) )
        NumPut( "int" , Y         , DWM_THUMBNAIL_PROPERTIES , 8 + 16*(flag = DWM_TNP_RECTSOURCE) )
        NumPut( "int" , X + W     , DWM_THUMBNAIL_PROPERTIES , 12 + 16*(flag = DWM_TNP_RECTSOURCE) )
        NumPut( "int" , Y + H     , DWM_THUMBNAIL_PROPERTIES , 16 + 16*(flag = DWM_TNP_RECTSOURCE) )
        NumPut( "UInt", clientOnly, DWM_THUMBNAIL_PROPERTIES , 44)
        this.UpdateThumbnailProperties(DWM_THUMBNAIL_PROPERTIES)
    }
    UpdateThumbnailProperties(pProp) {
        DllCall("dwmapi\DwmUpdateThumbnailProperties", "Ptr", this.ThumbnailId, "Ptr", pProp)
    }
}