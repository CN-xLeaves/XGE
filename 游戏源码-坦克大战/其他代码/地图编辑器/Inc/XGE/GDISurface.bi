
#Include Once "Win\ole2.bi"
#Inclib "LoadImage"
Declare Function BitmapFromFile Alias "BitmapFromFile" (ByVal FileName As ZString Ptr) As HBITMAP
Declare Function BitmapFromMemory Alias "BitmapFromMemory" (ByVal Buffer As Any Ptr,ByVal BufferSize As Integer) As HBITMAP
Declare Function BitmapFromResource Alias "BitmapFromResource" (ByVal ModHdr As HANDLE,ByVal NameStr As ZString Ptr) As HBITMAP



Function ConveColor(TheColor As UInteger) As UInteger
	TheColor = TheColor And &HFFFFFF
	If xywh_library_2dge_bpp=32 Then		' 32位转换一下像素位格式
		Dim FCor As UInteger
		Asm
			mov eax,[TheColor]
			And eax,0xFFFFFF
			mov [FCOR],eax
			bswap eax
			ror eax,8
			mov [TheColor],eax
		End Asm
	EndIf
	Return TheColor
End Function

Function XGE_GDI_Render(SurPix As UInteger,DesPix As UInteger,Param As Any Ptr) As UInteger
	If SurPix=MASK_COLOR Then
		Return DesPix
	Else
		Dim FCor As UInteger
		Asm
			mov eax,[SurPix]
			And eax,0xFFFFFF
			mov [FCOR],eax
			bswap eax
			ror eax,8
			mov [SurPix],eax
		End Asm
		Return SurPix
	EndIf
End Function



Type XGE_GDISurface
	DC As HDC
	BMP As HBITMAP
	ThePtr As Any Ptr
	'img As Surface
	
	sw As Integer
	sh As Integer
	
	Declare Constructor(w As Integer,h As Integer)
	Declare Destructor()
	
	Declare Sub Create(w As Integer,h As Integer)
	Declare Sub Destroy()
	'Declare Sub CreateSurface()
	'Declare Sub DestroySurface()
	Declare Sub Draw(sf As Surface,px As Integer,py As Integer,x As Integer,y As Integer,w As Integer,h As Integer,ConveColor As Integer=-1)
End Type



Constructor XGE_GDISurface(w As Integer,h As Integer)
	Create(w,h)
End Constructor

Destructor XGE_GDISurface()
	Destroy()
End Destructor

Sub XGE_GDISurface.Create(w As Integer,h As Integer)
	Dim MYBMPINFO As BITMAPINFO
	With MYBMPINFO.bmiheader
		.biSize = SizeOf(BITMAPINFOHEADER)
		.biWidth = w
		.biHeight = -(h+1)
		.biPlanes = 1
		.biBitCount = 32
		.biCompression = BI_RGB
	End With
	Dim DSKWND As HWND = GetDesktopWindow()
	Dim DSKDC As HDC = GetDC(DSKWND)
	DC = CreateCompatibleDC(DSKDC)
	BMP = CreateDIBSection(DC,@MYBMPINFO,DIB_RGB_COLORS,@ThePtr,NULL,NULL)
	SelectObject(DC,BMP)
	ReleaseDC(DSKWND,DSKDC)
	sw = w:sh = h
End Sub

Sub XGE_GDISurface.Destroy()
	DeleteDC(DC)
	DeleteObject(BMP)
End Sub

Sub XGE_GDISurface.Draw(sf As Surface,px As Integer,py As Integer,x As Integer,y As Integer,w As Integer,h As Integer,ConveColor As Integer=-1)
	Dim As Surface sf1,sf2
	' 填充 Surface 数据结构
	sf1 = THEPTR+(sw*4)-SizeOf(IMAGE)
	sf1->tpe = 7
	sf1->bpp = 4
	sf1->width = sw
	sf1->height = sh
	sf1->pitch = sw*4
	' 画出
	If xywh_library_2dge_bpp = 32 Then
		If ConveColor Then
			Put sf,(px,py),sf1,(x,y)-(w,h),Custom,@XGE_GDI_Render
		Else
			Put sf,(px,py),sf1,(x,y)-(w,h),Trans
		EndIf
	ElseIf xywh_library_2dge_bpp = 16 Then
		sf2 = ImageCreate(w,h,,xywh_library_2dge_bpp)
		Dim As Integer i,NewPX,OldPX
		Dim As Byte Ptr NewPD,OldPD
		ImageInfo(sf1,,,,OldPX,OldPD)
		ImageInfo(sf2,,,,NewPX,NewPD)
		For i = 0 To h-1
			ImageConvertRow(@OldPD[i*OldPX],32,@NewPD[i*NewPX],16,w)
		Next
		If ConveColor Then
			Put sf,(px,py),sf2,(x,y)-(w,h),Custom,@XGE_GDI_Render
		Else
			Put sf,(px,py),sf2,(x,y)-(w,h),Trans
		EndIf
		ImageDestroy(sf2)
	EndIf
End Sub
