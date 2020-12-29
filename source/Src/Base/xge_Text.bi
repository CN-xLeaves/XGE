'==================================================================================
	'★ xywh Game Engine 文字渲染模块
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



' 引用加载器
#Include "Src\Format\xge_xrf.bi"
#Include "Src\Format\xge_ttf.bi"



Extern XGE_EXTERNMODULE
	'#Ifdef XGE_BUILD_USEOOP
		Namespace xge
	'#EndIf
	
	
	
	Namespace Text
		
		
		
		' 加载字体 [ 目前支持 xrf字体 和 truetype字体 ] [ ttc字体包加载时通过param参数指定加载的字体ID ]
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
		
		' 移除字体 [移除字体后字体编号会变动，慎用]
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
		
		' 取得已加载的字体数量
		Function FontCount() As Integer XGE_EXPORT_ALL
			Return xge_fontlist.StructCount
		End Function
		
		' 设置字体大小 [针对ttf字体]
		Sub SetFontSize(idx As UInteger, size As UInteger) XGE_EXPORT_ALL
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(idx)
			If fd Then
				If fd->SetFontSize Then
					fd->SetFontSize(fd, size)
				EndIf
			EndIf
		End Sub
		
		
		
		' 写字
		Sub Draw(sf As xge.Surface Ptr, px As Integer, py As Integer, txt As WString Ptr, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0) XGE_EXPORT_ALL
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(fontid)
			If fd Then
				If (iColor And &HFF000000) = 0 Then
					iColor = iColor Or &HFF000000
				EndIf
				If fd->DrawLine_Fast Then
					fd->DrawLine_Fast(fd, sf, px, py, txt, iColor, Style, wd)
				Else
					Dim i As Integer = 0		' 遍历字的位置
					Dim wx As Integer = 0		' 文字绘制横向偏移
					Dim As Integer w, h
					Do While txt[i]
						' 渲染文字
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
					Dim i As Integer = 0		' 遍历字的位置
					Dim wx As Integer = 0		' 文字绘制横向偏移
					Dim As Integer iCode, w, h
					Do While txt[i]
						' 获取一个字
						If txt[i] < &H80 Then
							iCode = Cast(UByte Ptr, txt)[i]
						Else
							iCode = (Cast(UByte Ptr, txt)[i] Shl 8) + Cast(UByte Ptr, txt)[i + 1]
							i += 1
						EndIf
						' 渲染文字
						fd->WordInfoA(fd, iCode, Style, @w, @h)
						fd->DrawWordA(fd, sf, px + wx, py, w, h, iCode, iColor, Style)
						wx += w + wd
						i += 1
					Loop
				EndIf
			EndIf
		End Sub
		
		' 矩形格式化写字 [ align:对其方式、wd:字间距、ld:行间距 ]
		Sub DrawRect(sf As xge.Surface Ptr, px As Integer, py As Integer, pw As Integer, ph As Integer, txt As WString Ptr, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, align As Integer = XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, wd As Integer = 0, ld As Integer = 0) XGE_EXPORT_ALL
			Dim fd As FontDriver Ptr = xge_fontlist.GetPtrStruct(fontid)
			If fd Then
				If fd->DrawRect_Fast Then
					fd->DrawRect_Fast(fd, sf, px, py, pw, ph, txt, iColor, Style, align, wd, ld)
				Else
					' 统计行数 [垂直居中、居下的时候用]
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
							' 纵向居中
							DrawOffsetY = py + (ph - ((LineCount * (fd->HeightInt + ld)) - ld)) \ 2
						Case XGE_ALIGN_BOTTOM
							' 纵向居下
							DrawOffsetY = py + ph - ((LineCount * (fd->HeightInt + ld)) - ld)
						Case Else
							' 纵向居上
							DrawOffsetY = py + 0
					End Select
					' 渲染文字
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
										' 横向居中
										Draw(sf, px + (pw - DrawOffsetX) \ 2, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
									Case XGE_ALIGN_RIGHT
										' 横向居右
										Draw(sf, px + pw - DrawOffsetX, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
									Case Else
										' 横向居左
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
					' 补充渲染
					If DrawOffsetX <> 0 Then
						DrawOffsetX -= wd
						Select Case (align And (XGE_ALIGN_CENTER Or XGE_ALIGN_RIGHT))
							Case XGE_ALIGN_CENTER
								' 横向居中
								Draw(sf, px + (pw - DrawOffsetX) \ 2, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
							Case XGE_ALIGN_RIGHT
								' 横向居右
								Draw(sf, px + pw - DrawOffsetX, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
							Case Else
								' 横向居左
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
					' 统计行数 [垂直居中、居下的时候用]
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
							' 纵向居中
							DrawOffsetY = py + (ph - ((LineCount * (fd->HeightInt + ld)) - ld)) \ 2
						Case XGE_ALIGN_BOTTOM
							' 纵向居下
							DrawOffsetY = py + ph - ((LineCount * (fd->HeightInt + ld)) - ld)
						Case Else
							' 纵向居上
							DrawOffsetY = py + 0
					End Select
					' 渲染文字
					i = 0
					Dim As Integer iCode, w, h
					Dim DrawOffsetX As Integer = 0
					Dim DrawSubText As ZString Ptr = txt
					Do While txt[i]
						If txt[i] And &H80 Then
							' 宽字符文字
							iCode = (Cast(UByte Ptr, txt)[i] Shl 8) + Cast(UByte Ptr, txt)[i + 1]
							fd->WordInfoA(fd, iCode, Style, @w, @h)
							DrawOffsetX += w + wd
							i += 1
						ElseIf txt[i] = 10 Then
							' 分行处理
							If DrawOffsetX <> 0 Then
								Cast(UByte Ptr, txt)[i] = 0
								DrawOffsetX -= wd
								Select Case (align And (XGE_ALIGN_CENTER Or XGE_ALIGN_RIGHT))
									Case XGE_ALIGN_CENTER
										' 横向居中
										DrawA(sf, px + (pw - DrawOffsetX) \ 2, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
									Case XGE_ALIGN_RIGHT
										' 横向居右
										DrawA(sf, px + pw - DrawOffsetX, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
									Case Else
										' 横向居左
										DrawA(sf, px, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
								End Select
								Cast(UByte Ptr, txt)[i] = 10
							EndIf
							DrawSubText = @txt[i+1]
							DrawOffsetY += fd->HeightInt + ld
							DrawOffsetX = 0
						Else
							' 单字符文字
							fd->WordInfoA(fd, Cast(UByte Ptr, txt)[i], Style, @w, @h)
							DrawOffsetX += w + wd
						EndIf
						i += 1
					Loop
					' 补充渲染
					If DrawOffsetX <> 0 Then
						DrawOffsetX -= wd
						Select Case (align And (XGE_ALIGN_CENTER Or XGE_ALIGN_RIGHT))
							Case XGE_ALIGN_CENTER
								' 横向居中
								DrawA(sf, px + (pw - DrawOffsetX) \ 2, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
							Case XGE_ALIGN_RIGHT
								' 横向居右
								DrawA(sf, px + pw - DrawOffsetX, DrawOffsetY, DrawSubText, iColor, fontid, Style, wd)
							Case Else
								' 横向居左
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