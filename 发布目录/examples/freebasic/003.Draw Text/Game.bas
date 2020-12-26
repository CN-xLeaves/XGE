' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Init xywh Game Engine
xge.Init(800, 600, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - Draw Text")

' load font
xge.Text.LoadFont("..\..\..\res\font\ttf\DroidSans.ttf", 0)

' draw text with No.1 font
xge.Text.DrawA(NULL, 100, 50, "you are very clever!", &HFF00, 1)

' load font, if the font is loaded successfully, you can use font No.2
' judging whenther the font is loaded successfully by the return value, 0 is failure.
xge.Text.LoadFont("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)

' draw text with No.2 font
xge.Text.DrawA(NULL, 100, 150, "如果你理解了，那么恭喜你在游戏里输出文字不再困难了。", &HFF00, 2)

' sometimes you need to change the font size, truetype font can be realized
xge.Text.SetFontSize(1, 64)

' draw text with No.1 font
xge.Text.DrawA(NULL, 100, 250, "it's very nice!", &HFF00, 1)

' This is what i want to say you
xge.Text.DrawA(NULL, 100, 350, "the truetype font draw efficiency of is not high.", &HFF00, 2)
xge.Text.DrawA(NULL, 100, 370, "the xywhRasterFont very fast, but the text size is fixed.", &HFF00, 2)
xge.Text.DrawA(NULL, 100, 390, "use truetype to draw less text that requires quality.", &HFF00, 2)
xge.Text.DrawA(NULL, 100, 410, "use xywhRasterFont to draw lots of text.", &HFF00, 2)
xge.Text.DrawA(NULL, 100, 430, "both fonts can well support unicode encoding.", &HFF00, 2)

' this is the chinese translation of the above paragraph
xge.Text.DrawA(NULL, 100, 480, "truetype 字体的渲染效率不高.", &HFF00, 2)
xge.Text.DrawA(NULL, 100, 500, "xywhRasterFont 字体很快，但是字体大小是固定的.", &HFF00, 2)
xge.Text.DrawA(NULL, 100, 520, "使用 truetype 渲染对质量要求较高的字.", &HFF00, 2)
xge.Text.DrawA(NULL, 100, 540, "使用 xywhRasterFont 渲染游戏中的大量文字.", &HFF00, 2)
xge.Text.DrawA(NULL, 100, 560, "两种字体都能很好的支持 UNICODE 编码.", &HFF00, 2)

' wait 5s
Sleep 5000

' release menory by XGE
xge.Unit()
