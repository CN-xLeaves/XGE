'==================================================================================
	'�� xywh Game Engine ͼ����ģ��
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================



Extern XGE_EXTERNCLASS
	'#Ifdef XGE_BUILD_USEOOP
		Namespace xge
	'#EndIf
	
	
	
	' ���ü�����
	#Include "Src\Format\xge_xgi.bi"
	#Include "Src\Format\xge_stb.bi"
	
	' ������Ⱦ��
	#Include "Src\Blend\xge_Blend.bi"
	
	
	
	
	
	' ���� [��]
	Constructor Surface() XGE_EXPORT_OBJ
		img = NULL
	End Constructor
	
	' ���� [����]
	Constructor Surface(w As UInteger, h As UInteger) XGE_EXPORT_OBJ
		Create(w, h)
	End Constructor
	
	' ���� [����]
	Constructor Surface(addr As ZString Ptr, size As UInteger = 0) XGE_EXPORT_OBJ
		Load(addr, size)
	End Constructor
	
	' ����
	Destructor Surface() XGE_EXPORT_OBJ
		Free()
	End Destructor
	
	' ����ͼ��
	Function Surface.Create(w As UInteger, h As UInteger) As Integer XGE_EXPORT_OBJ
		Free()
		img = ImageCreate(w, h, &H00FF00FF, 32)
		If img Then
			Return TRUE
		EndIf
	End Function
	
	' ����ͼ��
	Function Surface.Load(addr As ZString Ptr, size As UInteger = 0) As Integer XGE_EXPORT_OBJ
		Free()
		If xLoad_stb(@This, addr, size) Then
			Return TRUE
		Else
			If xLoad_xgi(@This, addr, size) Then
				Return TRUE
			Else
				If xge_global_bldproc Then
					If xge_global_bldproc(@This, addr, size) Then
						Return TRUE
					Else
						Return FALSE
					EndIf
				Else
					Return FALSE
				EndIf
			EndIf
		EndIf
	End Function
	
	' ����ͼ��
	Function Surface.Save(addr As ZString Ptr, tpe As UInteger = 0, flag As Integer = 0) As Integer XGE_EXPORT_OBJ
		Select Case tpe
			Case XGE_IMG_FMT_XGI
				' ����Ϊ xgi ��ʽ
				Return xSave_xgi(@This, addr, flag)
			Case Else
				' ����Ϊ bmp ��ʽ
				Return BSave(*addr, img)
		End Select
	End Function
	
	' �ͷ�ͼ��
	Sub Surface.Free() XGE_EXPORT_OBJ
		If img Then
			ImageDestroy(img)
			img = NULL
		EndIf
	End Sub
	
	' ���ͼ��
	Sub Surface.Clear() XGE_EXPORT_OBJ
		Dim pAddr As Any Ptr
		Dim iSize As UInteger
		ImageInfo(img, , , , , pAddr, iSize)
		If pAddr Then
			memset(pAddr, 0, iSize - 32)
		EndIf
	End Sub
	
	' ��ȡͼ������
	Function Surface.Width() As UInteger XGE_EXPORT_OBJ
		If img Then
			Return img->Width
		EndIf
	End Function
	Function Surface.Height() As UInteger XGE_EXPORT_OBJ
		If img Then
			Return img->Height
		EndIf
	End Function
	Function Surface.PixAddr() As Any Ptr XGE_EXPORT_OBJ
		Dim TempUint As Any Ptr
		ImageInfo(img, , , , , TempUint, )
		Return TempUint
	End Function
	Function Surface.PixSize() As UInteger XGE_EXPORT_OBJ
		Dim TempUint As UInteger
		ImageInfo(img, , , , , , TempUint)
		Return TempUint - 32		' 32Ϊ��Ч����
	End Function
	Function Surface.Pitch() As UInteger XGE_EXPORT_OBJ
		If img Then
			Return img->Pitch
		EndIf
	End Function
	
	' ����ͼ�񸱱�
	Function Surface.Copy(x As Integer, y As Integer, w As Integer, h As Integer) As xge.Surface Ptr XGE_EXPORT_OBJ
		If img Then
			' �Զ�����ü����/�߶�
			If w = 0 Then
				w = img->Width - x
			EndIf
			If h = 0 Then
				h = img->Height - y
			EndIf
			' ����ͼ��
			Dim NewSurface As xge.Surface Ptr = New xge.Surface(w, h)
			If NewSurface->img Then
				Put NewSurface->img, (0, 0), img, (x, y) - Step(w, h), PSet
				Return NewSurface
			Else
				Delete(NewSurface)
			EndIf
		EndIf
	End Function
	
	
	' ����ͼ�� [Ĭ�Ϸ���Alpha]
	Sub Surface.Draw(sf As xge.Surface Ptr, x As Integer, y As Integer) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, Alpha
		Else
			Put (x,y), img, Alpha
		EndIf
	End Sub
	Sub Surface.DrawEx(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, (cx,cy)-Step(cw,ch), Alpha
		Else
			Put (x,y), img, (cx,cy)-Step(cw,ch), Alpha
		EndIf
	End Sub
	
	' ����ͼ�� [���ͼӷ�]
	Sub Surface.Draw_Add(sf As xge.Surface Ptr, x As Integer, y As Integer, mul As Integer = 255) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, Add, mul
		Else
			Put (x,y), img, Add, mul
		EndIf
	End Sub
	Sub Surface.DrawEx_Add(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, mul As Integer = 255) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, (cx,cy)-Step(cw,ch), Add, mul
		Else
			Put (x,y), img, (cx,cy)-Step(cw,ch), Add, mul
		EndIf
	End Sub
	
	' ����ͼ�� [ʹ�ð�͸��ͨ������]
	Sub Surface.Draw_Alpha(sf As xge.Surface Ptr, x As Integer, y As Integer) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, Alpha
		Else
			Put (x,y), img, Alpha
		EndIf
	End Sub
	Sub Surface.DrawEx_Alpha(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, (cx,cy)-Step(cw,ch), Alpha
		Else
			Put (x,y), img, (cx,cy)-Step(cw,ch), Alpha
		EndIf
	End Sub
	
	' ����ͼ�� [��͸������]
	Sub Surface.Draw_Alpha2(sf As xge.Surface Ptr, x As Integer, y As Integer, a As Integer) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, Alpha, a
		Else
			Put (x,y), img, Alpha, a
		EndIf
	End Sub
	Sub Surface.DrawEx_Alpha2(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, a As Integer) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, (cx,cy)-Step(cw,ch), Alpha, a
		Else
			Put (x,y), img, (cx,cy)-Step(cw,ch), Alpha, a
		EndIf
	End Sub
	
	' ����ͼ�� [��Ĥ��ɫ]
	Sub Surface.Draw_Trans(sf As xge.Surface Ptr, x As Integer, y As Integer) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, Trans
		Else
			Put (x,y), img, Trans
		EndIf
	End Sub
	Sub Surface.DrawEx_Trans(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, (cx,cy)-Step(cw,ch), Trans
		Else
			Put (x,y), img, (cx,cy)-Step(cw,ch), Trans
		EndIf
	End Sub
	
	' ����ͼ�� [������]
	Sub Surface.Draw_And(sf As xge.Surface Ptr, x As Integer, y As Integer) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, And
		Else
			Put (x,y), img, And
		EndIf
	End Sub
	Sub Surface.DrawEx_And(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, (cx,cy)-Step(cw,ch), And
		Else
			Put (x,y), img, (cx,cy)-Step(cw,ch), And
		EndIf
	End Sub
	
	' ����ͼ�� [������]
	Sub Surface.Draw_Or(sf As xge.Surface Ptr, x As Integer, y As Integer) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, Or
		Else
			Put (x,y), img, Or
		EndIf
	End Sub
	Sub Surface.DrawEx_Or(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, (cx,cy)-Step(cw,ch), Or
		Else
			Put (x,y), img, (cx,cy)-Step(cw,ch), Or
		EndIf
	End Sub
	
	' ����ͼ�� [ԭͼ������]
	Sub Surface.Draw_PSet(sf As xge.Surface Ptr, x As Integer, y As Integer) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, PSet
		Else
			Put (x,y), img, PSet
		EndIf
	End Sub
	Sub Surface.DrawEx_PSet(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, (cx,cy)-Step(cw,ch), PSet
		Else
			Put (x,y), img, (cx,cy)-Step(cw,ch), PSet
		EndIf
	End Sub
	
	' ����ͼ�� [���]
	Sub Surface.Draw_Xor(sf As xge.Surface Ptr, x As Integer, y As Integer) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, Xor
		Else
			Put (x,y), img, Xor
		EndIf
	End Sub
	Sub Surface.DrawEx_Xor(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, (cx,cy)-Step(cw,ch), Xor
		Else
			Put (x,y), img, (cx,cy)-Step(cw,ch), Xor
		EndIf
	End Sub
	
	' ����ͼ�� [�Զ����㷨]
	Sub Surface.Draw_Custom(sf As xge.Surface Ptr, x As Integer, y As Integer, bk As XGE_DRAW_CUSTOM, param As Any Ptr = NULL) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, Custom, bk, param
		Else
			Put (x,y), img, Custom, bk, param
		EndIf
	End Sub
	
	Sub Surface.DrawEx_Custom(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, bk As XGE_DRAW_CUSTOM, param As Any Ptr = NULL) XGE_EXPORT_OBJ
		If sf Then
			Put sf->img, (x,y), img, (cx,cy)-Step(cw,ch), Custom, bk, param
		Else
			Put (x,y), img, (cx,cy)-Step(cw,ch), Custom, bk, param
		EndIf
	End Sub
	
	' ����ͼ�� [�Ҷ�]
	Sub Surface.Draw_Gray(sf As xge.Surface Ptr, x As Integer, y As Integer) XGE_EXPORT_OBJ
		Blend_Custom(@This, x, y, 0, 0, img->Width - 1, img->Height - 1, sf, @Blend_Gray, 0)
	End Sub
	Sub Surface.DrawEx_Gray(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer) XGE_EXPORT_OBJ
		Blend_Custom(@This, x, y, cx, cy, cw, ch, sf, @Blend_Gray, 0)
	End Sub
	
	' ����ͼ�� [����]
	Sub Surface.Draw_Mirr(sf As xge.Surface Ptr, x As Integer, y As Integer, flag As Integer) XGE_EXPORT_OBJ
		Blend_Custom(@This, x, y, 0, 0, img->Width - 1, img->Height - 1, sf, @Blend_Mirr, flag)
	End Sub
	Sub Surface.DrawEx_Mirr(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, flag As Integer) XGE_EXPORT_OBJ
		Blend_Custom(@This, x, y, cx, cy, cw, ch, sf, @Blend_Mirr, flag)
	End Sub
	
	' ����ͼ�� [����]
	Sub Surface.Draw_Shade(sf As xge.Surface Ptr, x As Integer, y As Integer, mask As UByte) XGE_EXPORT_OBJ
		Blend_Custom(@This, x, y, 0, 0, img->Width - 1, img->Height - 1, sf, @Blend_Shade, mask)
	End Sub
	Sub Surface.DrawEx_Shade(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, mask As UByte) XGE_EXPORT_OBJ
		Blend_Custom(@This, x, y, cx, cy, cw, ch, sf, @Blend_Shade, mask)
	End Sub
	
	' ����ͼ�� [�Զ������㷨(XGE)]
	Sub Surface.Draw_Blend(sf As xge.Surface Ptr, x As Integer, y As Integer, bk As Any Ptr, param As Integer = 0) XGE_EXPORT_OBJ
		Blend_Custom(@This, x, y, 0, 0, img->Width - 1, img->Height - 1, sf, bk, param)
	End Sub
	Sub Surface.DrawEx_Blend(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, bk As Any Ptr, param As Integer = 0) XGE_EXPORT_OBJ
		Blend_Custom(@This, x, y, cx, cy, cw, ch, sf, bk, param)
	End Sub
	
	
	'#Ifdef XGE_BUILD_USEOOP
		End Namespace
	'#EndIf
End Extern