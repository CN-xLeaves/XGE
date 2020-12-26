'==================================================================================
	'★ Dynamic Draw String 文本绘制函数库
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================

#Define FontSize(PointSize) -MulDiv(PointSize, GetDeviceCaps(DDSurface.DC, LOGPIXELSY), 72)

Enum TextStyle
	FS_NULL = 0
	FS_BOLD = 1
	FS_ITALIC = 2
	FS_UNLINE = 4
End Enum

Dim Shared THEFONT As HFONT
Dim Shared SetClearFont As Integer

Dim Shared DDSurface As XGE_GDISurface = XGE_GDISurface(1024,512)

Sub SetDrawFont(Font As ZString Ptr,Size As Integer,FColor As UInteger=&H00FFFFFF,Style As TextStyle=FS_NULL)
	' 创建字体
	THEFONT = CreateFont(FontSize(Size),0,0,0,IIf(Style And FS_BOLD,FW_BOLD,FW_NORMAL),IIf(Style And FS_ITALIC,TRUE,FALSE),IIf(Style And FS_UNLINE,TRUE,FALSE),0,DEFAULT_CHARSET,0,0,0,0,Font)
	' 选入DC
	Dim MYTXINFO As TEXTMETRIC
	SelectObject(DDSurface.DC,DDSurface.BMP)
	SelectObject(DDSurface.DC,THEFONT)
	GetTextMetrics(DDSurface.DC,@MYTXINFO)
	' 设置颜色
	FColor = ConveColor(FColor)
	SetBkColor(DDSurface.DC,RGBA(255,0,255,0))
	SetTextColor(DDSurface.DC,FColor)
	' 关闭字体边缘处理
	SystemParametersInfo(SPI_GETFONTSMOOTHING,NULL,@SetClearFont,NULL)
	If SetClearFont Then SystemParametersInfo(SPI_SETFONTSMOOTHING,FALSE,NULL,NULL)
End Sub

Sub ClsDrawFont()
	If SetClearFont Then SystemParametersInfo(SPI_SETFONTSMOOTHING,TRUE,NULL,NULL)
	' 清理资源
	DeleteObject(THEFONT)
End Sub

Sub DrawString(sf As Surface,x As Integer,y As Integer,Text As ZString Ptr,Font As ZString Ptr,Size As Integer,FColor As UInteger=&H00FFFFFF,Style As TextStyle=FS_NULL)
	SetDrawFont(Font,Size,FColor,Style)
	' 取得文本宽度、高度
	Dim TXTSIZE As SIZE
	GetTextExtentPoint32(DDSurface.DC,Text,StrLen(Text),@TXTSIZE)
	Dim As Integer w,h
	w = TXTSIZE.CX
	h = TXTSIZE.CY
	' 渲染文字
	Dim TR As RECT = (0,0,w+1,h+2)
	ExtTextOut(DDSurface.DC,0,1,ETO_CLIPPED Or ETO_OPAQUE,@TR,Text,StrLen(Text),NULL)
	DDSurface.Draw(sf,x,y,0,0,w,h,0)
	ClsDrawFont()
End Sub

Sub DrawStringRect(sf As Surface,Rect As RECT,Text As ZString Ptr,Font As ZString Ptr,Size As Integer,FColor As UInteger=&H00FFFFFF,Style As TextStyle=FS_NULL)
	SetDrawFont(Font,Size,FColor,Style)
	' 取得文本宽度、高度
	Dim TXTSIZE As SIZE
	GetTextExtentPoint32(DDSurface.DC,Text,StrLen(Text),@TXTSIZE)
	Dim As Integer x,y,w,h
	w = TXTSIZE.CX
	h = TXTSIZE.CY
	' 计算坐标
	x = Rect.Left + ((Rect.Right - Rect.Left - w) \ 2)
	y = Rect.top + ((Rect.bottom - Rect.top - h) \ 2)
	' 渲染文字
	Dim TR As RECT = (0,0,w+1,h+2)
	ExtTextOut(DDSurface.DC,0,1,ETO_CLIPPED Or ETO_OPAQUE,@TR,Text,StrLen(Text),NULL)
	DDSurface.Draw(sf,x,y,0,0,w,h,0)
	ClsDrawFont()
End Sub
