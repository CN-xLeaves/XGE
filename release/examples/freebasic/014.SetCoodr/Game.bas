' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Init xywh Game Engine
xge.Init(640, 480, XGE_INIT_WINDOW, XGE_INIT_ALL, "XGE - SetCoodr")

' load image
Dim pic1 As xge.Surface Ptr = New xge.Surface("..\..\..\res\back.bmp", 0)

' Set coordinate system
xge.aux.SetCoodr(-320, -240, 320, 240)

' draw image
pic1->Draw(0,0)

' wait 1s
Sleep 1000

' Restore coordinate system
xge.aux.ReSetCoodr()

' draw image
pic1->Draw(0,0)

' free memory it's a good habit
Delete pic1

' wait 5s
Sleep 5000

' release menory by XGE
xge.Unit()
