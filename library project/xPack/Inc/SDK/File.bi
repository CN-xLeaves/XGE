'==================================================================================
	'★ xywh File System Object 文件库
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



#Ifndef xywh_library_file
	#Define xywh_library_file
	
	
	Extern XGE_EXTERNMODULE
		Namespace xFile
			Dim Shared xywh_library_xrtl_file_ecode As Integer
			
			' 创建文件
			Function Create(FilePath As ZString Ptr) As Integer XGE_EXPORT_ALL
				Dim FileHdr As HANDLE = CreateFile(FilePath, GENERIC_WRITE, FILE_SHARE_READ, NULL, CREATE_NEW, FILE_ATTRIBUTE_NORMAL, NULL)
				If FileHdr <> INVALID_HANDLE_VALUE Then
					CloseHandle(FileHdr)
					Return -1
				EndIf
				Return 0
			End Function
			
			' 打开文件
			Function Open(FilePath As ZString Ptr, OnlyRead As Integer = 0) As HANDLE XGE_EXPORT_ALL
				Return CreateFile(FilePath, IIf(OnlyRead, GENERIC_READ, GENERIC_READ Or GENERIC_WRITE), FILE_SHARE_READ, NULL, IIf(OnlyRead, OPEN_EXISTING, OPEN_ALWAYS), FILE_ATTRIBUTE_NORMAL, NULL)
			End Function
			
			' 关闭文件
			Function Close(FileHdr As HANDLE) As Integer XGE_EXPORT_ALL
				Return CloseHandle(FileHdr)
			End Function
			
			' 判断文件是否存在
			Function Exists(FilePath As ZString Ptr) As Integer XGE_EXPORT_ALL
				Dim FileHdr As HANDLE = CreateFile(FilePath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
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
			Function hWrite(FileHdr As HANDLE, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger XGE_EXPORT_ALL
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
			Function Write(FilePath As ZString Ptr, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger XGE_EXPORT_ALL
				Dim FileHdr As HANDLE = CreateFile(FilePath, GENERIC_WRITE, FILE_SHARE_READ, NULL, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL)
				Function = hWrite(FileHdr, Buffer, Addr, Length)
				CloseHandle(FileHdr)
			End Function
			
			' 从文件读出数据
			Function hRead(FileHdr As HANDLE, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger XGE_EXPORT_ALL
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
			Function Read(FilePath As ZString Ptr, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger XGE_EXPORT_ALL
				Dim FileHdr As HANDLE = CreateFile(FilePath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
				Function = hRead(FileHdr, Buffer, Addr, Length)
				CloseHandle(FileHdr)
			End Function
			
			' 读出全部文件数据
			Function eRead(FilePath As ZString Ptr, Buffer As Any Ptr Ptr) As UInteger XGE_EXPORT_ALL
				Dim FileHdr As HANDLE = xFile.Open(FilePath, TRUE)
				If FileHdr <> INVALID_HANDLE_VALUE Then
					Dim FileSize As UInteger = xFile.hSize(FileHdr)
					Dim FileMem As ZString Ptr = Allocate(FileSize + 1)
					Dim ReadSize As UInteger = xFile.hRead(FileHdr, FileMem, 0, FileSize)
					FileMem[ReadSize] = 0
					If Buffer Then
						*Buffer = FileMem
					EndIf
					Function = ReadSize
				EndIf
				CloseHandle(FileHdr)
			End Function
			
			' 获取文件长度
			Function hSize(FileHdr As HANDLE) As UInteger XGE_EXPORT_ALL
				If FileHdr <> INVALID_HANDLE_VALUE Then
					Return GetFileSize(FileHdr, NULL)
				EndIf
				Return 0
			End Function
			Function Size(FilePath As ZString Ptr) As UInteger XGE_EXPORT_ALL
				Dim FileHdr As HANDLE = CreateFile(FilePath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
				Function = hSize(FileHdr)
				CloseHandle(FileHdr)
			End Function
			
			' 截断
			Function hCut(FileHdr As HANDLE, FileSize As UInteger) As Integer XGE_EXPORT_ALL
				If FileHdr <> INVALID_HANDLE_VALUE Then
					SetFilePointer(FileHdr, FileSize, 0, FILE_BEGIN)
					SetEndOfFile(FileHdr)
					Return -1
				EndIf
				Return 0
			End Function
			Function Cut(FilePath As ZString Ptr, FileSize As UInteger) As Integer XGE_EXPORT_ALL
				Dim FileHdr As HANDLE = CreateFile(FilePath, GENERIC_WRITE, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
				Function = hCut(FileHdr, FileSize)
				CloseHandle(FileHdr)
			End Function
			
			' 遍历文件
			Function Scan(RootDir As ZString Ptr, Filter As ZString Ptr, Attrib As Integer, AttribEx As Integer, Recursive As Integer, CallBack As Function(Path As ZString Ptr, FindData As WIN32_FIND_DATA Ptr, param As Integer = 0) As Integer, param As Integer) As Integer XGE_EXPORT_ALL
				Dim FindData As WIN32_FIND_DATA
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
									FileCount += Scan(*RootDir & FindData.cFileName & "\", Filter, Attrib, AttribEx, Recursive, CallBack, param)
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
			
		End Namespace
	End Extern
#EndIf
