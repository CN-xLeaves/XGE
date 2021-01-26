'==================================================================================
	'★ xywh Game Engine 图像载入模块 [xgi格式]
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



' xgi 文件头
Type xywhGameImage_Head Field = 1
	MagicNumber As UShort		' xi = &H6978
	ver As UByte				' 1
	flag As UByte
	w As UShort
	h As UShort
	DataSize As UInteger
End Type



' 文件头魔法数字
#Define XGI_HEAD_MAGIC		&H6978

' lz4 压缩级别
#Define XGI_LZ4_LEVEL		7



Function xLoad_xgi_mem(img As xge.Surface Ptr, xgih As xywhGameImage_Head Ptr, dat As Any Ptr) As Integer
	img->Create(xgih->w, xgih->h)
	If img->img Then
		Dim BitmapData As Any Ptr = dat
		Dim BitmapSize As UInteger = xgih->DataSize
		Dim IsDeAlloca As Integer = FALSE
		' 还原 LZ4 压缩
		If xgih->flag And XGI_FLAG_LZ4 Then
			Dim DstLen As UInteger = img->PixSize
			Dim DstMem As Any Ptr
			If xgih->flag And Not(XGI_FLAG_LZ4) Then		' 性能优化 [没有其他算法的情况下直接写到PixAddr里]
				DstMem = Allocate(DstLen)
			Else
				DstMem = img->PixAddr
			EndIf
			Dim OutLen As UInteger = LZ4_decompress_safe(BitmapData, DstMem, BitmapSize, DstLen)
			If OutLen > 0 Then
				' 解压成功
				If xgih->flag And Not(XGI_FLAG_LZ4) Then
					BitmapData = DstMem
					BitmapSize = OutLen
					IsDeAlloca = TRUE
				Else
					Return TRUE								' 性能优化 [不需要额外的memcpy，直接返回]
				EndIf
			Else
				' 解压失败
				DeAllocate(DstMem)
				Return FALSE
			EndIf
		EndIf
		' 还原到 32 位图像
		If xgih->flag And XGI_FLAG_B16 Then
			Dim DstLen As UInteger = BitmapSize * 2
			Dim DstMem As UInteger Ptr = img->PixAddr
			' 像素转换
			Dim As Integer tColor, r, g, b
			For i As Integer = 0 To (xgih->w * xgih->h) - 1
				tColor = Cast(Short Ptr, BitmapData)[i]
				b = ((tColor Shl 3) Or &H7) And &HFF
				g = (tColor Shl 5) And &HFF00
				r = ((tColor Shl 8) Or &H70000) And &HFF0000
				DstMem[i] = (&HFF000000 Or g Or b Or r)
			Next
			If IsDeAlloca Then
				DeAllocate(BitmapData)
			EndIf
			Return TRUE
		Else
			' 拷贝数据
			memcpy(img->PixAddr, BitmapData, BitmapSize)
			If IsDeAlloca Then
				DeAllocate(BitmapData)
			EndIf
			Return TRUE
		EndIf
	EndIf
End Function

' 检查文件头是否合法
Function xLoad_xgi_check(xgih As xywhGameImage_Head Ptr) As Integer
	If xgih->MagicNumber = XGI_HEAD_MAGIC Then
		If xgih->ver = 1 Then
			If (xgih->w > 0) And (xgih->h > 0) Then
				If xgih->DataSize > 0 Then
					Return TRUE
				EndIf
			EndIf
		EndIf
	EndIf
End Function



