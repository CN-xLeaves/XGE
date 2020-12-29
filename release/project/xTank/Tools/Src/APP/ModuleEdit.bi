Dim Shared Con_MWindow As xGui.xWindow
Dim Shared Con_MapList As xGui.xListBox

Dim Shared As xGui.xTextBox Con_Mod_GameName, Con_Mod_InitLevel, Con_Mod_ExpMul
Dim Shared As xGui.xComboBox Con_Mod_TankP1

Dim Shared As xGui.xTextBox Con_Map_NumAI, Con_Map_RunAI, Con_Map_AddExp
Dim Shared As xGui.xCheckBox Con_Map_Clrar

Dim Shared MapCount As Integer
Dim Shared EditModule As ModuleInfo Ptr



Dim Shared img_MapTile As xge.Surface Ptr
#Include "..\src\app\class\class_map.bi"
Dim Shared SelMapObj As Tank_Map



Sub LoadModuleInfo()
	Con_Mod_GameName.Text = xIni.GetStr(@EditModule->ModuleFile, "option", "Title")
	Con_Mod_InitLevel.Text = Str(xIni.GetInt(@EditModule->ModuleFile, "option", "StartLevel"))
	Con_Mod_ExpMul.Text = Str(xIni.GetInt(@EditModule->ModuleFile, "option", "ExpMul"))
	Con_Mod_TankP1.Index = xIni.GetInt(@EditModule->ModuleFile, "option", "TankModel")
	MapCount = xIni.GetInt(@EditModule->ModuleFile, "option", "MapCount")
	Dim i As Integer
	For i = 1 To MapCount
		Con_MapList.AddItem(i & ".map")
	Next
End Sub



Sub SaveModuleInfo()
	xIni.SetStr(@EditModule->ModuleFile, "option", "Title", Con_Mod_GameName.Text)
	xIni.SetStr(@EditModule->ModuleFile, "option", "StartLevel", Con_Mod_InitLevel.Text)
	xIni.SetStr(@EditModule->ModuleFile, "option", "ExpMul", Con_Mod_ExpMul.Text)
	xIni.SetStr(@EditModule->ModuleFile, "option", "TankModel", Str(Con_Mod_TankP1.Index))
	xIni.SetStr(@EditModule->ModuleFile, "option", "MapCount", Str(MapCount))
	MessageBox(Con_MWindow.hWnd, "Module 信息保存完毕！", "Info :", MB_ICONINFORMATION)
End Sub



Function ModuleEditProc(ByVal hWin As HWND, ByVal uMsg As UINT, ByVal wParam As WPARAM, ByVal lParam As LPARAM) As Integer
	Dim As Long id, Event
	Select Case uMsg
		Case WM_INITDIALOG
			Con_MWindow.Bind(hWin)
			Con_MapList.Bind(hWin, 1121)
			
			Con_Mod_GameName.Bind(hWin, 1103)
			Con_Mod_InitLevel.Bind(hWin, 1115)
			Con_Mod_ExpMul.Bind(hWin, 1117)
			Con_Mod_TankP1.Bind(hWin, 1111)
			
			Con_Map_NumAI.Bind(hWin, 1127)
			Con_Map_RunAI.Bind(hWin, 1129)
			Con_Map_AddExp.Bind(hWin, 1131)
			Con_Map_Clrar.Bind(hWin, 1134)
			
			Con_Mod_TankP1.AddItem("速度型")
			Con_Mod_TankP1.AddItem("攻击型")
			Con_Mod_TankP1.AddItem("防御型")
			
			LoadModuleInfo()
		Case WM_COMMAND
			id=LoWord(wParam)
			Event=HiWord(wParam)
			If Event=BN_CLICKED Then
				Select Case id
					Case 1123			' 保存MOD设置
						SaveModuleInfo()
					Case 1126			' 保存地图信息
						SelMapObj.HeadInfo.NumAI = CInt(*Con_Map_NumAI.Text)
						SelMapObj.HeadInfo.RunAI = CInt(*Con_Map_RunAI.Text)
						SelMapObj.HeadInfo.PassExp = CInt(*Con_Map_AddExp.Text)
						If Con_Map_Clrar.Value Then
							SelMapObj.HeadInfo.ClearPlayer = 1
						Else
							SelMapObj.HeadInfo.ClearPlayer = 0
						EndIf
						SelMapObj.Save(EditModule->ModulePath & "\" & *Con_MapList.Text)
						MessageBox(Con_MWindow.hWnd,"地图信息保存完毕！","Info :",MB_ICONINFORMATION)
				End Select
			EndIf
			If Event=LBN_SELCHANGE Then
				Select Case id
					Case 1121			' 读取地图信息
						If xFile.Exists(EditModule->ModulePath & "\" & *Con_MapList.Text) = 0 Then
							ResToFile(200, EditModule->ModulePath & "\" & *Con_MapList.Text)
						EndIf
						SelMapObj.Load(EditModule->ModulePath & "\" & *Con_MapList.Text)
						Con_Map_NumAI.Text = Str(SelMapObj.HeadInfo.NumAI)
						Con_Map_RunAI.Text = Str(SelMapObj.HeadInfo.RunAI)
						Con_Map_AddExp.Text = Str(SelMapObj.HeadInfo.PassExp)
						If SelMapObj.HeadInfo.ClearPlayer Then
							Con_Map_Clrar.Value = 1
						Else
							Con_Map_Clrar.Value = 0
						EndIf
				End Select
			EndIf
			If Event=LBN_DBLCLK Then
				Select Case id
					Case 1121			' 编辑地图
						xRun("Game.exe -e """ & EditModule->ModulePath & "\" & *Con_MapList.Text & """", SW_SHOW)
				End Select
			EndIf
		Case WM_CLOSE
			EndDialog(hWin, 0)
		Case Else
			Return FALSE
	End Select
	Return TRUE
End Function
