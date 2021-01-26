'==================================================================================
	'★ xywh Game Engine Gdi图像模块
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



Extern XGE_EXTERNCLASS
	'#Ifdef XGE_BUILD_USEOOP
		Namespace xge
	'#EndIf
	
	
	
	' 加载 Gdi+ 图像
	Function xGdi_LoadImage(addr As WString Ptr, size As UInteger = 0) As Any Ptr
		Dim TempImg As GdiPlus.GpImage Ptr
		Dim RetGdiSta As Integer
		If size Then
			Dim TmpStream As IStream Ptr
			CreateStreamOnHGlobal(addr, FALSE, @TmpStream)
			RetGdiSta = GdiPlus.GdipLoadImageFromStream(TmpStream, @TempImg)
			If TmpStream Then
				TmpStream->lpVtbl->Release(TmpStream)
			EndIf
		Else
			RetGdiSta = GdiPlus.GdipLoadImageFromFile(addr, @TempImg)
		EndIf
		If RetGdiSta = GdiPlus.OK Then
			Return TempImg
		Else
			Return NULL
		EndIf
	End Function
	
	' 释放 Gdi+ 图像
	Sub xGdi_FreeImage(img As Any Ptr)
		GdiPlus.GdipDisposeImage(img)
	End Sub
	
	' 颜色处理
	Function GdiColorConv(c As UInteger) As UInteger
		If (c And &HFF000000) = 0 Then
			c Or= &HFF000000
		EndIf
		If (c And &HFF000000) = &HFF000000 Then
			c And= &HFEFFFFFF
		EndIf
		Return c
	End Function
	
	
	
	
	
	' 构造 [空]
	Constructor GdiSurface() XGE_EXPORT_OBJ
		
	End Constructor
	
	' 构造 [创建]
	Constructor GdiSurface(w As UInteger, h As UInteger) XGE_EXPORT_OBJ
		Create(w, h)
	End Constructor
	
	' 构造 [加载]
	Constructor GdiSurface(addr As ZString Ptr, size As UInteger = 0) XGE_EXPORT_OBJ
		Load(addr, size)
	End Constructor
	Constructor GdiSurface(addr As WString Ptr, size As UInteger = 0) XGE_EXPORT_OBJ
		Load(addr, size)
	End Constructor
	
	' 析构
	Destructor GdiSurface() XGE_EXPORT_OBJ
		Free()
	End Destructor
	
	' 创建图像
	Function GdiSurface.Create(w As UInteger, h As UInteger) As Integer XGE_EXPORT_OBJ
		Free()
		Dim BitMapInfo As BITMAPINFO
		BitMapInfo.bmiHeader.biSize = SizeOf(BITMAPINFOHEADER)
		BitMapInfo.bmiHeader.biWidth = w + 8
		BitMapInfo.bmiHeader.biHeight = -(h + 1)
		BitMapInfo.bmiHeader.biPlanes = 1
		BitMapInfo.bmiHeader.biBitCount = 32
		BitMapInfo.bmiHeader.biCompression = BI_RGB
		hDC = CreateCompatibleDC(NULL)
		hBitMap = CreateDIBSection(hDC, @BitMapInfo, DIB_RGB_COLORS, @BitMapAddr, NULL, 0)
		If hBitMap Then
			SelectObject(hDC, hBitMap)
			' 创建图像对应的 GDI+ 对象
			GdiPlus.GdipCreateFromHDC(hDC, @gfx)
			' 填充 Surface 内存数据
			img = BitMapAddr + ((w + 8) * 4) - SizeOf(FBGFX_IMAGE)
			img->tpe = 7
			img->bpp = 4
			img->Width = w
			img->Height = h
			img->pitch = (w + 8) * 4
			Return TRUE
		EndIf
	End Function
	
	' 载入图像
	Function GdiSurface.Load(addr As WString Ptr, size As UInteger = 0) As Integer XGE_EXPORT_OBJ
		Dim TempImg As GdiPlus.GpImage Ptr = xGdi_LoadImage(addr, size)
		If TempImg Then
			Dim w As Integer, h As Integer
			GdiPlus.GdipGetImageWidth(TempImg, @w)
			GdiPlus.GdipGetImageHeight(TempImg, @h)
			Create(w, h)
			GdiPlus.GdipDrawImageRect(gfx, TempImg, 0, 1, w, h)
			xGdi_FreeImage(TempImg)
			Return TRUE
		EndIf
	End Function
	Function GdiSurface.Load(addr As ZString Ptr, size As UInteger = 0) As Integer XGE_EXPORT_OBJ
		If size Then
			Return Load(Cast(WString Ptr, addr), size)
		Else
			Dim sf As WString Ptr = AsciToUnicode(addr, 0)
			Function = Load(sf, size)
			DeAllocate(sf)
		EndIf
	End Function
	
	' 释放图像
	Sub GdiSurface.Free() XGE_EXPORT_OBJ
		If hDC Then
			DeleteDC(hDC)
			hDC = NULL
		EndIf
		If hBitMap Then
			DeleteObject(hBitMap)
			hBitMap = NULL
		EndIf
		If gfx Then
			GdiPlus.GdipDeleteGraphics(gfx)
			gfx = NULL
		EndIf
		BitMapAddr = NULL
		img = NULL
	End Sub
	
	
	
	' 画线
	Sub GdiSurface.PrintLine(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As UInteger) XGE_EXPORT_OBJ
		' 检查透明通道
		c = GdiColorConv(c)
		' 开始绘制
		Dim Pen As GdiPlus.GpPen Ptr
		GdiPlus.GdipCreatePen1(c, 1, GdiPlus.UnitPixel, @Pen)
		GdiPlus.GdipDrawLineI(gfx, Pen, x1, y1, x2, y2)
		GdiPlus.GdipDeletePen(Pen)
	End Sub
	
	' 画矩形
	Sub GdiSurface.PrintRect(x As Integer, y As Integer, w As Integer, h As Integer, c As UInteger) XGE_EXPORT_OBJ
		' 检查透明通道
		c = GdiColorConv(c)
		' 开始绘制
		Dim Pen As GdiPlus.GpPen Ptr
		GdiPlus.GdipCreatePen1(c, 1, GdiPlus.UnitPixel, @Pen)
		GdiPlus.GdipDrawRectangleI(gfx, Pen, x, y, w, h)
		GdiPlus.GdipDeletePen(Pen)
	End Sub
	
	' 画填充矩形
	Sub GdiSurface.PrintRectFull(x As Integer, y As Integer, w As Integer, h As Integer, c As UInteger) XGE_EXPORT_OBJ
		' 检查透明通道
		c = GdiColorConv(c)
		' 开始绘制
		Dim Brush As GdiPlus.GpBrush Ptr
		GdiPlus.GdipCreateSolidFill(c, Cast(GdiPlus.GpSolidFill Ptr Ptr, @Brush))
		GdiPlus.GdipFillRectangleI(gfx, Brush, x, y, w, h)
		GdiPlus.GdipDeleteBrush(Brush)
	End Sub
	
	' 画圆形
	Sub GdiSurface.PrintCirc(x As Integer, y As Integer, w As Integer, h As Integer, c As UInteger) XGE_EXPORT_OBJ
		' 检查透明通道
		c = GdiColorConv(c)
		' 开始绘制
		Dim Pen As GdiPlus.GpPen Ptr
		GdiPlus.GdipCreatePen1(c, 1, GdiPlus.UnitPixel, @Pen)
		GdiPlus.GdipDrawEllipseI(gfx, Pen, x, y, w, h)
		GdiPlus.GdipDeletePen(Pen)
	End Sub
	
	' 画填充圆形
	Sub GdiSurface.PrintCircFull(x As Integer, y As Integer, w As Integer, h As Integer, c As UInteger) XGE_EXPORT_OBJ
		' 检查透明通道
		c = GdiColorConv(c)
		' 开始绘制
		Dim Brush As GdiPlus.GpBrush Ptr
		GdiPlus.GdipCreateSolidFill(c, Cast(GdiPlus.GpSolidFill Ptr Ptr, @Brush))
		GdiPlus.GdipFillEllipseI(gfx, Brush, x, y, w, h)
		GdiPlus.GdipDeleteBrush(Brush)
	End Sub
	
	' 写字
	Sub GdiSurface.PrintText(x As Integer, y As Integer, w As Integer, h As Integer, f As WString Ptr, px As Integer, flag As Integer, c As UInteger, txt As WString Ptr) XGE_EXPORT_OBJ
		' 检查透明通道
		c = GdiColorConv(c)
		' 创建画笔
		Dim Brush As GdiPlus.GpBrush Ptr
		GdiPlus.GdipCreateSolidFill(c, Cast(GdiPlus.GpSolidFill Ptr Ptr, @Brush))
		' 创建字体
		Dim FontFamily As GdiPlus.GpFontFamily Ptr
		GdiPlus.GdipCreateFontFamilyFromName(f, 0, @FontFamily)
		' 设置风格
		Dim StrFormat As GdiPlus.GpStringFormat Ptr
		GdiPlus.GdipCreateStringFormat(0, 0, @StrFormat)
		GdiPlus.GdipSetStringFormatAlign(StrFormat, flag And &H3)
		GdiPlus.GdipSetStringFormatLineAlign(StrFormat, (flag And &HC) Shr 2)
		Dim Font As GdiPlus.GpFont Ptr
		GdiPlus.GdipCreateFont(FontFamily, px, (flag And &HF0) Shr 4, GdiPlus.UnitPixel, @Font)
		' 写字
		Dim layout As GdiPlus.GpRectF = GdiPlus.GpRectF(x, y, w, h)
		GdiPlus.GdipDrawString(gfx, txt, -1, Font, @layout, StrFormat, Brush)
		' 释放资源
		GdiPlus.GdipDeleteBrush(Brush)
		GdiPlus.GdipDeleteFontFamily(FontFamily)
		GdiPlus.GdipDeleteStringFormat(StrFormat)
		GdiPlus.GdipDeleteFont(Font)
	End Sub
	Sub GdiSurface.PrintText(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, c As UInteger, txt As ZString Ptr) XGE_EXPORT_OBJ
		Dim st1 As WString Ptr = AsciToUnicode(f)
		Dim st2 As WString Ptr = AsciToUnicode(txt)
		PrintText(x, y, w, h, st1, px, flag, c, st2)
		DeAllocate(st1)
		DeAllocate(st2)
	End Sub
	
	' 写字 [镂空]
	Sub GdiSurface.PrintText(x As Integer, y As Integer, w As Integer, h As Integer, f As WString Ptr, px As Integer, flag As Integer, c As UInteger, weight As Integer, txt As WString Ptr) XGE_EXPORT_OBJ
		' 检查透明通道
		c = GdiColorConv(c)
		' 创建画笔
		Dim Pen As GdiPlus.GpPen Ptr
		GdiPlus.GdipCreatePen1(c, weight, GdiPlus.UnitPixel, @Pen)
		' 创建路径
		Dim strPath As GdiPlus.GpPath Ptr
		GdiPlus.GdipCreatePath(GdiPlus.FillModeAlternate, @strPath)
		' 创建字体
		Dim FontFamily As GdiPlus.GpFontFamily Ptr
		GdiPlus.GdipCreateFontFamilyFromName(f, 0, @FontFamily)
		' 设置风格
		Dim StrFormat As GdiPlus.GpStringFormat Ptr
		GdiPlus.GdipCreateStringFormat(0, 0, @StrFormat)
		GdiPlus.GdipSetStringFormatAlign(StrFormat, flag And &H3)
		GdiPlus.GdipSetStringFormatLineAlign(StrFormat, (flag And &HC) Shr 2)
		' 写字
		Dim layout As GdiPlus.GpRectF = GdiPlus.GpRectF(x, y, w, h)
		GdiPlus.GdipAddPathString(strPath, txt, -1, FontFamily, (flag And &HF0) Shr 4, px, @layout, strFormat)
		GdiPlus.GdipDrawPath(gfx, Pen, strPath)
		' 释放资源
		GdiPlus.GdipDeletePen(Pen)
		GdiPlus.GdipDeletePath(strPath)
		GdiPlus.GdipDeleteFontFamily(FontFamily)
		GdiPlus.GdipDeleteStringFormat(StrFormat)
	End Sub
	Sub GdiSurface.PrintText(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, c As UInteger, weight As Integer, txt As ZString Ptr) XGE_EXPORT_OBJ
		Dim st1 As WString Ptr = AsciToUnicode(f)
		Dim st2 As WString Ptr = AsciToUnicode(txt)
		PrintText(x, y, w, h, st1, px, flag, c, weight, st2)
		DeAllocate(st1)
		DeAllocate(st2)
	End Sub
	
	' 写字 [填充]
	Sub GdiSurface.PrintText(x As Integer, y As Integer, w As Integer, h As Integer, f As WString Ptr, px As Integer, flag As Integer, c1 As UInteger, c2 As UInteger, weight As Integer, txt As WString Ptr) XGE_EXPORT_OBJ
		' 检查透明通道
		c1 = GdiColorConv(c1)
		c2 = GdiColorConv(c2)
		' 开始绘制
		' 创建画笔
		Dim Pen As GdiPlus.GpPen Ptr
		GdiPlus.GdipCreatePen1(c1, weight, GdiPlus.UnitPixel, @Pen)
		Dim Brush As GdiPlus.GpBrush Ptr
		GdiPlus.GdipCreateSolidFill(c2, Cast(GdiPlus.GpSolidFill Ptr Ptr, @Brush))
		' 创建路径
		Dim strPath As GdiPlus.GpPath Ptr
		GdiPlus.GdipCreatePath(GdiPlus.FillModeAlternate, @strPath)
		' 创建字体
		Dim FontFamily As GdiPlus.GpFontFamily Ptr
		GdiPlus.GdipCreateFontFamilyFromName(f, 0, @FontFamily)
		' 设置风格
		Dim StrFormat As GdiPlus.GpStringFormat Ptr
		GdiPlus.GdipCreateStringFormat(0, 0, @StrFormat)
		GdiPlus.GdipSetStringFormatAlign(StrFormat, flag And &H3)
		GdiPlus.GdipSetStringFormatLineAlign(StrFormat, (flag And &HC) Shr 2)
		' 写字
		Dim layout As GdiPlus.GpRectF = GdiPlus.GpRectF(x, y, w, h)
		GdiPlus.GdipAddPathString(strPath, txt, -1, FontFamily, (flag And &HF0) Shr 4, px, @layout, strFormat)
		GdiPlus.GdipFillPath(gfx, Brush, strPath)
		GdiPlus.GdipDrawPath(gfx, Pen, strPath)
		' 释放资源
		GdiPlus.GdipDeletePen(Pen)
		GdiPlus.GdipDeleteBrush(Brush)
		GdiPlus.GdipDeletePath(strPath)
		GdiPlus.GdipDeleteFontFamily(FontFamily)
		GdiPlus.GdipDeleteStringFormat(StrFormat)
	End Sub
	Sub GdiSurface.PrintText(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, c1 As UInteger, c2 As UInteger, weight As Integer, txt As ZString Ptr) XGE_EXPORT_OBJ
		Dim st1 As WString Ptr = AsciToUnicode(f)
		Dim st2 As WString Ptr = AsciToUnicode(txt)
		PrintText(x, y, w, h, st1, px, flag, c1, c2, weight, st2)
		DeAllocate(st1)
		DeAllocate(st2)
	End Sub
	
	' 写字 [图像画刷]
	Sub GdiSurface.PrintText(x As Integer, y As Integer, w As Integer, h As Integer, f As WString Ptr, px As Integer, flag As Integer, addr As WString Ptr, size As Integer, txt As WString Ptr) XGE_EXPORT_OBJ
		' 创建画笔
		Dim TempImg As GdiPlus.GpImage Ptr = xGdi_LoadImage(addr, size)
		If TempImg Then
			Dim Brush As GdiPlus.GpBrush Ptr
			GdiPlus.GdipCreateTexture(TempImg, GdiPlus.WrapModeTileFlipX, Cast(GdiPlus.GpTexture Ptr Ptr, @Brush))
			' 创建路径
			Dim strPath As GdiPlus.GpPath Ptr
			GdiPlus.GdipCreatePath(GdiPlus.FillModeAlternate, @strPath)
			' 创建字体
			Dim FontFamily As GdiPlus.GpFontFamily Ptr
			GdiPlus.GdipCreateFontFamilyFromName(f, 0, @FontFamily)
			' 设置风格
			Dim StrFormat As GdiPlus.GpStringFormat Ptr
			GdiPlus.GdipCreateStringFormat(0, 0, @StrFormat)
			GdiPlus.GdipSetStringFormatAlign(StrFormat, flag And &H3)
			GdiPlus.GdipSetStringFormatLineAlign(StrFormat, (flag And &HC) Shr 2)
			' 写字
			Dim layout As GdiPlus.GpRectF = GdiPlus.GpRectF(x, y, w, h)
			GdiPlus.GdipAddPathString(strPath, txt, -1, FontFamily, (flag And &HF0) Shr 4, px, @layout, strFormat)
			GdiPlus.GdipFillPath(gfx, Brush, strPath)
			' 释放资源
			xGdi_FreeImage(TempImg)
			GdiPlus.GdipDeleteBrush(Brush)
			GdiPlus.GdipDeletePath(strPath)
			GdiPlus.GdipDeleteFontFamily(FontFamily)
			GdiPlus.GdipDeleteStringFormat(StrFormat)
		EndIf
	End Sub
	Sub GdiSurface.PrintText(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, addr As ZString Ptr, size As Integer, txt As ZString Ptr) XGE_EXPORT_OBJ
		Dim st1 As WString Ptr = AsciToUnicode(f)
		Dim st2 As WString Ptr = AsciToUnicode(txt)
		Dim st3 As WString Ptr = AsciToUnicode(addr)
		PrintText(x, y, w, h, st1, px, flag, st3, size, st2)
		DeAllocate(st1)
		DeAllocate(st2)
		DeAllocate(st3)
	End Sub
	
	' 贴图
	Sub GdiSurface.PrintImageDpi(x As Integer, y As Integer, addr As WString Ptr, size As Integer = 0) XGE_EXPORT_OBJ
		Dim TempImg As GdiPlus.GpImage Ptr = xGdi_LoadImage(addr, size)
		If TempImg Then
			GdiPlus.GdipDrawImage(gfx, TempImg, x, y)
			xGdi_FreeImage(TempImg)
		EndIf
	End Sub
	Sub GdiSurface.PrintImageDpi(x As Integer, y As Integer, addr As ZString Ptr, size As Integer = 0) XGE_EXPORT_OBJ
		If size Then
			PrintImageDpi(x, y, Cast(WString Ptr, addr), size)
		Else
			Dim st As WString Ptr = AsciToUnicode(addr)
			PrintImageDpi(x, y, st, size)
			DeAllocate(st)
		EndIf
	End Sub
	
	' 贴图 [避免DPI问题]
	Sub GdiSurface.PrintImage(x As Integer, y As Integer, addr As WString Ptr, size As Integer = 0) XGE_EXPORT_OBJ
		Dim TempImg As GdiPlus.GpImage Ptr = xGdi_LoadImage(addr, size)
		If TempImg Then
			Dim w As Integer, h As Integer
			GdiPlus.GdipGetImageWidth(TempImg, @w)
			GdiPlus.GdipGetImageHeight(TempImg, @h)
			GdiPlus.GdipDrawImageRectI(gfx, TempImg, x, y, w, h)
			xGdi_FreeImage(TempImg)
		EndIf
	End Sub
	Sub GdiSurface.PrintImage(x As Integer, y As Integer, addr As ZString Ptr, size As Integer = 0) XGE_EXPORT_OBJ
		If size Then
			PrintImage(x, y, Cast(WString Ptr, addr), size)
		Else
			Dim st As WString Ptr = AsciToUnicode(addr)
			PrintImage(x, y, st, size)
			DeAllocate(st)
		EndIf
	End Sub
	
	' 贴图 [支持缩放]
	Sub GdiSurface.PrintImageZoom(x As Integer, y As Integer, w As Integer, h As Integer, addr As WString Ptr, size As Integer = 0) XGE_EXPORT_OBJ
		Dim TempImg As GdiPlus.GpImage Ptr = xGdi_LoadImage(addr, size)
		If TempImg Then
			GdiPlus.GdipDrawImageRectI(gfx, TempImg, x, y, w, h)
			xGdi_FreeImage(TempImg)
		EndIf
	End Sub
	Sub GdiSurface.PrintImageZoom(x As Integer, y As Integer, w As Integer, h As Integer, addr As ZString Ptr, size As Integer = 0) XGE_EXPORT_OBJ
		If size Then
			PrintImageZoom(x, y, w, h, Cast(WString Ptr, addr), size)
		Else
			Dim st As WString Ptr = AsciToUnicode(addr)
			PrintImageZoom(x, y, w, h, st, size)
			DeAllocate(st)
		EndIf
	End Sub
	
	' 贴图 [支持裁剪和缩放]
	Sub GdiSurface.PrintImageEx(x As Integer, y As Integer, w As Integer, h As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, addr As WString Ptr, size As Integer = 0) XGE_EXPORT_OBJ
		Dim TempImg As GdiPlus.GpImage Ptr = xGdi_LoadImage(addr, size)
		If TempImg Then
			GdiPlus.GdipDrawImageRectRect(gfx, TempImg, x, y, w, h, cx, cy, cw, ch, GdiPlus.UnitPixel, 0, 0, 0)
			xGdi_FreeImage(TempImg)
		EndIf
	End Sub
	Sub GdiSurface.PrintImageEx(x As Integer, y As Integer, w As Integer, h As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, addr As ZString Ptr, size As Integer = 0) XGE_EXPORT_OBJ
		If size Then
			PrintImageEx(x, y, w, h, cx, cy, cw, ch, Cast(WString Ptr, addr), size)
		Else
			Dim st As WString Ptr = AsciToUnicode(addr)
			PrintImageEx(x, y, w, h, cx, cy, cw, ch, st, size)
			DeAllocate(st)
		EndIf
	End Sub
	
	' 贴图 [平铺填满区域]
	Sub GdiSurface.PrintImageFull(x As Integer, y As Integer, w As Integer, h As Integer, addr As WString Ptr, size As Integer = 0) XGE_EXPORT_OBJ
		Dim TempImg As GdiPlus.GpImage Ptr = xGdi_LoadImage(addr, size)
		If TempImg Then
			Dim Brush As GdiPlus.GpBrush Ptr
			GdiPlus.GdipCreateTexture(TempImg, GdiPlus.WrapModeTileFlipX, Cast(GdiPlus.GpTexture Ptr Ptr, @Brush))
			GdiPlus.GdipFillRectangle(gfx, Brush, x, y, w, h)
			GdiPlus.GdipDeleteBrush(Brush)
			xGdi_FreeImage(TempImg)
		EndIf
	End Sub
	Sub GdiSurface.PrintImageFull(x As Integer, y As Integer, w As Integer, h As Integer, addr As ZString Ptr, size As Integer = 0) XGE_EXPORT_OBJ
		If size Then
			PrintImageFull(x, y, w, h, Cast(WString Ptr, addr), size)
		Else
			Dim st As WString Ptr = AsciToUnicode(addr)
			PrintImageFull(x, y, w, h, st, size)
			DeAllocate(st)
		EndIf
	End Sub
	
	
	'#Ifdef XGE_BUILD_USEOOP
		End Namespace
	'#EndIf
End Extern
