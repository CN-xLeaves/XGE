' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Init xywh Game Engine
xge.Init(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - Draw Image")

' load image
' XGE supports loading common file formats
' PNG, JPG, GIF, BMP, TGA and XGI
' XGI format is a compressed image format dedicated to XGE
' It has extremely fast loading speed and reasonable compression ratio (LZ4 compression)
Dim img As xge.Surface Ptr = New xge.Surface("..\..\..\res\back.xgi", 0)

' draw image
img->Draw(0,0)

' free memory it's a good habit
Delete img

' wait 5s
Sleep 5000

' release menory by XGE
xge.Unit()
