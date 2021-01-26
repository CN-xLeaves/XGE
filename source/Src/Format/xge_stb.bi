'==================================================================================
	'★ xywh Game Engine 图像载入模块 [Stb库]
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





Function xLoad_stb(img As xge.Surface Ptr, addr As WString Ptr, size As UInteger) As Integer
	Dim As Integer w, h, c
	Dim src As Any Ptr
	' 载入数据
	If size Then
		' 从内存加载
		src = stbi_load_from_memory(Cast(Any Ptr, addr), size, @w, @h, @c, 4)
	Else
		' 从文件加载
		Dim st As ZString Ptr = UnicodeToAsci(addr)
		src = stbi_load(st, @w, @h, @c, 4)
		DeAllocate(st)
	EndIf
	' 创建图像
	If src Then
		img->Create(w, h)
		If img->img Then
			Dim dst As Any Ptr = img->PixAddr
			Dim SrcPitch As UInteger = w * 4
			Dim DstPitch As UInteger = img->Pitch()
			For y As Integer = 0 To h - 1
				Dim pSrcLine As Integer Ptr = src + (SrcPitch * y)
				Dim pDstLint As Integer Ptr = dst + (DstPitch * y)
				For x As Integer = 0 To w - 1
					Dim iColor As Integer = pSrcLine[x]
					Asm
						mov eax,[iColor]
						bswap eax
						ror eax, 8
						mov [iColor],eax
					End Asm
					pDstLint[x] = iColor
				Next
			Next
			stbi_image_free(src)
			Return TRUE
		EndIf
		stbi_image_free(src)
	EndIf
End Function
