#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
^!d::AddToDynalist()  ;  ctrl+alt-D快捷键调用
^!s::AddToSeeds()  ;  ctrl-alt-S快捷键调用

AddToDynalist() {
	clipboard := ""
	Send ^c
	ClipWait 0.5
	StringReplace, Clipboard, Clipboard, `r`n, %A_Space%, All

	InputBox, UserInput, Add to Dynalist ,,,350,120,,,,,✏️%clipboard%
	If (!ErrorLevel and UserInput <> "")
	{
	    ;UserInput := UriEncode(UserInput)
	    URL := "https://dynalist.io/api/v1/inbox/add"
	    HttpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	    HttpObj.Open("POST", URL, 0)
	    HttpObj.SetRequestHeader("Content-Type", "application/json")

	    Body := "{ ""content"": """ . UserInput . """,""token"":""请换成你自己的Token""}"
	    HttpObj.Send(Body)
	    Result := HttpObj.ResponseText
	    Status := HttpObj.Status
	}
}

AddToSeeds() {
	clipboard := ""
	Send ^c
	ClipWait 0.5
	StringReplace, Clipboard, Clipboard, `r`n, %A_Space%, All
	InputBox, UserInput, Add to Seeds ,,,350,120,,,,,✏️%clipboard%
	If (!ErrorLevel and UserInput <> "")
	{
	;UserInput := UriEncode(UserInput)
	URL := "请换成你自己的Seeds Api"
	    HttpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	    HttpObj.Open("POST", URL, 0)
	    HttpObj.SetRequestHeader("Content-Type", "application/json")

	    Body := "{ ""content"": ""✏️" . UserInput . """}"
	    HttpObj.Send(Body)
	    Result := HttpObj.ResponseText
	    Status := HttpObj.Status
	}
}