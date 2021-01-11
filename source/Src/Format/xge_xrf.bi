


#Define XRF_VER1_ANSI		&H01414658		' A、W 版本API通用
#Define XRF_VER1_UCS2		&H01554658		' 仅支持 W 版本API
#Define XRF_VER1_GB2312		&H01674658		' 仅支持 A 版本API
#Define XRF_VER1_GBK		&H01474658		' 仅支持 A 版本API



#Define XRF_FLAG_COMPRESS	1		' 压缩字库 [使用LZ4算法] [暂未实现]



Static Shared XRF_POINTS(32) As UInteger = {&H00000001, &H00000002, &H00000004, &H00000008, &H00000010, &H00000020, &H00000040, &H00000080, _
											&H00000100, &H00000200, &H00000400, &H00000800, &H00001000, &H00002000, &H00004000, &H00008000, _
											&H00010000, &H00020000, &H00040000, &H00080000, &H00100000, &H00200000, &H00400000, &H00800000, _
											&H01000000, &H02000000, &H04000000, &H08000000, &H10000000, &H20000000, &H40000000, &H80000000}



Type xywhRasterFont_Handle Field = 1
	Ver As UInteger							' 文件头部识别标识和版本信息
	AnsiWidth As UByte						' 最大32 [为了算法优化，点阵字库超过32以后文件太大，没意义]
	WordWidth As UByte						' 最大32 [为了算法优化，点阵字库超过32以后文件太大，没意义]
	WordHeight As UByte						' 最大32 [为了算法优化，点阵字库超过32以后文件太大，没意义]
	FontFlag As UByte						' 位标记
End Type



Type FontDriverInfo_xrf
	Data As xywhRasterFont_Handle Ptr		' 文件内存指针
	AscPtr As Any Ptr						' ASC字库数据指针
	UniPtr As Any Ptr						' GB字库数据指针
	ChrMemSize As UInteger					' 一个字符占用多少内存
	LineMemSize As UInteger					' 一行点阵占用多少内存
	IsMemoryFree As Integer					' 是否是内存载入的 [内存载入的字库不需要释放Data]
End Type



' 渲染单个文字 [ANSI]
Sub xFont_DrawWord_xrf_ansi(fd As xge.Text.FontDriver Ptr, sf As xge.Surface Ptr, px As Integer, py As Integer, w As Integer, h As Integer, iCode As UInteger, iColor As UInteger, Style As Integer)
	Dim info As FontDriverInfo_xrf Ptr = fd->Font
	Dim BW As Integer = info->LineMemSize
	If iCode < &H80 Then
		' ASCII字符
		If iCode >= 32 Then		' 避免某些字库特殊，这里 Space 也会尝试读取点阵数据
			Dim bm As Any Ptr = info->AscPtr + ((iCode - 32) * info->ChrMemSize)
			Dim As Integer x, y
			For y = 0 To info->Data->WordHeight - 1
				Dim tb As UInteger = *Cast(UInteger Ptr, bm)
				For x = 0 To info->Data->AnsiWidth - 1
					If tb And XRF_POINTS(x) Then
						If sf Then
							PSet sf->img, (px + x, py + y), iColor
						Else
							PSet (px + x, py + y), iColor
						EndIf
					EndIf
				Next
				bm += BW
			Next
		EndIf
		' 下划线
		If Style And XGE_FONT_UNDERLINE Then
			If sf Then
				Line sf->img, (px, py + fd->HeightInt + 1) - (px + fd->FontSizeInt, py + fd->HeightInt + 1), iColor
			Else
				Line (px, py + fd->HeightInt + 1) - (px + fd->WidthInt, py + fd->HeightInt + 1), iColor
			EndIf
		EndIf
	Else
		' 宽字符 [ANSI不渲染宽字符，避免因为寻址问题导致崩溃]
		
		' 下划线
		If Style And XGE_FONT_UNDERLINE Then
			If sf Then
				Line sf->img, (px, py + fd->HeightInt + 1) - (px + fd->WidthInt, py + fd->HeightInt + 1), iColor
			Else
				Line (px, py + fd->HeightInt + 1) - (px + fd->WidthInt, py + fd->HeightInt + 1), iColor
			EndIf
		EndIf
	EndIf
