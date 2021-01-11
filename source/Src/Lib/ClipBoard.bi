


Extern XGE_EXTERNSTDEXT
	
	
	
	' 获取文本
	Function Clip_GetText() As WString Ptr XGE_EXPORT_LIB
		If OpenClipboard(NULL) Then
			If IsClipboardFormatAvailable(CF_UNICODETEXT) Then
				Dim hMem As HGLOBAL = GetClipboardData(CF_UNICODETEXT)
				If hMem Then
					Dim lpStr As WString Ptr = GlobalLock(hMem)
					If lpStr Then
						Dim sMem As UInteger = wcslen(lpStr)
						Dim pMem As WString Ptr = Allocate((sMem + 1) * SizeOf(WString))
						If pMem Then
							memcpy(pMem, lpStr, sMem * SizeOf(WString))
							pMem[sMem] = 0
							Function = pMem
						Else
							Function = Cast(WString Ptr, @xge_global_snull)
						EndIf
						GlobalUnlock(hMem)
					Else
						Function = Cast(WString Ptr, @xge_global_snull)
					EndIf
				Else
					Function = Cast(WString Ptr, @xge_global_snull)
				EndIf
			Else
				Function = Cast(WString Ptr, @xge_global_snull)
			EndIf
			CloseClipboard()
		EndIf
	End Function
	
	' 设置文本
	Function Clip_SetText(Text As WString Ptr, Size As UInteger = 0) As Integer XGE_EXPORT_LIB
		If OpenClipboard(NULL) Then
			EmptyClipboard()
			If Size = 0 Then
				Size = wcslen(Text)
			EndIf
			Dim hMem As HGLOBAL = GlobalAlloc(GMEM_MOVEABLE, (Size + 1) * SizeOf(WString))
			If hMem Then
				Dim lpStr As WString Ptr = GlobalLock(hMem)
				If lpStr Then
					memcpy(lpStr, Text, Size * SizeOf(WString))
					lpStr[Size] = 0
					GlobalUnlock(hMem)
					SetClipboardData(CF_UNICODETEXT, hMem)
					Function = -1
				EndIf
			EndIf
			CloseClipboard()
		EndIf
	End Function
	
	
	
	' 获取文本
	Function Clip_GetTextA() As ZString Ptr XGE_EXPORT_LIB
		If OpenClipboard(NULL) Then
			If IsClipboardFormatAvailable(CF_TEXT) Then
				Dim hMem As HGLOBAL = GetClipboardData(CF_TEXT)
				If hMem Then
					Dim lpStr As ZString Ptr = GlobalLock(hMem)
					If lpStr Then
						Dim sMem As UInteger = strlen(lpStr)
						Dim pMem As ZString Ptr = Allocate(sMem + 1)
						If pMem Then
							memcpy(pMem, lpStr, sMem)
							pMem[sMem] = 0
							Function = pMem
						Else
							Function = @xge_global_snull
						EndIf
						GlobalUnlock(hMem)
					Else
						Function = @xge_global_snull
					EndIf
				Else
					Function = @xge_global_snull
				EndIf
			Else
				Function = @xge_global_snull
			EndIf
			CloseClipboard()
		EndIf
	End Function
	
	' 设置文本
	Function Clip_SetTextA(Text As ZString Ptr, Size As UInteger = 0) As Integer XGE_EXPORT_LIB
		If OpenClipboard(NULL) Then
			EmptyClipboard()
			If Size = 0 Then
				Size = strlen(Text)
			EndIf
			Dim hMem As HGLOBAL = GlobalAlloc(GMEM_MOVEABLE, Size + 1)
			If hMem Then
				Dim lpStr As ZString Ptr = GlobalLock(hMem)
				If lpStr Then
					memcpy(lpStr, Text, Size)
					lpStr[Size] = 0
					GlobalUnlock(hMem)
					SetClipboardData(CF_TEXT, hMem)
					Function = -1
				EndIf
			EndIf
			CloseClipboard()
		EndIf
	End Function
	
	
	
End Extern


