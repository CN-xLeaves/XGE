' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Init xywh Game Engine
xge.Init(800, 600, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE·¶Àý - Draw Image")

' load image
Dim img As xge.Surface Ptr = New xge.Surface("..\..\..\res\1.bmp", 0)

' draw image
img->Draw_Trans(NULL, 100,100)

' Cut the image and draw separately
img->DrawEx_Trans(NULL, 300, 100, 0, 0, 32, 48)
img->DrawEx_Trans(NULL, 400, 100, 32, 0, 32, 48)
img->DrawEx_Trans(NULL, 500, 100, 64, 0, 32, 48)
img->DrawEx_Trans(NULL, 600, 100, 96, 0, 32, 48)
img->DrawEx_Trans(NULL, 300, 200, 0, 48, 32, 48)
img->DrawEx_Trans(NULL, 400, 200, 32, 48, 32, 48)
img->DrawEx_Trans(NULL, 500, 200, 64, 48, 32, 48)
img->DrawEx_Trans(NULL, 600, 200, 96, 48, 32, 48)
img->DrawEx_Trans(NULL, 300, 300, 0, 96, 32, 48)
img->DrawEx_Trans(NULL, 400, 300, 32, 96, 32, 48)
img->DrawEx_Trans(NULL, 500, 300, 64, 96, 32, 48)
img->DrawEx_Trans(NULL, 600, 300, 96, 96, 32, 48)
img->DrawEx_Trans(NULL, 300, 400, 0, 144, 32, 48)
img->DrawEx_Trans(NULL, 400, 400, 32, 144, 32, 48)
img->DrawEx_Trans(NULL, 500, 400, 64, 144, 32, 48)
img->DrawEx_Trans(NULL, 600, 400, 96, 144, 32, 48)

' free memory it's a good habit
Delete img

' wait 5s
Sleep 5000

' release menory by XGE
xge.Unit()
