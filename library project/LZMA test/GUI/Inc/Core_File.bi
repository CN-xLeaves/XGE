#Include Once "win\commdlg.bi"
#Define xywhCoreFile



#Define xywh_IsFile




Type BROWSEINFO
	hwndOwner As HWND
	pidlRoot As Integer
	pszDisplayName As ZString Ptr
	lpszTitle As ZString Ptr
	ulFlags As Integer
	lpfn As Integer
	lParam As Integer
	iImage As Integer
End Type




/'
	函数名称 : PutFile
	函数作者 : 叶子的离开
	函数功能 : 将指定内容写入到指定文件中
	容错能力 : 严谨错误处理
	参数说明 : FileName[文件名]		OutBuffer[写入的数据]		StartPoint[写入起始点]		OutLenght[写入长度]
	返 回 值 : 成功返回 0 , 否则为 GetLastError 取得的数值
'/
Function PutFile(ByVal FileName As ZString Ptr,ByVal OutBuffer As Any Ptr,ByVal StartPoint As Integer,ByVal OutLenght As Integer) As Integer
	#Ifdef LogOutPut
		AddLog("	PutFile	函数执行 , 参数列表 : FileName[" & *FileName & "]  StartPoint[" & StartPoint & "]  OutLenght[" & OutLenght & "]")
	#EndIf
	Dim As HANDLE File_HANDLE = CreateFile(FileName,GENERIC_WRITE,FILE_SHARE_READ,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)
	If File_HANDLE = INVALID_HANDLE_VALUE Then
		#Ifdef LogOutPut
			AddLog("Error : [CreateFile] , GetLastError : " & GetLastError())
		#EndIf
		PutFile = GetLastError()
	Else
		Dim As Integer oRet = SetFilePointer(File_HANDLE,StartPoint,0,FILE_BEGIN)
		If oRet = -1 Then
			#Ifdef LogOutPut
				AddLog("Error : [SetFilePointer] , GetLastError : " & GetLastError())
			#EndIf
			PutFile = GetLastError()
		Else
			Dim TOL As OVERLAPPED
			TOL.Offset = oRet
			If WriteFile(File_HANDLE,OutBuffer,OutLenght,NULL,@TOL) Then
				PutFile = 0
			Else
				#Ifdef LogOutPut
					AddLog("Error : [WriteFile] , GetLastError : " & GetLastError())
				#EndIf
				PutFile = GetLastError()
			EndIf
		EndIf
	EndIf
	CloseHandle(File_HANDLE)
End Function


/'
	函数名称 : PutFile_h
	函数作者 : 叶子的离开
	函数功能 : 将指定内容写入到指定文件句柄中
	容错能力 : 严谨错误处理
	参数说明 : File_HANDLE[文件句柄]		OutBuffer[写入的数据]		StartPoint[写入起始点]		OutLenght[写入长度]
	返 回 值 : 成功返回 0 , 否则为 GetLastError 取得的数值
'/
Function PutFile_h(ByVal File_HANDLE As HANDLE,ByVal OutBuffer As Any Ptr,ByVal StartPoint As Integer,ByVal OutLenght As Integer) As Integer
	#Ifdef LogOutPut
		AddLog("	PutFile_h	函数执行 , 参数列表 : File_HANDLE[" & File_HANDLE & "]  StartPoint[" & StartPoint & "]  OutLenght[" & OutLenght & "]")
	#EndIf
	Dim As Integer oRet = SetFilePointer(File_HANDLE,StartPoint,0,FILE_BEGIN)
	If oRet = -1 Then
		#Ifdef LogOutPut
			AddLog("Error : [SetFilePointer] , GetLastError : " & GetLastError())
		#EndIf
		PutFile_h = GetLastError()
	Else
		Dim TOL As OVERLAPPED
		TOL.Offset = oRet
		If WriteFile(File_HANDLE,OutBuffer,OutLenght,NULL,@TOL) Then
			PutFile_h = 0
		Else
			#Ifdef LogOutPut
				AddLog("Error : [WriteFile] , GetLastError : " & GetLastError())
			#EndIf
			PutFile_h = GetLastError()
		EndIf
	EndIf
End Function


/'
	函数名称 : GetFile
	函数作者 : 叶子的离开
	函数功能 : 读取指定文件的内容到缓冲区
	容错能力 : 严谨错误处理
	参数说明 : FileName[文件名]		OutBuffer[准备的数据]		StartPoint[读取起始点]		GetLenght[读取长度]
	返 回 值 : 成功返回 0 , 否则为 GetLastError 取得的数值