' 加载 xgi 图像
Function xLoad_xgi(img As xge.Surface Ptr, addr As WString Ptr, size As UInteger) As Integer
	If size Then
		' 从内存载入图像
		size -= SizeOf(xywhGameImage_Head)
		If size > 0 Then
			Dim xgih As xywhGameImage_Head Ptr = Cast(Any Ptr, addr)
			If xLoad_xgi_check(xgih) Then
				' 避免内存越界
				xgih->DataSize = IIf(xgih->DataSize > size, size, xgih->DataSize)
				Return xLoad_xgi_mem(img, Cast(Any Ptr, addr), addr + SizeOf(xywhGameImage_Head))
			EndIf
		EndIf
	Else
		' 从文件载入图像
		Dim xgih As xywhGameImage_Head
		xFile_ReadW(addr, @xgih, 0, SizeOf(xywhGameImage_Head))
		If xLoad_xgi_check(@xgih) Then
			Dim img_data As Any Ptr = Allocate(xgih.DataSize)
			If img_data Then
				xFile_ReadW(addr, img_data, SizeOf(xywhGameImage_Head), xgih.DataSize)
				Dim RetInt As Integer = xLoad_xgi_mem(img, @xgih, img_data)
				DeAllocate(img_data)
				Return RetInt
			EndIf
		EndIf
	EndIf
End Function

' 保存 xgi 图像
Function xSave_xgi(img As xge.Surface Ptr, file As ZString Ptr, iscomp As Integer) As Integer
	' 填文件头
	Dim xgih As xywhGameImage_Head
	xgih.MagicNumber = XGI_HEAD_MAGIC
	xgih.ver = 1
	xgih.flag = iscomp
	xgih.w = img->Width
	xgih.h = img->Height
	' 准备数据
	Dim BitmapData As Any Ptr = img->PixAddr
	Dim BitmapSize As UInteger = img->PixSize
	Dim IsDeAlloca As Integer = FALSE
	If iscomp And XGI_FLAG_B16 Then
		' 存储为 16 位图像
		Dim DstLen As UInteger = BitmapSize \ 2
		Dim DstMem As Short Ptr = Allocate(DstLen)
		If DstMem Then
			' 转换成功
			Dim As Integer tColor, r, g, b
			For i As Integer = 0 To (xgih.w * xgih.h) - 1
				tColor = Cast(Integer Ptr, BitmapData)[i]
				b = (tColor Shr 3) And &H1f
				g = (tColor Shr (8+2)) And &H3f
				r = (tColor Shr (16+3)) And &H1f
				DstMem[i] = (r Shl 11) Or (g Shl 5) Or b
			Next
			BitmapData = DstMem
			BitmapSize = DstLen
			IsDeAlloca = TRUE
		Else
			' 转换失败
			xgih.flag = xgih.flag And Not(XGI_FLAG_B16)
		EndIf
	EndIf
	If iscomp And XGI_FLAG_LZ4 Then
		' 进行 LZ4 压缩
		Dim DstLen As UInteger = LZ4_compressBound(BitmapSize)
		Dim DstMem As Any Ptr = Allocate(DstLen)
		Dim OutLen As UInteger = LZ4_compress_HC(BitmapData, DstMem, BitmapSize, DstLen, XGI_LZ4_LEVEL)
		If (OutLen=0) Or (OutLen>BitmapSize) Then
			' 压缩失败或者压缩反而更大的情况
			xgih.flag = xgih.flag And Not(XGI_FLAG_LZ4)
			DeAllocate(DstMem)
		Else
			' 压缩成功
			If IsDeAlloca Then
				DeAllocate(BitmapData)
			EndIf
			BitmapData = DstMem
			BitmapSize = OutLen
			IsDeAlloca = TRUE
		EndIf
	EndIf
	' 写入文件
	xgih.DataSize = BitmapSize
	if xFile_WriteA(file, @xgih, 0, SizeOf(xywhGameImage_Head)) Then
		if xFile_WriteA(file, BitmapData, SizeOf(xywhGameImage_Head), BitmapSize) Then
			xFile_CutA(file, SizeOf(xywhGameImage_Head) + BitmapSize)
			If IsDeAlloca Then
				DeAllocate(BitmapData)
			EndIf
			Return TRUE
		EndIf
	EndIf
End Function