End Sub



' 渲染单个文字 [GB2312]
Sub xFont_DrawWord_xrf_gb2312(fd As xge.Text.FontDriver Ptr, sf As xge.Surface Ptr, px As Integer, py As Integer, w As Integer, h As Integer, iCode As UInteger, iColor As UInteger, Style As Integer)
	Dim info As FontDriverInfo_xrf Ptr = fd->Font
	Dim BW As Integer = info->LineMemSize
	If iCode < &H80 Then
		' ASCII字符
		If iCode >= 32 Then		' 避免某些字库特殊，这里 Space 也会尝试读取点阵数据
			Dim bm As Any Ptr = info->AscPtr + ((iCode - 32) * info->ChrMemSize)
			Dim As Integer x, y
			For y = 0 To info->Data->WordHeight - 1
				Dim tb As UInteger = *Cast(UInteger Ptr, bm)
				For x = 0 To info->Data->AnsiWidth - 1
					If tb And XRF_POINTS(x) Then
						If sf Then
							PSet sf->img, (px + x, py + y), iColor
						Else
							PSet (px + x, py + y), iColor
						EndIf
					EndIf
				Next
				bm += BW
			Next
		EndIf
		' 下划线
		If Style And XGE_FONT_UNDERLINE Then
			If sf Then
				Line sf->img, (px, py + fd->HeightInt + 1) - (px + fd->FontSizeInt, py + fd->HeightInt + 1), iColor
			Else
				Line (px, py + fd->HeightInt + 1) - (px + fd->WidthInt, py + fd->HeightInt + 1), iColor
			EndIf
		EndIf
	Else
		' 宽字符
		Dim HiCode As UByte = (iCode And &HFF00) Shr 8
		Dim LoCode As UByte = iCode And &HFF
		Dim bm As Any Ptr = info->UniPtr + (((HiCode - &HA1) * &H5E) + (LoCode - &HA1)) * info->ChrMemSize
		Dim As Integer x, y
		For y = 0 To info->Data->WordHeight - 1
			Dim tb As UInteger = *Cast(UInteger Ptr, bm)
			For x = 0 To info->Data->WordWidth - 1
				If tb And XRF_POINTS(x) Then
					If sf Then
						PSet sf->img, (px + x, py + y), iColor
					Else
						PSet (px + x, py + y), iColor
					EndIf
				EndIf
			Next
			bm += BW
		Next
		' 下划线
		If Style And XGE_FONT_UNDERLINE Then
			If sf Then
				Line sf->img, (px, py + fd->HeightInt + 1) - (px + fd->WidthInt, py + fd->HeightInt + 1), iColor
			Else
				Line (px, py + fd->HeightInt + 1) - (px + fd->WidthInt, py + fd->HeightInt + 1), iColor
			EndIf
		EndIf
	EndIf
End Sub
' 输入 UNICODE 编码字符，转码为 GB2312 后渲染
Sub xFont_DrawWord_xrf_gb2312_fromUcs2(fd As xge.Text.FontDriver Ptr, sf As xge.Surface Ptr, px As Integer, py As Integer, w As Integer, h As Integer, iCode As UInteger, iColor As UInteger, Style As Integer)
	Dim s As UByte Ptr = UnicodeToAsci(Cast(WString Ptr, @iCode), 1)
	If s[1] = 0 Then
		xFont_DrawWord_xrf_gb2312(fd, sf, px, py, w, h, s[0], iColor, Style)
	Else
		Dim NewCode As UInteger = (s[0] Shl 8) + s[1]
		xFont_DrawWord_xrf_gb2312(fd, sf, px, py, w, h, NewCode, iColor, Style)
	EndIf
	DeAllocate(s)
End Sub