'/
Function GetFile(ByVal FileName As ZString Ptr,ByVal InBuffer As Any Ptr,ByVal StartPoint As Integer,ByVal GetLenght As Integer) As Integer
	Dim File_HANDLE As HANDLE
	#Ifdef LogOutPut
	AddLog("	GetFile	函数执行 , 参数列表 : FileName[" & *FileName & "]  StartPoint[" & StartPoint & "]  GetLenght[" & GetLenght & "]")
	#EndIf
	File_HANDLE = CreateFile(FileName,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)
	If File_HANDLE = INVALID_HANDLE_VALUE Then
		#Ifdef LogOutPut
			AddLog("Error : [CreateFile] , GetLastError : " & GetLastError())
		#EndIf
		GetFile = GetLastError()
	Else
		Dim As Integer oRet = SetFilePointer(File_HANDLE,StartPoint,0,FILE_BEGIN)
		If oRet = -1 Then
			#Ifdef LogOutPut
				AddLog("Error : [SetFilePointer] , GetLastError : " & GetLastError())
			#EndIf
			GetFile = GetLastError()
		Else
			Dim TOL As OVERLAPPED
			TOL.Offset = oRet
			If ReadFile(File_HANDLE,InBuffer,GetLenght,NULL,@TOL) Then
				GetFile = 0
			Else
				#Ifdef LogOutPut
					AddLog("Error : [ReadFile] , GetLastError : " & GetLastError())
				#EndIf
				GetFile = GetLastError()
			EndIf
		EndIf
	EndIf
	CloseHandle(File_HANDLE)
End Function


/'
	函数名称 : PutFile_h
	函数作者 : 叶子的离开
	函数功能 : 将指定内容写入到指定文件句柄中
	容错能力 : 严谨错误处理
	参数说明 : File_HANDLE[文件句柄]		OutBuffer[写入的数据]		StartPoint[写入起始点]		GetLenght[读取长度]
	返 回 值 : 成功返回 0 , 否则为 GetLastError 取得的数值
'/
Function GetFile_h(ByVal File_HANDLE As HANDLE,ByVal InBuffer As Any Ptr,ByVal StartPoint As Integer,ByVal GetLenght As Integer) As Integer
	#Ifdef LogOutPut
	AddLog("	GetFile_h	函数执行 , 参数列表 : File_HANDLE[" & File_HANDLE & "]  StartPoint[" & StartPoint & "]  GetLenght[" & GetLenght & "]")
	#EndIf
	Dim As Integer oRet = SetFilePointer(File_HANDLE,StartPoint,NULL,FILE_BEGIN)
	If oRet = -1 Then
		#Ifdef LogOutPut
			AddLog("Error : [SetFilePointer] , GetLastError : " & GetLastError())
		#EndIf
		GetFile_h = GetLastError()
	Else
		Dim TOL As OVERLAPPED
		TOL.Offset = oRet
		If ReadFile(File_HANDLE,InBuffer,GetLenght,NULL,@TOL) Then
			GetFile_h = 0
		Else
			#Ifdef LogOutPut
			AddLog("Error : [ReadFile] , GetLastError : " & GetLastError())
			#EndIf
			GetFile_h = GetLastError()
		EndIf
	EndIf
End Function


/'
	函数名称 : FileExists
	函数作者 : 叶子的离开
	函数功能 : 判断一个文件是否存在
	容错能力 : 严谨错误处理
	参数说明 : FileName[文件名]
	返 回 值 : 成功返回 -1 , 失败返回 0
'/
Function FileExists(ByVal FileName As ZString Ptr) As Integer
	Dim File_HANDLE As HANDLE
	#Ifdef LogOutPut
		AddLog("	FileExists	函数执行 , 参数列表 : FileName[" & *FileName & "]")
	#EndIf
	File_HANDLE = CreateFile(FileName,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL)
	If File_HANDLE <> INVALID_HANDLE_VALUE Then
		FileExists = -1
	EndIf
	CloseHandle(File_HANDLE)
End Function


/'
	函数名称 : FileLen
	函数作者 : 叶子的离开
	函数功能 : 取得指定文件的大小
	容错能力 : 严谨错误处理
	参数说明 : FileName[文件名]
	返 回 值 : 成功返回文件大小 , 失败返回 0
