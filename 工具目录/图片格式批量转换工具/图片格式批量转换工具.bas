' include XGE header file
#LibPath "..\..\发布目录\library"
#Include "..\..\发布目录\include\xge.bi"



' this is another gui library i developed, which wraps Win32SDK as a more friendly interface
#LibPath "Lib"
#Include "Inc\xGui.bi"



#Include "Inc\Diadlg.bi"



Dim Shared As xGui.xWindow MainWindow
Dim Shared As xGui.xTextBox TextBox_Scan, TextBox_Out
Dim Shared As xGui.xButton CheckBox_Sub, CheckBox_XGI, CheckBox_PNG, CheckBox_JPG, CheckBox_GIF, CheckBox_BMP, CheckBox_TGA, CheckBox_Out, Button_Run
Dim Shared As xGui.xComboBox ComboBox_Out, ComboBox_Bpp
Dim Shared As ZString * MAX_PATH ScanPath, OutPath
Dim Shared As Integer FormatMask, IsPutSource, IsPutImgBpp, IsPutFormat



Function GetPathFloder(sInPath As ZString Ptr, sOutPath As ZString Ptr) As Integer
	Dim rstr As ZString Ptr = StrRChr(sInPath, 92)
	If rstr Then
		memcpy(sOutPath, sInPath, rstr - sInPath)
		Return -1
	EndIf
End Function

Function GetPathFileName(sInPath As ZString Ptr, sOutPath As ZString Ptr) As Integer
	Dim rstr As ZString Ptr = StrRChr(sInPath, 92)
	If rstr Then
		strcpy(sOutPath, rstr + 1)
		Return -1
	EndIf
End Function

Function GetFileFileType(sInPath As ZString Ptr, sOutPath As ZString Ptr) As Integer
	Dim rstr As UByte Ptr = StrRChr(sInPath, 46)
	If rstr Then
		For i As Integer = 1 To strlen(rstr)
			sOutPath[i-1] = toupper(rstr[i])
		Next
		Return -1
	EndIf
End Function

Function GetPathFileType(sInPath As ZString Ptr, sOutPath As ZString Ptr) As Integer
	Dim TmpPath As ZString Ptr = malloc(MAX_PATH)
	If GetPathFileName(sInPath, TmpPath) Then
		If GetFileFileType(TmpPath, sOutPath) Then
			free(TmpPath)
			Return -1
		EndIf
	EndIf
	free(TmpPath)
End Function



Sub ConvImg(sInPath As ZString Ptr, sOutPath As ZString Ptr)
	Dim img As xge.Surface Ptr = New xge.Surface(sInPath, 0)
	img->Save(sOutPath, IsPutFormat, XGI_FLAG_LZ4 Or IsPutImgBpp)
	Delete img
End Sub

Function ScanFile(Path As ZString Ptr, FindData As WIN32_FIND_DATA Ptr, param As Integer = 0) As Integer
	If (FindData->dwFileAttributes And FILE_ATTRIBUTE_DIRECTORY) = 0 Then
		Dim sFormat As ZString * 16
		If GetFileFileType(@FindData->cFileName, @sFormat) Then
			Select Case sFormat
				Case "BMP"
					If FormatMask And 1 Then
						If IsPutSource Then
							ConvImg(*Path & FindData->cFileName, *Path & FindData->cFileName & IIf(IsPutFormat = 1, ".conv.xgi", ".conv.bmp"))
						Else
							ConvImg(*Path & FindData->cFileName, OutPath & FindData->cFileName & IIf(IsPutFormat = 1, ".conv.xgi", ".conv.bmp"))
						EndIf
					EndIf
				Case "PNG"
					If FormatMask And 2 Then
						If IsPutSource Then
							ConvImg(*Path & FindData->cFileName, *Path & FindData->cFileName & IIf(IsPutFormat = 1, ".conv.xgi", ".conv.bmp"))
						Else
							ConvImg(*Path & FindData->cFileName, OutPath & FindData->cFileName & IIf(IsPutFormat = 1, ".conv.xgi", ".conv.bmp"))
						EndIf
						
					EndIf
				Case "JPG"
					If FormatMask And 4 Then
						If IsPutSource Then
							ConvImg(*Path & FindData->cFileName, *Path & FindData->cFileName & IIf(IsPutFormat = 1, ".conv.xgi", ".conv.bmp"))
						Else
							ConvImg(*Path & FindData->cFileName, OutPath & FindData->cFileName & IIf(IsPutFormat = 1, ".conv.xgi", ".conv.bmp"))
						EndIf
						
					EndIf
				Case "GIF"
					If FormatMask And 8 Then
						If IsPutSource Then
							ConvImg(*Path & FindData->cFileName, *Path & FindData->cFileName & IIf(IsPutFormat = 1, ".conv.xgi", ".conv.bmp"))
						Else
							ConvImg(*Path & FindData->cFileName, OutPath & FindData->cFileName & IIf(IsPutFormat = 1, ".conv.xgi", ".conv.bmp"))
						EndIf
						
					EndIf
			End Select
		EndIf
	EndIf
	Return 0
