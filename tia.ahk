#SingleInstance, force

WrapClipText(Left, Right) ;wrap any selected text between two strings
{
    ClipSaved := ClipboardAll
    Clipboard =
    Send ^c
    ClipWait, 1
    Clipboard := Left . Clipboard . Right
    Send ^v
    Sleep, 1000
    Clipboard := ClipSaved
    ClipSaved =
    Return
}

CommentWrappedText() ;comment/uncomment selected text
{
    Clipboard =
    Send ^c
    ClipWait, 1
    if (InStr(Clipboard, "(*") AND InStr(Clipboard, "*)")) {
        Clipboard:=StrReplace(Clipboard, "(*", "", Limit := 1)
        Clipboard:=StrReplace(Clipboard, "*)", "", Limit := 1)
        Send ^v
    }else
    WrapClipText("(*", "*)")
}

#if WinActive("ahk_exe Siemens.Automation.Portal.exe")

#+-:: ; Invert result with operator of current assignment
    Send {CtrlDown}c{CtrlUp}
    Sleep, 500
    commmandstr := Clipboard
    loop, Parse, commmandstr, `;
    {
        Position := InStr(A_LoopField, ":=") ; position of assignment
        word_array1 := SubStr(A_LoopField, 1, Position - 1)
        word_array1 := StrReplace(word_array1, "`n", "") ; removing new line from read string
        word_array2 := StrReplace(SubStr(A_LoopField, Position + StrLen(":=")), ";", "")
        word_array1 := Trim(word_array1)
        word_array2 := Trim(word_array2)
        result := word_array2 " := " word_array1 ";`n"
        Clipboard := result
        ClipWait, 500
        if Trim(A_LoopField) != ""
            Send {CtrlDown}v{CtrlUp}
        Sleep, 500
    }
Return

+^f:: ;auto Format all code
    Send {CtrlDown} a {CtrlUp}
    Send {CtrlDown}{ShiftDown} w {CtrlUp}{ShiftUp}
    send {Right}
Return

^/:: ;comment current line
    Send, {End}
    Send, {ShiftDown} {Home}
    Clipboard =
    Send ^c
    ClipWait, 1
    if (InStr(Clipboard, "//")) {
        Clipboard:=StrReplace(Clipboard, "//", "", Limit := 1)
        Send ^v
    } else {
        WrapClipText("//", "")
    }
Return

^#s:: ;paste clipboard content for every row at the end of string
    Loop {
        Send, {F2}
        Sleep, 500
        Send, {Right}
        Sleep, 500
        Send ^v
        Sleep, 500
        Send, {Enter}
        sleep, 1000
        if(GetKeyState("LControl")) {
            break
        }
    }
Return

^w:: ;close current tab
    Send, {CtrlDown} {F4} {CtrlUp}
Return

#+r::WrapClipText("REGION _region_name_`n", "`nEND_REGION") ;create region
#+i::WrapClipText("if _condition_ THEN`n", "`nEND_IF;") ;create if
#+f::WrapClipText("FOR _counter_ := 0 TO limit BY 1 DO`n", "`nEND_FOR;") ;create for
#+w::WrapClipText("while _condition_ DO`n", "`nEND_WHILE;") ;create while
#+c::WrapClipText("CASE _switch_ OF`n0:`n", "`nEND_CASE;") ;create switch case
#+q::WrapClipText("REPEAT`n", "`nUNTIL _condition_`nEND_REPEAT;") ;create repeat
#+9::WrapClipText("(", ")") ;enclose in parenthesis
#+m::CommentWrappedText() ;comment selected code
#if

Return
