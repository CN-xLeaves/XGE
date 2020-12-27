' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Init xywh Game Engine
xge.Init(640, 480, XGE_INIT_WINDOW, XGE_INIT_ALL, "XGE - Play URL Sound")

' load font
xge.Text.LoadFont("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)

' draw text
xge.Text.DrawRectA(NULL, 0, 0, 640, 480, !"Press ESC to exit\n\nURL link may be invalid, please replace a link that can be used", &HFF00)

' load music
Dim bgm As xge.Sound Ptr = New xge.Sound(XGE_SOUND_STREAM, XGE_SUD_STE_URL, "http://win.web.rh03.sycdn.kuwo.cn/587f890acf48790df64ac86135276b64/577e229e/resource/a2/38/48/2885410136.aac")

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
