#SingleInstance, force


WrapClipText(Left, Right) {
	ClipSaved := ClipboardAll
	Clipboard = 
	Send ^c
	ClipWait, 1
    Clipboard := Left . Clipboard . Right
    Send ^v
    Sleep, 1000
    Clipboard := ClipSaved
    ClipSaved = 
    return
}

CommentWrappedText() {
    Clipboard =
    Send ^c
    ClipWait, 1
    if (InStr(Clipboard, "(*") AND InStr(Clipboard, "*)"))
    {
        Clipboard:=StrReplace(Clipboard, "(*", "", Limit := 1)
        Clipboard:=StrReplace(Clipboard, "*)", "", Limit := 1)
        Send ^v
    } 
    else
        WrapClipText("(*", "*)")
}

#IfWinActive, ahk_exe Siemens.Automation.Portal.exe
    
    #+-:: ; Invert result with operator of current assignment
        ; Send {End}
        ; Send {ShiftDown}{Home}{ShiftUp}
        Send {CtrlDown}c{CtrlUp}
       ; MsgBox, %Clipboard%
        Sleep, 500
        commmandstr := Clipboard    
       ; MsgBox, %Clipboard%
        ; rows := StrSplit(Cslipboard, ";")
            ; MsgBox %rows%
        loop, Parse, commmandstr, `;`n 
        {
            if Trim(A_LoopField) = ""
                Continue
           ; MsgBox %A_LoopField%
            ; InStr(Haystack, Needle [, CaseSensitive = false, StartingPos = 1, Occurrence = 1])
            Position := InStr(A_LoopField, ":=") ; position of assignment
            ; SubStr(String, StartingPos [, Length])
            word_array1 := SubStr(A_LoopField, 1, Position - 1)
            word_array1 := StrReplace(word_array1, "`n", "") ; removing new line from read string
            word_array2 := StrReplace(SubStr(A_LoopField, Position  + StrLen(":=")), ";", "")
            ; MsgBox %word_array1%
            ; MsgBox %word_array2%
            word_array1 := Trim(word_array1)
            word_array2 := Trim(word_array2)
            result := word_array2 " := " word_array1 ";`n" 
            Clipboard := result
            Send {CtrlDown}v{CtrlUp}
            
            ;MsgBox %Clipboard%
        }
    Return

    ^#s::
    while GetKeyState("LControl")
    {
        Send, {F2}
        Sleep, 500
        Send, {Right}
        Sleep, 500
        Send, {Space}
        sleep, 500
        Send, {CtrlDown} v {CtrlUp}
        Sleep, 500
        Send, {Enter}
        sleep, 1000
    }
        return

    #w::
        Send, {CtrlDown} {F4} {CtrlUp}
        return

    #+r::WrapClipText("REGION region_name`n", "`nEND_REGION")
    #+i::WrapClipText("IF condition THEN`n", "`nEND_IF;")
    #+f::WrapClipText("FOR counter:=0 TO limit BY 1 DO`n", "`nEND_FOR;")
    #+w::WrapClipText("WHILE condition DO`n", "`nEND_WHILE;")
    #+c::WrapClipText("CASE switch OF`n0:`n", "`nEND_CASE;")
    #+q::WrapClipText("REPEAT`n", "`nUNTIL condition`nEND_REPEAT;")
    #+9::WrapClipText("(", ")")
    #+m::CommentWrappedText()
         
Return
