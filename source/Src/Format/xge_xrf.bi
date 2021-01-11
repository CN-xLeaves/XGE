


#Define XRF_VER1_ANSI		&H01414658		' A��W �汾APIͨ��
#Define XRF_VER1_UCS2		&H01554658		' ��֧�� W �汾API
#Define XRF_VER1_GB2312		&H01674658		' ��֧�� A �汾API
#Define XRF_VER1_GBK		&H01474658		' ��֧�� A �汾API



#Define XRF_FLAG_COMPRESS	1		' ѹ���ֿ� [ʹ��LZ4�㷨] [��δʵ��]



Static Shared XRF_POINTS(32) As UInteger = {&H00000001, &H00000002, &H00000004, &H00000008, &H00000010, &H00000020, &H00000040, &H00000080, _
											&H00000100, &H00000200, &H00000400, &H00000800, &H00001000, &H00002000, &H00004000, &H00008000, _
											&H00010000, &H00020000, &H00040000, &H00080000, &H00100000, &H00200000, &H00400000, &H00800000, _
											&H01000000, &H02000000, &H04000000, &H08000000, &H10000000, &H20000000, &H40000000, &H80000000}



Type xywhRasterFont_Handle Field = 1
	Ver As UInteger							' �ļ�ͷ��ʶ���ʶ�Ͱ汾��Ϣ
	AnsiWidth As UByte						' ���32 [Ϊ���㷨�Ż��������ֿⳬ��32�Ժ��ļ�̫��û����]
	WordWidth As UByte						' ���32 [Ϊ���㷨�Ż��������ֿⳬ��32�Ժ��ļ�̫��û����]
	WordHeight As UByte						' ���32 [Ϊ���㷨�Ż��������ֿⳬ��32�Ժ��ļ�̫��û����]
	FontFlag As UByte						' λ���
End Type



Type FontDriverInfo_xrf
	Data As xywhRasterFont_Handle Ptr		' �ļ��ڴ�ָ��
	AscPtr As Any Ptr						' ASC�ֿ�����ָ��
	UniPtr As Any Ptr						' GB�ֿ�����ָ��
	ChrMemSize As UInteger					' һ���ַ�ռ�ö����ڴ�
	LineMemSize As UInteger					' һ�е���ռ�ö����ڴ�
	IsMemoryFree As Integer					' �Ƿ����ڴ������ [�ڴ�������ֿⲻ��Ҫ�ͷ�Data]
End Type



' ��Ⱦ�������� [ANSI]
Sub xFont_DrawWord_xrf_ansi(fd As xge.Text.FontDriver Ptr, sf As xge.Surface Ptr, px As Integer, py As Integer, w As Integer, h As Integer, iCode As UInteger, iColor As UInteger, Style As Integer)
	Dim info As FontDriverInfo_xrf Ptr = fd->Font
	Dim BW As Integer = info->LineMemSize
	If iCode < &H80 Then
		' ASCII�ַ�
		If iCode >= 32 Then		' ����ĳЩ�ֿ����⣬���� Space Ҳ�᳢�Զ�ȡ��������
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
		' �»���
		If Style And XGE_FONT_UNDERLINE Then
			If sf Then
				Line sf->img, (px, py + fd->HeightInt + 1) - (px + fd->FontSizeInt, py + fd->HeightInt + 1), iColor
			Else
				Line (px, py + fd->HeightInt + 1) - (px + fd->WidthInt, py + fd->HeightInt + 1), iColor
			EndIf
		EndIf
	Else
		' ���ַ� [ANSI����Ⱦ���ַ���������ΪѰַ���⵼�±���]
		
		' �»���
		If Style And XGE_FONT_UNDERLINE Then
			If sf Then
				Line sf->img, (px, py + fd->HeightInt + 1) - (px + fd->WidthInt, py + fd->HeightInt + 1), iColor
			Else
				Line (px, py + fd->HeightInt + 1) - (px + fd->WidthInt, py + fd->HeightInt + 1), iColor
			EndIf
		EndIf
	EndIf
End Sub



' ��Ⱦ�������� [GB2312]
Sub xFont_DrawWord_xrf_gb2312(fd As xge.Text.FontDriver Ptr, sf As xge.Surface Ptr, px As Integer, py As Integer, w As Integer, h As Integer, iCode As UInteger, iColor As UInteger, Style As Integer)
	Dim info As FontDriverInfo_xrf Ptr = fd->Font
	Dim BW As Integer = info->LineMemSize
	If iCode < &H80 Then
		' ASCII�ַ�
		If iCode >= 32 Then		' ����ĳЩ�ֿ����⣬���� Space Ҳ�᳢�Զ�ȡ��������
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
		' �»���
		If Style And XGE_FONT_UNDERLINE Then
			If sf Then
				Line sf->img, (px, py + fd->HeightInt + 1) - (px + fd->FontSizeInt, py + fd->HeightInt + 1), iColor
			Else
				Line (px, py + fd->HeightInt + 1) - (px + fd->WidthInt, py + fd->HeightInt + 1), iColor
			EndIf
		EndIf
	Else
		' ���ַ�
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
		' �»���
		If Style And XGE_FONT_UNDERLINE Then
			If sf Then
				Line sf->img, (px, py + fd->HeightInt + 1) - (px + fd->WidthInt, py + fd->HeightInt + 1), iColor
			Else
				Line (px, py + fd->HeightInt + 1) - (px + fd->WidthInt, py + fd->HeightInt + 1), iColor
			EndIf
		EndIf
	EndIf
