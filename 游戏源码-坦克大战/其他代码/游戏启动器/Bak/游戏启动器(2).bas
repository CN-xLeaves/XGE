#Include Once "Windows.bi"
#Include "Inc\File.bi"
#Include "Inc\FindFile.bi"
#Include "Inc\xywhSDK.bi"
#Include "Inc\xywhGUI.bi"
#Include "Inc\xywhBSMM.bi"



Type ModuleInfo
	ModuleFile As ZString * 260
	ModuleName As ZString * 80
End Type



Dim Shared mm As xywhBSMM = xywhBSMM(SizeOf(ModuleInfo),10,10)
Dim Shared ModuleList As xywh_ComboBox



Function ScanFile(Path As String,FindData As WIN32_FIND_DATA) As Integer
	Dim ModuleFile As ZString * 260 = Path & FindData.cFileName
	Dim Info As ModuleInfo Ptr = mm.AddStruct()
	If Info Then
		Info->ModuleFile = Left(FindData.cFileName,Len(FindData.cFileName)-4)
		Info->ModuleName = *rtl.IniFile.GetStr(ModuleFile,"xywhsoft","Title")
	EndIf
	Return 0
End Function



Function DlgProc(ByVal hWin As HWND, ByVal uMsg As UINT, ByVal wParam As WPARAM, ByVal lParam As LPARAM) As Integer
	Dim As Long id, Event
	Select Case uMsg
		Case WM_INITDIALOG
			ModuleList.Bind(hWin,1001)
			FindFile(ExePath & "\Data\Moudle\","*.ini",0,NoAttribEx,0,@ScanFile)
			Dim i As Integer
			Dim Info As ModuleInfo Ptr
			For i = 1 To mm.Count
				Info = mm.GetPoint(i)
				If Info Then
					ModuleList.AddItemEx(@Info->ModuleName,Cast(Integer,@Info->ModuleFile))
				EndIf
			Next
			ModuleList.Index = 0
		Case WM_COMMAND
			id=LoWord(wParam)
			Event=HiWord(wParam)
			If Event=BN_CLICKED Then
				Select Case id
					Case 1002
						rtl.IniFile.SetStr(ExePath & "\Data\setup.ini","Tank","LoadModule",Cast(ZString Ptr,ModuleList.ListData(ModuleList.Index)))
						rtl.Shell(ExePath & "\Game.exe",SW_SHOW)
						Print ExePath & "\Game.exe"
						Sleep
						
						EndDialog(hWin, 0)
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