' 渲染单个文字 [UNICODE]
Sub xFont_DrawWord_xrf_ucs2(fd As xge.Text.FontDriver Ptr, sf As xge.Surface Ptr, px As Integer, py As Integer, w As Integer, h As Integer, iCode As UInteger, iColor As UInteger, Style As Integer)
	Dim info As FontDriverInfo_xrf Ptr = fd->Font
	Dim BW As Integer = info->LineMemSize
	Dim bm As Any Ptr = info->AscPtr + (iCode * info->ChrMemSize)
	Dim ww As Integer = IIf(iCode < &H80, info->Data->AnsiWidth, info->Data->WordWidth)
	If iCode >= 32 Then
		Dim As Integer x, y
		For y = 0 To info->Data->WordHeight - 1
			Dim tb As UInteger = *Cast(UInteger Ptr, bm)
			For x = 0 To ww - 1
				If tb And XRF_POINTS(x) Then
					If sf Then
						PSet sf->img, (px + x, py + y), iColor
					Else
						PSet (px + x, py + y), iColor
					EndIf
				EndIf
			Next
			bm += BW
		Next
	EndIf
	' 下划线
	If Style And XGE_FONT_UNDERLINE Then
		If sf Then
			Line sf->img, (px, py + fd->HeightInt + 1) - (px + ww, py + fd->HeightInt + 1), iColor
		Else
			Line (px, py + fd->HeightInt + 1) - (px + fd->WidthInt, py + fd->HeightInt + 1), iColor
		EndIf
	EndIf
End Sub
' 输入 GB2312 编码字符，转码为 UNICODE 后渲染
Sub xFont_DrawWord_xrf_ucs2_fromAnsi(fd As xge.Text.FontDriver Ptr, sf As xge.Surface Ptr, px As Integer, py As Integer, w As Integer, h As Integer, iCode As UInteger, iColor As UInteger, Style As Integer)
	Dim s As WString Ptr
	If iCode < &H100 Then
		s = AsciToUnicode(Cast(ZString Ptr, @iCode), 1)
	Else
		Dim NewCode As UInteger = ((iCode And &HFF00) Shr 8) + ((iCode And &HFF) Shl 8)
		s = AsciToUnicode(Cast(ZString Ptr, @NewCode), 2)
	EndIf
	xFont_DrawWord_xrf_ucs2(fd, sf, px, py, w, h, Cast(UShort Ptr, s)[0], iColor, Style)
	DeAllocate(s)
End Sub



' 获取单个文字的字符信息
Sub xFont_WordInfo_xrf(fd As xge.Text.FontDriver Ptr, iCode As Integer, Style As Integer, w As Integer Ptr, h As Integer Ptr)
	If iCode < &H80 Then	' 暂时没有控制字符的处理功能，例如 制表符 之类的
		' ASCII字符
		If w Then
			*w = fd->FontSizeInt
		EndIf
		If h Then
			*h = fd->HeightInt
		EndIf
	Else
		' 宽字符
		If w Then
			*w = fd->WidthInt
		EndIf
		If h Then
			*h = fd->HeightInt
		EndIf
	EndIf
End Sub



' 渲染一行文字
Sub DrawLine_Fast_xrf(fd As xge.Text.FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, txt As ZString Ptr, iColor As Integer, Style As Integer, wd As Integer)
	
End Sub
Sub DrawLineA_Fast_xrf(fd As xge.Text.FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, txt As ZString Ptr, iColor As Integer, Style As Integer, wd As Integer)
	
End Sub

' 将文字渲染到一个矩形内
Sub DrawRect_Fast_xrf(fd As xge.Text.FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, w As Integer, h As Integer, txt As ZString Ptr, iColor As Integer, Style As Integer, align As Integer, wd As Integer, ld As Integer)
	
End Sub
Sub DrawRectA_Fast_xrf(fd As xge.Text.FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, w As Integer, h As Integer, txt As ZString Ptr, iColor As Integer, Style As Integer, align As Integer, wd As Integer, ld As Integer)
	
End Sub



