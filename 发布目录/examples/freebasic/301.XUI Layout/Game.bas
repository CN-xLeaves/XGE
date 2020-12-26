' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui
	Static As xui.Element Ptr LeftLayout, CenterLayout, RightLayout
	Static As xui.Element Ptr TopLayout, MiddleLayout, BottomLayout
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
			
			' the layout of the previous example (change RightLayout width)
			ui = xui.GetRootElement()
			ui->LayoutMode = XUI_LAYOUT_L2R
			LeftLayout = xui.CreateElement(XUI_LAYOUT_RULER_RATIO, 0, 0, 1, 1, XUI_LAYOUT_COORD, "LeftLayout")
			CenterLayout = xui.CreateElement(XUI_LAYOUT_RULER_PIXEL, 0, 0, 240, 600, XUI_LAYOUT_COORD, "CenterLayout")
			RightLayout = xui.CreateElement(XUI_LAYOUT_RULER_RATIO, 0, 0, 1, 1, XUI_LAYOUT_COORD, "RightLayout")
			ui->Childs.AddElement(LeftLayout)
			ui->Childs.AddElement(CenterLayout)
			ui->Childs.AddElement(RightLayout)
			
			' modify the layout mode of element CenterLayout to XUI_LAYOUT_T2B
			CenterLayout->LayoutMode = XUI_LAYOUT_T2B
			
			' create three more elements for layout
			TopLayout = xui.CreateElement(XUI_LAYOUT_RULER_RATIO, 0, 0, 1, 1, XUI_LAYOUT_COORD, "TopLayout")
			MiddleLayout = xui.CreateElement(XUI_LAYOUT_RULER_RATIO, 0, 0, 1, 1, XUI_LAYOUT_COORD, "MiddleLayout")
			BottomLayout = xui.CreateElement(XUI_LAYOUT_RULER_RATIO, 0, 0, 1, 1, XUI_LAYOUT_COORD, "BottomLayout")
			
			' put these three elements into the CenterLayout element
			CenterLayout->Childs.AddElement(TopLayout)
			CenterLayout->Childs.AddElement(MiddleLayout)
			CenterLayout->Childs.AddElement(BottomLayout)
			
			' draw the reference lines of the three elements so as to observe their positions
			LeftLayout->DrawRange = TRUE
			'CenterLayout->DrawRange = TRUE		the space of this layout is occupied by other elements, so we don't meed to display is again
			RightLayout->DrawRange = TRUE
			TopLayout->DrawRange = TRUE
			MiddleLayout->DrawRange = TRUE
			BottomLayout->DrawRange = TRUE
			
			' apply layout
			xui.LayoutApply()
			
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(800, 600, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - XUI Layout")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
