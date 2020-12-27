' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



Sub OnMouseEnter(ele As xui.Element Ptr)
	ele->Identifier = "OnMouseEnter"
End Sub

Sub OnMouseLeave(ele As xui.Element Ptr)
	ele->Identifier = "OnMouseLeave"
End Sub

Sub OnDraw(ele As xui.Element Ptr)
	ele->DrawDebug()
End Sub



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui, ele
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
			ele = xui.CreateElement(XUI_LAYOUT_RULER_PIXEL, 200, 150, 400, 300, XUI_LAYOUT_COORD, "Mouse Enter or Leave")
			
			' the ClassEvent attribute of the element holds some basic events, and in response to them, you can create your own elements
			ele->ClassEvent.OnMouseEnter = Cast(Any Ptr, @OnMouseEnter)
			ele->ClassEvent.OnMouseLeave = Cast(Any Ptr, @OnMouseLeave)
			ele->ClassEvent.OnDraw = Cast(Any Ptr, @OnDraw)
			
			' in fact, the built-in elements of xui are all made like this
			' therefore, the ClassEvent of some elements may be occupied, so you can override it and customize it
			' the redrawing of elements is a special case, OnDraw is user by the elements class, OnUserDraw is generally not occupied.
			' so there are two ways to redraw elements
			' realize OnUserDraw to add new drawing content on the existsing basic
			' or override OnDraw to completely redraw element
			' in the next example, we will try these two methods separately
			
			ui->Childs.AddElement(ele)
			xui.LayoutApply()
			
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(800, 600, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - XUI ClassEvent")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
