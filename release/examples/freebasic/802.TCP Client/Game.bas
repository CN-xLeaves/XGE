' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' this is another gui library i developed, which wraps Win32SDK as a more friendly interface
#LibPath "Lib"
#Include "Inc\xGui.bi"



Dim Shared As xGui.xTextBox TextIP, TextPort, TextSend, TextRecv
Dim Shared As xGui.xWindow MainWindow
Dim Shared As xGui.xButton BtnCreate
Dim Shared As xGui.xLabel LabelState
Dim Shared tcp As xSock.xClient



' recv data event
Sub my_tcp_RecvEvent(pack As ZString Ptr, size As UInteger)
	pack[size] = 0
	TextRecv.Text = *TextRecv.Text & !"收到服务器发来的消息：\r\n" & *pack & !"\r\n\r\n"
	TextRecv.Send(EM_LINESCROLL, 0, TextRecv.Send(EM_GETLINECOUNT))
End Sub

' send event (code of 0 is success, code of 1 is fail)
Sub my_tcp_SendEvent(code As Integer)
	
End Sub

' disconnect event
Sub my_tcp_CloseEvent()
	BtnCreate.Enabled = TRUE
End Sub



Function DlgProc(ByVal hWin As HWND, ByVal uMsg As UINT, ByVal wParam As WPARAM, ByVal lParam As LPARAM) As Integer
	Dim As Long id, Event
	Select Case uMsg
		Case WM_INITDIALOG
			MainWindow.Bind(hWin)
			TextIP.Bind(hWin, 1001)
			TextPort.Bind(hWin, 1004)
			TextSend.Bind(hWin, 1006)
			TextRecv.Bind(hWin, 1005)
			BtnCreate.Bind(hWin, 1008)
			LabelState.Bind(hWin, 1009)
			tcp.Event.OnRecv = Cast(Any Ptr, @my_tcp_RecvEvent)
			tcp.Event.OnSend = Cast(Any Ptr, @my_tcp_SendEvent)
			tcp.Event.OnDisconn = Cast(Any Ptr, @my_tcp_CloseEvent)
		Case WM_COMMAND
			id=LoWord(wParam)
			Event=HiWord(wParam)
			If Event=BN_CLICKED Then
				Select Case id
					Case 1008	' Create
						Dim Port As Integer = CInt(*TextPort.Text)
						If tcp.Connect("127.0.0.1", Port) Then
							MainWindow.Caption = "TCP客户端 [已连接]"
							BtnCreate.Enabled = FALSE
						EndIf
					Case 1007	' Send
						If tcp.Status Then
							If TextSend.Length > 0 Then
								If tcp.Send(TextSend.Text, 0) Then
									LabelState.Caption = "发送成功"
								Else
									LabelState.Caption = "发送失败"
								EndIf
							Else
								LabelState.Caption = "请先输入要发送的内容"
							EndIf
						Else
							LabelState.Caption = "请先创建本地Socket"
						EndIf
				End Select
			EndIf
		Case WM_CLOSE
			EndDialog(hWin, 0)
		Case Else
			Return FALSE
	End Select
	Return TRUE
End Function



DialogBoxParam(GetModuleHandle(NULL),Cast(zstring ptr,1000),NULL,@DlgProc, 0)
ExitProcess(0)
