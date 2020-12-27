' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



Declare Function Scene2(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
Declare Function Scene3(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer



' Scene function
Function Scene1(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static img As xge.Surface Ptr
	Select Case msg
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			img->Draw(0,0)
			xge.Text.DrawRectA(NULL, 0, 0, 640, 480, !"Press [Space] to enter the next scene\n\nPress [Esc] to exit the current scene", &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
		Case XGE_MSG_KEY_DOWN			' mouse down
			If eve->scancode = SC_ESCAPE Then
				xge.Scene.Stop()
			ElseIf eve->scancode = SC_SPACE Then
				xge.Scene.Start(@Scene2, 40)
			EndIf
		Case XGE_MSG_LOADRES			' load resources
			Print "Scene1 LoadRes"
			img = New xge.Surface("..\..\..\res\001-Title01.bmp", 0)
		Case XGE_MSG_FREERES			' unload resources
			Print "Scene1 FreeRes"
			Delete img
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function

' Scene function
Function Scene2(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static img As xge.Surface Ptr
	Select Case msg
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			img->Draw(0,0)
			xge.Text.DrawRectA(NULL, 0, 0, 640, 480, !"Press [Space] to enter the next scene\n\nPress [Esc] to return the previous scene", &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
		Case XGE_MSG_KEY_DOWN			' mouse down
			If eve->scancode = SC_ESCAPE Then
				xge.Scene.Stop()
			ElseIf eve->scancode = SC_SPACE Then
				xge.Scene.Start(@Scene3, 40)
			EndIf
		Case XGE_MSG_LOADRES			' load resources
			Print "Scene2 LoadRes"
			img = New xge.Surface("..\..\..\res\015-Diamond01.bmp", 0)
		Case XGE_MSG_FREERES			' unload resources
			Print "Scene2 FreeRes"
			Delete img
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function

' Scene function
Function Scene3(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static img As xge.Surface Ptr
	Select Case msg
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			img->Draw(0,0)
			xge.Text.DrawRectA(NULL, 0, 0, 640, 480, !"Press [Esc] to return the previous scene", &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
		Case XGE_MSG_KEY_DOWN			' mouse down
			If eve->scancode = SC_ESCAPE Then
				xge.Scene.Stop()
			EndIf
		Case XGE_MSG_LOADRES			' load resources
			Print "Scene3 LoadRes"
			img = New xge.Surface("..\..\..\res\back.bmp", 0)
		Case XGE_MSG_FREERES			' unload resources
			Print "Scene3 FreeRes"
			Delete img
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - Scene Stack")
xge.Text.LoadFont("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)
xge.Scene.Start(@Scene1, 40)
xge.Text.RemoveFont(1)
xge.Unit()
