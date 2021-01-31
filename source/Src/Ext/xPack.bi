


Extern XGE_EXTERNSTDEXT
	' 创建一个空的文件包
	Function xPack_CreateA(sFile As ZString Ptr, iPackExt As UShort = 0, iFileExt As UShort = 0) As UInteger XGE_EXPORT_ALL
		Dim HeadInfo As xPack_HeadInfo
		HeadInfo.PackVer = XPACK_VERSION
		HeadInfo.FileCount = 0
		HeadInfo.LDB_Addr = SizeOf(xPack_HeadInfo) + iPackExt
		HeadInfo.LDB_Size = 0
		HeadInfo.LDB_Hash = NULL
		HeadInfo.PackExtSize = iPackExt
		HeadInfo.FileExtSize = iFileExt
		xFile_WriteA(sFile, @HeadInfo, 0, SizeOf(xPack_HeadInfo))
		If iPackExt Then
			Dim pMemory As Any Ptr = Allocate(iPackExt)
			memset(pMemory, 0, iPackExt)
			xFile_WriteA(sFile, pMemory, SizeOf(xPack_HeadInfo), iPackExt)
			DeAllocate(pMemory)
		EndIf
		Return xFile_CutA(sFile, SizeOf(xPack_HeadInfo) + iPackExt)
	End Function
	Function xPack_CreateW(sFile As WString Ptr, iPackExt As UShort = 0, iFileExt As UShort = 0) As UInteger XGE_EXPORT_ALL
		Dim HeadInfo As xPack_HeadInfo
		HeadInfo.PackVer = XPACK_VERSION
		HeadInfo.FileCount = 0
		HeadInfo.LDB_Addr = SizeOf(xPack_HeadInfo) + iPackExt
		HeadInfo.LDB_Size = 0
		HeadInfo.LDB_Hash = NULL
		HeadInfo.PackExtSize = iPackExt
		HeadInfo.FileExtSize = iFileExt
		xFile_WriteW(sFile, @HeadInfo, 0, SizeOf(xPack_HeadInfo))
		If iPackExt Then
			Dim pMemory As Any Ptr = Allocate(iPackExt)
			memset(pMemory, 0, iPackExt)
			xFile_WriteW(sFile, pMemory, SizeOf(xPack_HeadInfo), iPackExt)
			DeAllocate(pMemory)
		EndIf
		Return xFile_CutW(sFile, SizeOf(xPack_HeadInfo) + iPackExt)
	End Function
	
	' 重构文件包 [释放无效的空间]
	Function xPack_ReBuildA(sFile As ZString Ptr) As ZString Ptr XGE_EXPORT_ALL
		Dim wt As WString Ptr = AsciToUnicode(sFile)
		Function = W2A(xPack_ReBuildW(wt))
		DeAllocate(wt)
	End Function
	Function xPack_ReBuildW(sFile As WString Ptr) As WString Ptr XGE_EXPORT_ALL
		' 文件包必须存在
		If xFile_ExistsW(sFile) = FALSE Then
			Return NULL
		EndIf
		' 备份文件
		Dim sBackup As WString Ptr = AllocTempMemory(MAX_PATH * SizeOf(WString Ptr))
		wcscpy(sBackup, sFile)
		PathRemoveExtensionW(sBackup)
		wcscpy(sBackup, xFile_TempPathW(*sBackup & "_backup_%lld.xpk"))
		CopyFileW(sFile, sBackup, TRUE)
		' 重构文件包
		Dim As xPack xpkOld, xpkNew
		If xpkOld.Open(sBackup, TRUE) And xpkNew.Open(sFile) Then
			xpkNew.HeadInfo->LDB_Addr = SizeOf(xPack_HeadInfo) + xpkNew.HeadInfo->PackExtSize
			For i As UInteger = 1 To xpkOld.LDB.StructCount
				Dim FileInfo As xPack_FileInfo Ptr
				FileInfo = xpkOld.LDB.GetPtrStruct(i)
				' 将文件依次写入到新包中
				Dim FileData As Any Ptr = Allocate(FileInfo->DataSize)
				xFile_hRead(xpkOld.FileHdr, FileData, FileInfo->FileAddr, FileInfo->DataSize)
				xFile_hwrite(xpkNew.FileHdr, FileData, xpkNew.HeadInfo->LDB_Addr, FileInfo->DataSize)
				DeAllocate(FileData)
				' 修改文件和文件包属性
				FileInfo->FileAddr = xpkNew.HeadInfo->LDB_Addr
				xpkNew.HeadInfo->LDB_Addr += FileInfo->DataSize
			Next
			' 写入文件头和LDB
			xFile_hwrite(xpkNew.FileHdr, xpkNew.HeadInfo, 0, SizeOf(xPack_HeadInfo) + xpkNew.HeadInfo->PackExtSize)
			memcpy(xpkNew.LDB.StructMemory, xpkOld.LDB.StructMemory, xpkNew.HeadInfo->LDB_Size)
			' 关闭文件
			xpkNew.Close()
			xpkOld.Close()
			Return sBackup
		Else
			' 文件打开失败时，删除备份文件
			DeleteFileW(sBackup)
		EndIf
		Return NULL
	End Function
