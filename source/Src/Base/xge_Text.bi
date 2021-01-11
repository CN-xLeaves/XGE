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
		
		' ��ȡ�����С
		Function GetFontSize(idx As UInteger) As Integer XGE_EXPORT_ALL
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(idx)
			If fd Then
				Return fd->HeightInt
			EndIf
		End Function
		
		
		
		' �������ֵĿ�Ⱥ͸߶�
		Function GetTextWidth(txt As WString Ptr, txtLen As UInteger = 0, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0) As Integer
			Dim RetInt As Integer = 0
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(fontid)
			If fd Then
				If txtLen = 0 Then
					txtLen = wcslen(txt)
				EndIf
				If txtLen = 0 Then
					Return 0
				EndIf
				If fd->GetTextWidth_Fast Then
					Return fd->GetTextWidth_Fast(fd, txt, txtLen, Style, wd)
				Else
					Dim As Integer w, h
					For i As Integer = 0 To txtLen - 1
						fd->WordInfo(fd, Cast(UShort Ptr, txt)[i], Style, @w, @h)
						RetInt += w + wd
					Next
				EndIf
			EndIf
			Return RetInt
		End Function
		Function GetTextWidthA(txt As ZString Ptr, txtLen As UInteger = 0, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0) As Integer
			Dim RetInt As Integer = 0
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(fontid)
			If fd Then
				If txtLen = 0 Then
					txtLen = strlen(txt)
				EndIf
				If txtLen = 0 Then
					Return 0
				EndIf
				If fd->GetTextWidthA_Fast Then
					Return fd->GetTextWidthA_Fast(fd, txt, txtLen, Style, wd)
				Else
					Dim As Integer iCode, w, h
					For i As Integer = 0 To txtLen - 1
						' ��ȡһ����
						If txt[i] < &H80 Then
							iCode = Cast(UByte Ptr, txt)[i]
						Else
							iCode = (Cast(UByte Ptr, txt)[i] Shl 8) + Cast(UByte Ptr, txt)[i + 1]
							i += 1
						EndIf
						fd->WordInfoA(fd, iCode, Style, @w, @h)
						RetInt += w + wd
					Next
				EndIf
			EndIf
			Return RetInt
		End Function
		Function GetTextRect(txt As WString Ptr, txtLen As UInteger = 0, fontid As Integer = 1, Style As Integer = 0, align As Integer = XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, wd As Integer = 0, ld As Integer = 0) As xui.Rect
			Dim RetRect As xui.Rect = (0, 0, 0, 0)
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(fontid)
			If fd Then
				If txtLen = 0 Then
					txtLen = wcslen(txt)
				EndIf
				If txtLen = 0 Then
					Return RetRect
				EndIf
				If fd->GetTextRect_Fast Then
					Return fd->GetTextRect_Fast(fd, txt, txtLen, Style, align, wd, ld)
				Else
					' ͳ������
					Dim LineCount As Integer = 1
					Dim DrawMaxW As Integer = 0
					Dim LineWidth As Integer = 0
					Dim As Integer w, h
					For i As Integer = 0 To txtLen - 1
						If Cast(UShort Ptr, txt)[i] = 10 Then
							LineCount += 1
							If LineWidth > DrawMaxW Then
								DrawMaxW = LineWidth
							EndIf
							LineWidth = 0
						Else
							fd->WordInfo(fd, Cast(UShort Ptr, txt)[i], Style, @w, @h)
							LineWidth += w + wd
						EndIf
					Next
					If LineWidth > DrawMaxW Then
						DrawMaxW = LineWidth
					EndIf
					RetRect.w = DrawMaxW
					RetRect.h = (LineCount * (fd->HeightInt + ld)) - ld
				EndIf
			EndIf
			Return RetRect
		End Function
		Function GetTextRectA(txt As ZString Ptr, txtLen As UInteger = 0, fontid As Integer = 1, Style As Integer = 0, align As Integer = XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, wd As Integer = 0, ld As Integer = 0) As xui.Rect
			Dim RetRect As xui.Rect = (0, 0, 0, 0)
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(fontid)
			If fd Then
				If txtLen = 0 Then
					txtLen = strlen(txt)
				EndIf
				If txtLen = 0 Then
					Return RetRect
				EndIf
				If fd->GetTextRectA_Fast Then
					Return fd->GetTextRectA_Fast(fd, txt, txtLen, Style, align, wd, ld)
				Else
					' ͳ������
					Dim LineCount As Integer = 1
					Dim DrawMaxW As Integer = 0
					Dim LineWidth As Integer = 0
					Dim As Integer iCode, w, h
					For i As Integer = 0 To txtLen - 1
						If Cast(UShort Ptr, txt)[i] = 10 Then
							LineCount += 1
							If LineWidth > DrawMaxW Then
								DrawMaxW = LineWidth
							EndIf
							LineWidth = 0
						Else
							' ��ȡһ����
							If txt[i] < &H80 Then
								iCode = Cast(UByte Ptr, txt)[i]
							Else
								iCode = (Cast(UByte Ptr, txt)[i] Shl 8) + Cast(UByte Ptr, txt)[i + 1]
								i += 1
							EndIf
							fd->WordInfoA(fd, iCode, Style, @w, @h)
							LineWidth += w + wd
						EndIf
					Next
					If LineWidth > DrawMaxW Then
						DrawMaxW = LineWidth
					EndIf
					RetRect.w = DrawMaxW
					RetRect.h = (LineCount * (fd->HeightInt + ld)) - ld
				EndIf
			EndIf
			Return RetRect
		End Function
		
		
		
		' ����������ȷ������ֵ�λ��
		Function WidthToPos(cw As Integer, txt As WString Ptr, txtLen As UInteger = 0, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0) As UInteger
			Dim iPos As UInteger = 0
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(fontid)
			If fd Then
				If txtLen = 0 Then
					txtLen = wcslen(txt)
				EndIf
				If fd->WidthToPos_Fast Then
					Return fd->WidthToPos_Fast(fd, cw, txt, txtLen, Style, wd)
				Else
					Dim As Integer w, h
					For iPos = 0 To txtLen - 1
						fd->WordInfo(fd, Cast(UShort Ptr, txt)[iPos], Style, @w, @h)
						cw -= (w + wd)
						If cw <= 0 Then
							If cw + (w \ 2) >= 0 Then
								Return iPos + 1
							Else
								Return iPos
							EndIf
						EndIf
					Next
				EndIf
			EndIf
			Return iPos
		End Function
		Function WidthToPosA(cw As Integer, txt As ZString Ptr, txtLen As UInteger = 0, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0) As UInteger
			Dim iPos As UInteger = 0
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(fontid)
			If fd Then
				If txtLen = 0 Then
					txtLen = strlen(txt)
				EndIf
				If fd->WidthToPos_Fast Then
					Return fd->WidthToPosA_Fast(fd, cw, txt, txtLen, Style, wd)
				Else
					Dim As Integer iCode, w, h
					For iPos = 0 To txtLen - 1
						' ��ȡһ����
						If txt[iPos] < &H80 Then
							iCode = Cast(UByte Ptr, txt)[iPos]
						Else
							iCode = (Cast(UByte Ptr, txt)[iPos] Shl 8) + Cast(UByte Ptr, txt)[iPos + 1]
							iPos += 1
						EndIf
						fd->WordInfo(fd, iCode, Style, @w, @h)
						cw -= (w + wd)
						If cw <= 0 Then
							If cw + (w \ 2) >= 0 Then
								Return iPos + 1
							Else
								Return iPos
							EndIf
						EndIf
					Next
				EndIf
			EndIf
			Return iPos
		End Function
		/'
		Function PointToPos() As UInteger
			
		End Function
		'/
		
		
		
		' д��
		Function Draw(sf As xge.Surface Ptr, px As Integer, py As Integer, txt As WString Ptr, txtLen As UInteger, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0) As xui.Rect XGE_EXPORT_ALL
			Dim RetRect As xui.Rect = (px, py, 0, 0)
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(fontid)
			If fd Then
				If txtLen = 0 Then
					txtLen = wcslen(txt)
				EndIf
				If txtLen = 0 Then
					Return RetRect
				EndIf
				If (iColor And &HFF000000) = 0 Then
					iColor = iColor Or &HFF000000
				EndIf
				If fd->DrawLine_Fast Then
					Return fd->DrawLine_Fast(fd, sf, px, py, txt, txtLen, iColor, Style, wd)
				Else
					Dim wx As Integer = 0		' ���ֻ��ƺ���ƫ��
					Dim As Integer w, h
					For i As Integer = 0 To txtLen - 1
						' ��Ⱦ����
						fd->WordInfo(fd, Cast(UShort Ptr, txt)[i], Style, @w, @h)
						fd->DrawWord(fd, sf, px + wx, py, w, h, Cast(UShort Ptr, txt)[i], iColor, Style)
						wx += w + wd
					Next
					RetRect.w = wx
					RetRect.h = h
				EndIf
			EndIf
			Return RetRect
		End Function
		Function DrawA(sf As xge.Surface Ptr, px As Integer, py As Integer, txt As ZString Ptr, txtLen As UInteger, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0) As xui.Rect XGE_EXPORT_ALL
			Dim RetRect As xui.Rect = (px, py, 0, 0)
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(fontid)
			If fd Then
				If txtLen = 0 Then
					txtLen = strlen(txt)
				EndIf
				If txtLen = 0 Then
					Return RetRect
				EndIf
				If (iColor And &HFF000000) = 0 Then
					iColor = iColor Or &HFF000000
				EndIf
				If fd->DrawLineA_Fast Then
					Return fd->DrawLineA_Fast(fd, sf, px, py, txt, txtLen, iColor, Style, wd)
				Else
					Dim wx As Integer = 0		' ���ֻ��ƺ���ƫ��
					Dim As Integer iCode, w, h
					For i As Integer = 0 To txtLen - 1
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
					Next
					RetRect.w = wx
					RetRect.h = h
				EndIf
			EndIf
			Return RetRect
		End Function
		
		' ���θ�ʽ��д�� [ align:���䷽ʽ��wd:�ּ�ࡢld:�м�� ]
		Function DrawRect(sf As xge.Surface Ptr, px As Integer, py As Integer, pw As Integer, ph As Integer, txt As WString Ptr, txtLen As UInteger, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, align As Integer = XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, wd As Integer = 0, ld As Integer = 0) As xui.Rect XGE_EXPORT_ALL
			Dim RetRect As xui.Rect = (0, 0, 0, 0)
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(fontid)
			If fd Then
				If txtLen = 0 Then
					txtLen = wcslen(txt)
				EndIf
				If txtLen = 0 Then
					Return RetRect
				EndIf
				If fd->DrawRect_Fast Then
					Return fd->DrawRect_Fast(fd, sf, px, py, pw, ph, txt, txtLen, iColor, Style, align, wd, ld)
				Else
					' ͳ������ [��ֱ���С����µ�ʱ����]
					Dim LineCount As Integer = 1
					Dim MaxHeight As Integer = 0
					For i As Integer = 0 To txtLen - 1
						If Cast(UShort Ptr, txt)[i] = 10 Then
							LineCount += 1
						EndIf
					Next
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
					RetRect.y = DrawOffsetY
					RetRect.h = (LineCount * (fd->HeightInt + ld)) - ld
					' ��Ⱦ����
					Dim As Integer w, h
					Dim DrawOffsetX As Integer = 0
					Dim DrawSubText As WString Ptr = txt
					Dim DrawMaxW As Integer = 0
					For i As Integer = 0 To txtLen - 1
						If txt[i] = 10 Then
							If DrawOffsetX <> 0 Then
								Cast(UShort Ptr, txt)[i] = 0
								DrawOffsetX -= wd
								Select Case (align And (XGE_ALIGN_CENTER Or XGE_ALIGN_RIGHT))
									Case XGE_ALIGN_CENTER
										' �������
										Draw(sf, px + (pw - DrawOffsetX) \ 2, DrawOffsetY, DrawSubText, 0, iColor, fontid, Style, wd)
									Case XGE_ALIGN_RIGHT
										' �������
										Draw(sf, px + pw - DrawOffsetX, DrawOffsetY, DrawSubText, 0, iColor, fontid, Style, wd)
									Case Else
										' �������
										Draw(sf, px, DrawOffsetY, DrawSubText, 0, iColor, fontid, Style, wd)
								End Select
								Cast(UShort Ptr, txt)[i] = 10
							EndIf
							DrawSubText = @txt[i+1]
							DrawOffsetY += fd->HeightInt + ld
							If DrawOffsetX > DrawMaxW Then
								DrawMaxW = DrawOffsetX
							EndIf
							DrawOffsetX = 0
						Else
							fd->WordInfo(fd, Cast(UShort Ptr, txt)[i], Style, @w, @h)
							DrawOffsetX += w + wd
						EndIf
					Next
					' ������Ⱦ
					If DrawOffsetX <> 0 Then
						DrawOffsetX -= wd
						Select Case (align And (XGE_ALIGN_CENTER Or XGE_ALIGN_RIGHT))
							Case XGE_ALIGN_CENTER
								' �������
								Draw(sf, px + (pw - DrawOffsetX) \ 2, DrawOffsetY, DrawSubText, 0, iColor, fontid, Style, wd)
							Case XGE_ALIGN_RIGHT
								' �������
								Draw(sf, px + pw - DrawOffsetX, DrawOffsetY, DrawSubText, 0, iColor, fontid, Style, wd)
							Case Else
								' �������
								Draw(sf, px, DrawOffsetY, DrawSubText, 0, iColor, fontid, Style, wd)
						End Select
					EndIf
					' ����������εĿ�Ⱥ�����
					If DrawOffsetX > DrawMaxW Then
						DrawMaxW = DrawOffsetX
					EndIf
					RetRect.w = DrawMaxW
					Select Case (align And (XGE_ALIGN_CENTER Or XGE_ALIGN_RIGHT))
						Case XGE_ALIGN_CENTER
							' �������
							RetRect.x = px + (pw - DrawMaxW) \ 2
						Case XGE_ALIGN_RIGHT
							' �������
							RetRect.x = px + pw - DrawMaxW
						Case Else
							' �������
							RetRect.x = px
					End Select
				EndIf
			EndIf
			Return RetRect
		End Function
		Function DrawRectA(sf As xge.Surface Ptr, px As Integer, py As Integer, pw As Integer, ph As Integer, txt As ZString Ptr, txtLen As UInteger, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, align As Integer = XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, wd As Integer = 0, ld As Integer = 0) As xui.Rect XGE_EXPORT_ALL
			Dim RetRect As xui.Rect = (0, 0, 0, 0)
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(fontid)
			If fd Then
				If txtLen = 0 Then
					txtLen = strlen(txt)
				EndIf
				If txtLen = 0 Then
					Return RetRect
				EndIf
				If fd->DrawRectA_Fast Then
					Return fd->DrawRectA_Fast(fd, sf, px, py, pw, ph, txt, txtLen, iColor, Style, align, wd, ld)
				Else
					' ͳ������ [��ֱ���С����µ�ʱ����]
					Dim LineCount As Integer = 1
					Dim MaxHeight As Integer = 0
					For i As Integer = 0 To txtLen - 1
						If txt[i] And &H80 Then
							i += 1
						ElseIf Cast(UByte Ptr, txt)[i] = 10 Then
							LineCount += 1
						EndIf
					Next
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
					RetRect.y = DrawOffsetY
					RetRect.h = (LineCount * (fd->HeightInt + ld)) - ld
					' ��Ⱦ����
					Dim As Integer iCode, w, h
					Dim DrawOffsetX As Integer = 0
					Dim DrawSubText As ZString Ptr = txt
					Dim DrawMaxW As Integer = 0
					For i As Integer = 0 To txtLen - 1
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
										DrawA(sf, px + (pw - DrawOffsetX) \ 2, DrawOffsetY, DrawSubText, 0, iColor, fontid, Style, wd)
									Case XGE_ALIGN_RIGHT
										' �������
										DrawA(sf, px + pw - DrawOffsetX, DrawOffsetY, DrawSubText, 0, iColor, fontid, Style, wd)
									Case Else
										' �������
										DrawA(sf, px, DrawOffsetY, DrawSubText, 0, iColor, fontid, Style, wd)
								End Select
								Cast(UByte Ptr, txt)[i] = 10
							EndIf
							DrawSubText = @txt[i+1]
							DrawOffsetY += fd->HeightInt + ld
							If DrawOffsetX > DrawMaxW Then
								DrawMaxW = DrawOffsetX
							EndIf
							DrawOffsetX = 0
						Else
							' ���ַ�����
							fd->WordInfoA(fd, Cast(UByte Ptr, txt)[i], Style, @w, @h)
							DrawOffsetX += w + wd
						EndIf
					Next
					' ������Ⱦ
					If DrawOffsetX <> 0 Then
						DrawOffsetX -= wd
						Select Case (align And (XGE_ALIGN_CENTER Or XGE_ALIGN_RIGHT))
							Case XGE_ALIGN_CENTER
								' �������
								DrawA(sf, px + (pw - DrawOffsetX) \ 2, DrawOffsetY, DrawSubText, 0, iColor, fontid, Style, wd)
							Case XGE_ALIGN_RIGHT
								' �������
								DrawA(sf, px + pw - DrawOffsetX, DrawOffsetY, DrawSubText, 0, iColor, fontid, Style, wd)
							Case Else
								' �������
								DrawA(sf, px, DrawOffsetY, DrawSubText, 0, iColor, fontid, Style, wd)
						End Select
					EndIf
					' ����������εĿ�Ⱥ�����
					If DrawOffsetX > DrawMaxW Then
						DrawMaxW = DrawOffsetX
					EndIf
					RetRect.w = DrawMaxW
					Select Case (align And (XGE_ALIGN_CENTER Or XGE_ALIGN_RIGHT))
						Case XGE_ALIGN_CENTER
							' �������
							RetRect.x = px + (pw - DrawMaxW) \ 2
						Case XGE_ALIGN_RIGHT
							' �������
							RetRect.x = px + pw - DrawMaxW
						Case Else
							' �������
							RetRect.x = px
					End Select
				EndIf
			EndIf
			Return RetRect
		End Function
		
		
		
	End Namespace
	
	
	
	'#Ifdef XGE_BUILD_USEOOP
		End Namespace
	'#EndIf
End Extern