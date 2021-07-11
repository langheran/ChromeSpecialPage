#SingleInstance on
#include acc.ahk

args:=""
Loop, %0%  ; For each parameter:
{
    param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
	num = %A_Index%
	args := args . param
}
if(args="")
    ExitApp

args:=StrReplace(args,"chrome:")
args:=StrReplace(args,"chromespecialpage:")
args:=StrReplace(args,"\","/")
args:=LTrim(args, "/")

DetectHiddenWindows, On
SetTitleMatchMode, RegEx

hwndChrome:=WinExist(" - Google Chrome")
chromeExists:=1
if(!hwndChrome)
{
    chromeExists:=0
    Run, chrome
    while(!hwndChrome)
    {
        hwndChrome:=WinExist(" - Google Chrome")
        Sleep, 100
    }
}
WinActivate, % "ahk_id " . hwndChrome
if(chromeExists)
    SendInput, ^t
Sleep, 100
; ; ControlSend, Chrome_OmniboxView1, chrome://%args%{Enter}, - Google Chrome
; ControlFocus, Chrome_OmniboxView1
; Send chrome://%args%{Enter}
AccChrome := Acc_ObjectFromWindow(hwndChrome)
AccAddressBar := GetElementByName(AccChrome, "Address and search bar")
AccAddressBar.accValue(0) := "chrome://" . args
AccAddressBar.accSelect(0x1,0)
SendInput, {Enter}
ExitApp

GetElementByName(AccObj, name) {
   if (AccObj.accName(0) = name)
      return AccObj

   for k, v in Acc_Children(AccObj)
      if IsObject(obj := GetElementByName(v, name))
         return obj
}