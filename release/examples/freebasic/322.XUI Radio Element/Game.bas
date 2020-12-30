' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' button check event
Sub OnCheck(ele As xui.Button Ptr)
	' it's not recommended to use this kind of thread blocking function in XGE
	' which may cause fps calculation errors. this is only for demonstration
	MessageBox(xge.hWnd, ele->Identifier & "_OnCheck triger, checked : " & IIf(ele->Checked, "TRUE", "FALSE"), "OnCheck", MB_OK)
End Sub



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui
	Static As xui.Element Ptr LeftLayout, RightLayout
	Static As xui.Button Ptr Radio11, Radio12, Radio13, Radio21, Radio22, Radio23
	Select Case msg
		Case XGE_MSG_FRAME				' frame Logic processing
			
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
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
			ui = xui.GetRootElement()
			LeftLayout = xui.CreateElement(XUI_LAYOUT_RULER_PIXEL, 0, 0, 800, 600)
			RightLayout = xui.CreateElement(XUI_LAYOUT_RULER_PIXEL, 0, 0, 800, 600)
			Radio11 = xui.CreateRadioButton(XUI_LAYOUT_RULER_PIXEL, 100, 200, 200, 24, "RadioButton", "Radio11")
			Radio12 = xui.CreateRadioButton(XUI_LAYOUT_RULER_PIXEL, 100, 300, 200, 24, "RadioButton", "Radio12")
			Radio13 = xui.CreateRadioButton(XUI_LAYOUT_RULER_PIXEL, 100, 400, 200, 24, "RadioButton", "Radio13")
			Radio21 = xui.CreateRadioBox(XUI_LAYOUT_RULER_PIXEL, 500, 200, 200, 24, "RadioBox", "Radio21")
			Radio22 = xui.CreateRadioBox(XUI_LAYOUT_RULER_PIXEL, 500, 300, 200, 24, "RadioBox", "Radio22")
			Radio23 = xui.CreateRadioBox(XUI_LAYOUT_RULER_PIXEL, 500, 400, 200, 24, "RadioBox", "Radio23")
			
			' RadioBox need to be grouped because only one element in a container can be selected at the same time
			LeftLayout->Childs.AddElement(Radio11)
			LeftLayout->Childs.AddElement(Radio12)
			LeftLayout->Childs.AddElement(Radio13)
			RightLayout->Childs.AddElement(Radio21)
			RightLayout->Childs.AddElement(Radio22)
			RightLayout->Childs.AddElement(Radio23)
			ui->Childs.AddElement(LeftLayout)
			ui->Childs.AddElement(RightLayout)
			xui.LayoutApply()
			
			' the color scheme of buttons is also applicable to RadioBox
			Radio22->NormalStyle.BorderColor = &HFFD88E0A
			Radio22->NormalStyle.FillColor = &HFFD88E0A
			Radio22->NormalStyle.TextColor = &HFFFFE8CC
			Radio22->PressStyle.BorderColor = &HFFD88E0A
			Radio22->PressStyle.FillColor = &HFFA86000
			Radio22->PressStyle.TextColor = &HFFFFFFFF
			Radio22->HotStyle.BorderColor = &HFFD88E0A
			Radio22->HotStyle.FillColor = &HFFFAB21C
			Radio22->HotStyle.TextColor = &HFFFFFFFF
			Radio22->CheckStyle.BorderColor = &HFFD88E0A
			Radio22->CheckStyle.FillColor = &HFFD88E0A
			Radio22->CheckStyle.TextColor = &HFF66B8FF
			
			' RadioBox can use OnCheck event, which only trigers when it changes
			Radio11->Event.OnCheck = Cast(Any Ptr, @OnCheck)
			Radio12->Event.OnCheck = Cast(Any Ptr, @OnCheck)
			Radio13->Event.OnCheck = Cast(Any Ptr, @OnCheck)
			Radio21->Event.OnCheck = Cast(Any Ptr, @OnCheck)
			Radio22->Event.OnCheck = Cast(Any Ptr, @OnCheck)
			Radio23->Event.OnCheck = Cast(Any Ptr, @OnCheck)
			
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(800, 600, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - XUI Radio Element")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
