'==================================================================================
	'�� xywh File System Object ini�ļ���
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================



' -------------------------- ��������
Dim Shared xge_global_snull As ZString * 4 = !"\0\0\0"					' ���ַ���



#Ifndef xywh_library_inifile
	#Define xywh_library_inifile
	
	
	Extern XGE_EXTERNSTDEXT
		
		' ���ַ�����ֵ
		Function xIni_GetStrA(IniFile As ZString Ptr, IniSec As ZString Ptr, IniKey As ZString Ptr) As ZString Ptr XGE_EXPORT_ALL
			Dim pMem As ZString Ptr = Allocate(MAX_PATH)
			If pMem Then
				Dim iLen As UInteger = GetPrivateProfileStringA(IniSec, IniKey, "", pMem, MAX_PATH, IniFile)
				pMem[iLen] = 0
				Return pMem
			Else
				Return @xge_global_snull
			EndIf
		End Function
		Function xIni_GetStrW(IniFile As WString Ptr, IniSec As WString Ptr, IniKey As WString Ptr) As WString Ptr XGE_EXPORT_ALL
			Dim pMem As WString Ptr = Allocate(MAX_PATH * SizeOf(WString))
			If pMem Then
				Dim iLen As UInteger = GetPrivateProfileStringW(IniSec, IniKey, "", pMem, MAX_PATH, IniFile)
				pMem[iLen] = 0
				Return pMem
			Else
				Return Cast(Any Ptr, @xge_global_snull)
			EndIf
		End Function
		
		' ��������ֵ
		Function xIni_GetIntA(IniFile As ZString Ptr, IniSec As ZString Ptr, IniKey As ZString Ptr) As Integer XGE_EXPORT_ALL
			Return GetPrivateProfileIntA(IniSec, IniKey, 0, IniFile)
		End Function
		Function xIni_GetIntW(IniFile As WString Ptr, IniSec As WString Ptr, IniKey As WString Ptr) As Integer XGE_EXPORT_ALL
			Return GetPrivateProfileIntW(IniSec, IniKey, 0, IniFile)
		End Function
		
		' д�ַ�����ֵ
		Function xIni_SetStrA(IniFile As ZString Ptr, IniSec As ZString Ptr, IniKey As ZString Ptr, kValue As ZString Ptr) As Integer XGE_EXPORT_ALL
			Return WritePrivateProfileStringA(IniSec, IniKey, kValue, IniFile)
		End Function
		Function xIni_SetStrW(IniFile As WString Ptr, IniSec As WString Ptr, IniKey As WString Ptr, kValue As WString Ptr) As Integer XGE_EXPORT_ALL
			Return WritePrivateProfileStringW(IniSec, IniKey, kValue, IniFile)
		End Function
		
	End Extern
#EndIf
