'==================================================================================
	'★ xywh File System Object 文件库
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



#Ifndef xywh_library_file
	#Define xywh_library_file
	
	
	Extern XGE_EXTERNSTDEXT
		
		Dim Shared xywh_library_xrtl_file_ecode As Integer
		
		' 创建文件
		Function xFile_CreateA(FilePath As ZString Ptr) As Integer XGE_EXPORT_ALL
			Dim FileHdr As HANDLE = CreateFileA(FilePath, GENERIC_WRITE, FILE_SHARE_READ, NULL, CREATE_NEW, FILE_ATTRIBUTE_NORMAL, NULL)
			If FileHdr <> INVALID_HANDLE_VALUE Then
				CloseHandle(FileHdr)
				Return -1
			EndIf
			Return 0
		End Function
		Function xFile_CreateW(FilePath As WString Ptr) As Integer XGE_EXPORT_ALL
			Dim FileHdr As HANDLE = CreateFileW(FilePath, GENERIC_WRITE, FILE_SHARE_READ, NULL, CREATE_NEW, FILE_ATTRIBUTE_NORMAL, NULL)
			If FileHdr <> INVALID_HANDLE_VALUE Then
				CloseHandle(FileHdr)
				Return -1
			EndIf
			Return 0
		End Function
		
		' 打开文件
		Function xFile_OpenA(FilePath As ZString Ptr, OnlyRead As Integer = 0) As HANDLE XGE_EXPORT_ALL
			Return CreateFileA(FilePath, IIf(OnlyRead, GENERIC_READ, GENERIC_READ Or GENERIC_WRITE), FILE_SHARE_READ, NULL, IIf(OnlyRead, OPEN_EXISTING, OPEN_ALWAYS), FILE_ATTRIBUTE_NORMAL, NULL)
		End Function
		Function xFile_OpenW(FilePath As WString Ptr, OnlyRead As Integer = 0) As HANDLE XGE_EXPORT_ALL
			Return CreateFileW(FilePath, IIf(OnlyRead, GENERIC_READ, GENERIC_READ Or GENERIC_WRITE), FILE_SHARE_READ, NULL, IIf(OnlyRead, OPEN_EXISTING, OPEN_ALWAYS), FILE_ATTRIBUTE_NORMAL, NULL)
		End Function
		
		' 关闭文件
		Function xFile_Close(FileHdr As HANDLE) As Integer XGE_EXPORT_ALL
			Return CloseHandle(FileHdr)
		End Function
		
		' 判断文件是否存在
		Function xFile_ExistsA(FilePath As ZString Ptr) As Integer XGE_EXPORT_ALL
			Dim FileHdr As HANDLE = CreateFileA(FilePath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
			If FileHdr = INVALID_HANDLE_VALUE Then
				If GetLastError() = 32 Then
					Return -1
				EndIf
			Else
				CloseHandle(FileHdr)
				Return -1
			EndIf
			Return 0
		End Function
		Function xFile_ExistsW(FilePath As WString Ptr) As Integer XGE_EXPORT_ALL
			Dim FileHdr As HANDLE = CreateFileW(FilePath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
			If FileHdr = INVALID_HANDLE_VALUE Then
				If GetLastError() = 32 Then
					Return -1
				EndIf
			Else
				CloseHandle(FileHdr)
				Return -1
			EndIf
			Return 0
		End Function
		
		' 向文件写入数据
		Function xFile_hwrite(FileHdr As HANDLE, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger XGE_EXPORT_ALL
			If FileHdr <> INVALID_HANDLE_VALUE Then
				Dim PutAddr As UInteger = SetFilePointer(FileHdr, Addr, 0, FILE_BEGIN)
				If PutAddr <> HFILE_ERROR Then
					Dim ol As OVERLAPPED
					Dim wb As UInteger
					ol.Offset = PutAddr
					If WriteFile(FileHdr, Buffer, Length, Cast(Any Ptr, @wb), @ol) Then
						Return wb
					EndIf
				EndIf
			EndIf
			Return 0
		End Function
		Function xFile_WriteA(FilePath As ZString Ptr, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger XGE_EXPORT_ALL
			Dim FileHdr As HANDLE = CreateFileA(FilePath, GENERIC_WRITE, FILE_SHARE_READ, NULL, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL)
			Function = xFile_hwrite(FileHdr, Buffer, Addr, Length)
			CloseHandle(FileHdr)
		End Function
		Function xFile_WriteW(FilePath As WString Ptr, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger XGE_EXPORT_ALL
			Dim FileHdr As HANDLE = CreateFileW(FilePath, GENERIC_WRITE, FILE_SHARE_READ, NULL, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL)
			Function = xFile_hwrite(FileHdr, Buffer, Addr, Length)
			CloseHandle(FileHdr)
		End Function
		
		' 从文件读出数据
		Function xFile_hRead(FileHdr As HANDLE, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger XGE_EXPORT_ALL
			If FileHdr <> INVALID_HANDLE_VALUE Then
				Dim GetAddr As Integer = SetFilePointer(FileHdr, Addr, 0, FILE_BEGIN)
				If GetAddr <> HFILE_ERROR Then
					Dim ol As OVERLAPPED
					Dim rb As UInteger
					ol.Offset = GetAddr
					If ReadFile(FileHdr, Buffer, Length, Cast(Any Ptr, @rb), @ol) Then
						Return rb
					EndIf
				EndIf
			EndIf
			Return 0
		End Function
		Function xFile_ReadA(FilePath As ZString Ptr, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger XGE_EXPORT_ALL
			Dim FileHdr As HANDLE = CreateFileA(FilePath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
			Function = xFile_hRead(FileHdr, Buffer, Addr, Length)
			CloseHandle(FileHdr)
		End Function
		Function xFile_ReadW(FilePath As WString Ptr, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger XGE_EXPORT_ALL
			Dim FileHdr As HANDLE = CreateFileW(FilePath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
			Function = xFile_hRead(FileHdr, Buffer, Addr, Length)
			CloseHandle(FileHdr)
		End Function
		
		' 获取文件长度
		Function xFile_hSize(FileHdr As HANDLE) As UInteger XGE_EXPORT_ALL
			If FileHdr <> INVALID_HANDLE_VALUE Then
				Return GetFileSize(FileHdr, NULL)
			EndIf
			Return 0
		End Function
		Function xFile_SizeA(FilePath As ZString Ptr) As UInteger XGE_EXPORT_ALL
			Dim FileHdr As HANDLE = CreateFileA(FilePath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
			Function = xFile_hSize(FileHdr)
			CloseHandle(FileHdr)
		End Function
		Function xFile_SizeW(FilePath As WString Ptr) As UInteger XGE_EXPORT_ALL
			Dim FileHdr As HANDLE = CreateFileW(FilePath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
			Function = xFile_hSize(FileHdr)
			CloseHandle(FileHdr)
		End Function
		
		' 截断
		Function xFile_hCut(FileHdr As HANDLE, FileSize As UInteger) As Integer XGE_EXPORT_ALL
			If FileHdr <> INVALID_HANDLE_VALUE Then
				SetFilePointer(FileHdr, FileSize, 0, FILE_BEGIN)
				SetEndOfFile(FileHdr)
				Return -1
			EndIf
			Return 0
		End Function
		Function xFile_CutA(FilePath As ZString Ptr, FileSize As UInteger) As Integer XGE_EXPORT_ALL
			Dim FileHdr As HANDLE = CreateFileA(FilePath, GENERIC_WRITE, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
			Function = xFile_hCut(FileHdr, FileSize)
			CloseHandle(FileHdr)
		End Function
		Function xFile_CutW(FilePath As WString Ptr, FileSize As UInteger) As Integer XGE_EXPORT_ALL
			Dim FileHdr As HANDLE = CreateFileW(FilePath, GENERIC_WRITE, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
			Function = xFile_hCut(FileHdr, FileSize)
			CloseHandle(FileHdr)
		End Function
		
		' 获取临时文件名 [使用%lld表示随机部分]
		Function xFile_TempPathA(sPath As ZString Ptr) As ZString Ptr XGE_EXPORT_ALL
			Dim pMemory As Any Ptr = AllocTempMemory(MAX_PATH)
			Dim iRnd As Double = Rnd()
			sprintf(pMemory, sPath, iRnd)
			If xFile_ExistsA(pMemory) Then
				Return xFile_TempPathA(sPath)
			EndIf
			Return pMemory
		End Function
		Function xFile_TempPathW(sPath As WString Ptr) As WString Ptr XGE_EXPORT_ALL
			Dim pMemory As Any Ptr = AllocTempMemory(MAX_PATH * SizeOf(WString))
			Dim iRnd As Double = Rnd()
			swprintf(pMemory, sPath, iRnd)
			If xFile_ExistsW(pMemory) Then
				Return xFile_TempPathW(sPath)
			EndIf
			Return pMemory
		End Function
		
		' 遍历文件
		Function xFile_ScanA(RootDir As ZString Ptr, Filter As ZString Ptr, Attrib As Integer, AttribEx As Integer, Recursive As Integer, CallBack As Function(Path As ZString Ptr, FindData As WIN32_FIND_DATAA Ptr, param As Integer = 0) As Integer, param As Integer) As Integer XGE_EXPORT_ALL
			Dim FindData As WIN32_FIND_DATAA
			Dim FileCount As UInteger = 0
			' 遍历文件
			Dim FindFileHdr As HANDLE = FindFirstFile(*RootDir & *Filter, @FindData)
			xywh_library_xrtl_file_ecode = 0
			If FindFileHdr <> INVALID_HANDLE_VALUE Then
				Dim FindOver As BOOLEAN = TRUE
				Do While FindOver
					If (FindData.dwFileAttributes And (Attrib Or FILE_ATTRIBUTE_DIRECTORY)) = 0 Then		' 符合查找规则
						' 查找到文件
						If (AttribEx And XFILE_RULE_FloderOnly) = 0 Then
							If CallBack Then
								xywh_library_xrtl_file_ecode = CallBack(RootDir, @FindData, param)
								If xywh_library_xrtl_file_ecode Then
									Exit Do
								EndIf
							EndIf
							FileCount += 1
						EndIf
					EndIf
					FindOver = FindNextFile(FindFileHdr, @FindData)
				Loop
			EndIf
			FindClose(FindFileHdr)
			' 递归子目录
			Dim FindFoldHdr As HANDLE = FindFirstFile(*RootDir & "*", @FindData)
			If FindFoldHdr <> INVALID_HANDLE_VALUE Then
				Dim FindOver As BOOLEAN = TRUE
				Do While FindOver
					If FindData.dwFileAttributes And FILE_ATTRIBUTE_DIRECTORY Then
						' 过滤当前文件夹和父文件夹
						If (FindData.cFileName=".") Or (FindData.cFileName="..") Then
							If AttribEx And XFILE_RULE_PointFloder Then
								If CallBack Then
									xywh_library_xrtl_file_ecode = CallBack(RootDir, @FindData, param)
									If xywh_library_xrtl_file_ecode Then
										Exit Do
									EndIf
								EndIf
								FileCount += 1
							EndIf
						Else
							If CallBack Then
								xywh_library_xrtl_file_ecode = CallBack(RootDir, @FindData, param)
								If xywh_library_xrtl_file_ecode Then
									Exit Do
								EndIf
							EndIf
							FileCount += 1
							If Recursive Then			' 启用递归
								FileCount += xFile_ScanA(*RootDir & FindData.cFileName & "\", Filter, Attrib, AttribEx, Recursive, CallBack, param)
								If xywh_library_xrtl_file_ecode Then
									Exit Do
								EndIf
							EndIf
						EndIf
					EndIf
					FindOver = FindNextFile(FindFoldHdr, @FindData)
				Loop
			EndIf
			FindClose(FindFoldHdr)
			Return FileCount
		End Function
		Function xFile_ScanW(RootDir As WString Ptr, Filter As WString Ptr, Attrib As Integer, AttribEx As Integer, Recursive As Integer, CallBack As Function(Path As WString Ptr, FindData As WIN32_FIND_DATAW Ptr, param As Integer = 0) As Integer, param As Integer) As Integer XGE_EXPORT_ALL
			Dim FindData As WIN32_FIND_DATAW
			Dim FileCount As UInteger = 0
			' 遍历文件
			Dim FindFileHdr As HANDLE = FindFirstFileW(*RootDir & *Filter, @FindData)
			xywh_library_xrtl_file_ecode = 0
			If FindFileHdr <> INVALID_HANDLE_VALUE Then
				Dim FindOver As BOOLEAN = TRUE
				Do While FindOver
					If (FindData.dwFileAttributes And (Attrib Or FILE_ATTRIBUTE_DIRECTORY)) = 0 Then		' 符合查找规则
						' 查找到文件
						If (AttribEx And XFILE_RULE_FloderOnly) = 0 Then
							If CallBack Then
								xywh_library_xrtl_file_ecode = CallBack(RootDir, @FindData, param)
								If xywh_library_xrtl_file_ecode Then
									Exit Do
								EndIf
							EndIf
							FileCount += 1
						EndIf
					EndIf
					FindOver = FindNextFileW(FindFileHdr, @FindData)
				Loop
			EndIf
			FindClose(FindFileHdr)
			' 递归子目录
			Dim FindFoldHdr As HANDLE = FindFirstFileW(*RootDir & "*", @FindData)
			If FindFoldHdr <> INVALID_HANDLE_VALUE Then
				Dim FindOver As BOOLEAN = TRUE
				Do While FindOver
					If FindData.dwFileAttributes And FILE_ATTRIBUTE_DIRECTORY Then
						' 过滤当前文件夹和父文件夹
						If (FindData.cFileName=".") Or (FindData.cFileName="..") Then
							If AttribEx And XFILE_RULE_PointFloder Then
								If CallBack Then
									xywh_library_xrtl_file_ecode = CallBack(RootDir, @FindData, param)
									If xywh_library_xrtl_file_ecode Then
										Exit Do
									EndIf
								EndIf
								FileCount += 1
							EndIf
						Else
							If CallBack Then
								xywh_library_xrtl_file_ecode = CallBack(RootDir, @FindData, param)
								If xywh_library_xrtl_file_ecode Then
									Exit Do
								EndIf
							EndIf
							FileCount += 1
							If Recursive Then			' 启用递归
								FileCount += xFile_ScanW(*RootDir & FindData.cFileName & "\", Filter, Attrib, AttribEx, Recursive, CallBack, param)
								If xywh_library_xrtl_file_ecode Then
									Exit Do
								EndIf
							EndIf
						EndIf
					EndIf
					FindOver = FindNextFileW(FindFoldHdr, @FindData)
				Loop
			EndIf
			FindClose(FindFoldHdr)
			Return FileCount
		End Function
		
	End Extern
#EndIf