' xrf 字库清理
Sub xFree_xrf(fd As xge.Text.FontDriver Ptr)
	Dim info As FontDriverInfo_xrf Ptr = fd->Font
	If info->IsMemoryFree Then
		DeAllocate(info->Data)
	EndIf
	DeAllocate(info)
End Sub

' xrf 字库加载器
Function xLoad_xrf(fd As xge.Text.FontDriver Ptr, Addr As ZString Ptr, iSize As UInteger, param As Any Ptr) As Integer
	Dim info As FontDriverInfo_xrf Ptr = Allocate(SizeOf(FontDriverInfo_xrf))
	If iSize Then
		' 从内存载入字库
		info->Data = Cast(Any Ptr, Addr)
	Else
		' 从文件载入字库
		iSize = xFile.Size(Addr)
		If iSize = 0 Then
			DeAllocate(info)
			Return 0
		EndIf
		info->IsMemoryFree = -1
		info->Data = Allocate(iSize)
		xFile.Read(Addr, info->Data, 0, SizeOf(xywhRasterFont_Handle))
	EndIf
	' 计算一个字符占用多少字节的内存
	info->LineMemSize = (info->Data->WordWidth + 7) \ 8
	info->ChrMemSize = info->LineMemSize * info->Data->WordHeight
	' 检验文件头
	Select Case info->Data->Ver
		Case XRF_VER1_ANSI
			' ANSI 字库
			info->AscPtr = Cast(Any Ptr, info->Data) + SizeOf(xywhRasterFont_Handle)
			info->UniPtr = NULL
			fd->DrawWord = Cast(Any Ptr, @xFont_DrawWord_xrf_ansi)
			fd->DrawWordA = Cast(Any Ptr, @xFont_DrawWord_xrf_ansi)
		Case XRF_VER1_UCS2
			' UNICODE 字库
			info->AscPtr = Cast(Any Ptr, info->Data) + SizeOf(xywhRasterFont_Handle)
			info->UniPtr = Cast(Any Ptr, info->Data) + SizeOf(xywhRasterFont_Handle)
			fd->DrawWord = Cast(Any Ptr, @xFont_DrawWord_xrf_ucs2)
			fd->DrawWordA = Cast(Any Ptr, @xFont_DrawWord_xrf_ucs2_fromAnsi)
		Case XRF_VER1_GB2312
			' GB2312 字库
			info->AscPtr = Cast(Any Ptr, info->Data) + SizeOf(xywhRasterFont_Handle)
			info->UniPtr = info->AscPtr + (info->ChrMemSize * 96)
			fd->DrawWord = Cast(Any Ptr, @xFont_DrawWord_xrf_gb2312_fromUcs2)
			fd->DrawWordA = Cast(Any Ptr, @xFont_DrawWord_xrf_gb2312)
		Case Else
			' 无法识别的文件头
			DeAllocate(info)
			If info->IsMemoryFree Then
				DeAllocate(info->Data)
			EndIf
			Return 0
	End Select
	' 如果是从文件加载的，则读入全部内容 [一开始只读文件头]
	If info->IsMemoryFree Then
		xFile.Read(Addr, info->Data, 0, iSize)
	EndIf
	' 填充字体驱动
	fd->Font = info
	fd->WidthInt    = info->Data->WordWidth
	fd->HeightInt   = info->Data->WordHeight
	fd->FontSizeInt = info->Data->AnsiWidth
	fd->WordInfo    = Cast(Any Ptr, @xFont_WordInfo_xrf)
	fd->WordInfoA   = Cast(Any Ptr, @xFont_WordInfo_xrf)
	fd->FreeFont    = Cast(Any Ptr, @xFree_xrf)
	fd->SetFontSize = NULL
	fd->DrawLine_Fast  = NULL	'Cast(Any Ptr, @DrawLine_Fast_xrf)
	fd->DrawLineA_Fast = NULL
	fd->DrawRect_Fast  = NULL	'Cast(Any Ptr, @DrawRect_Fast_xrf)
	fd->DrawRectA_Fast = NULL
	Return -1
End Function


