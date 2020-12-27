' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Init xywh Game Engine
xge.Init(640, 480, XGE_INIT_WINDOW, XGE_INIT_ALL, "XGE - Play SE")

' load sample
Dim se As xge.Sound Ptr = New xge.Sound(XGE_SOUND_SAMPLE, 0, "..\..\..\res\se.ogg")

' play sample
se->Play()
Sleep 200
se->Play()
Sleep 350
se->Play()
Sleep 500
se->Play()

' wait 1s
Sleep 1000

' free memory it's a good habit
Delete se

' release menory by XGE
xge.Unit()
