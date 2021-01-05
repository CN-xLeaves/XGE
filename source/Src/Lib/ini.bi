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
	
	
	Extern XGE_EXTERNMODULE
		Namespace xIni
			
			' ���ַ�����ֵ
			Function GetStr(IniFile As ZString Ptr, IniSec As ZString Ptr, IniKey As ZString Ptr) As ZString Ptr XGE_EXPORT_ALL
				Dim pMem As ZString Ptr = Allocate(MAX_PATH)
				If pMem Then
					Dim iLen As UInteger = GetPrivateProfileString(IniSec, IniKey, "", pMem, MAX_PATH, IniFile)
					pMem[iLen] = 0
					Return pMem
				Else
					Return @xge_global_snull
				EndIf
			End Function
			
			' ��������ֵ
			Function GetInt(IniFile As ZString Ptr, IniSec As ZString Ptr, IniKey As ZString Ptr) As Integer XGE_EXPORT_ALL
				Return GetPrivateProfileInt(IniSec, IniKey, 0, IniFile)
			End Function
			
			' д�ַ�����ֵ
			Function SetStr(IniFile As ZString Ptr, IniSec As ZString Ptr, IniKey As ZString Ptr, kValue As ZString Ptr) As Integer XGE_EXPORT_ALL
				Return WritePrivateProfileString(IniSec, IniKey, kValue, IniFile)
			End Function
			
			' ö�ټ�
			Function EnumSec(IniFile As ZString Ptr, OutArr As ZString Ptr Ptr Ptr) As Integer XGE_EXPORT_ALL
				Dim pMem As ZString Ptr = Allocate(32768)
				If pMem Then
					Dim iLen As UInteger = GetPrivateProfileSectionNames(pMem, 32768, IniFile)
					If iLen Then
						' ͳ��С������
						Dim cSec As Integer = 1
						For i As Integer = 0 To iLen - 2
							If pMem[i] = 0 Then
								cSec += 1
							EndIf
						Next
						' ���С������
						If OutArr Then
							Dim aMem As ZString Ptr Ptr = Allocate(SizeOf(ZString Ptr) * (cSec + 1))
							Dim aIdx As Integer
							If aMem Then
								aMem[0] = pMem
								For i As Integer = 0 To iLen - 2
									If pMem[i] = 0 Then
										aIdx += 1
										aMem[aIdx] = @pMem[i + 1]
									EndIf
								Next
								aMem[cSec] = NULL
								*OutArr = aMem
							Else
								Return 0
							EndIf
						EndIf
						Return cSec
					EndIf
				EndIf
			End Function
			
			' ö�ټ�ֵ
			Function EnumKey(IniFile As ZString Ptr, IniSec As ZString Ptr, OutArr As ZString Ptr Ptr Ptr) As Integer XGE_EXPORT_ALL
				Dim pMem As ZString Ptr = Allocate(32768)
				If pMem Then
					Dim iLen As UInteger = GetPrivateProfileSection(IniSec, pMem, 32768, IniFile)
					If iLen Then
						' ͳ�Ƽ�����
						Dim cKey As Integer = 1
						For i As Integer = 0 To iLen - 2
							If pMem[i] = 0 Then
								cKey += 1
							EndIf
						Next
						' ����ֵ����
						If OutArr Then
							Dim aMem As ZString Ptr Ptr = Allocate(SizeOf(ZString Ptr) * (cKey + 1))
							Dim aIdx As Integer
							If aMem Then
								aMem[0] = pMem
								For i As Integer = 0 To iLen - 2
									If pMem[i] = 0 Then
										aIdx += 1
										aMem[aIdx] = @pMem[i + 1]
									EndIf
								Next
								aMem[cKey] = NULL
								*OutArr = aMem
							Else
								Return 0
							EndIf
						EndIf
						Return cKey
					EndIf
				EndIf
			End Function
		End Namespace
	End Extern
#EndIf
