


Sub NewGame_OnClick(ele As Any Ptr, btn As Integer)
	' �����л�����
	Module.CurMapID = 1
	xge.Scene.Start(@GameScene, 40)
	/'
	Do
		Select Case 
			Case 0		' �����˳�
				Exit Do
			Case 1		' ͨ��
				If Module.CurMapID >= Module.MapCount Then
					xge.Scene.Cut(@PauseScene, 40, FALSE, Cast(Integer, img_PassImage))
				Else
					Module.CurMapID += 1
					xge.Scene.Cut(@GameScene, 40)
					Exit Do
				EndIf
			Case 2		' ��Ϸ����
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
			img = Cast(Any Ptr, param)
			ui = xui.GetRootElement()
			Btn_NewGame  = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 280, 160, 40, !"��ʼ��Ϸ\n(New Game)")
			Btn_LoadGame = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 340, 160, 40, !"����浵\n(Load)")
			Btn_ExitGame = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 400, 160, 40, !"�˳���Ϸ\n(Exit)")
			Btn_NewGame->CaptionFont  = 2
			Btn_LoadGame->CaptionFont = 2
			Btn_ExitGame->CaptionFont = 2
			Btn_NewGame->Event.OnClick  = Cast(Any Ptr, @NewGame_OnClick )
			Btn_LoadGame->Event.OnClick = Cast(Any Ptr, @LoadGame_OnClick)
			Btn_ExitGame->Event.OnClick = Cast(Any Ptr, @ExitGame_OnClick)
			ui->Childs.AddElement(Btn_NewGame )
			ui->Childs.AddElement(Btn_LoadGame)
			ui->Childs.AddElement(Btn_ExitGame)
			xui.LayoutApply()
		Case XGE_MSG_FREERES			' unload resources
			xui.FreeChilds(ui)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function
