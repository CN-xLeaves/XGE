


#Inclib "stb_truetype"



Type stbtt__buf
	Data As UByte Ptr
	cursor As Integer
	size As Integer
End Type

Type stbtt_fontinfo
	userdata As Any Ptr
	Data As UByte Ptr
	fontstart As Integer
	
	numGlyphs As Integer
	
	As Integer loca,head,glyf,hhea,hmtx,kern,gpos
	index_map As Integer
	indexToLocFormat As Integer
	
	cff As stbtt__buf
	charstrings As stbtt__buf
	gsubrs As stbtt__buf
	subrs As stbtt__buf
	fontdicts As stbtt__buf
	fdselect As stbtt__buf
	
	IsMemoryFree As Integer					' 是否是内存载入的 [内存载入的字库不需要释放Data]
End Type



Extern "C"
	Declare Function stbtt_InitFont(info As stbtt_fontinfo Ptr, Data As Any Ptr, offset As Integer) As Integer
	Declare Function stbtt_GetFontOffsetForIndex(Data As Any Ptr, index As Integer) As Integer
	Declare Sub stbtt_MakeCodepointBitmap(info As stbtt_fontinfo Ptr, Output As UByte Ptr, out_w As Integer, out_h As Integer, out_stride As Integer, scale_x As Single, scale_y As Single, codepoint As Integer)
	Declare Function stbtt_ScaleForPixelHeight(info As stbtt_fontinfo Ptr, pixels As Single) As Single
	Declare Function stbtt_GetCodepointBitmap(info As stbtt_fontinfo Ptr, scale_x As Single, scale_y As Single, codepoint As Integer, w As Integer Ptr, h As Integer Ptr, x As Integer Ptr, y As Integer Ptr) As UByte Ptr
	Declare Sub stbtt_GetCodepointBitmapBox(info As stbtt_fontinfo Ptr, codepoint As Integer, scale_x As Single, scale_y As Single, x0 As Integer Ptr, y0 As Integer Ptr, x1 As Integer Ptr, y1 As Integer Ptr)
	Declare Function stbtt_GetCodepointBox(info As stbtt_fontinfo Ptr, codepoint As Integer, x0 As Integer Ptr, y0 As Integer Ptr, x1 As Integer Ptr, y1 As Integer Ptr) As Integer
	Declare Sub stbtt_GetCodepointHMetrics(info As stbtt_fontinfo Ptr, codepoint As Integer, advanceWidth As Integer Ptr, leftSideBearing As Integer Ptr)
	Declare Sub stbtt_FreeBitmap(bitmap As UByte Ptr, userdata As Any Ptr)
	Declare Sub stbtt_GetFontVMetrics(info As stbtt_fontinfo Ptr, ascent As Integer Ptr, descent As Integer Ptr, lineGap As Integer Ptr)
	Declare Sub stbtt_GetFontBoundingBox(info As stbtt_fontinfo Ptr, x0 As Integer Ptr, y0 As Integer Ptr, x1 As Integer Ptr, y1 As Integer Ptr)
End Extern



' 渲染单个文字
Sub xFont_DrawWord_ttf(fd As xge.FontDriver Ptr, sf As xge.Surface Ptr, px As Integer, py As Integer, w As Integer, h As Integer, iCode As UInteger, iColor As Integer, Style As Integer)
	Dim font As stbtt_fontinfo Ptr = fd->Font
	Dim As Integer ww, wh, wx, wy
	Dim word As UByte Ptr = stbtt_GetCodepointBitmap(font, 0, fd->FontSizeFloat, iCode, @ww, @wh, @wx, @wy)
	px += wx
	py += fd->TagFloat + wy
	Dim a As Integer
	iColor = iColor And &HFFFFFF
	For y As Integer = 0 To wh - 1
		For x As Integer = 0 To ww - 1
			a = word[y * ww + x]
			If a Then
				If sf Then
					PSet sf->img, (px + x, py + y), iColor Or a Shl 24
				Else
					PSet (px + x, py + y), iColor Or a Shl 24
				EndIf
			EndIf
		Next
	Next
	stbtt_FreeBitmap(word, NULL)
End Sub
Sub xFont_DrawWord_ttf_ansi(fd As xge.FontDriver Ptr, sf As xge.Surface Ptr, px As Integer, py As Integer, w As Integer, h As Integer, iCode As UInteger, iColor As Integer, Style As Integer)
	Dim s As WString Ptr
	If iCode < &H100 Then
		s = AsciToUnicode(Cast(ZString Ptr, @iCode), 1)
	Else
		Dim NewCode As UInteger = ((iCode And &HFF00) Shr 8) + ((iCode And &HFF) Shl 8)
		s = AsciToUnicode(Cast(ZString Ptr, @NewCode), 2)
	EndIf
	xFont_DrawWord_ttf(fd, sf, px, py, w, h, Cast(UShort Ptr, s)[0], iColor, Style)
	DeAllocate(s)
