#Include Once "Windows.bi"



#Define xywh_library_file



Type xywhFileSystem
	FileHdr As HANDLE
	FileName As ZString * 260
	FileAddr As Integer
	FileSize As Integer
End Type



/'
	函数名称 : PutFileD
	函数作者 : 叶子的离开
	函数功能 : 将数据写入文件
	参数说明 : FileName[文件名]		Buffer[写入的数据]		Addr[写入起始点]		Lenght[写入长度]
	返 回 值 : 成功返回写入字节数量 ,失败返回0
'/
Function PutFile(ByVal FileName As ZString Ptr,ByVal Buffer As Any Ptr,ByVal Addr As Integer,ByVal Lenght As Integer) As Integer
	Dim FileHdr As HANDLE = CreateFile(FileName,GENERIC_WRITE,FILE_SHARE_READ,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)
	If FileHdr <> INVALID_HANDLE_VALUE Then
		Dim FileAddr As Integer = SetFilePointer(FileHdr,Addr,0,FILE_BEGIN)
		If FileAddr <> HFILE_ERROR Then
			Dim TOL As OVERLAPPED
			Dim WriteBytes As Integer
			TOL.Offset = FileAddr
			If WriteFile(FileHdr,Buffer,Lenght,@WriteBytes,@TOL) Then
				CloseHandle(FileHdr)
				Return WriteBytes
			EndIf
		Else
			CloseHandle(FileHdr)
		EndIf
	EndIf
End Function



/'
	函数名称 : GetFileD
	函数作者 : 叶子的离开
	函数功能 : 读取指定文件的内容到缓冲区
	参数说明 : FileName[文件名]		OutBuffer[准备的数据]		StartPoint[读取起始点]		GetLenght[读取长度]
	返 回 值 : 成功返回 0 , 否则为 GetLastError 取得的数值
'/
Function GetFile(ByVal FileName As ZString Ptr,ByVal Buffer As Any Ptr,ByVal Addr As Integer,ByVal Lenght As Integer) As Integer
	Dim FileHdr As HANDLE = CreateFile(FileName,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL)
	If FileHdr <> INVALID_HANDLE_VALUE Then
		Dim FileAddr As Integer = SetFilePointer(FileHdr,Addr,0,FILE_BEGIN)
		If FileAddr <> HFILE_ERROR Then
			Dim TOL As OVERLAPPED
			Dim ReadBytes As Integer
			TOL.Offset = FileAddr
			If ReadFile(FileHdr,Buffer,Lenght,@ReadBytes,@TOL) Then
				CloseHandle(FileHdr)
				Return ReadBytes
			EndIf
		EndIf
	EndIf
End Function

Function NewFile(ByVal FileName As ZString Ptr) As Integer
	Dim FileHdr As HANDLE = CreateFile(FileName,GENERIC_WRITE,FILE_SHARE_READ,NULL,CREATE_NEW,FILE_ATTRIBUTE_NORMAL,NULL)
	If FileHdr <> INVALID_HANDLE_VALUE Then
		CloseHandle(FileHdr)
		Return -1
	EndIf
End Function

Function FileExists(ByVal FileName As ZString Ptr) As Integer
	Dim FileHdr As HANDLE = CreateFile(FileName,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL)
	If FileHdr <> INVALID_HANDLE_VALUE Then
		CloseHandle(FileHdr)
		Return -1
	EndIf
End Function

Function FileLen(ByVal FileName As ZString Ptr) As Integer
	Dim FileHdr As HANDLE = CreateFile(FileName,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)
	If FileHdr <> INVALID_HANDLE_VALUE Then
		FileLen = GetFileSize(FileHdr,NULL)
		CloseHandle(FileHdr)
	EndIf
End Function

Function SetFileSize(ByVal FileName As ZString Ptr,ByVal FileSize As Integer) As Integer
	Dim FileHdr As HANDLE = CreateFile(FileName,GENERIC_READ Or GENERIC_WRITE,FILE_SHARE_READ,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)
	If FileHdr <> INVALID_HANDLE_VALUE Then
		SetFilePointer(FileHdr,FileSize,0,FILE_BEGIN)
		SetEndOfFile(FileHdr)
		CloseHandle(FileHdr)
		Return -1
	EndIf
End Function

Sub GetRandomFileName(ByVal FileName As ZString Ptr,ByVal DirStr As ZString Ptr,ByVal EndStr As ZString Ptr,ByVal RndStrLen As Integer = 8)
	Dim RndFile As ZString Ptr = Allocate(260)
	Dim i As Integer
	Do
		ZeroMemory(RndFile,260)
		Dim TempFile As ZString Ptr = Allocate(260)
		If DirStr = NULL Then
			If GetTempPath(260,TempFile) Then
				*RndFile = *TempFile
			Else
				*RndFile = ExePath()
			EndIf
		Else
			*RndFile = *DirStr
		EndIf
		DeAllocate(TempFile)
		For i = 1 To RndStrLen
			Randomize()
			*RndFile &= Chr(CByte(Rnd * 25) + 65)
		Next
		If EndStr <> NULL Then
			*RndFile &= *EndStr
		EndIf
		If FileExists(RndFile)=0 Then Exit Do
	Loop
	lstrcpy(FileName,RndFile)
	DeAllocate(RndFile)
End Sub





Function Open_File(ByVal FileName As ZString Ptr,OnlyRead As Integer = 0) As HANDLE
	Dim FileHdr As HANDLE = CreateFile(FileName,GENERIC_READ Or IIf(OnlyRead,0,GENERIC_WRITE),FILE_SHARE_READ,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)
	If FileHdr <> INVALID_HANDLE_VALUE Then
		Return FileHdr
	EndIf
End Function

Function Put_File(ByVal FileHdr As HANDLE,ByVal Buffer As Any Ptr,ByVal Addr As Integer,ByVal Lenght As Integer) As Integer
	Dim FileAddr As Integer = SetFilePointer(FileHdr,Addr,0,FILE_BEGIN)
	If FileAddr <> HFILE_ERROR Then
		Dim TOL As OVERLAPPED
		Dim WriteBytes As Integer
		TOL.Offset = FileAddr
		If WriteFile(FileHdr,Buffer,Lenght,@WriteBytes,@TOL) Then
			Return WriteBytes
		EndIf
	EndIf
End Function

Function Get_File(ByVal FileHdr As HANDLE,ByVal Buffer As Any Ptr,ByVal Addr As Integer,ByVal Lenght As Integer) As Integer
	Dim FileAddr As Integer = SetFilePointer(FileHdr,Addr,0,FILE_BEGIN)
	If FileAddr <> HFILE_ERROR Then
		Dim TOL As OVERLAPPED
		Dim ReadBytes As Integer
		TOL.Offset = FileAddr
		If ReadFile(FileHdr,Buffer,Lenght,@ReadBytes,@TOL) Then
			Return ReadBytes
		EndIf
	EndIf
End Function

Function File_Len(ByVal FileHdr As HANDLE) As Integer
	Return GetFileSize(FileHdr,NULL)
End Function
