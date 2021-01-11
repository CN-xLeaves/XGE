' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Init xywh Game Engine
xge.Init(640, 480, XGE_INIT_WINDOW, XGE_INIT_ALL, "XGE - Play Sound")

' load font
xge.Text.LoadFont("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)

' draw text
xge.Text.DrawRectA(NULL, 0, 0, 640, 480, "Press ESC to exit", 0, &HFF00)

' load music
Dim bgm As xge.Sound Ptr = New xge.Sound(XGE_SOUND_STREAM, 0, "..\..\..\res\bgm.mp3")

' play music
bgm->Play()

' Wait, press ESC to exit
Do
	Sleep(15)
Loop Until xInput.KeyStatus(SC_ESCAPE)

' free memory it's a good habit
Delete bgm

' release menory by XGE
xge.Unit()