End Sub

' 获取单个文字的字符信息
Sub xFont_WordInfo_ttf(fd As xge.FontDriver Ptr, iCode As Integer, Style As Integer, w As Integer Ptr, h As Integer Ptr)
	Dim font As stbtt_fontinfo Ptr = fd->Font
	Dim As Integer advanceWidth
	stbtt_GetCodepointHMetrics(font, iCode, @advanceWidth, NULL)
	If w Then
		*w = advanceWidth * fd->FontSizeFloat
	EndIf
	If h Then
		*h = fd->FontSizeInt
	EndIf
End Sub
Sub xFont_WordInfo_ttf_ansi(fd As xge.FontDriver Ptr, iCode As Integer, Style As Integer, w As Integer Ptr, h As Integer Ptr)
	Dim s As WString Ptr
	If iCode < &H100 Then
		s = AsciToUnicode(Cast(ZString Ptr, @iCode), 1)
	Else
		Dim NewCode As UInteger = ((iCode And &HFF00) Shr 8) + ((iCode And &HFF) Shl 8)
		s = AsciToUnicode(Cast(ZString Ptr, @NewCode), 2)
	EndIf
	xFont_WordInfo_ttf(fd, Cast(UShort Ptr, s)[0], Style, w, h)
	DeAllocate(s)
End Sub



' ttf 字库清理
Sub xFree_ttf(fd As xge.FontDriver Ptr)
	Dim info As stbtt_fontinfo Ptr = fd->Font
	If info->IsMemoryFree Then
		DeAllocate(info->Data)
	EndIf
	DeAllocate(info)
End Sub



' ttf 设置字体大小
Sub SetFontSize_ttf(fd As xge.FontDriver Ptr, size As UInteger)
	Dim ascent As Integer
	stbtt_GetFontVMetrics(fd->Font, @ascent, 0, 0)
	fd->FontSizeInt   = size
	fd->HeightInt     = size
	fd->FontSizeFloat = stbtt_ScaleForPixelHeight(fd->Font, size)
	fd->TagFloat      = ascent * fd->FontSizeFloat		' 这里保存字体的基线
End Sub



' ttf 字库加载器
Function xLoad_ttf(fd As xge.FontDriver Ptr, Addr As WString Ptr, iSize As UInteger, param As Integer) As Integer
	Dim IsMemoryFree As Integer
	Dim Buff As WString Ptr
	If iSize Then
		' 从内存载入字库
		Buff = Addr
	Else
		' 从文件载入字库
		Dim iSize As UInteger = xFile_SizeW(Addr)
		If iSize = 0 Then
			Return 0
		EndIf
		IsMemoryFree = -1
		Buff = Allocate(iSize)
		xFile_ReadW(Addr, Buff, 0, iSize)
	EndIf
	' 开始加载字体
	Dim font As stbtt_fontinfo Ptr = Allocate(SizeOf(stbtt_fontinfo))
	If stbtt_InitFont(font, Buff, stbtt_GetFontOffsetForIndex(Buff, param)) = 0 Then
		DeAllocate(font)
		If IsMemoryFree Then
			DeAllocate(Buff)
		EndIf
		Return 0
	EndIf
	' 计算字体基线需要的数据
	Dim ascent As Integer
	stbtt_GetFontVMetrics(font, @ascent, 0, 0)
	' 填充字体驱动
	font->IsMemoryFree = IsMemoryFree
	fd->Font = font
	fd->FontSizeInt   = 36
	fd->HeightInt     = 36
	fd->FontSizeFloat = stbtt_ScaleForPixelHeight(font, 36)
	fd->TagFloat      = ascent * fd->FontSizeFloat		' 这里保存字体的基线
	fd->DrawWordW   = Cast(Any Ptr, @xFont_DrawWord_ttf)
	fd->DrawWordA   = Cast(Any Ptr, @xFont_DrawWord_ttf_ansi)
	fd->WordInfoW   = Cast(Any Ptr, @xFont_WordInfo_ttf)
	fd->WordInfoA   = Cast(Any Ptr, @xFont_WordInfo_ttf_ansi)
	fd->FreeFont    = Cast(Any Ptr, @xFree_ttf)
	fd->SetFontSize = Cast(Any Ptr, @SetFontSize_ttf)
	fd->DrawLineW_Fast = NULL	'Cast(Any Ptr, @DrawLine_Fast_ttf)
	fd->DrawLineA_Fast = NULL
	fd->DrawRectW_Fast = NULL	'Cast(Any Ptr, @DrawRect_Fast_ttf)
	fd->DrawRectA_Fast = NULL
	Return -1
End Function


