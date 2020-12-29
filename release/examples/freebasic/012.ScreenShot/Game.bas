' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Init xywh Game Engine
xge.Init(640, 480, XGE_INIT_WINDOW, XGE_INIT_ALL, "XGE - ScreenShot")

' load image
Dim img As xge.Surface Ptr = New xge.Surface("..\..\..\res\back.bmp", 0)

' draw image
img->Draw(NULL, 0, 0)

' screenshot
Dim shot As xge.Surface Ptr = xge.aux.ScreenShot()

' clear
xge.Clear

' draw screenshot image
shot->Draw(NULL, 0, 0)

' save screenshot image
shot->Save("c:\1.bmp", XGE_IMG_FMT_BMP)

' The screenshot is saved on disk C. you can view this file

' free memory it's a good habit
Delete img
Delete shot

' wait 5s
Sleep 5000

' release menory by XGE
xge.Unit()
