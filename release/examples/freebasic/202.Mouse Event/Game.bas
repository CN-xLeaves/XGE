' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As Integer down, click, dclick, ot1, ot2
	Static buf As ZString * 256
	Select Case msg
		Case XGE_MSG_FRAME				' frame Logic processing
			' One second later, the state fails
			If GetTickCount() - ot1 > 1000 Then
				click = FALSE
			EndIf
			If GetTickCount() - ot2 > 1000 Then
				dclick = FALSE
			EndIf
		Case XGE_MSG_DRAW				' draw
			' draw text
			xge.Clear()
			buf  = IIf(down, !"Mouse Down\n\n", !"Mouse Normal\n\n")
			buf &= IIf(click, !"You click the mouse\n\n", !"No mouse click for one second\n\n")
			buf &= IIf(dclick, !"You double click the mouse", !"No mouse double click for one second")
			xge.Text.DrawRectA(NULL, 0, 0, 800, 600, @buf, &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
		Case XGE_MSG_MOUSE_MOVE			' mouse move
			
		Case XGE_MSG_MOUSE_DOWN			' mouse down
			down = TRUE
		Case XGE_MSG_MOUSE_UP			' mouse up
			down = FALSE
		Case XGE_MSG_MOUSE_CLICK		' mouse click
			click = TRUE
			ot1 = GetTickCount()
		Case XGE_MSG_MOUSE_DCLICK		' mouse double click
			dclick = TRUE
			ot2 = GetTickCount()
		Case XGE_MSG_MOUSE_WHELL		' mouse whell
			
		Case XGE_MSG_KEY_DOWN			' keyboard down
			
		Case XGE_MSG_KEY_UP				' keyboard up
			
		Case XGE_MSG_KEY_REPEAT			' keyboard hold
			
		Case XGE_MSG_GOTFOCUS			' got focus
			
		Case XGE_MSG_LOSTFOCUS			' lost focus
			
		Case XGE_MSG_MOUSE_ENTER		' mouse enter
			
		Case XGE_MSG_MOUSE_EXIT			' mouse leave
			
		Case XGE_MSG_LOADRES			' load resources
			' load font
			xge.Text.LoadFont("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)
		Case XGE_MSG_FREERES			' unload resources
			' remove font
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(800, 600, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - Mouse Event")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
