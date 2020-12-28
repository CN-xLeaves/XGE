#Include Once "windows.bi"
#Include Once "crt\String.bi"
#Include Once "Inc\Core_File.bi"
#Include Once "Lzma.bi"



Dim Shared As HWND MainWindow,InFile,OutFile
Dim Shared As Integer DlRet
Dim Shared TS As ZString * 260
Dim Shared TS2 As ZString * 260



Function GetText(WindowHWND As HWND) As String
	Dim TL As DWORD,TS As String
	TL = GetWindowTextLength(WindowHWND)
	TS = String(TL,0)
	GetWindowText(WindowHWND,TS,TL+1)
	GetText = TS
End Function

Function DlgProc(ByVal hWin As HWND, ByVal uMsg As UINT, ByVal wParam As WPARAM, ByVal lParam As LPARAM) As Integer
	Dim As Long id, Event
	Select Case uMsg
		Case WM_INITDIALOG
			MainWindow = hWin
			InFile = GetDlgItem(MainWindow,1004)
			OutFile = GetDlgItem(MainWindow,1006)
			GetRandomFileName(@TS2,ExePath & "\xywh_",".txt",8)
			SetWindowText(OutFile,TS2)
			TS = ExePath() & "\*"
		Case WM_COMMAND
			id=LoWord(wParam)
			Event=HiWord(wParam)
			If Event=BN_CLICKED Then
				Select Case id
					Case 1002			' 浏览加密文件
						If OpenFileDlg(MainWindow,@TS,"*") Then
							SetWindowText(InFile,TS)
						EndIf
					Case 1005			' 保存解密后文件路径
						If SaveFileDlg(MainWindow,@TS2,"*") Then
							SetWindowText(OutFile,TS2)
						EndIf
					Case 1011			' 执行压缩
						If FileExists(GetText(InFile)) Then
							Dim SurLen As Integer = FileLen(GetText(InFile))
							Dim Sur As Any Ptr = Allocate(SurLen)
							Dim Dst As Any Ptr
							GetFile(GetText(InFile),Sur,0,SurLen)
							Dim DstLen As Integer = CompressBuffer_Lzma(Sur,SurLen,Dst)
							If DstLen Then
								PutFile(GetText(OutFile),Dst,0,DstLen)
								MessageBox(MainWindow,"压缩完成，压缩比 : " & (DstLen / SurLen) & "%","消息 :",MB_OK Or MB_ICONINFORMATION)
							Else
								MessageBox(MainWindow,"压缩失败，错误代码 : " & Cast(Integer,Dst),"消息 :",MB_OK Or MB_ICONINFORMATION)
							EndIf
						Else
							MessageBox(MainWindow,"原始文件不存在！","错误 :",MB_OK Or MB_ICONERROR)
						EndIf
					Case 1007			' 执行解压
						If FileExists(GetText(InFile)) Then
							Dim SurLen As Integer = FileLen(GetText(InFile))
							Dim Sur As Any Ptr = Allocate(SurLen)
							Dim Dst As Any Ptr
							GetFile(GetText(InFile),Sur,0,SurLen)
							Dim DstLen As Integer = DeCompressBuffer_Lzma(Sur,SurLen,Dst)
							If DstLen Then
								PutFile(GetText(OutFile),Dst,0,DstLen)
								MessageBox(MainWindow,"解压完成，文件大小 : " & DstLen & " Byte","消息 :",MB_OK Or MB_ICONINFORMATION)
							Else
								MessageBox(MainWindow,"解压失败，错误代码 : " & Cast(Integer,Dst),"消息 :",MB_OK Or MB_ICONINFORMATION)
							EndIf
						Else
							MessageBox(MainWindow,"原始文件不存在！","错误 :",MB_OK Or MB_ICONERROR)
						EndIf
				End Select
			EndIf
		Case WM_CLOSE
			EndDialog(hWin,0)
		Case Else
			Return FALSE
	End Select
	Return TRUE
End Function



DialogBoxParam(GetModuleHandle(NULL),Cast(ZString Ptr,1000),NULL,@DlgProc,NULL)
ExitProcess(0)