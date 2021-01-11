' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' button click event
Sub OnClick(ele As xui.Button Ptr)
	xge.Scene.StopAll()
End Sub



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui
	Static As xui.Frame Ptr frmAbout
	Static As xui.Image Ptr imgIocn
	Static As xui.Label Ptr labTitle, labText
	Static As xui.Button Ptr btnClose
	Static As xge.Surface Ptr icon
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
			xge.Text.LoadFont("..\..\..\res\font\ttf\cn_zk_happy_2016.ttf", 0)
			ui = xui.GetRootElement()
			
			' Create frame element (Ignore the first parameter and use pixel layout)
			frmAbout = xui.CreateFrame(, 160, 120, 320, 240, XUI_LAYOUT_COORD, "About xywh Game Engine")
			
			' Create image element
			icon = New xge.Surface("..\..\..\res\gamg.png")
			imgIocn = xui.CreateImage(, 20, 40, 48, 48, icon)
			
			' Create label element (The two elements use different fonts)
			labTitle = xui.CreateLabel(, 90, 40, 200, 48, "About XGE", &HFFFFFFFF, 2)
			labText = xui.CreateLabel(, 90, 120, 200, 48, !"xywh Game Engine description\ndraw, sound, network, gui", &HFFFFFFFF, 1)
			
			' Create button element
			btnClose = xui.CreateButton(, 224, 200, 80, 24, "Exit")
			btnClose->Event.OnClick = Cast(Any Ptr, @OnClick)
			
			' Add to elements list
			frmAbout->Childs.AddElement(imgIocn)
			frmAbout->Childs.AddElement(labTitle)
			frmAbout->Childs.AddElement(labText)
			frmAbout->Childs.AddElement(btnClose)
			ui->Childs.AddElement(frmAbout)
			
			' Apply layout
			xui.LayoutApply()
			
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - XUI Static Element")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
