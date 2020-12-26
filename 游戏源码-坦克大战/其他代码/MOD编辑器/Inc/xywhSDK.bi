#Include Once "Windows.bi"



#Define xywh_library_xbrt



Dim Shared xywh_library_xbrt_tsptr As ZString Ptr



Namespace rtl
	
	
	
	Function Shell(ByVal Path As ZString Ptr,ByVal WinShow As Integer) As Integer
		Dim si As STARTUPINFO
		Dim pi As PROCESS_INFORMATION
		GetStartupInfo(@si)
		si.wShowWindow = WinShow
		CreateProcess(NULL,Path,NULL,NULL,FALSE,0,NULL,NULL,@si,@pi)
		WaitForInputIdle(Cast(Any Ptr,pi.hProcess),INFINITE)
		Shell = Cast(Integer,pi.hProcess)
	End Function
	
	Function Run(ByVal Path As ZString Ptr,ByVal WinShow As Integer) As Integer
		Dim si As STARTUPINFO
		Dim pi As PROCESS_INFORMATION
		GetStartupInfo(@si)
		si.wShowWindow = WinShow
		CreateProcess(NULL,Path,NULL,NULL,FALSE,0,NULL,NULL,@si,@pi)
		Run = Cast(Integer,pi.hProcess)
	End Function

	Function Chain(ByVal Path As ZString Ptr,ByVal WinShow As Integer) As Integer
		Dim si As STARTUPINFO
		Dim pi As PROCESS_INFORMATION
		GetStartupInfo(@si)
		si.wShowWindow = WinShow
		CreateProcess(NULL,Path,NULL,NULL,FALSE,0,NULL,NULL,@si,@pi)
		Chain = WaitForSingleObject(Cast(Any Ptr,pi.hProcess),-1)
	End Function

	Sub DoEvents()
		Dim wMsg As MSG
		While(PeekMessage(@wMsg,NULL,0,0,PM_REMOVE)<>FALSE)
			TranslateMessage(@wMsg)
			DispatchMessage(@wMsg)
		Wend
	End Sub
	
	Function Replace(ByVal Raw_Text as String,ByVal What_needs_to_be_Replaced as String,ByVal What_to_Replace_it_with as String) As String
		Dim Replace_Output As String
		Dim position As Long
		Dim Old_Position As Long
		Do
			Old_Position = position
			position = InStr(position + 1, lcase(Raw_Text), lcase(What_needs_to_be_Replaced))
			If 0 <> position Then
				Replace_Output = Replace_Output + Mid(Raw_Text, Old_Position + 1, (position - 1) - Old_Position)
				Replace_Output = Replace_Output + What_to_Replace_it_with
				position = position + Len(What_needs_to_be_Replaced) - 1
			Else
				Replace_Output = Replace_Output + Mid(Raw_Text, Old_Position + 1)
			End If
		Loop While 0 <> position
		Replace = Replace_Output
	End Function
	
	
	
	Namespace IniFile
		Function GetStr(ByVal IniFile As ZString Ptr,ByVal IniSec As ZString Ptr,ByVal IniKey As ZString Ptr) As ZString Ptr
			Dim TL As Integer
			DeAllocate(xywh_library_xbrt_tsptr)
			xywh_library_xbrt_tsptr = Allocate(MAX_PATH)
			TL = GetPrivateProfileString(IniSec,IniKey,"",xywh_library_xbrt_tsptr,MAX_PATH,IniFile)
			If TL Then
				xywh_library_xbrt_tsptr[TL] = 0
				GetStr = xywh_library_xbrt_tsptr
			EndIf
		End Function
		
		Function GetInt(ByVal IniFile As ZString Ptr,ByVal IniSec As ZString Ptr,ByVal IniKey As ZString Ptr) As Integer
			GetInt = GetPrivateProfileInt(IniSec,IniKey,0,IniFile)
		End Function
		
		Function SetStr(ByVal IniFile As ZString Ptr,ByVal IniSec As ZString Ptr,ByVal IniKey As ZString Ptr,ByVal KeyValue As ZString Ptr) As Integer
			SetStr = WritePrivateProfileString(IniSec,IniKey,KeyValue,IniFile)
		End Function
	End Namespace
	
	
	
	Namespace Res
		#Ifdef xywh_library_file
			Function ToFile(ByVal ResID As Integer,ByVal FileName As ZString Ptr) As Integer
				Dim ResHdr As HRSRC = FindResource(NULL,MAKEINTRESOURCE(ResID),RT_RCDATA)
				If ResHdr Then
					Dim ResSize As Integer = SizeofResource(NULL,ResHdr)
					If ResSize Then
						Dim ResData As HGLOBAL = LoadResource(NULL,ResHdr)
						If ResData Then
							PutFile(FileName,ResData,0,ResSize)
							Return -1
						EndIf
					EndIf
				EndIf
			End Function
		#EndIf
		
		Function Load(ByVal ResID As Integer) As ZString Ptr
			Dim ResHdr As HRSRC = FindResource(NULL,MAKEINTRESOURCE(ResID),RT_RCDATA)
			If ResHdr Then
				Return LoadResource(NULL,ResHdr)
			EndIf
		End Function
		
		Function Free(ByVal DataPtr As Any Ptr) As Integer
			Return FreeResource(DataPtr)
		End Function
		
		Function LoadText(ByVal ResID As Integer) As ZString Ptr
			DeAllocate(xywh_library_xbrt_tsptr)
			xywh_library_xbrt_tsptr = Allocate(260)
			If LoadString(NULL,ResID,xywh_library_xbrt_tsptr,260) Then
				Return xywh_library_xbrt_tsptr
			EndIf
		End Function
	End Namespace
End Namespace





