' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Init xywh Game Engine
xge.Init(640, 480, XGE_INIT_WINDOW, XGE_INIT_ALL, "XGE - Memory Load Image")

' Loading pictures from memory is mainly used to load compressed package resources
' We do not have a compressed package, so first read the data into memory
Dim t_len As Integer = xFile.Size("..\..\..\res\back.bmp")
Dim t_mem As Any Ptr = Allocate(t_len)
xFile.Read("..\..\..\res\back.bmp", t_mem, 0, t_len)

' load image from memory
' Load image from memory using the same method, but the memory length is specified
Dim img As xge.Surface Ptr = New xge.Surface(t_mem, t_len)

' draw image
img->Draw(0,0)

' free memory it's a good habit
DeAllocate(t_mem)
Delete img

' wait 5s
Sleep 5000

' release menory by XGE
xge.Unit()
