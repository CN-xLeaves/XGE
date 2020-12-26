Dim Shared As ZString Ptr WinStr,WinTil,TxtStr
Dim Shared As Integer PX,PY,WinSty,WinSex
Dim Shared As ZString * 256 RetStr

Function InputProc(ByVal hWin As HWND, ByVal uMsg As UINT, ByVal wParam As WPARAM, ByVal lParam As LPARAM) As Integer
	Dim As Long id, Event
	Select Case uMsg
		Case WM_INITDIALOG
			If (PX<>0) And (PY<>0) Then															' 处理窗口位置
				SetWindowPos(hWin,HWND_TOP,PX,PY,0,0,SWP_NOSIZE)
			EndIf
			SetWindowText(hWin,WinTil)															' 处理默认字符
			SetWindowText(GetDlgItem(hWin,30001),WinStr)
			SetWindowText(GetDlgItem(hWin,30004),TxtStr)
		Case WM_COMMAND
			id=LoWord(wParam)
			Event=HiWord(wParam)
			If Event=BN_CLICKED Then
				Select Case id
					Case IDCANCEL
						EndDialog(hWin,0)
					Case 30002
						GetWindowText(GetDlgItem(hWin,30004),StrPtr(RetStr),256)
						EndDialog(hWin,1)
					Case 30003
						EndDialog(hWin,0)
				End Select
			EndIf
		Case WM_CLOSE
			EndDialog(hWin, 0)
		Case Else
			Return FALSE
	End Select
	Return TRUE
End Function

Function InputBox(ByVal ParHWND As HWND,ByVal MsgStr As ZString Ptr,ByVal Title As ZString Ptr,ByVal Default As ZString Ptr,ByVal X As Integer,ByVal Y As Integer,ByVal Style As Integer,ByVal StyleEx As Integer) As ZString Ptr
	WinStr = MsgStr
	WinTil = Title
	TxtStr = Default
	PX = X
	PY = Y
	WinSty = Style
	WinSex = StyleEx
	RetStr = ""
	Dim As Integer WinRet = DialogBoxParam(GetModuleHandle(NULL),Cast(zstring ptr,30000),ParHWND,@InputProc,0)
	If WinRet Then
		InputBox = StrPtr(RetStr)
	Else
		InputBox = StrPtr("")
	EndIf
End Function
