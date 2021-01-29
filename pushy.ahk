#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Gui Add, Button, x376 y8 w80 h120, Send

Gui Add, Text, x8 y8 w120 h23 +0x200, Title
Gui Add, Text, x8 y40 w120 h23 +0x200, Detail Text
Gui Add, Text, x8 y72 w120 h23 +0x200, URL
Gui Add, Text, x8 y104 w120 h23 +0x200, Key

Gui Add, Edit, x106 y8 w262 h21 vT
Gui Add, Edit, x106 y40 w262 h21 vD
Gui Add, Edit, x106 y72 w262 h21 vU
Gui Add, Edit, x106 y104 w262 h21 vK

IniRead, K, pushy.ini, config, key
IniRead, T, pushy.ini, config, title
IniRead, D, pushy.ini, config, desc
IniRead, U, pushy.ini, config, url

GuiControl,,K,%K%
GuiControl,,T,%T%
GuiControl,,U,%U%
GuiControl,,D,%D%
Gui, Show,, Pushy

Return

ButtonSend:
    Gui, Submit, NoHide
    IniWrite, %K%, pushy.ini, config, key
    IniWrite, %T%, pushy.ini, config, title
    IniWrite, %U%, pushy.ini, config, url
    IniWrite, %D%, pushy.ini, config, desc

    GuiControl, Disable, Send

    URL = https://xdroid.net/api/message?k=%K%&c=%D%&t=%T%&u=%U%

    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("GET", URL , true)
    whr.Send()
    whr.WaitForResponse()
    
    GuiControl, Enable, Send
    Return

GuiEscape:
GuiClose:
    ExitApp
