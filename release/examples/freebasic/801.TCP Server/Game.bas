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
Dim Shared As xGui.xListBox ListClient
Dim Shared tcp As xSock.xServer



' recv data event
Sub my_tcp_RecvEvent(client As HANDLE, pack As ZString Ptr, size As UInteger)
	Dim ip As ZString Ptr
	Dim port As UInteger
	tcp.GetClientInfo(Client, @ip, @port)
	pack[size] = 0
	TextRecv.Text = *TextRecv.Text & "收到来自客户端" & *ip & ":" & port & !"的消息：\r\n" & *pack & !"\r\n\r\n"
	TextRecv.Send(EM_LINESCROLL, 0, TextRecv.Send(EM_GETLINECOUNT))
End Sub

' send event (code of 0 is success, code of 1 is fail)
Sub my_tcp_SendEvent(client As HANDLE, code As Integer)
	
End Sub

' client connect event
Sub my_tcp_AcceptEvent(client As HANDLE)
	MainWindow.Post(WM_COMMAND, MAKEWPARAM(1011, BN_CLICKED), 0)
End Sub

' client disconnect event
Sub my_tcp_DisconnEvent(client As HANDLE)
	MainWindow.Post(WM_COMMAND, MAKEWPARAM(1011, BN_CLICKED), 0)
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
			ListClient.Bind(hWin, 1010)
			tcp.Event.OnRecv = Cast(Any Ptr, @my_tcp_RecvEvent)
			tcp.Event.OnSend = Cast(Any Ptr, @my_tcp_SendEvent)
			tcp.Event.OnAccept = Cast(Any Ptr, @my_tcp_AcceptEvent)
			tcp.Event.OnDisconn = Cast(Any Ptr, @my_tcp_DisconnEvent)
		Case WM_COMMAND
			id=LoWord(wParam)
			Event=HiWord(wParam)
			If Event=BN_CLICKED Then
				Select Case id
					Case 1008	' Create
						Dim Port As Integer = CInt(*TextPort.Text)
						If tcp.Create("0.0.0.0", Port, 10) Then
							MainWindow.Caption = "TCP服务端 [已启动(" & Port & ")]"
						EndIf
					Case 1007	' Send
						If tcp.Status Then
							If TextSend.Length > 0 Then
								If ListClient.ListIndex >= 0 Then
									Dim Client As HANDLE = Cast(HANDLE, ListClient.ItemData(ListClient.ListIndex))
									If Client Then
										If tcp.Send(Client, TextSend.Text, 0) Then
											LabelState.Caption = "发送成功"
										Else
											LabelState.Caption = "发送失败"
										EndIf
									Else
										LabelState.Caption = "获取到了无效的客户端句柄"
									EndIf
								Else
									' Broadcast
									Dim Client As HANDLE
									Do
										Client = tcp.EnumClient(Client)
										If Client Then
											tcp.Send(Client, TextSend.Text, 0, FALSE)
										EndIf
									Loop While Client
								EndIf
							Else
								LabelState.Caption = "请先输入要发送的内容"
							EndIf
						Else
							LabelState.Caption = "请先创建本地Socket"
						EndIf
					Case 1011	' Refresh Client List
						ListClient.Clear()
						Dim Client As HANDLE
						Do
							Client = tcp.EnumClient(Client)
							If Client Then
								Dim ip As ZString Ptr
								Dim port As UInteger
								tcp.GetClientInfo(Client, @ip, @port)
								ListClient.AddItemEx(*ip & ":" & port, Cast(Integer, Client))
							EndIf
						Loop While Client
				End Select
			EndIf
		Case WM_CLOSE
			EndDialog(hWin, 0)
		Case Else
			Return FALSE
	End Select
	Return TRUE
End Function



DialogBoxParam(GetModuleHandle(NULL), Cast(ZString Ptr, 1000), NULL, @DlgProc, 0)
ExitProcess(0)
