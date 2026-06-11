#Requires AutoHotkey v2.0

; [Relaunch as admin so the keyboard hook can intercept keys for elevated apps like Terminal]
full_command_line := DllCall("GetCommandLine", "str")
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)")) {
    try {
        if A_IsCompiled
            Run '*RunAs "' A_ScriptFullPath '" /restart'
        else
            Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
    }
    ExitApp
}

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


; [LCtrl+Backspace -> Delete (forward delete, like Mac fn+Backspace)]
<^Backspace:: {
    Send("{Delete}")
    return
}

; [LCtrl+LShift+4 -> Win+Shift+S (native screenshot/snipping overlay, like Mac Cmd+Shift+4)]
<^<+4:: {
    Send("#+{s}")
    return
}

; [RCtrl+LShift+V -> Win+V (native clipboard history modal)]
>^<+v:: {
    Send("#{v}")
    return
}

; [LCtrl+Space -> PowerToys Command Palette (launched directly)]
<^Space:: {
    Run("shell:AppsFolder\Microsoft.CommandPalette_8wekyb3d8bbwe!App")
    return
}
