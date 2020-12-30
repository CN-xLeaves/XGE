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
	Static As xui.Button Ptr chk11, chk12, chk13, chk21, chk22, chk23
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
			chk11 = xui.CreateCheckButton(XUI_LAYOUT_RULER_PIXEL, 100, 200, 200, 24, "CheckButton", "chk11")
			chk12 = xui.CreateCheckButton(XUI_LAYOUT_RULER_PIXEL, 100, 300, 200, 24, "CheckButton", "chk12")
			chk13 = xui.CreateCheckButton(XUI_LAYOUT_RULER_PIXEL, 100, 400, 200, 24, "CheckButton", "chk13")
			chk21 = xui.CreateCheckBox(XUI_LAYOUT_RULER_PIXEL, 500, 200, 200, 24, "CheckBox", "chk21")
			chk22 = xui.CreateCheckBox(XUI_LAYOUT_RULER_PIXEL, 500, 300, 200, 24, "CheckBox", "chk22")
			chk23 = xui.CreateCheckBox(XUI_LAYOUT_RULER_PIXEL, 500, 400, 200, 24, "CheckBox", "chk23")
			ui->Childs.AddElement(chk11)
			ui->Childs.AddElement(chk12)
			ui->Childs.AddElement(chk13)
			ui->Childs.AddElement(chk21)
			ui->Childs.AddElement(chk22)
			ui->Childs.AddElement(chk23)
			xui.LayoutApply()
			
			' the color scheme of buttons is also applicable to CheckBox
			chk22->NormalStyle.BorderColor = &HFFD88E0A
			chk22->NormalStyle.FillColor = &HFFD88E0A
			chk22->NormalStyle.TextColor = &HFFFFE8CC
			chk22->PressStyle.BorderColor = &HFFD88E0A
			chk22->PressStyle.FillColor = &HFFA86000
			chk22->PressStyle.TextColor = &HFFFFFFFF
			chk22->HotStyle.BorderColor = &HFFD88E0A
			chk22->HotStyle.FillColor = &HFFFAB21C
			chk22->HotStyle.TextColor = &HFFFFFFFF
			chk22->CheckStyle.BorderColor = &HFFD88E0A
			chk22->CheckStyle.FillColor = &HFFD88E0A
			chk22->CheckStyle.TextColor = &HFF66B8FF
			
			' CheckBox can use OnCheck event, which only trigers when it changes
			chk11->Event.OnCheck = Cast(Any Ptr, @OnCheck)
			chk12->Event.OnCheck = Cast(Any Ptr, @OnCheck)
			chk13->Event.OnCheck = Cast(Any Ptr, @OnCheck)
			chk21->Event.OnCheck = Cast(Any Ptr, @OnCheck)
			chk22->Event.OnCheck = Cast(Any Ptr, @OnCheck)
			chk23->Event.OnCheck = Cast(Any Ptr, @OnCheck)
			
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(800, 600, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - XUI Check Element")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
