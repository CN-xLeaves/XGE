'==================================================================================
	'�� xywh Game Engine �Զ�����Ⱦģ��
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================



#Ifndef xywh_library_xblend
	#Define xywh_library_xblend
	
	
	Extern XGE_EXTERNSTDEXT
		' �Զ�����Ⱦ���� [�ü������0����,100x100��ͼ������Ϊ0-99,0-99]
		Function Blend_Custom(src As xge.Surface Ptr, px As Integer, py As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer,dst As xge.Surface Ptr, bk As XGE_DRAW_BLEND, param As Integer) As Integer XGE_EXPORT_ALL
			Dim Src_LineAddr As Any Ptr, Src_LineS As Integer
			Dim Dst_LineAddr As Any Ptr, Dst_LineS As Integer, Dst_Pitch As Integer
			Dim SrcImg As IMAGE Ptr = src->img
			Dim DstImg As IMAGE Ptr = NULL
			' �߽���
			If cx >= SrcImg->Width Then
				Return 0
			EndIf
			If cy >= SrcImg->Height Then
				Return 0
			EndIf
			If cx + cw >= SrcImg->Width Then
				cw = SrcImg->Width - cx - 1
			EndIf
			If cy + ch >= SrcImg->Height Then
				ch = SrcImg->Height - cy - 1
			EndIf
			ImageInfo(SrcImg,,,,,Src_LineAddr,)
			Src_LineAddr += SrcImg->Pitch * cy
			If dst Then
				DstImg = dst->img
				' �߽��� [�������һ��ͼ��]
				If px >= DstImg->Width Then
					Return 0
				EndIf
				If py >= DstImg->Height Then
					Return 0
				EndIf
				If px + cw >= DstImg->Width Then
					cw = DstImg->Width - px - 1
				EndIf
				If py + ch >= DstImg->Height Then
					ch = DstImg->Height - py - 1
				EndIf
				ImageInfo(DstImg,,,,,Dst_LineAddr,)
				Dst_Pitch = DstImg->Pitch
				Dst_LineAddr += Dst_Pitch * py
			Else
				' �߽��� [���������]
				If px >= xge_global_width Then
					Return 0
				EndIf
				If py >= xge_global_height Then
					Return 0
				EndIf
				If px + cw >= xge_global_width Then
					cw = xge_global_width - px - 1
				EndIf
				If py + ch >= xge_global_height Then
					ch = xge_global_height - py - 1
				EndIf
				Dst_Pitch = xge_global_width * 4
				Dst_LineAddr = xge_global_scrptr + (Dst_Pitch * py)
			EndIf
			' Bitmap���ݴ���
			Src_LineS = cx * 4
			Dst_LineS = px * 4
			bk(Src_LineAddr, SrcImg->Pitch, Src_LineS, Dst_LineAddr, Dst_Pitch, Dst_LineS, cw, ch, param)
			Return -1
		End Function
		
		
		
		' �Ҷ�Ч��
		Sub Blend_Gray(SrcAddr As Any Ptr, SrcPitch As Integer, SrcLineS As Integer, DstAddr As Any Ptr, DstPitch As Integer, DstLineS As Integer, w As Integer, h As Integer, param As Integer) XGE_EXPORT_ALL
			Dim As UInteger Ptr DstLine, SrcLine
			Dim TmpColor As UInteger
			For y As Integer = 0 To h
				SrcLine = SrcAddr + (SrcPitch * y) + SrcLineS
				DstLine = DstAddr + (DstPitch * y) + DstLineS
				For x As Integer = 0 To w
					TmpColor = SrcLine[x]
					If (TmpColor And MASK32) <> MASK_COLOR_32 Then
						TmpColor = (((TmpColor And Mask32_R) Shr 16) * 1224 + ((TmpColor And Mask32_G) Shr 8) * 2405 + (TmpColor And Mask32_B) * 467) Shr 12
						TmpColor = (TmpColor Shl 16) Or (TmpColor Shl 8) Or TmpColor
						DstLine[x] = TmpColor
					EndIf
				Next
			Next
		End Sub
		
		' ����Ч��
		Sub Blend_Mirr(SrcAddr As Any Ptr, SrcPitch As Integer, SrcLineS As Integer, DstAddr As Any Ptr, DstPitch As Integer, DstLineS As Integer, w As Integer, h As Integer, param As Integer) XGE_EXPORT_ALL
			Dim As UInteger Ptr DstLine, SrcLine
			Dim TmpColor As UInteger
			For y As Integer = 0 To h
				SrcLine = SrcAddr + (SrcPitch * y) + SrcLineS
				' ��ֱ��������ָ��
				If param And XGE_BLEND_MIRR_V Then
					DstLine = DstAddr + (DstPitch * (h-y)) + DstLineS
				Else
					DstLine = DstAddr + (DstPitch * y) + DstLineS
				EndIf
				For x As Integer = 0 To w
					'/' ��ֱʮ��κ�ʱ 6.7 ��		ˮƽʮ��κ�ʱ 7.1 ��		��ֱ+ˮƽʮ��κ�ʱ 7.1 ��
					If ((SrcLine[x] And MASK32_A) <> 0) And ((SrcLine[x] And MASK32) <> MASK_COLOR_32) Then
						' ˮƽ��������ָ��
						If param And XGE_BLEND_MIRR_H Then
							DstLine[w-x] = SrcLine[x]
						Else
							DstLine[x] = SrcLine[x]
						EndIf
					EndIf
					'/
				Next
			Next
		End Sub
		
		' ���ó���������Ч
		Dim Shared XGE_Blend_ShadeData As UByte Ptr
		Dim Shared XGE_Blend_ShadeWidth As Integer
		Dim Shared XGE_Blend_ShadeHeight As Integer
		Sub SetShadeData(w As Integer, h As Integer, d As Any Ptr) XGE_EXPORT_ALL
			XGE_Blend_ShadeData = d
			XGE_Blend_ShadeWidth = w
			XGE_Blend_ShadeHeight = h
		End Sub
		Sub MakeShadeData(sf As xge.Surface Ptr, sd As UByte Ptr) XGE_EXPORT_ALL
			Dim w As Integer = sf->Width
			Dim h As Integer = sf->Height
			Dim a As Any Ptr = sf->PixAddr
			Dim p As Integer = sf->Pitch
			For y As Integer = 0 To h-1
				Dim LineAddr As Integer Ptr = a + (p * y)
				For x As Integer = 0 To w-1
					sd[(y*w)+x] = LineAddr[x] And &HFF
				Next
			Next
		End Sub
		
		' ��������Ч��
		Sub Blend_Shade(SrcAddr As Any Ptr, SrcPitch As Integer, SrcLineS As Integer, DstAddr As Any Ptr, DstPitch As Integer, DstLineS As Integer, w As Integer, h As Integer, param As Integer) XGE_EXPORT_ALL
			Dim As UInteger Ptr DstLine, SrcLine
			For y As Integer = 0 To h
				SrcLine = SrcAddr + (SrcPitch * y) + SrcLineS
				DstLine = DstAddr + (DstPitch * y) + DstLineS
				For x As Integer = 0 To w
					If XGE_Blend_ShadeData[(y*XGE_Blend_ShadeWidth)+x] <= param Then
						DstLine[x] = SrcLine[x]
					EndIf
				Next
			Next
		End Sub
	End Extern
#EndIf
