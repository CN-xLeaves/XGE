#Include Once "Windows.bi"
#Include "Win\ShellApi.bi"
#Include "Inc\File.bi"
#Include "Inc\FindFile.bi"
#Include "Inc\xywhGUI.bi"
#Include "Inc\xywhSDK.bi"
#Include "Inc\InputBox.bi"



Dim Shared Con_MWindow As xywh_Window
Dim Shared Con_MapList As xywh_ListBox
Dim Shared Con_DelMap As xywh_Button
Dim Shared Con_MapMov_Add As xywh_Button
Dim Shared Con_MapMov_Sub As xywh_Button

Dim Shared As xywh_TextBox Con_Mod_GameName,Con_Mod_InitLevel,Con_Mod_ExpMul
Dim Shared As xywh_ComboBox Con_Mod_TankP1,Con_Mod_TankP2
Dim Shared As xywh_CheckBox Con_Mod_ShowHP,Con_Mod_ShowLevel,Con_Mod_ShowVHP

Dim Shared As xywh_TextBox Con_Map_NumAI,Con_Map_RunAI,Con_Map_AddExp,Con_Map_AddG1,Con_Map_AddG2,Con_Map_AddG3,Con_Map_AddG4
Dim Shared As xywh_CheckBox Con_Map_Clrar

Dim Shared ModuleFile As ZString * 260
Dim Shared ModulePath As ZString * 260
Dim Shared ScreenCount As Integer



#Include "Inc\map.bi"
Dim Shared SelMapObj As Tank_Map



Sub LoadModuleInfo()
	Con_Mod_GameName.Text = rtl.IniFile.GetStr(@ModuleFile,"xywhsoft","Title")
	Con_Mod_InitLevel.Text = Str(rtl.IniFile.GetInt(@ModuleFile,"xywhsoft","PlayerLV"))
	Con_Mod_ExpMul.Text = Str(rtl.IniFile.GetInt(@ModuleFile,"xywhsoft","ExpMul"))
	Con_Mod_TankP1.Index = rtl.IniFile.GetInt(@ModuleFile,"xywhsoft","Player1")
	Con_Mod_TankP2.Index = rtl.IniFile.GetInt(@ModuleFile,"xywhsoft","Player2")
	If rtl.IniFile.GetInt(@ModuleFile,"xywhsoft","ViewHP") Then
		Con_Mod_ShowHP.Value = 1
	Else
		Con_Mod_ShowHP.Value = 0
	EndIf
	If rtl.IniFile.GetInt(@ModuleFile,"xywhsoft","ViewLevel") Then
		Con_Mod_ShowLevel.Value = 1
	Else
		Con_Mod_ShowLevel.Value = 0
	EndIf
	If rtl.IniFile.GetInt(@ModuleFile,"xywhsoft","ViewValueHP") Then
		Con_Mod_ShowVHP.Value = 1
	Else
		Con_Mod_ShowVHP.Value = 0
	EndIf
	ScreenCount = rtl.IniFile.GetInt(@ModuleFile,"xywhsoft","ScreenCount")
	Dim i As Integer
	For i = 1 To ScreenCount
		Con_MapList.AddItem(i & ".map")
	Next
End Sub



Sub SaveModuleInfo()
	rtl.IniFile.SetStr(@ModuleFile,"xywhsoft","Title",Con_Mod_GameName.Text)
	rtl.IniFile.SetStr(@ModuleFile,"xywhsoft","PlayerLV",Con_Mod_InitLevel.Text)
	rtl.IniFile.SetStr(@ModuleFile,"xywhsoft","ExpMul",Con_Mod_ExpMul.Text)
	rtl.IniFile.SetStr(@ModuleFile,"xywhsoft","Player1",Str(Con_Mod_TankP1.Index))
	rtl.IniFile.SetStr(@ModuleFile,"xywhsoft","Player2",Str(Con_Mod_TankP2.Index))
	If Con_Mod_ShowHP.Value Then
		rtl.IniFile.SetStr(@ModuleFile,"xywhsoft","ViewHP","1")
	Else
		rtl.IniFile.SetStr(@ModuleFile,"xywhsoft","ViewHP","0")
	EndIf
	If Con_Mod_ShowLevel.Value Then
		rtl.IniFile.SetStr(@ModuleFile,"xywhsoft","ViewLevel","1")
	Else
		rtl.IniFile.SetStr(@ModuleFile,"xywhsoft","ViewLevel","0")
	EndIf
	If Con_Mod_ShowVHP.Value Then
		rtl.IniFile.SetStr(@ModuleFile,"xywhsoft","ViewValueHP","1")
	Else
		rtl.IniFile.SetStr(@ModuleFile,"xywhsoft","ViewValueHP","0")
	EndIf
	rtl.IniFile.SetStr(@ModuleFile,"xywhsoft","ScreenCount",Str(ScreenCount))
	MessageBox(Con_MWindow.hWnd,"Module 信息保存完毕！","Info :",MB_ICONINFORMATION)
End Sub



