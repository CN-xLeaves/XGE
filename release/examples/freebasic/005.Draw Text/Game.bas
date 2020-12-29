' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Init xywh Game Engine
xge.Init(800, 600, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - Draw Text")

' maybe you can use gdi and gdiplus skillfully
' then you can draw words in another way

' create an image that can interact with gdi (800*600px), it extends from xge.Surface.
Dim img As xge.GdiSurface Ptr = New xge.GdiSurface(800, 600)

' now let's write the words on it
' -> is member function of the class is called, through the pointer
' developing a game needs to manage a lot of resources, and it is convenient to use pointers and classes.
img->PrintText(0, 100, 800, 100, "宋体", 48, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE Or XGE_FONT_UNDERLINE, &HFFFF00, "xywh Game Engine")
img->PrintText(0, 200, 800, 100, "微软雅黑", 60, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE Or XGE_FONT_BOLD, &HFFFF, 2, "星月无痕软件工作组出品")
img->PrintText(0, 300, 800, 100, "微软雅黑", 48, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE Or XGE_FONT_BOLD, &HFF00, &HFF, 2, "作者 : xLeaves (叶子的离开)")
img->PrintText(0, 400, 800, 100, "微软雅黑", 52, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE Or XGE_FONT_BOLD, "..\..\..\res\fire.jpg", 0, "xywhsoft@qq.com")

' free memory it's a good habit
img->Draw(NULL, 0,0)

' it should be noted that gdi is ineffcient and is not recommended for large-scale use in games.

' wait 5s
Sleep 5000

' release menory by XGE
xge.Unit()
