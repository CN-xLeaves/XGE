' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Init xywh Game Engine
xge.Init(640, 480, XGE_INIT_WINDOW, XGE_INIT_ALL, "XGE - SetView")

' load image
Dim img As xge.Surface Ptr = New xge.Surface("..\..\..\res\back.bmp", 0)

' set view
xge.aux.SetView(100, 100, 540, 380, &HFF00FF, FALSE)

' draw image
img->Draw(NULL, 0, 0)

' wait 1s
Sleep 1000

' reduction view
xge.aux.ReSetView()

' draw image
img->Draw(NULL, 0, 0)

' free memory it's a good habit
Delete img

' wait 5s
Sleep 5000

' release menory by XGE
xge.Unit()
