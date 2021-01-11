' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Init xywh Game Engine
xge.Init(800, 600, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - Draw Text")

' load font
xge.Text.LoadFont("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)

' many times, it is necessary to draw the text into a range, so easy
' drawrect has more typesetting functions than draw
' it is not difficult to find the secret by examining the paramenters carefuly
xge.Text.DrawRectA(NULL, 0, 0, 800, 600, "LEFT and TOP", 0, &HFF00, 1, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_TOP)
xge.Text.DrawRectA(NULL, 0, 0, 800, 600, "CENTER and TOP", 0, &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_TOP)
xge.Text.DrawRectA(NULL, 0, 0, 800, 600, "RIGHT and TOP", 0, &HFF00, 1, 0, XGE_ALIGN_RIGHT Or XGE_ALIGN_TOP)
xge.Text.DrawRectA(NULL, 0, 0, 800, 600, "LEFT and MIDDLE", 0, &HFF00, 1, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
xge.Text.DrawRectA(NULL, 0, 0, 800, 600, "CENTER and MIDDLE", 0, &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
xge.Text.DrawRectA(NULL, 0, 0, 800, 600, "RIGHT and MIDDLE", 0, &HFF00, 1, 0, XGE_ALIGN_RIGHT Or XGE_ALIGN_MIDDLE)
xge.Text.DrawRectA(NULL, 0, 0, 800, 600, "LEFT and BOTTOM", 0, &HFF00, 1, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_BOTTOM)
xge.Text.DrawRectA(NULL, 0, 0, 800, 600, "CENTER and BOTTOM", 0, &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_BOTTOM)
xge.Text.DrawRectA(NULL, 0, 0, 800, 600, "RIGHT and BOTTOM", 0, &HFF00, 1, 0, XGE_ALIGN_RIGHT Or XGE_ALIGN_BOTTOM)

' wait 5s
Sleep 5000

' release menory by XGE
xge.Unit()
