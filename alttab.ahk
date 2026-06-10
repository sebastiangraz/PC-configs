#Requires AutoHotkey v2.0

; [!  = ALT]
; [^  = CTRL]
; [>^ = RCtrl]
; [+  = SHIFT]
; [#  = WIN]



; [from Ctrl-Tab to Alt-Tab]
; >^Tab:: {
;    Send "{Ctrl down}{Tab}"
;    Keywait "Control"
;    Send "{Ctrl up}"
;    return
;}
;>^+Tab:: {
;    Send "{Ctrl down}{Shift down}{Tab}"
;    Keywait "Control"
;    Send "{Ctrl up}"
;    Send "{Shift up}"
;    return
;}


; [from Alt-Tab to Ctrl-Tab]

LCtrl & Tab:: {
    ; [Check if Shift is pressed at the time of the hotkey activation]
    if GetKeyState("Shift", "P") {
        ; [If Shift is pressed, send Alt+Shift+Tab to move backwards in the tab menu]
        Send("{Alt Down}{Shift Down}{Tab}")
    } else {
        ; [If Shift is not pressed, send Alt+Tab to move forwards in the tab menu]
        Send("{Alt Down}{Tab}")
    }
    return
}
; [Handles the release of the LCtrl to stop the operation]
~*LCtrl Up:: {
    ; [Release the Shift and Alt keys to end tab navigation]
    Send("{Shift Up}{Alt Up}")
    return
}