End Function



Function DlgProc(ByVal hWin As HWND, ByVal uMsg As UINT, ByVal wParam As WPARAM, ByVal lParam As LPARAM) As Integer
	Dim As Long id, Event
	Select Case uMsg
		Case WM_INITDIALOG
			MainWindow.Bind(hWin)
			TextBox_Scan.Bind(hWin, 1002)
			TextBox_Out.Bind(hWin, 1010)
			CheckBox_Sub.Bind(hWin, 1004)
			CheckBox_XGI.Bind(hWin, 1020)
			CheckBox_PNG.Bind(hWin, 1006)
			CheckBox_JPG.Bind(hWin, 1007)
			CheckBox_GIF.Bind(hWin, 1008)
			CheckBox_BMP.Bind(hWin, 1018)
			CheckBox_TGA.Bind(hWin, 1019)
			CheckBox_Out.Bind(hWin, 1012)
			Button_Run.Bind(hWin, 1013)
			ComboBox_Out.Bind(hWin, 1014)
			ComboBox_Bpp.Bind(hWin, 1017)
			' 初始化界面
			CheckBox_Sub.Value = TRUE
			CheckBox_XGI.Value = FALSE
			CheckBox_PNG.Value = TRUE
			CheckBox_JPG.Value = TRUE
			CheckBox_GIF.Value = TRUE
			CheckBox_BMP.Value = TRUE
			CheckBox_TGA.Value = TRUE
			CheckBox_Out.Value = TRUE
			ComboBox_Out.AddItemEx("xgi [XGE压缩位图]", XGE_IMG_FMT_XGI)
			ComboBox_Out.AddItemEx("bmp [标准位图]", XGE_IMG_FMT_BMP)
			ComboBox_Out.ListIndex = 0
			ComboBox_Bpp.AddItemEx("16 位 (仅支持xgi格式)", XGI_FLAG_B16)
			ComboBox_Bpp.AddItemEx("32 位", 0)
			ComboBox_Bpp.ListIndex = 0
			' 设置窗口图标
			Dim ExeIcon As HICON = LoadIcon(GetModuleHandle(NULL),Cast(Any Ptr,100))
			SendMessage(hWin,WM_SETICON,ICON_BIG,Cast(Integer,ExeIcon))
			SendMessage(hWin,WM_SETICON,ICON_SMALL,Cast(Integer,ExeIcon))
		Case WM_COMMAND
			id=LoWord(wParam)
			Event=HiWord(wParam)
			If Event=BN_CLICKED Then
				Select Case id
					Case 1003		' 浏览扫描目录
						If OpenFolderDlg(hWin, @ScanPath) Then
							If Right(ScanPath, 1) <> "\" Then
								ScanPath &= "\"
							EndIf
							TextBox_Scan.Text = @ScanPath
							Button_Run.Enabled = TRUE
						EndIf
					Case 1009		' 浏览输出目录
						If OpenFolderDlg(hWin, @OutPath) Then
							If Right(OutPath, 1) <> "\" Then
								OutPath &= "\"
							EndIf
							TextBox_Out.Text = @OutPath
							CheckBox_Out.Value = FALSE
						EndIf
					Case 1012		' 与目标目录相同
						If CheckBox_Out.Value Then
							OutPath = !"\0"
							TextBox_Out.Text = OutPath
						EndIf
					Case 1013		' 开始转换
						FormatMask += IIf(CheckBox_PNG.Value, 2, 0)
						FormatMask += IIf(CheckBox_JPG.Value, 4, 0)
						FormatMask += IIf(CheckBox_GIF.Value, 8, 0)
						FormatMask += IIf(CheckBox_BMP.Value, 1, 0)
						IsPutSource = IIf(CheckBox_Out.Value,-1, 0)
						IsPutImgBpp = ComboBox_Bpp.ItemData(ComboBox_Bpp.ListIndex)
						IsPutFormat = ComboBox_Out.ItemData(ComboBox_Out.ListIndex)
						xge.Init(1, 1, XGE_INIT_NOSWITCH Or XGE_INIT_NOFRAME, 0, NULL)
						xFile.Scan(ScanPath, "*", 0, XFILE_RULE_NoAttribEx, CheckBox_Sub.Value, @ScanFile)
						xge.Unit()
						MessageBox(hWin, "转换完毕~！", "info :", MB_ICONINFORMATION)
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