End Extern



Extern XGE_EXTERNMODULE

	' 构造和析构
	Constructor xPack() XGE_EXPORT_OBJ
		FileHdr = INVALID_HANDLE_VALUE
		HeadInfo = NULL
	End Constructor
	Constructor xPack(sFile As ZString Ptr, bReadOnly As Integer = FALSE) XGE_EXPORT_OBJ
		FileHdr = INVALID_HANDLE_VALUE
		HeadInfo = NULL
		This.Open(sFile, bReadOnly)
	End Constructor
	Constructor xPack(sFile As WString Ptr, bReadOnly As Integer = FALSE) XGE_EXPORT_OBJ
		FileHdr = INVALID_HANDLE_VALUE
		HeadInfo = NULL
		This.Open(sFile, bReadOnly)
	End Constructor
	Destructor xPack() XGE_EXPORT_OBJ
		This.Close()
	End Destructor
	
	' 打开文件包
	Function xPack.Open(sFile As ZString Ptr, bReadOnly As Integer = FALSE) As Integer XGE_EXPORT_OBJ
		Dim wt As WString Ptr = AsciToUnicode(sFile)
		Function = Open(wt, bReadOnly)
		DeAllocate(wt)
	End Function
	Function xPack.Open(sFile As WString Ptr, bReadOnly As Integer = FALSE) As Integer XGE_EXPORT_OBJ
		This.Close()
		' 文件不存在则创建一个
		If xFile_ExistsW(sFile) = FALSE Then
			If bReadOnly Then
				LastError = XPACK_ERROR_FILEXIST
				Return 0
			Else
				xPack_CreateW(sFile)
			EndIf
		EndIf
		' 打开文件
		OnlyRead = bReadOnly
		FileHdr = xFile_OpenW(sFile, bReadOnly)
		If FileHdr = INVALID_HANDLE_VALUE Then
			LastError = XPACK_ERROR_FILEOPEN
			Return 0
		EndIf
		' 读取文件头
		Dim PackHead As xPack_HeadInfo
		xFile_hRead(FileHdr, @PackHead, 0, SizeOf(xPack_HeadInfo))
		' 判断版本，读入LDB
		LDB.StructLenght = SizeOf(xPack_FileInfo) + PackHead.FileExtSize
		Select Case PackHead.PackVer
			Case XPACK_VERSION					' 普通的文件包
				If PackHead.FileCount > 0 Then
					If LDB.CallocMemory(PackHead.FileCount) = FALSE Then
						LastError = XPACK_ERROR_MEMALLOC
						xFile_Close(FileHdr)
						Return 0
					EndIf
					LDB.StructCount = PackHead.FileCount
					xFile_hRead(FileHdr, LDB.StructMemory, PackHead.LDB_Addr, PackHead.LDB_Size)
				EndIf
			Case XPACK_VERSION_COMP				' LDB压缩的文件包
				If PackHead.FileCount > 0 Then
					If LDB.CallocMemory(PackHead.FileCount) = FALSE Then
						LastError = XPACK_ERROR_MEMALLOC
						xFile_Close(FileHdr)
						Return 0
					EndIf
					LDB.StructCount = PackHead.FileCount
					' 解压缩LDB数据
					Dim CompLDB As Any Ptr = Allocate(PackHead.LDB_Size)
					Dim CompLen As Integer = PackHead.FileCount * (SizeOf(xPack_FileInfo) + PackHead.FileExtSize)
					xFile_hRead(FileHdr, CompLDB, PackHead.LDB_Addr, PackHead.LDB_Size)
					Dim iRet As UInteger = LZ4_decompress_safe(CompLDB, LDB.StructMemory, PackHead.LDB_Size, CompLen)
					DeAllocate(CompLDB)
					If iRet <> CompLen Then
						LastError = XPACK_ERROR_DECOMPER
						xFile_Close(FileHdr)
						Return 0
					EndIf
				EndIf
			Case Else							' 其他文件
				LastError = XPACK_ERROR_VERERROR
				xFile_Close(FileHdr)
				Return 0
		End Select
		' 加载成功，读取包文件头
		HeadInfo = Allocate(SizeOf(xPack_HeadInfo) + PackHead.PackExtSize)
		xFile_hRead(FileHdr, HeadInfo, 0, SizeOf(xPack_HeadInfo) + PackHead.PackExtSize)
		Return -1
	End Function
	
	' 保存文件包
	Sub xPack.Save()
		If (FileHdr <> INVALID_HANDLE_VALUE) And (OnlyRead = FALSE) Then
			HeadInfo->FileCount = LDB.StructCount
			HeadInfo->LDB_Size = LDB.StructCount * (SizeOf(xPack_FileInfo) + HeadInfo->FileExtSize)
			HeadInfo->LDB_Hash = XXH32(LDB.StructMemory, HeadInfo->LDB_Size, 0)
			' 压缩LDB
			Dim CompLDB As Any Ptr = Allocate(HeadInfo->LDB_Size)
			Dim iRet As UInteger = LZ4_compress_HC(LDB.StructMemory, CompLDB, HeadInfo->LDB_Size, HeadInfo->LDB_Size, LZ4HC_CLEVEL_MAX)
			If iRet Then
				HeadInfo->PackVer  = XPACK_VERSION_COMP
				HeadInfo->LDB_Size = iRet
				xFile_hwrite(FileHdr, CompLDB, HeadInfo->LDB_Addr, iRet)
			Else
				HeadInfo->PackVer  = XPACK_VERSION
				xFile_hwrite(FileHdr, LDB.StructMemory, HeadInfo->LDB_Addr, HeadInfo->LDB_Size)
			EndIf
			DeAllocate(CompLDB)
			xFile_hwrite(FileHdr, HeadInfo, 0, SizeOf(xPack_HeadInfo) + HeadInfo->PackExtSize)
			xFile_hCut(FileHdr, HeadInfo->LDB_Addr + HeadInfo->LDB_Size)
		EndIf
	End Sub
	
	' 关闭文件包
	Sub xPack.Close() XGE_EXPORT_OBJ
		If OnlyRead = FALSE Then
			Save()
		EndIf
		If FileHdr <> INVALID_HANDLE_VALUE Then
			xFile_Close(FileHdr)
			FileHdr = INVALID_HANDLE_VALUE
		EndIf
		If HeadInfo Then
			DeAllocate(HeadInfo)
			HeadInfo = NULL
		EndIf
		LDB.ReInitManage()
	End Sub
	
	' 获取文件数量
	Function xPack.Count() As UInteger XGE_EXPORT_OBJ
		Return LDB.StructCount
	End Function
	
	' 添加文件
	Function xPack.AppendFile(sFile As WString Ptr, iIndex As UInteger, iComp As Integer = XPACK_COMPRESS_LZ4) As Any Ptr XGE_EXPORT_OBJ
		If FileHdr = INVALID_HANDLE_VALUE Then
			LastError = XPACK_ERROR_PACKOPEN
			Return 0
		EndIf
		If OnlyRead Then
			LastError = XPACK_ERROR_READONLY
			Return 0
		EndIf
		If xFile_ExistsW(sFile) = FALSE Then
			LastError = XPACK_ERROR_FILEXIST
			Return 0
		EndIf
		' 打开文件
		Dim pFile As HANDLE = xFile_OpenW(sFile, TRUE)
		If pFile = INVALID_HANDLE_VALUE Then
			LastError = XPACK_ERROR_FILEOPEN
			Return 0
		EndIf
		' 如果文件重复了，就删掉之前的
		RemoveFile(iIndex)
		' 添加LDB数据
		Dim iPos As UInteger = LDB.AppendStruct()
		If iPos = 0 Then
			LastError = XPACK_ERROR_MEMALLOC
			Return 0
		EndIf
		' 添加文件
		Dim FileInfo As xPack_FileInfo Ptr = LDB.GetPtrStruct(iPos)
		Dim iSize As UInteger = xFile_hSize(pFile)
		Dim pMemory As Any Ptr = Allocate(iSize)
		xFile_hRead(pFile, pMemory, 0, iSize)
		xFile_Close(pFile)
		Private_AppendMemory(pMemory, iSize, iIndex, FileInfo, iComp)
		DeAllocate(pMemory)
		Return FileInfo
	End Function
	Function xPack.AppendFile(sFile As ZString Ptr, iIndex As UInteger, iComp As Integer = XPACK_COMPRESS_LZ4) As Any Ptr XGE_EXPORT_OBJ
		Dim wt As WString Ptr = AsciToUnicode(sFile)
		Function = AppendFile(wt, iIndex)
		DeAllocate(wt)
	End Function
	Function xPack.AppendMemory(pMemory As Any Ptr, iSize As UInteger, iIndex As UInteger, iComp As Integer = XPACK_COMPRESS_LZ4) As Any Ptr XGE_EXPORT_OBJ
		If FileHdr = INVALID_HANDLE_VALUE Then
			LastError = XPACK_ERROR_PACKOPEN
			Return 0
		EndIf
		If OnlyRead Then
			LastError = XPACK_ERROR_READONLY
			Return 0
		EndIf
		' 如果文件重复了，就删掉之前的
		RemoveFile(iIndex)
		' 添加LDB数据
		Dim iPos As UInteger = LDB.AppendStruct()
		If iPos = 0 Then
			LastError = XPACK_ERROR_MEMALLOC
			Return 0
		EndIf
		' 添加文件
		Dim FileInfo As xPack_FileInfo Ptr = LDB.GetPtrStruct(iPos)
		Private_AppendMemory(pMemory, iSize, iIndex, FileInfo, iComp)
		Return FileInfo
	End Function
	Sub xPack.Private_AppendMemory(pMemory As Any Ptr, iSize As UInteger, iIndex As UInteger, FileInfo As xPack_FileInfo Ptr, iComp As Integer = XPACK_COMPRESS_LZ4)
		' 设置文件信息
		FileInfo->FileAddr = HeadInfo->LDB_Addr
		FileInfo->FileSize = iSize
		FileInfo->DataSize = iSize
		FileInfo->FileIndex = iIndex
		FileInfo->Compress = iComp
		FileInfo->FileHash = XXH32(pMemory, iSize, 0)
		FileInfo->FileType = XPACK_TYPE_BINARY
		FileInfo->FileFlag = 0
		If HeadInfo->FileExtSize Then
			memset(@FileInfo[1], 0, HeadInfo->FileExtSize)
		EndIf
		' 压缩文件
		Dim pData As Any Ptr = pMemory
		Dim bFree As Integer = FALSE
		Select Case iComp
			Case XPACK_COMPRESS_LZ4				' LZ4算法 (偏重速度)
				pData = Allocate(iSize)
				Dim iRet As UInteger = LZ4_compress_HC(pMemory, pData, iSize, iSize, LZ4HC_CLEVEL_MAX)
				If iRet Then
					FileInfo->DataSize = iRet
					bFree = TRUE
				Else
					DeAllocate(pData)
					pData = pMemory
					FileInfo->Compress = XPACK_COMPRESS_NULL
				EndIf
			Case XPACK_COMPRESS_LZMA			' LZMA算法 (偏重压缩比)
				pData = Allocate(iSize)
				Dim iRet As UInteger = iSize
				If LzmaCompress(pData + LZMA_PROPS_SIZE, @iRet, pMemory, iSize, pData, LZMA_PROPS_SIZE, 7) = SZ_OK Then
					FileInfo->DataSize = iRet + LZMA_PROPS_SIZE
					bFree = TRUE
				Else
					DeAllocate(pData)
					pData = pMemory
					FileInfo->Compress = XPACK_COMPRESS_NULL
				EndIf
			Case Else							' 无算法
				FileInfo->Compress = XPACK_COMPRESS_NULL
		End Select
		' 将文件数据写入到文件包
		xFile_hwrite(FileHdr, pData, FileInfo->FileAddr, FileInfo->DataSize)
		HeadInfo->LDB_Addr += FileInfo->DataSize
		' 释放内存
		If bFree Then
			DeAllocate(pData)
		EndIf
	End Sub
	
	' 删除文件
	Sub xPack.RemoveFile(iIndex As UInteger) XGE_EXPORT_OBJ
		Dim FileInfo As xPack_FileInfo Ptr
		For i As UInteger = LDB.StructCount To 1 Step -1
			FileInfo = LDB.GetPtrStruct(i)
			If FileInfo->FileIndex = iIndex Then
				Private_RemoveFile(i)
			EndIf
		Next
	End Sub
	
	' 解压文件
	Function xPack.UnPackFile(iIndex As UInteger, sFile As ZString Ptr) As Integer XGE_EXPORT_OBJ
		Dim wt As WString Ptr = AsciToUnicode(sFile)
		Function = UnPackFile(iIndex, wt)
		DeAllocate(wt)
	End Function
	Function xPack.UnPackFile(iIndex As UInteger, sFile As WString Ptr) As Integer XGE_EXPORT_OBJ
		Dim FileInfo As xPack_FileInfo Ptr = GetFileInfo(iIndex)
		Dim pMemory As Any Ptr = Allocate(FileInfo->FileSize)
		If Private_UnPackMemory(FileInfo, pMemory) Then
			xFile_WriteW(sFile, pMemory, 0, FileInfo->FileSize)
			DeAllocate(pMemory)
			Return -1
		Else
			DeAllocate(pMemory)
			Return 0
		EndIf
	End Function
	Function xPack.UnPackMemory(iIndex As UInteger, pMemory As Any Ptr Ptr) As Any Ptr XGE_EXPORT_OBJ
		Dim FileInfo As xPack_FileInfo Ptr = GetFileInfo(iIndex)
		If FileInfo Then
			Dim pData As Any Ptr = Allocate(FileInfo->FileSize)
			If Private_UnPackMemory(FileInfo, pData) Then
				*pMemory = pData
				Return FileInfo
			Else
				DeAllocate(pData)
				Return NULL
			EndIf
		EndIf
		Return NULL
	End Function
	Function xPack.Private_UnPackMemory(FileInfo As xPack_FileInfo Ptr, pMemory As Any Ptr) As Integer XGE_EXPORT_OBJ
		Select Case FileInfo->Compress
			Case XPACK_COMPRESS_NULL			' 无算法
				xFile_hRead(FileHdr, pMemory, FileInfo->FileAddr, FileInfo->FileSize)
			Case XPACK_COMPRESS_LZ4				' LZ4算法 (偏重速度)
				Dim pData As Any Ptr = Allocate(FileInfo->DataSize)
				xFile_hRead(FileHdr, pData, FileInfo->FileAddr, FileInfo->DataSize)
				Dim iRet As UInteger = LZ4_decompress_safe(pData, pMemory, FileInfo->DataSize, FileInfo->FileSize)
				DeAllocate(pData)
				If iRet <> FileInfo->FileSize Then
					LastError = XPACK_ERROR_DECOMPER
					Return 0
				EndIf
			Case XPACK_COMPRESS_LZMA			' LZMA算法 (偏重压缩比)
				Dim pData As Any Ptr = Allocate(FileInfo->DataSize)
				xFile_hRead(FileHdr, pData, FileInfo->FileAddr, FileInfo->DataSize)
				Dim ScrLen As UInteger = FileInfo->DataSize
				Dim DstLen As UInteger = FileInfo->FileSize
				Dim iRet As Integer = LzmaUncompress(pMemory, @DstLen, pData + LZMA_PROPS_SIZE, @ScrLen, pData, LZMA_PROPS_SIZE)
				DeAllocate(pData)
				If (iRet <> SZ_OK) Or (DstLen <> FileInfo->FileSize) Then
					LastError = XPACK_ERROR_DECOMPER
					Return 0
				EndIf
		End Select
		Return -1
	End Function
	
	' 获取包扩展数据结构体指着
	Function xPack.GetPackExtData() As Any Ptr XGE_EXPORT_OBJ
		Return Cast(Any Ptr, HeadInfo) + SizeOf(xPack_HeadInfo)
	End Function
	
	' 获取文件信息
	Function xPack.GetFileInfo(iIndex As UInteger) As Any Ptr XGE_EXPORT_OBJ
		Dim iPos As UInteger = IndexToPos(iIndex)
		Return LDB.GetPtrStruct(iPos)
	End Function
	
	' 通过文件ID获取LDB位置
	Function xPack.IndexToPos(iIndex As UInteger) As UInteger XGE_EXPORT_OBJ
		Dim FileInfo As xPack_FileInfo Ptr
		For i As UInteger = 1 To LDB.StructCount
			FileInfo = LDB.GetPtrStruct(i)
			If FileInfo->FileIndex = iIndex Then
				Return i
			EndIf
		Next
		Return 0
	End Function
	
	' 通过位置删除文件
	Sub xPack.Private_RemoveFile(iPos As UInteger) XGE_EXPORT_OBJ
		LDB.DeleteStruct(iPos)
	End Sub
End Extern
