#Include Once "Windows.bi"
#LibPath "Lib"
#LibPath "..\..\发布目录\library"



#Inclib "xui"



#Include "Inc\xui_base.bi"
#Include "Inc\Diadlg.bi"
#Include "..\..\发布目录\include\xge.bi"



Dim Shared As xui.xWindow MainWindow
Dim Shared As xui.xButtom Button_View, Button_Save
Dim Shared As xui.xTextBox TextBox_File, TextBox_Width, TextBox_Height, TextBox_Back, TextBox_Fore
Dim Shared FilePath As ZString * MAX_PATH



Function DlgProc(ByVal hWin As HWND, ByVal uMsg As UINT, ByVal wParam As WPARAM, ByVal lParam As LPARAM) As Integer
	Dim As Long id, Event
	Select Case uMsg
		Case WM_INITDIALOG
			FilePath = ExePath & "\shades\*.*"
			MainWindow.Bind(hWin)
			Button_View.Bind(hWin, 1009)
			Button_Save.Bind(hWin, 1016)
			TextBox_File.Bind(hWin, 1005)
			TextBox_Width.Bind(hWin, 1002)
			TextBox_Height.Bind(hWin, 1008)
			TextBox_Back.Bind(hWin, 1013)
			TextBox_Fore.Bind(hWin, 1014)
			' 设置窗口图标
			Dim ExeIcon As HICON = LoadIcon(GetModuleHandle(NULL),Cast(Any Ptr,100))
			SendMessage(hWin,WM_SETICON,ICON_BIG,Cast(Integer,ExeIcon))
			SendMessage(hWin,WM_SETICON,ICON_SMALL,Cast(Integer,ExeIcon))
		Case WM_COMMAND
			id=LoWord(wParam)
			Event=HiWord(wParam)
			If Event=BN_CLICKED Then
				Select Case id
					Case 1004		' 打开特效图片
						If OpenFileDlg(hWin, @FilePath, !"支持的图片格式\0*.xgi;*.bmp;*.png;*.jpg;*.gif;*.tga\0所有文件\0*.*\0\0") Then
							xge.Init(1, 1, XGE_INIT_NOSWITCH Or XGE_INIT_NOFRAME, 0)
							Dim TmpImg As xge.Surface Ptr = New xge.Surface(@FilePath, 0)
							xge.Init(TmpImg->Width, TmpImg->Height, XGE_INIT_WINDOW, 0, "xywh Game Engine Shade Tool")
							TmpImg->Draw(0, 0)
							TextBox_File.Text = @FilePath
							If *TextBox_Width.Text = "" Then
								TextBox_Width.Text = Str(TmpImg->Width)
							EndIf
							If *TextBox_Height.Text = "" Then
								TextBox_Height.Text = Str(TmpImg->Height)
							EndIf
							Delete TmpImg
							Button_View.Enabled = TRUE
							Button_Save.Enabled = TRUE
						EndIf
					Case 1009		' 点击预览效果
						MainWindow.Hide
						Dim w As Integer = CInt(*TextBox_Width.Text)
						Dim h As Integer = CInt(*TextBox_Height.Text)
						xge.Init(w, h, XGE_INIT_WINDOW, XGE_INIT_GDI, "xywh Game Engine Shade Tool")
						' 缩放处理图片
						Dim TmpImg As xge.GdiSurface Ptr = New xge.GdiSurface(w + 8, h)
						TmpImg->PrintImageZoom(0, 0, w, h, @FilePath, 0)
						Dim ConImg As xge.Surface Ptr = TmpImg->Copy(0, 0, w, h)
						' 创建效果数据
						Dim ShadeData As UByte Ptr = Allocate(w*h)
						MakeShadeData(ConImg, ShadeData)
						SetShadeData(w, h, ShadeData)
						' 创建预览
						TmpImg->PrintImageZoom(0, 0, w, h, ExePath & "\res\" & *TextBox_Back.Text, 0)
						Dim BackImg As xge.Surface Ptr = TmpImg->Copy(0, 0, w, h)
						TmpImg->PrintImageZoom(0, 0, w, h, ExePath & "\res\" & *TextBox_Fore.Text, 0)
						Dim ForeImg As xge.Surface Ptr = TmpImg->Copy(0, 0, w, h)
						For i As Integer = 0 To 255
							xge.Lock
								BackImg->Draw(0, 0)
								ForeImg->Draw_Shade(0, 0, i)
							xge.UnLock
							xge.Sync
						Next
						Delete ConImg
						Delete TmpImg
						Delete BackImg
						Delete ForeImg
						DeAllocate(ShadeData)
						MainWindow.Show
					Case 1016		' 保存特效文件
						Dim SaveFile As ZString * MAX_PATH = ExePath & "\*.*"
						If SaveFileDlg(hWin, @SaveFile, !"所有文件\0*.*\0\0") Then
							Dim w As Integer = CInt(*TextBox_Width.Text)
							Dim h As Integer = CInt(*TextBox_Height.Text)
							' 缩放处理图片
							Dim TmpImg As xge.GdiSurface Ptr = New xge.GdiSurface(w, h)
							TmpImg->PrintImageZoom(0, 0, w, h, @FilePath, 0)
							Dim ConImg As xge.Surface Ptr = TmpImg->Copy(0, 0, w, h)
							' 创建效果数据
							Dim ShadeData As UByte Ptr = Allocate(w*h)
							MakeShadeData(ConImg, ShadeData)
							PutFile(@SaveFile, ShadeData, 0, w*h)
							Delete ConImg
							Delete TmpImg
							DeAllocate(ShadeData)
						EndIf
					Case 1018		' 退出
						EndDialog(hWin, 0)
					Case 1019		' 关于
						MessageBox(hWin, !"xywh Game Engine 场景过渡特效素材转换工具\r\n\r\n由 xywhsoft 开发 : http://xge.xywhsoft.com", "xywh Game Engine Shade Tool", MB_ICONINFORMATION)
				End Select
			EndIf
		Case WM_CLOSE
			EndDialog(hWin, 0)
		Case Else
			Return FALSE
	End Select
	Return TRUE
End Function



DialogBoxParam(GetModuleHandle(NULL),Cast(zstring ptr,1000),NULL,@DlgProc,NULL)
ExitProcess(0)