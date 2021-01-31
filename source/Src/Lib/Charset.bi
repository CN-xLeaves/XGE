'==================================================================================
	'★ xywh File System Object 字符集库
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



#Ifndef xywh_library_char
	#Define xywh_library_char
	
	
	
	Extern XGE_EXTERNSTDEXT
		Function AsciToUnicode(ZStrPtr As ZString Ptr, ZStrLen As UInteger = 0) As WString Ptr XGE_EXPORT_LIB
			If ZStrLen = 0 Then
				ZStrLen = strlen(ZStrPtr)
			EndIf
			Dim WStrLen As Integer = MultiByteToWideChar(CP_ACP,0,ZStrPtr,ZStrLen,NULL,0)
			Dim WStrMem As WString Ptr = Allocate(WStrLen*SizeOf(WString)+2)
			MultiByteToWideChar(CP_ACP,0,ZStrPtr,ZStrLen,WStrMem,WStrLen)
			WStrMem[WStrLen] = 0
			Return WStrMem
		End Function
		
		Function UnicodeToAsci(WStrPtr As WString Ptr, WStrLen As UInteger = 0) As ZString Ptr XGE_EXPORT_LIB
			If WStrLen = 0 Then
				WStrLen = wcslen(WStrPtr)
			EndIf
			Dim ZStrLen As Integer = WideCharToMultiByte(CP_ACP,0,WStrPtr,WStrLen,NULL,0,NULL,NULL)
			Dim ZStrMem As ZString Ptr = Allocate(ZStrLen+1)
			WideCharToMultiByte(CP_ACP,0,WStrPtr,WStrLen,ZStrMem,ZStrLen,NULL,NULL)
			ZStrMem[ZStrLen] = 0
			Return ZStrMem
		End Function
		
		Function UnicodeToUTF8(WStrPtr As WString Ptr, WStrLen As UInteger = 0) As ZString Ptr XGE_EXPORT_LIB
			If WStrLen = 0 Then
				WStrLen = wcslen(WStrPtr)
			EndIf
			Dim UTF8Len As Integer = WideCharToMultiByte(CP_UTF8,0,WStrPtr,WStrLen,NULL,0,NULL,NULL)
			Dim UTF8Mem As ZString Ptr = Allocate(UTF8Len+1)
			WideCharToMultiByte(CP_UTF8,0,WStrPtr,WStrLen,UTF8Mem,UTF8Len,NULL,NULL)
			UTF8Mem[UTF8Len] = 0
			Return UTF8Mem
		End Function
		
		Function UTF8ToUnicode(UTF8Ptr As ZString Ptr, UTF8Len As UInteger = 0) As WString Ptr XGE_EXPORT_LIB
			If UTF8Len = 0 Then
				UTF8Len = strlen(UTF8Ptr)
			EndIf
			Dim WStrLen As Integer = MultiByteToWideChar(CP_UTF8,0,UTF8Ptr,UTF8Len,NULL,0)
			Dim WStrMem As WString Ptr = Allocate(WStrLen*SizeOf(WString)+2)
			MultiByteToWideChar(CP_UTF8,0,UTF8Ptr,UTF8Len,WStrMem,WStrLen)
			WStrMem[WStrLen] = 0
			Return WStrMem
		End Function
		
		
		
		Function A2W(AStr As ZString Ptr, ALen As UInteger = 0) As WString Ptr XGE_EXPORT_LIB
			Dim pMemory As Any Ptr = AsciToUnicode(AStr, ALen)
			AddTempMemory(pMemory)
			Return pMemory
		End Function
		
		Function W2A(UStr As WString Ptr, ULen As UInteger = 0) As ZString Ptr XGE_EXPORT_LIB
			Dim pMemory As Any Ptr = UnicodeToAsci(UStr, ULen)
			AddTempMemory(pMemory)
			Return pMemory
		End Function
		
		Function W2U(UStr As WString Ptr, ULen As UInteger = 0) As ZString Ptr XGE_EXPORT_LIB
			Dim pMemory As Any Ptr = UnicodeToUTF8(UStr, ULen)
			AddTempMemory(pMemory)
			Return pMemory
		End Function
		
		Function U2W(UStr As ZString Ptr, ULen As UInteger = 0) As WString Ptr XGE_EXPORT_LIB
			Dim pMemory As Any Ptr = UTF8ToUnicode(UStr, ULen)
			AddTempMemory(pMemory)
			Return pMemory
		End Function
		
		Function A2U(ZStr As ZString Ptr, ZLen As UInteger = 0) As ZString Ptr XGE_EXPORT_LIB
			Dim TempPtr As Any Ptr
			TempPtr = AsciToUnicode(ZStr,ZLen)
			Dim pMemory As Any Ptr = UnicodeToUTF8(TempPtr,0)
			DeAllocate(TempPtr)
			AddTempMemory(pMemory)
			Return pMemory
		End Function
		
		Function U2A(UStr As ZString Ptr, ULen As UInteger = 0) As ZString Ptr XGE_EXPORT_LIB
			Dim TempPtr As Any Ptr
			TempPtr = UTF8ToUnicode(UStr,ULen)
			Dim pMemory As Any Ptr = UnicodeToAsci(TempPtr,0)
			DeAllocate(TempPtr)
			AddTempMemory(pMemory)
			Return pMemory
		End Function
	End Extern
#EndIf
