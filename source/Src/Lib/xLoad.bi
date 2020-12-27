'==================================================================================
	'★ xywh Game Engine 图像载入模块
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



#Inclib "stb_image"



Extern "Windows-MS"
	Declare Function stbi_load(filename As ZString Ptr, x As Integer Ptr, y As Integer Ptr, comp As Integer Ptr, req_comp As Integer) As Integer Ptr
	Declare Function stbi_load_from_memory(buffer As ZString Ptr, size As Integer, x As Integer Ptr, y As Integer Ptr, comp As Integer Ptr, req_comp As Integer) As Integer Ptr
	Declare Sub stbi_image_free(ubptr As Any Ptr)
End Extern



' xgi 文件头
Type xywhGameImage_Head Field = 1
	MagicNumber As UShort		' xi = &H6978
	ver As UByte				' 1
	flag As UByte
	w As UShort
	h As UShort
	DataSize As UInteger
End Type
#Define XGI_HEAD_MAGIC		&H6978
#Define XGI_FLAG_XE1		1
#Define XGI_FLAG_LZ4		2



Function xLoad_xgi_mem(img As xge.Surface Ptr, xgih As xywhGameImage_Head Ptr, dat As Any Ptr, size As UInteger) As Integer
	img->Create(xgih->w, xgih->h)
	If img->img Then
		If xgih->flag Then
			
		Else
			memcpy(img->PixAddr, dat, IIf(size > img->PixSize, img->PixSize, size))
			Return TRUE
		EndIf
	EndIf
End Function

Function xLoad_xgi_check(xgih As xywhGameImage_Head Ptr) As Integer
	If xgih->MagicNumber = XGI_HEAD_MAGIC Then
		If xgih->ver = 1 Then
			Return TRUE
		EndIf
	EndIf
End Function

Function xLoad_xgi(img As xge.Surface Ptr, addr As ZString Ptr, size As UInteger) As Integer
	If size Then
		If xLoad_xgi_check(Cast(Any Ptr, addr)) Then
			Return xLoad_xgi_mem(img, Cast(Any Ptr, addr), addr + SizeOf(xywhGameImage_Head), size - SizeOf(xywhGameImage_Head))
		EndIf
	Else
		Dim xgih As xywhGameImage_Head
		GetFile(addr, @xgih, 0, SizeOf(xgih))
		If xLoad_xgi_check(@xgih) Then
			Dim img_data As Any Ptr = Allocate(xgih.DataSize)
			If img_data Then
				GetFile(addr, img_data, SizeOf(xywhGameImage_Head), xgih.DataSize)
				Dim RetInt As Integer = xLoad_xgi_mem(img, @xgih, img_data, xgih.DataSize)
				DeAllocate(img_data)
				Return RetInt
			EndIf
		EndIf
	EndIf
End Function

Function xSave_xgi(img As xge.Surface Ptr, file As ZString Ptr, iscomp As Integer) As Integer
	Dim xgih As xywhGameImage_Head
	xgih.MagicNumber = XGI_HEAD_MAGIC
	xgih.ver = 1
	xgih.flag = IIf(iscomp, 1, 0)
	xgih.w = img->Width
	xgih.h = img->Height
	If iscomp Then
		
	Else
		xgih.DataSize = img->PixSize
		if PutFile(file, @xgih, 0, SizeOf(xgih)) Then
			Return PutFile(file, img->PixAddr, SizeOf(xgih), xgih.DataSize)
		EndIf
	EndIf
End Function

Function xLoad_stb(img As xge.Surface Ptr, addr As ZString Ptr, size As UInteger) As Integer
	Dim As Integer w, h, c
	Dim dat As Integer Ptr
	Dim dst As Integer Ptr
	' 载入数据
	If size Then
		' 从内存加载
		dat = stbi_load_from_memory(addr, size, @w, @h, @c, 4)
	Else
		' 从文件加载
		dat = stbi_load(addr, @w, @h, @c, 4)
	EndIf
	' 创建图像
	If dat Then
		img->Create(w, h)
		If img->img Then
			' 颜色转换
			dst = img->PixAddr
			For i As Integer = 0 To (w * h) - 1
				c = dat[i]
				Asm
					mov eax,[c]
					bswap eax
					ror eax,8
					mov [c],eax
				End Asm
				dst[i] = c
			Next
			stbi_image_free(dat)
			Return TRUE
		EndIf
		stbi_image_free(dat)
	EndIf
End Function
