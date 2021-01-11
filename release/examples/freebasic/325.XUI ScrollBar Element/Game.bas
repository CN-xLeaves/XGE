' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' global label element (Because it needs to be accessed outside the scene function)
Dim Shared labEvent As xui.Label Ptr

Dim Shared strEvent As ZString * 64



' Scroll event
Sub OnScroll(ele As xui.ScrollBar Ptr)
	strEvent = ele->Identifier & " OnScroll : value = " & ele->Value
	labEvent->Text = @strEvent
End Sub

' Slider draw
Sub OnDraw(ele As xui.ScrollBar Ptr)
	Dim rc As xui.Rect = (0, 6, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 7)
	xui_DrawBackStyle_Rect(ele, @ele->BackStyle, @rc)
End Sub



Namespace xui
	' Customize your own user interface element and make them mass-produced
	Function CreateSlider(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 200, h As Integer = 18, sIdentifier As ZString Ptr = NULL) As xui.ScrollBar Ptr
		' Create an common scrollbar
		Dim slider As xui.ScrollBar Ptr = xui.CreateHScrollBar(iLayoutRuler, x, y, w, h, sIdentifier)
		' Hide the front and back buttons
		slider->private_ButtonUp->Visible = FALSE
		slider->private_ButtonDown->Visible = FALSE
		' Set the slider size and disable the OnSize event so that the size will not be restored
		slider->private_ButtonCurPos->Layout.w = 10
		slider->private_ButtonCurPos->Layout.Rect.w = 10
		slider->private_ButtonCurPos->Layout.RectBox.RightOffset = 1
		slider->ClassEvent.OnSize = NULL
		' Redrawing the background makes the background appear thinner
		slider->ClassEvent.OnDraw = Cast(Any Ptr, @OnDraw)
		Return slider
	End Function
End Namespace



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui
	Static As xui.ScrollBar Ptr vs, hs, slider
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
			
			' Create ScrollBar elements
			vs = xui.CreateVScrollBar(, 100, 100, 18, 280, "VScrollBar")
			hs = xui.CreateHScrollBar(, 200, 100, 340, 18, "HScrollBar")
			
			' Create slider style ScrollBar element
			slider = xui.CreateSlider(, 200, 360, 340, 20, "Slider ScrollBar")
			
			' Create label element (used to show event details)
			labEvent = xui.CreateLabel(, 200, 218, 340, 52, "Try changeing the ScrollBar", &HFF00FF00)
			
			' Apply layout
			ui->Childs.AddElement(vs)
			ui->Childs.AddElement(hs)
			ui->Childs.AddElement(slider)
			ui->Childs.AddElement(labEvent)
			xui.LayoutApply()
			
			' set events
			vs->Event.OnScroll = Cast(Any Ptr, @OnScroll)
			hs->Event.OnScroll = Cast(Any Ptr, @OnScroll)
			slider->Event.OnScroll = Cast(Any Ptr, @OnScroll)
			
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - XUI ScrollBar Element")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
