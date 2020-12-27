' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Init xywh Game Engine
xge.Init(640, 480, XGE_INIT_WINDOW, XGE_INIT_ALL, "XGE - Play Memory Sound")

' load font
xge.Text.LoadFont("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)

' draw text
xge.Text.DrawRectA(NULL, 0, 0, 640, 480, "Press ESC to exit", &HFF00)

' Read music into memory
Dim t_len As Integer = xFile.Size("..\..\..\res\bgm.mp3")
Dim t_mem As Any Ptr = Allocate(t_len)
xFile.Read("..\..\..\res\bgm.mp3", t_mem, 0, t_len)

' load music (XGE_ SUD_ STE_ AFRE can release memory automatically, so t_ MEM does not need to be released manually)
Dim bgm As xge.Sound Ptr = New xge.Sound(XGE_SOUND_STREAM, XGE_SUD_STE_AFRE, t_mem, t_len)

' play music
bgm->Play()

' Wait, press ESC to exit
Do
	Sleep(15)
Loop Until xge.xInput.KeyStatus(SC_ESCAPE)

' free memory it's a good habit
Delete bgm

' release menory by XGE
xge.Unit()
