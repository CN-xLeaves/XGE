'==================================================================================
	'�� xywh Game Engine ������Ⱦģ��
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================



' ���ü�����
#Include "Src\Format\xge_xrf.bi"
#Include "Src\Format\xge_ttf.bi"



Extern XGE_EXTERNMODULE
	'#Ifdef XGE_BUILD_USEOOP
		Namespace xge
	'#EndIf
	
	
	
	Namespace Text
		
		
		
		' �������� [ Ŀǰ֧�� xrf���� �� truetype���� ] [ ttc���������ʱͨ��param����ָ�����ص�����ID ]
		Function LoadFont(Addr As ZString Ptr, iSize As UInteger, param As Any Ptr = NULL) As UInteger XGE_EXPORT_ALL
			Dim iList As UInteger = xge_fontlist.AppendStruct()
			If iList Then
				Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(iList)
				If xLoad_xrf(fd, Addr, iSize, param) Then
					Return iList
				Else
					If xLoad_ttf(fd, Addr, iSize, Cast(Integer, param)) Then
						Return iList
					Else
						If xge_global_fldproc Then
							If xge_global_fldproc(fd, Addr, iSize, param) Then
								Return iList
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
			xge_fontlist.DeleteStruct(iList)
			Return 0
		End Function
		
		' �Ƴ����� [�Ƴ�����������Ż�䶯������]
		Function RemoveFont(idx As UInteger) As Integer XGE_EXPORT_ALL
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(idx)
			If fd Then
				If fd->FreeFont Then
					fd->FreeFont(fd)
				EndIf
				xge_fontlist.DeleteStruct(idx)
				Return -1
			EndIf
			Return 0
		End Function
		
		' ȡ���Ѽ��ص���������
		Function FontCount() As Integer XGE_EXPORT_ALL
			Return xge_fontlist.StructCount
		End Function
		
		' ���������С [���ttf����]
		Sub SetFontSize(idx As UInteger, size As UInteger) XGE_EXPORT_ALL
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(idx)
			If fd Then
				If fd->SetFontSize Then
					fd->SetFontSize(fd, size)
				EndIf
			EndIf
		End Sub
		
		
		
		' д��
		Sub Draw(sf As xge.Surface Ptr, px As Integer, py As Integer, txt As WString Ptr, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0) XGE_EXPORT_ALL
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(fontid)
			If fd Then
				If (iColor And &HFF000000) = 0 Then
					iColor = iColor Or &HFF000000
				EndIf
				If fd->DrawLine_Fast Then
					fd->DrawLine_Fast(fd, sf, px, py, txt, iColor, Style, wd)
				Else
					Dim i As Integer = 0		' �����ֵ�λ��
					Dim wx As Integer = 0		' ���ֻ��ƺ���ƫ��
					Dim As Integer w, h
					Do While txt[i]
						' ��Ⱦ����
						fd->WordInfo(fd, Cast(UShort Ptr, txt)[i], Style, @w, @h)
						fd->DrawWord(fd, sf, px + wx, py, w, h, Cast(UShort Ptr, txt)[i], iColor, Style)
						wx += w + wd
						i += 1
					Loop
				EndIf
			EndIf
		End Sub
		Sub DrawA(sf As xge.Surface Ptr, px As Integer, py As Integer, txt As ZString Ptr, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0) XGE_EXPORT_ALL
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(fontid)
			If fd Then
				If (iColor And &HFF000000) = 0 Then
					iColor = iColor Or &HFF000000
				EndIf
				If fd->DrawLineA_Fast Then
					fd->DrawLineA_Fast(fd, sf, px, py, txt, iColor, Style, wd)
				Else
					Dim i As Integer = 0		' �����ֵ�λ��
					Dim wx As Integer = 0		' ���ֻ��ƺ���ƫ��
					Dim As Integer iCode, w, h
					Do While txt[i]
						' ��ȡһ����
						If txt[i] < &H80 Then
							iCode = Cast(UByte Ptr, txt)[i]
						Else
							iCode = (Cast(UByte Ptr, txt)[i] Shl 8) + Cast(UByte Ptr, txt)[i + 1]
							i += 1
						EndIf
						' ��Ⱦ����
						fd->WordInfoA(fd, iCode, Style, @w, @h)
						fd->DrawWordA(fd, sf, px + wx, py, w, h, iCode, iColor, Style)
						wx += w + wd
						i += 1
					Loop
				EndIf
			EndIf
		End Sub
		
		' ���θ�ʽ��д�� [ align:���䷽ʽ��wd:�ּ�ࡢld:�м�� ]
		Sub DrawRect(sf As xge.Surface Ptr, px As Integer, py As Integer, pw As Integer, ph As Integer, txt As WString Ptr, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, align As Integer = XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, wd As Integer = 0, ld As Integer = 0) XGE_EXPORT_ALL
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(fontid)
			If fd Then
				If fd->DrawRect_Fast Then
					fd->DrawRect_Fast(fd, sf, px, py, pw, ph, txt, iColor, Style, align, wd, ld)
				Else
					' ͳ������ [��ֱ���С����µ�ʱ����]
					Dim i As Integer = 0
					Dim LineCount As Integer = 1
					Dim MaxHeight As Integer = 0
					Do While txt[i]
						If Cast(UShort Ptr, txt)[i] = 10 Then
							LineCount += 1
						EndIf
						i += 1
					Loop
					Dim DrawOffsetY As Integer
					Select Case (align And (XGE_ALIGN_MIDDLE Or XGE_ALIGN_BOTTOM))
						Case XGE_ALIGN_MIDDLE
							' �������
							DrawOffsetY = py + (ph - ((LineCount * (fd->HeightInt + ld)) - ld)) \ 2
						Case XGE_ALIGN_BOTTOM
							' �������
							DrawOffsetY = py + ph - ((LineCount * (fd->HeightInt + ld)) - ld)
						Case Else
							' �������
							DrawOffsetY = py + 0
					End Select
					' ��Ⱦ����
					i = 0
					Dim As Integer w, h
					Dim DrawOffsetX As Integer = 0
					Dim DrawSubText As WString Ptr = txt
					Do While txt[i]
						If txt[i] = 10 Then
							If DrawOffsetX <> 0 Then
								Cast(UShort Ptr, txt)[i] = 0
								DrawOffsetX -= wd
								Select Case (align And (XGE_ALIGN_CENTER Or XGE_ALIGN_RIGHT))
									Case XGE_ALIGN_CENTER
										' �������
										Draw(sf, px + (pw - DrawOffsetX) \ 2, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
									Case XGE_ALIGN_RIGHT
										' �������
										Draw(sf, px + pw - DrawOffsetX, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
									Case Else
										' �������
										Draw(sf, px, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
								End Select
								Cast(UShort Ptr, txt)[i] = 10
							EndIf
							DrawSubText = @txt[i+1]
							DrawOffsetY += fd->HeightInt + ld
							DrawOffsetX = 0
						Else
							fd->WordInfo(fd, Cast(UShort Ptr, txt)[i], Style, @w, @h)
							DrawOffsetX += w + wd
						EndIf
						i += 1
					Loop
					' ������Ⱦ
					If DrawOffsetX <> 0 Then
						DrawOffsetX -= wd
						Select Case (align And (XGE_ALIGN_CENTER Or XGE_ALIGN_RIGHT))
							Case XGE_ALIGN_CENTER
								' �������
								Draw(sf, px + (pw - DrawOffsetX) \ 2, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
							Case XGE_ALIGN_RIGHT
								' �������
								Draw(sf, px + pw - DrawOffsetX, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
							Case Else
								' �������
								Draw(sf, px, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
						End Select
					EndIf
				EndIf
			EndIf
		End Sub
		Sub DrawRectA(sf As xge.Surface Ptr, px As Integer, py As Integer, pw As Integer, ph As Integer, txt As ZString Ptr, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, align As Integer = XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, wd As Integer = 0, ld As Integer = 0) XGE_EXPORT_ALL
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(fontid)
			If fd Then
				If fd->DrawRectA_Fast Then
					fd->DrawRectA_Fast(fd, sf, px, py, pw, ph, txt, iColor, Style, align, wd, ld)
				Else
					' ͳ������ [��ֱ���С����µ�ʱ����]
					Dim i As Integer = 0
					Dim LineCount As Integer = 1
					Dim MaxHeight As Integer = 0
					Do While txt[i]
						If txt[i] And &H80 Then
							i += 1
						ElseIf Cast(UByte Ptr, txt)[i] = 10 Then
							LineCount += 1
						EndIf
						i += 1
					Loop
					Dim DrawOffsetY As Integer
					Select Case (align And (XGE_ALIGN_MIDDLE Or XGE_ALIGN_BOTTOM))
						Case XGE_ALIGN_MIDDLE
							' �������
							DrawOffsetY = py + (ph - ((LineCount * (fd->HeightInt + ld)) - ld)) \ 2
						Case XGE_ALIGN_BOTTOM
							' �������
							DrawOffsetY = py + ph - ((LineCount * (fd->HeightInt + ld)) - ld)
						Case Else
							' �������
							DrawOffsetY = py + 0
					End Select
					' ��Ⱦ����
					i = 0
					Dim As Integer iCode, w, h
					Dim DrawOffsetX As Integer = 0
					Dim DrawSubText As ZString Ptr = txt
					Do While txt[i]
						If txt[i] And &H80 Then
							' ���ַ�����
							iCode = (Cast(UByte Ptr, txt)[i] Shl 8) + Cast(UByte Ptr, txt)[i + 1]
							fd->WordInfoA(fd, iCode, Style, @w, @h)
							DrawOffsetX += w + wd
							i += 1
						ElseIf txt[i] = 10 Then
							' ���д���
							If DrawOffsetX <> 0 Then
								Cast(UByte Ptr, txt)[i] = 0
								DrawOffsetX -= wd
								Select Case (align And (XGE_ALIGN_CENTER Or XGE_ALIGN_RIGHT))
									Case XGE_ALIGN_CENTER
										' �������
										DrawA(sf, px + (pw - DrawOffsetX) \ 2, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
									Case XGE_ALIGN_RIGHT
										' �������
										DrawA(sf, px + pw - DrawOffsetX, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
									Case Else
										' �������
										DrawA(sf, px, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
								End Select
								Cast(UByte Ptr, txt)[i] = 10
							EndIf
							DrawSubText = @txt[i+1]
							DrawOffsetY += fd->HeightInt + ld
							DrawOffsetX = 0
						Else
							' ���ַ�����
							fd->WordInfoA(fd, Cast(UByte Ptr, txt)[i], Style, @w, @h)
							DrawOffsetX += w + wd
						EndIf
						i += 1
					Loop
					' ������Ⱦ
					If DrawOffsetX <> 0 Then
						DrawOffsetX -= wd
						Select Case (align And (XGE_ALIGN_CENTER Or XGE_ALIGN_RIGHT))
							Case XGE_ALIGN_CENTER
								' �������
								DrawA(sf, px + (pw - DrawOffsetX) \ 2, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
							Case XGE_ALIGN_RIGHT
								' �������
								DrawA(sf, px + pw - DrawOffsetX, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
							Case Else
								' �������
								DrawA(sf, px, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
						End Select
					EndIf
				EndIf
			EndIf
		End Sub
		
		
		
	End Namespace
	
	
	
	'#Ifdef XGE_BUILD_USEOOP
		End Namespace
	'#EndIf
End Extern