


Sub NewGame_OnClick(ele As Any Ptr, btn As Integer)
	' 场景切换处理
	Module.CurMapID = 1
	xge.Scene.Start(@GameScene, 40)
	/'
	Do
		Select Case 
			Case 0		' 意外退出
				Exit Do
			Case 1		' 通关
				If Module.CurMapID >= Module.MapCount Then
					xge.Scene.Cut(@PauseScene, 40, FALSE, Cast(Integer, img_PassImage))
				Else
					Module.CurMapID += 1
					xge.Scene.Cut(@GameScene, 40)
					Exit Do
				EndIf
			Case 2		' 游戏结束
				xge.Scene.Cut(@PauseScene, 40, FALSE, Cast(Integer, img_EndImage))
				Exit Do
		End Select
	Loop'/
End Sub

Sub LoadGame_OnClick(ele As Any Ptr, btn As Integer)
	
End Sub

Sub ExitGame_OnClick(ele As Any Ptr, btn As Integer)
	xge.Scene.Stop()
End Sub



' Scene function
Function MenuScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui
	Static As xui.Button Ptr Btn_NewGame, Btn_LoadGame, Btn_ExitGame
	Static As xge.Surface Ptr img
	Select Case msg
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			img->Draw(0, 0)
			ui->Draw(NULL)
		Case XGE_MSG_LOADRES			' load resources
			Print 1
			img = Cast(Any Ptr, param)
			ui = xui.GetRootElement()
			Print 1
			Btn_NewGame  = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 280, 160, 40, !"开始游戏\n(New Game)")
			Print 1
			Btn_LoadGame = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 340, 160, 40, !"载入存档\n(Load)")
			Print 1
			Btn_ExitGame = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 400, 160, 40, !"退出游戏\n(Exit)")
			Print 1, Btn_NewGame, Btn_LoadGame, Btn_ExitGame
			Btn_NewGame->CaptionFont  = 2
			Btn_LoadGame->CaptionFont = 2
			Btn_ExitGame->CaptionFont = 2
			Btn_NewGame->Event.OnClick  = Cast(Any Ptr, @NewGame_OnClick )
			Btn_LoadGame->Event.OnClick = Cast(Any Ptr, @LoadGame_OnClick)
			Btn_ExitGame->Event.OnClick = Cast(Any Ptr, @ExitGame_OnClick)
			Print 2
			ui->Childs.AddElement(Btn_NewGame )
			ui->Childs.AddElement(Btn_LoadGame)
			ui->Childs.AddElement(Btn_ExitGame)
			Print 2
			xui.LayoutApply()
			Print 2
		Case XGE_MSG_FREERES			' unload resources
			
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function
