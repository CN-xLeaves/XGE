' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



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
			ui = xui.GetRootElement()
			
			' of course, you can also use the traditional method to input coordinates directly
			' this is convenient when there are few elements, but is will be confusing when there are many elements
			Btn1 = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 280, 160, 40, !"开始游戏\n(New Game)")
			Btn2 = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 340, 160, 40, !"载入存档\n(Load)")
			Btn3 = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 400, 160, 40, !"退出游戏\n(Exit)")
			
			' add three buttons to the root element
			ui->Childs.AddElement(Btn1)
			ui->Childs.AddElement(Btn2)
			ui->Childs.AddElement(Btn3)
			
			' in any case, you must call xui.LayoutApply()
			xui.LayoutApply()
			
			' we can also load a background image to make the image less empty
			backimg = New xge.Surface("..\..\..\res\back.bmp", 0)
			
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - XUI Layout")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
