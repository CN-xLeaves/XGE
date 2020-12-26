' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static img As xge.Surface Ptr
	Static shock As Integer
	Select Case msg
		Case XGE_MSG_FRAME				' frame Logic processing
			' Simulation of vibration effect by randomly changing coordinate system
			If shock Then
				Dim x As Integer = (Rnd * 20) - 10
				Dim y As Integer = (Rnd * 20) - 10
				xge.aux.SetCoodr(x, y, x+640, y+480)
			EndIf
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			img->Draw(0,0)
			xge.Text.DrawRectA(NULL, 0, 0, 640, 480, !"Double click the left button to start shaking\n\nDouble right click to stop shaking", &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
		Case XGE_MSG_MOUSE_MOVE			' mouse move
			
		Case XGE_MSG_MOUSE_DOWN			' mouse down
			
		Case XGE_MSG_MOUSE_UP			' mouse up
			
		Case XGE_MSG_MOUSE_CLICK		' mouse click
			
		Case XGE_MSG_MOUSE_DCLICK		' mouse double click
			' Double click the left button to start shaking
			If eve->button And 1 Then
				shock = TRUE
			EndIf
			' Double right click to stop shaking
			If eve->button And 2 Then
				shock = FALSE
				xge.aux.ReSetCoodr()
			EndIf
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
			img = New xge.Surface("..\..\..\res\back.bmp", 0)
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
			Delete img
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - Earthquake")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