'/
Function FileLen(ByVal FileName As ZString Ptr) As Integer
	Dim File_HANDLE As HANDLE
	#Ifdef LogOutPut
		AddLog("	FileLen	函数执行 , 参数列表 : FileName[" & *FileName & "]")
	#EndIf
	File_HANDLE = CreateFile(FileName,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)
	If File_HANDLE = INVALID_HANDLE_VALUE Then
		#Ifdef LogOutPut
			AddLog("Error : [CreateFile] , GetLastError : " & GetLastError())
		#EndIf
	Else
		FileLen = GetFileSize(File_HANDLE,NULL)
		CloseHandle(File_HANDLE)
	EndIf
End Function


/'
	函数名称 : FileLen_h
	函数作者 : 叶子的离开
	函数功能 : 取得指定文件句柄对应文件的大小
	容错能力 : 严谨错误处理
	参数说明 : File_HANDLE[文件句柄]
	返 回 值 : 成功返回文件大小 , 失败返回 0
'/
Function FileLen_h(ByVal File_HANDLE As HANDLE) As Integer
	#Ifdef LogOutPut
		AddLog("	FileLen_h	函数执行 , 参数列表 : File_HANDLE[" & File_HANDLE & "]")
	#EndIf
	FileLen_h = GetFileSize(File_HANDLE,NULL)
End Function


/'
	函数名称 : GetOpenFile
	函数作者 : 叶子的离开
	函数功能 : 打开一个文件并返回句柄
	容错能力 : 严谨错误处理
	参数说明 : FileName[文件名]
	返 回 值 : 成功返回文件句柄 , 失败返回 -1
'/
Function GetOpenFile(ByVal FileName As ZString Ptr,OnlyRead As Integer = 0) As HANDLE
	Dim File_HANDLE As HANDLE
	#Ifdef LogOutPut
		AddLog("	GetOpenFile	函数执行 , 参数列表 : FileName[" & *FileName & "]")
	#EndIf
	If OnlyRead Then
		File_HANDLE = CreateFile(FileName,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)
	Else
		File_HANDLE = CreateFile(FileName,GENERIC_READ Or GENERIC_WRITE,FILE_SHARE_READ,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)
	EndIf
	If File_HANDLE = INVALID_HANDLE_VALUE Then
	Else
		GetOpenFile = File_HANDLE
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
			*RndFile &= Chr(CByte(Rnd * 26) + 65)
		Next
		If EndStr <> NULL Then
			*RndFile &= *EndStr
		EndIf
		If FileExists(RndFile)=0 Then Exit Do
	Loop
	lstrcpy(FileName,RndFile)
	DeAllocate(RndFile)
End Sub

/'
	函数名称 : SetFileSize
	函数作者 : 叶子的离开
	函数功能 : 直接设置一个文件的大小
	容错能力 : 次严谨错误处理
	参数说明 : FileName[文件名]		FileSize[文件大小]
	返 回 值 : 成功返回 -1 , 失败返回 0
'/
Function SetFileSize(ByVal FileName As ZString Ptr,ByVal FileSize As Integer) As Integer
	Dim File_HANDLE As HANDLE
	#Ifdef LogOutPut
		AddLog("	SetFileSize	函数执行 , 参数列表 : FileName[" & *FileName & "]  FileSize[" & FileSize & "]")
	#EndIf
	File_HANDLE = CreateFile(FileName,GENERIC_READ Or GENERIC_WRITE,FILE_SHARE_READ,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)
	If File_HANDLE = INVALID_HANDLE_VALUE Then
		#Ifdef LogOutPut
			AddLog("Error : [CreateFile] , GetLastError : " & GetLastError())
		#EndIf
	Else
		SetFilePointer(File_HANDLE,FileSize,0,FILE_BEGIN)
		SetEndOfFile(File_HANDLE)
		SetFileSize = -1
		CloseHandle(File_HANDLE)
	EndIf
End Function


/'
	函数名称 : PutLogFile
	函数作者 : 叶子的离开
	函数功能 : 输出内容到文件并自动设置文件大小
	容错能力 : 次严谨错误处理
	参数说明 : FileName[文件名]		OutBuffer[写入的数据]		StartPoint[写入起始点]		OutLenght[写入长度]
	返 回 值 : 成功返回 0 , 否则为 GetLastError 取得的数值
'/
Function PutLogFile(ByVal FileName As ZString Ptr,ByVal OutBuffer As Any Ptr,ByVal StartPoint As Integer,ByVal OutLenght As Integer) As Integer
	PutLogFile = PutFile(FileName,OutBuffer,StartPoint,OutLenght)
	SetFileSize(FileName,OutLenght+StartPoint)