End Sub
' ���� UNICODE �����ַ���ת��Ϊ GB2312 ����Ⱦ
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



' ��Ⱦ�������� [UNICODE]
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
	' �»���
	If Style And XGE_FONT_UNDERLINE Then
		If sf Then
			Line sf->img, (px, py + fd->HeightInt + 1) - (px + ww, py + fd->HeightInt + 1), iColor
		Else
			Line (px, py + fd->HeightInt + 1) - (px + fd->WidthInt, py + fd->HeightInt + 1), iColor
		EndIf
	EndIf
End Sub
' ���� GB2312 �����ַ���ת��Ϊ UNICODE ����Ⱦ
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



' ��ȡ�������ֵ��ַ���Ϣ
Sub xFont_WordInfo_xrf(fd As xge.Text.FontDriver Ptr, iCode As Integer, Style As Integer, w As Integer Ptr, h As Integer Ptr)
	If iCode < &H80 Then	' ��ʱû�п����ַ��Ĵ����ܣ����� �Ʊ�� ֮���
		' ASCII�ַ�
		If w Then
			*w = fd->FontSizeInt
		EndIf
		If h Then
			*h = fd->HeightInt
		EndIf
	Else
		' ���ַ�
		If w Then
			*w = fd->WidthInt
		EndIf
		If h Then
			*h = fd->HeightInt
		EndIf
	EndIf
End Sub



' ��Ⱦһ������
Sub DrawLine_Fast_xrf(fd As xge.Text.FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, txt As ZString Ptr, iColor As Integer, Style As Integer, wd As Integer)
	
End Sub
Sub DrawLineA_Fast_xrf(fd As xge.Text.FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, txt As ZString Ptr, iColor As Integer, Style As Integer, wd As Integer)
	
End Sub

' ��������Ⱦ��һ��������
Sub DrawRect_Fast_xrf(fd As xge.Text.FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, w As Integer, h As Integer, txt As ZString Ptr, iColor As Integer, Style As Integer, align As Integer, wd As Integer, ld As Integer)
	
End Sub
Sub DrawRectA_Fast_xrf(fd As xge.Text.FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, w As Integer, h As Integer, txt As ZString Ptr, iColor As Integer, Style As Integer, align As Integer, wd As Integer, ld As Integer)
	
End Sub



' xrf �ֿ�����
Sub xFree_xrf(fd As xge.Text.FontDriver Ptr)
	Dim info As FontDriverInfo_xrf Ptr = fd->Font
	If info->IsMemoryFree Then
		DeAllocate(info->Data)
	EndIf
	DeAllocate(info)
End Sub

' xrf �ֿ������
Function xLoad_xrf(fd As xge.Text.FontDriver Ptr, Addr As ZString Ptr, iSize As UInteger, param As Any Ptr) As Integer
	Dim info As FontDriverInfo_xrf Ptr = Allocate(SizeOf(FontDriverInfo_xrf))
	If iSize Then
		' ���ڴ������ֿ�
		info->Data = Cast(Any Ptr, Addr)
	Else
		' ���ļ������ֿ�
		iSize = xFile.Size(Addr)
		If iSize = 0 Then
			DeAllocate(info)
			Return 0
		EndIf
		info->IsMemoryFree = -1
		info->Data = Allocate(iSize)
		xFile.Read(Addr, info->Data, 0, SizeOf(xywhRasterFont_Handle))
	EndIf
	' ����һ���ַ�ռ�ö����ֽڵ��ڴ�
	info->LineMemSize = (info->Data->WordWidth + 7) \ 8
	info->ChrMemSize = info->LineMemSize * info->Data->WordHeight
	' �����ļ�ͷ
	Select Case info->Data->Ver
		Case XRF_VER1_ANSI
			' ANSI �ֿ�
			info->AscPtr = Cast(Any Ptr, info->Data) + SizeOf(xywhRasterFont_Handle)
			info->UniPtr = NULL
			fd->DrawWord = Cast(Any Ptr, @xFont_DrawWord_xrf_ansi)
			fd->DrawWordA = Cast(Any Ptr, @xFont_DrawWord_xrf_ansi)
		Case XRF_VER1_UCS2
			' UNICODE �ֿ�
			info->AscPtr = Cast(Any Ptr, info->Data) + SizeOf(xywhRasterFont_Handle)
			info->UniPtr = Cast(Any Ptr, info->Data) + SizeOf(xywhRasterFont_Handle)
			fd->DrawWord = Cast(Any Ptr, @xFont_DrawWord_xrf_ucs2)
			fd->DrawWordA = Cast(Any Ptr, @xFont_DrawWord_xrf_ucs2_fromAnsi)
		Case XRF_VER1_GB2312
			' GB2312 �ֿ�
			info->AscPtr = Cast(Any Ptr, info->Data) + SizeOf(xywhRasterFont_Handle)
			info->UniPtr = info->AscPtr + (info->ChrMemSize * 96)
			fd->DrawWord = Cast(Any Ptr, @xFont_DrawWord_xrf_gb2312_fromUcs2)
			fd->DrawWordA = Cast(Any Ptr, @xFont_DrawWord_xrf_gb2312)
		Case Else
			' �޷�ʶ����ļ�ͷ
			DeAllocate(info)
			If info->IsMemoryFree Then
				DeAllocate(info->Data)
			EndIf
			Return 0
	End Select
	' ����Ǵ��ļ����صģ������ȫ������ [һ��ʼֻ���ļ�ͷ]
	If info->IsMemoryFree Then
		xFile.Read(Addr, info->Data, 0, iSize)
	EndIf
	' �����������
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