Function DlgProc(ByVal hWin As HWND, ByVal uMsg As UINT, ByVal wParam As WPARAM, ByVal lParam As LPARAM) As Integer
	Dim As Long id, Event
	Select Case uMsg
		Case WM_INITDIALOG
			Con_MWindow.Bind(hWin)
			Con_MapList.Bind(hWin,1021)
			Con_DelMap.Bind(hWin,1025)
			Con_MapMov_Add.Bind(hWin,1035)
			Con_MapMov_Sub.Bind(hWin,1038)
			
			Con_Mod_GameName.Bind(hWin,1003)
			Con_Mod_InitLevel.Bind(hWin,1015)
			Con_Mod_ExpMul.Bind(hWin,1017)
			Con_Mod_TankP1.Bind(hWin,1011)
			Con_Mod_TankP2.Bind(hWin,1013)
			Con_Mod_ShowHP.Bind(hWin,1018)
			Con_Mod_ShowLevel.Bind(hWin,1019)
			Con_Mod_ShowVHP.Bind(hWin,1020)
			
			Con_Map_NumAI.Bind(hWin,1027)
			Con_Map_RunAI.Bind(hWin,1029)
			Con_Map_AddExp.Bind(hWin,1031)
			Con_Map_AddG1.Bind(hWin,1037)
			Con_Map_AddG2.Bind(hWin,1046)
			Con_Map_AddG3.Bind(hWin,1042)
			Con_Map_AddG4.Bind(hWin,1050)
			Con_Map_Clrar.Bind(hWin,1034)
			
			Con_Mod_TankP1.AddItem("速度型")
			Con_Mod_TankP1.AddItem("攻击型")
			Con_Mod_TankP1.AddItem("防御型")
			Con_Mod_TankP2.AddItem("速度型")
			Con_Mod_TankP2.AddItem("攻击型")
			Con_Mod_TankP2.AddItem("防御型")
			
			ModuleFile = ExePath & "\Data\Moudle\" & *rtl.IniFile.GetStr(ExePath & "\Data\setup.ini","Tank","LoadModule") & ".ini"
			ModulePath = ExePath & "\Data\Moudle\" & *rtl.IniFile.GetStr(ExePath & "\Data\setup.ini","Tank","LoadModule") & "\"
			LoadModuleInfo()
		Case WM_COMMAND
			id=LoWord(wParam)
			Event=HiWord(wParam)
			If Event=BN_CLICKED Then
				Select Case id
					Case 1023			' 保存MOD设置
						SaveModuleInfo()
					Case 1026			' 保存地图信息
						SelMapObj.Info.NumAI = CInt(*Con_Map_NumAI.Text)
						SelMapObj.Info.RunAI = CInt(*Con_Map_RunAI.Text)
						SelMapObj.Info.PassExp = CInt(*Con_Map_AddExp.Text)
						SelMapObj.Info.AddGoods1 = CInt(*Con_Map_AddG1.Text)
						SelMapObj.Info.AddGoods2 = CInt(*Con_Map_AddG2.Text)
						SelMapObj.Info.AddGoods3 = CInt(*Con_Map_AddG3.Text)
						SelMapObj.Info.AddGoods4 = CInt(*Con_Map_AddG4.Text)
						If Con_Map_Clrar.Value Then
							SelMapObj.Info.ClearPlayer = 1
						Else
							SelMapObj.Info.ClearPlayer = 0
						EndIf
						SelMapObj.Save(ModulePath & "\" & *Con_MapList.Text)
						MessageBox(Con_MWindow.hWnd,"地图信息保存完毕！","Info :",MB_ICONINFORMATION)
				End Select
			EndIf
			If Event=LBN_SELCHANGE Then
				Select Case id
					Case 1021			' 读取地图信息
						If FileExists(ModulePath & "\" & *Con_MapList.Text) = 0 Then
							rtl.Res.ToFile(200,ModulePath & "\" & *Con_MapList.Text)
						EndIf
						Con_DelMap.Enabled = TRUE
						SelMapObj.Load(ModulePath & "\" & *Con_MapList.Text)
						Con_Map_NumAI.Text = Str(SelMapObj.Info.NumAI)
						Con_Map_RunAI.Text = Str(SelMapObj.Info.RunAI)
						Con_Map_AddExp.Text = Str(SelMapObj.Info.PassExp)
						Con_Map_AddG1.Text = Str(SelMapObj.Info.AddGoods1)
						Con_Map_AddG2.Text = Str(SelMapObj.Info.AddGoods2)
						Con_Map_AddG3.Text = Str(SelMapObj.Info.AddGoods3)
						Con_Map_AddG4.Text = Str(SelMapObj.Info.AddGoods4)
						If SelMapObj.Info.ClearPlayer Then
							Con_Map_Clrar.Value = 1
						Else
							Con_Map_Clrar.Value = 0
						EndIf
						If Con_MapList.Index > 0 Then
							Con_MapMov_Add.Enabled = TRUE
						Else
							Con_MapMov_Add.Enabled = FALSE
						EndIf
						If Con_MapList.Index < Con_MapList.ListCount-1 Then
							Con_MapMov_Sub.Enabled = TRUE
						Else
							Con_MapMov_Sub.Enabled = FALSE
						EndIf
				End Select
			EndIf
			If Event=LBN_DBLCLK Then
				Select Case id
					Case 1021			' 编辑地图
						rtl.Run("MapEdit.exe -e " & ModulePath & "\" & *Con_MapList.Text,SW_SHOW)
				End Select
			EndIf
		Case WM_CLOSE
			EndDialog(hWin, 0)
		Case Else
			Return FALSE
	End Select
	Return TRUE
End Function



ShellExecute(0,"open","http://www.52xge.com",NULL,NULL,SW_SHOW)
DialogBoxParam(GetModuleHandle(NULL),Cast(zstring ptr,1000),NULL,@DlgProc,NULL)
ExitProcess(0)