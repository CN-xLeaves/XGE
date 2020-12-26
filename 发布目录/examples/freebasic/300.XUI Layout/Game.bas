' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui
	Static As xui.Element Ptr LeftLayout, CenterLayout, RightLayout
	Select Case msg
		Case XGE_MSG_FRAME				' frame Logic processing
			
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			
			' draw ui system
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
			
			' get root element node, all ui element must be inside it
			ui = xui.GetRootElement()
			
			' adjust the layout mode from left to right
			' There are several layout modes:
			'     XUI_LAYOUT_COORD			do not automatically layout, need coord and size
			'     XUI_LAYOUT_L2R			from left to right, support automation layout
			'     XUI_LAYOUT_R2L			from right to left, support automation layout
			'     XUI_LAYOUT_T2B			from top to bottom, support automation layout
			'     XUI_LAYOUT_B2T			from bottom to left, support automation layout
			ui->LayoutMode = XUI_LAYOUT_L2R
			
			' create there elements for layout
			' XUI_LAYOUT_RULER_RATIO layout mode : which is automatically allocated according to the proportion of remaining space
			' XUI_LAYOUT_RULER_PIXEL layout mode : occupy a fixed size
			' because the layout is from left to right, the height parameter of XUI_LAYOUT_RULER_RATIO layout mode is meaningless
			' the total width of LeftLayout and RightLayout is 3, so they occupy 1/3 and 2/3 of the remaining space respectively after automatic layout
			LeftLayout = xui.CreateElement(XUI_LAYOUT_RULER_RATIO, 0, 0, 1, 1, XUI_LAYOUT_COORD, "SpaceL")
			CenterLayout = xui.CreateElement(XUI_LAYOUT_RULER_PIXEL, 0, 0, 240, 600, XUI_LAYOUT_COORD, "SpaceL")
			RightLayout = xui.CreateElement(XUI_LAYOUT_RULER_RATIO, 0, 0, 2, 1, XUI_LAYOUT_COORD, "SpaceL")
			
			' draw the reference lines of the three elements so as to observe their positions
			LeftLayout->DrawRange = TRUE
			CenterLayout->DrawRange = TRUE
			RightLayout->DrawRange = TRUE
			
			' put these three elements into the root element
			ui->Childs.AddElement(LeftLayout)
			ui->Childs.AddElement(CenterLayout)
			ui->Childs.AddElement(RightLayout)
			
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
