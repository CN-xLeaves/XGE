' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Exit button click event
Sub Exit_OnClick(ele As Any Ptr, btn As Integer)
	xge.Scene.Stop()
End Sub



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui
	Static As xui.Button Ptr Btn1, Btn2, Btn3
	Static As xge.Surface Ptr backimg
	Select Case msg
		Case XGE_MSG_FRAME				' frame Logic processing
			
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			backimg->Draw(NULL, 0, 0)
			ui->Draw(NULL)
		Case XGE_MSG_MOUSE_MOVE			' mouse move
			
		Case XGE_MSG_MOUSE_DOWN			' mouse down
			
		Case XGE_MSG_MOUSE_UP			' mouse up
			
		Case XGE_MSG_MOUSE_CLICK		' mouse click
			
		Case XGE_MSG_MOUSE_DCLICK		' mouse double click
			
		Case XGE_MSG_MOUSE_WHELL		' mouse whell
			
		Case XGE_MSG_KEY_DOWN			' keyboard down
			
		Case XGE_MSG_KEY_UP				' keyboard up
			
		Case XGE_MSG_KEY_REPEAT			' keyboard hold
			
		Case XGE_MSG_GOTFOCUS			' got focus
			
		Case XGE_MSG_LOSTFOCUS			' lost focus
			
		Case XGE_MSG_MOUSE_ENTER		' mouse enter
			
		Case XGE_MSG_MOUSE_EXIT			' mouse leave
			
		Case XGE_MSG_LOADRES			' load resources
			xge.Text.LoadFont("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)
			xge.Text.LoadFont("..\..\..\res\font\xrf\simsun_12px_ucs2.xrf", 0)
			ui = xui.GetRootElement()
			Btn1 = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 280, 160, 40, !"开始游戏\n(New Game)")
			Btn2 = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 340, 160, 40, !"载入存档\n(Load)")
			Btn3 = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 400, 160, 40, !"退出游戏\n(Exit)")
			ui->Childs.AddElement(Btn1)
			ui->Childs.AddElement(Btn2)
			ui->Childs.AddElement(Btn3)
			xui.LayoutApply()
			backimg = New xge.Surface("..\..\..\res\back.bmp", 0)
			
			' we can provide a new color scheme for the buttons
			Btn2->NormalStyle.BorderColor = &HFFD88E0A
			Btn2->NormalStyle.FillColor = &HFFD88E0A
			Btn2->NormalStyle.TextColor = &HFFFFE8CC
			Btn2->PressStyle.BorderColor = &HFFD88E0A
			Btn2->PressStyle.FillColor = &HFFA86000
			Btn2->PressStyle.TextColor = &HFFFFFFFF
			Btn2->HotStyle.BorderColor = &HFFD88E0A
			Btn2->HotStyle.FillColor = &HFFFAB21C
			Btn2->HotStyle.TextColor = &HFFFFFFFF
			Btn2->CheckStyle.BorderColor = &HFFD88E0A
			Btn2->CheckStyle.FillColor = &HFFD88E0A
			Btn2->CheckStyle.TextColor = &HFF66B8FF
			
			' modify fonts and dispaly offsets
			Btn2->TextOffset.x = 8
			Btn2->TextOffset.y = 8
			Btn2->TextFont = 2
			
			' events in response to buttons
			Btn3->Event.OnClick = Cast(Any Ptr, @Exit_OnClick)
			
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - XUI Button Element")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
