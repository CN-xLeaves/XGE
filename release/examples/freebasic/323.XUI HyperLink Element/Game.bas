' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"

' ShellExecute rely on
#Include "win\shellapi.bi"



' button click event
Sub OnClick(ele As xui.Button Ptr)
	ShellExecute(xge.hWnd, "Open", "http://www.freebasic.net", NULL, NULL, SW_SHOW)
End Sub



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui
	Static As xui.Button Ptr hl1, hl2, hl3
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
			hl1 = xui.CreateHyperLink(XUI_LAYOUT_RULER_PIXEL, 300, 200, 200, 24, "www.freebasic.net", "hl1")
			hl2 = xui.CreateHyperLink(XUI_LAYOUT_RULER_PIXEL, 300, 300, 200, 24, "www.freebasic.net", "hl2")
			hl3 = xui.CreateHyperLink(XUI_LAYOUT_RULER_PIXEL, 300, 400, 200, 24, "www.freebasic.net", "hl3")
			ui->Childs.AddElement(hl1)
			ui->Childs.AddElement(hl2)
			ui->Childs.AddElement(hl3)
			xui.LayoutApply()
			
			' color matching of HyperLink element only supports TextColor
			hl2->NormalBack.TextColor = &HFFFFE8CC
			hl2->PressBack.TextColor = &HFFFFFFFF
			hl2->HotBack.TextColor = &HFFFFFFFF
			hl2->CheckBack.TextColor = &HFF800080
			
			' the HyperLink element till enter the accessed state after begin clicked.
			' and the working mode is modified to make this state invalid
			hl3->Mode = 0
			
			' HyperLink Click Event
			hl1->Event.OnClick = Cast(Any Ptr, @OnClick)
			hl2->Event.OnClick = Cast(Any Ptr, @OnClick)
			hl3->Event.OnClick = Cast(Any Ptr, @OnClick)
			
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(800, 600, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - XUI HyperLink Element")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
