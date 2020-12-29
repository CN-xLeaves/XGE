' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Init xywh Game Engine
xge.Init(640, 480, XGE_INIT_WINDOW, XGE_INIT_ALL, "XGE - GDI Draw Image")

' XGE supports linkage with GDI, so you can also use GDI to draw into XGE

' create GdiSurface
Dim img As xge.GdiSurface Ptr = New xge.GdiSurface(320, 240)

' Draw the image on GdiSurface
img->PrintImageZoom(0, 0, 320, 240, "..\..\..\res\back.bmp", 0)

' GDI can easily handle image rotation and scaling
' However, these methods are not efficient and are not recommended for large-scale use in games.

' draw image
img->Draw(NULL, 0, 0)

' free memory it's a good habit
Delete img

' wait 5s
Sleep 5000

' release menory by XGE
xge.Unit()
