' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static buf As WString * 256
	Select Case msg
		Case XGE_MSG_FRAME				' frame Logic processing
			
		Case XGE_MSG_DRAW				' draw
			' This logic is executed every frame
			' xge.Clear Used to clear the previous content on the canvas
			xge.Clear()
			' Draw the coordinate information to the screen
			xge.Text.DrawRectW(NULL, 0, 0, 800, 600, @buf, 0, &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
		Case XGE_MSG_MOUSE_MOVE			' mouse move
			' Record the coordinates of the mouse on the screen
			buf = "x : " & eve->x & !"\ny : " & eve->y & !"\ndx : " & eve->dx & !"\ndy : " & eve->dy
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
			' load font (This logic is executed only once, before the scene starts)
			xge.Text.LoadFontW("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)
			buf = "Try moving the mouse over the screen"
		Case XGE_MSG_FREERES			' unload resources
			' remove font (This logic is executed only once, at the end of the scene)
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.InitW(800, 600, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, "XGE - Mouse Event")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
