' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static img As xge.Surface Ptr
	Select Case msg
		Case XGE_MSG_FRAME				' frame Logic processing
			' The shaking scene is convenient to observe the effect
			Dim x As Integer = (Rnd * 20) - 10
			Dim y As Integer = (Rnd * 20) - 10
			xge.aux.SetCoodr(x, y, x+640, y+480)
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			img->Draw(NULL, 0, 0)
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
			xge.Scene.Resume()	
		Case XGE_MSG_LOSTFOCUS			' lost focus
			' Graying out before pausing
			' Note: only XGE_MSG_DRAW event will automatically lock screen
			' Other events require manually locking the screen to avoid tearing the image
			xge.Lock()
				img->Draw_Gray(NULL, 0, 0)
				xge.Text.DrawRectW(NULL, 0, 0, 640, 480, "The game has been suspended", 0, &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
			xge.UnLock()
			xge.Scene.Pause()
		Case XGE_MSG_MOUSE_ENTER		' mouse enter
			
		Case XGE_MSG_MOUSE_EXIT			' mouse leave
			
		Case XGE_MSG_LOADRES			' load resources
			xge.Text.LoadFontW("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)
			img = New xge.Surface("..\..\..\res\back.bmp")
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
			Delete img
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.InitW(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, "XGE - Auto Pause")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
