


Dim Shared ModuleList As xGui.xComboBox



' 扫描Module列表
Function ScanFile(Path As ZString Ptr, FindData As WIN32_FIND_DATA Ptr, param As Integer = 0) As Integer
	Dim ModulePath As ZString * MAX_PATH = *Path & FindData->cFileName & "\"
	Dim ModuleFile As ZString * MAX_PATH = *Path & FindData->cFileName & "\moudle.ini"
	If xFile.Exists(@ModuleFile) Then
		Dim idx As UInteger = mm.AppendStruct()
		Dim Info As ModuleInfo Ptr = mm.GetPtrStruct(idx)
		If Info Then
			Info->ModulePath = ModulePath
			Info->ModuleFile = ModuleFile
			Info->ModuleName = FindData->cFileName
			Info->ModuleTitle = *xIni.GetStr(ModuleFile, "option", "Title")
		EndIf
	EndIf
	Return 0
End Function



' 启动器窗口
Function GameLoaderProc(ByVal hWin As HWND, ByVal uMsg As UINT, ByVal wParam As WPARAM, ByVal lParam As LPARAM) As Integer
	Dim As Long id, Event
	Select Case uMsg
		Case WM_INITDIALOG
			ModuleList.Bind(hWin,1001)
			xFile.Scan(ExePath & "\Moudle\", "*", 0, XFILE_RULE_FloderOnly Or XFILE_RULE_PointFloder, FALSE, @ScanFile)
			Dim CurModule As ZString Ptr = xIni.GetStr(ExePath & "\setup.ini", "option", "Module")
			Dim Info As ModuleInfo Ptr
			For i As Integer = 1 To mm.StructCount
				Info = mm.GetPtrStruct(i)
				If Info Then
					ModuleList.AddItemEx(@Info->ModuleTitle, i)
					If *CurModule = Info->ModuleName Then
						ModuleList.ListIndex = i - 1
					EndIf
				EndIf
			Next
			If ModuleList.ListIndex < 0 Then
				ModuleList.ListIndex = 0
			EndIf
		Case WM_COMMAND
			id=LoWord(wParam)
			Event=HiWord(wParam)
			If Event=BN_CLICKED Then
				Select Case id
					Case 1002		' Start Game
						Dim idx As Integer = ModuleList.ItemData(ModuleList.ListIndex)
						Dim Info As ModuleInfo Ptr = mm.GetPtrStruct(idx)
						xIni.SetStr(ExePath & "\setup.ini", "option", "Module", @Info->ModuleName)
						xShell("""" & ExePath & "\Game.exe""",SW_SHOW)
						EndDialog(hWin, 0)
					Case 1003		' Module Edit
						Dim idx As Integer = ModuleList.ItemData(ModuleList.ListIndex)
						EditModule = mm.GetPtrStruct(idx)
						DialogBoxParam(GetModuleHandle(NULL), Cast(ZString Ptr, 1100), hWin, @ModuleEditProc, NULL)
				End Select
			EndIf
		Case WM_CLOSE
			EndDialog(hWin, 0)
		Case Else
			Return FALSE
	End Select
	Return TRUE
End Function