End Function


/'
	函数名称 : NewFile
	函数作者 : 叶子的离开
	函数功能 : 新建一个文件
	容错能力 : 严谨错误处理
	参数说明 : FileName[文件名]
	返 回 值 : 成功返回 -1 , 失败返回 0
'/
Function NewFile(ByVal FileName As ZString Ptr) As Integer
	Dim File_HANDLE As HANDLE
	#Ifdef LogOutPut
		AddLog("	NewFile	函数执行 , 参数列表 : FileName[" & *FileName & "]")
	#EndIf
	File_HANDLE = CreateFile(FileName,GENERIC_WRITE,FILE_SHARE_READ,NULL,CREATE_NEW,FILE_ATTRIBUTE_NORMAL,NULL)
	If File_HANDLE = INVALID_HANDLE_VALUE Then
		#Ifdef LogOutPut
			AddLog("Error : [CreateFile] , GetLastError : " & GetLastError())
		#EndIf
	Else
		NewFile = -1
	EndIf
	CloseHandle(File_HANDLE)
End Function



Function OpenFolderDlg(ByVal hWin As HWND,ByVal OutPath As ZString Ptr) As Integer
	Dim ShellHdr As HANDLE
	ShellHdr = LoadLibrary("shell32.dll")
	If ShellHdr Then
		Dim SHBrowseForFolder As Function(lpBrowseInfo As Any Ptr) As Any Ptr
		SHBrowseForFolder = Cast(Any Ptr,GetProcAddress(ShellHdr,"SHBrowseForFolderA"))
		If SHBrowseForFolder Then
			Dim Bi As BROWSEINFO
			Bi.hwndOwner = hWin
			Bi.pidlRoot = NULL
			Bi.pszDisplayName = Allocate(256)
			Bi.lpszTitle = StrPtr("浏览文件夹 :")
			Bi.ulFlags = 0
			Bi.lpfn = NULL
			Bi.lParam = 0
			Bi.iImage = NULL
			Dim IDList As Any Ptr
			IDList = SHBrowseForFolder(@Bi)
			If IDList Then
				Dim SHGetPathFromIDList As Function(lpIDList As Any Ptr,OutBuffer As Any Ptr) As Integer
				SHGetPathFromIDList = Cast(Any Ptr,GetProcAddress(ShellHdr,"SHGetPathFromIDListA"))
				If SHGetPathFromIDList Then
					SHGetPathFromIDList(IDList,OutPath)
					OpenFolderDlg = -1
				EndIf
			EndIf
		EndIf
	EndIf
End Function

Function OpenFileDlg(ByVal hWin As HWND,ByVal FilePath As ZString Ptr,ByVal FilterStr As ZString Ptr) As Integer
	Dim ofn As OPENFILENAME
	ofn.lStructSize = SizeOf(OPENFILENAME)
	ofn.hwndOwner = hWin
	ofn.hInstance = GetModuleHandle(NULL)
	ofn.lpstrFilter = FilterStr
	ofn.lpstrFile = FilePath
	ofn.lpstrInitialDir = FilePath
	ofn.nMaxFile = 260
	ofn.lpstrTitle = StrPtr("打开文件 :")
	ofn.Flags = OFN_PATHMUSTEXIST Or OFN_HIDEREADONLY Or OFN_FILEMUSTEXIST Or OFN_EXPLORER
	If GetOpenFileName(@ofn) Then
		OpenFileDlg = -1
	EndIf
End Function

Function SaveFileDlg(ByVal hWin As HWND,ByVal FilePath As ZString Ptr,ByVal FilterStr As ZString Ptr) As Integer
	Dim ofn As OPENFILENAME
	ofn.lStructSize = SizeOf(OPENFILENAME)
	ofn.hwndOwner = hWin
	ofn.hInstance = GetModuleHandle(NULL)
	ofn.lpstrFilter = FilterStr
	ofn.lpstrFile = FilePath
	ofn.lpstrInitialDir = FilePath
	ofn.nMaxFile = 260
	ofn.lpstrTitle = StrPtr("保存文件 :")
	ofn.Flags = OFN_PATHMUSTEXIST Or OFN_HIDEREADONLY Or OFN_OVERWRITEPROMPT Or OFN_EXPLORER
	If GetSaveFileName(@ofn) Then
		SaveFileDlg = -1
	EndIf
End Function