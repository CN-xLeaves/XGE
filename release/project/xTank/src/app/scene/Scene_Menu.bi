


Sub NewGame_OnClick(ele As Any Ptr, btn As Integer)
	' 场景切换处理
	Module.CurMapID = 1
	xge.Scene.Start(@GameScene, 40)
End Sub

Sub ExitGame_OnClick(ele As Any Ptr, btn As Integer)
	xge.Scene.Stop()
End Sub



' Scene function
Function MenuScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui
	Static As xui.Button Ptr Btn_NewGame, Btn_ExitGame
	Static As xge.Surface Ptr img
	Select Case msg
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			img->Draw(NULL, 0, 0)
			ui->Draw(NULL)
		Case XGE_MSG_LOADRES			' load resources
			img = Cast(Any Ptr, param)
			ui = xui.GetRootElement()
			Btn_NewGame  = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 320, 160, 40, !"开始游戏\n(New Game)")
			Btn_ExitGame = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 380, 160, 40, !"退出游戏\n(Exit)")
			Btn_NewGame->TextFont  = 2
			Btn_ExitGame->TextFont = 2
			Btn_NewGame->Event.OnClick  = Cast(Any Ptr, @NewGame_OnClick )
			Btn_ExitGame->Event.OnClick = Cast(Any Ptr, @ExitGame_OnClick)
			ui->Childs.AddElement(Btn_NewGame )
			ui->Childs.AddElement(Btn_ExitGame)
			xui.LayoutApply()
		Case XGE_MSG_FREERES			' unload resources
			xui.FreeChilds(ui)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function
