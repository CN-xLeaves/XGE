' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' When no scene is running, xge.Scene.Cut And xge.Scene.Start The same function, will start a new scene.

' When a scene is running, xge.Scene.Start Saves the current scene and starts the next one.
' and xge.Scene.Cut The current scene will be released and the next scene will be started. After the next scene is finished, it will not return here.



' Scene function
Function Scene3(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static img As xge.Surface Ptr
	Select Case msg
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			img->Draw(NULL, 0, 0)
			xge.Text.DrawRectW(NULL, 0, 0, 640, 480, !"Press [Esc] to return the previous scene", 0, &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
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

' Scene function
Function Scene2(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static img As xge.Surface Ptr
	Select Case msg
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			img->Draw(NULL, 0, 0)
			xge.Text.DrawRectW(NULL, 0, 0, 640, 480, !"Press [Space] to cut the next scene\n\nPress [Esc] to return the previous scene", 0, &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
		Case XGE_MSG_KEY_DOWN			' mouse down
			If eve->scancode = SC_ESCAPE Then
				xge.Scene.Stop()
			ElseIf eve->scancode = SC_SPACE Then
				xge.Scene.Cut(@Scene3, 40)
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
Function Scene1(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static img As xge.Surface Ptr
	Select Case msg
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			img->Draw(NULL, 0, 0)
			xge.Text.DrawRectW(NULL, 0, 0, 640, 480, !"Press [Space] to enter the next scene\n\nPress [Esc] to exit the current scene", 0, &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
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



xge.InitW(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, "XGE - Scene Cut")
xge.Text.LoadFontW("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)
xge.Scene.Start(@Scene1, 40)
xge.Text.RemoveFont(1)
xge.Unit()
