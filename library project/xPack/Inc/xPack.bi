


' ����һ���յ��ļ���
Function xPack_Create(sFile As ZString Ptr) As Integer XGE_EXPORT_ALL
	Dim HeadInfo As xPack_Head
	HeadInfo.PackVer = XPACK_VERSION
	HeadInfo.SubVer = XPACK_SUBVER
	HeadInfo.Compress = XPACK_COMPRESS_NULL
	HeadInfo.Flag = 0
	HeadInfo.FileCount = 0
	HeadInfo.LDB_Addr = SizeOf(xPack_Head)
	HeadInfo.LDB_Size = 0
	HeadInfo.LDB_Hash = NULL
	Return xFile.Write(sFile, @HeadInfo, 0, SizeOf(xPack_Head))
End Function

' �ع��ļ��� [�ͷ���Ч�Ŀռ�]
Function xPack_ReBuild(sFile As ZString Ptr) As Integer XGE_EXPORT_ALL
	Return -1
End Function



' ���������
Constructor xPack() XGE_EXPORT_OBJ
	FileHdr = INVALID_HANDLE_VALUE
	LDB.StructLenght = SizeOf(xPack_FileInfo)
End Constructor
Constructor xPack(sFile As ZString Ptr, bReadOnly As Integer = FALSE) XGE_EXPORT_OBJ
	LDB.StructLenght = SizeOf(xPack_FileInfo)
	This.Open(sFile, bReadOnly)
End Constructor
Destructor xPack() XGE_EXPORT_OBJ
	This.Close()
End Destructor

' ���ļ���
Function xPack.Open(sFile As ZString Ptr, bReadOnly As Integer = FALSE) As Integer XGE_EXPORT_OBJ
	This.Close()
	' �ļ��������򴴽�һ��
	If xFile.Exists(sFile) = FALSE Then
		If bReadOnly Then
			Print "Open Error 1"
			Return 0
		Else
			xPack_Create(sFile)
		EndIf
	EndIf
	' ���ļ�
	FileHdr = xFile.Open(sFile, bReadOnly)
	If FileHdr = INVALID_HANDLE_VALUE Then
		Print "Open Error 2"
		Return 0
	EndIf
	xFile.hRead(FileHdr, @HeadInfo, 0, SizeOf(HeadInfo))
	' �жϰ汾
	If HeadInfo.PackVer <> XPACK_VERSION Then
		Print "Open Error 3"
		Return 0
	EndIf
	' ����LDB
	If HeadInfo.FileCount > 0 Then
		If LDB.CallocMemory(HeadInfo.FileCount) = FALSE Then
			Print "Open Error 4"
			Return 0
		EndIf
		xFile.hRead(FileHdr, LDB.StructMemory, HeadInfo.LDB_Addr, HeadInfo.LDB_Size)
	EndIf
	OnlyRead = bReadOnly
	Return -1
End Function

' �ر��ļ���
Sub xPack.Close() XGE_EXPORT_OBJ
	If FileHdr <> INVALID_HANDLE_VALUE Then
		HeadInfo.PackVer = XPACK_VERSION
		HeadInfo.SubVer = XPACK_SUBVER
		HeadInfo.FileCount = LDB.StructCount
		HeadInfo.LDB_Size = LDB.StructCount * SizeOf(xPack_FileInfo)
		HeadInfo.LDB_Hash = XXH32(LDB.StructMemory, HeadInfo.LDB_Size, 0)
		xFile.hWrite(FileHdr, @HeadInfo, 0, SizeOf(xPack_Head))
		xFile.hWrite(FileHdr, LDB.StructMemory, HeadInfo.LDB_Addr, HeadInfo.LDB_Size)
		xFile.Close(FileHdr)
		FileHdr = INVALID_HANDLE_VALUE
	EndIf
	LDB.ReInitManage()
End Sub

' ��ȡ�ļ�����
Function xPack.Count() As UInteger XGE_EXPORT_OBJ
	Return LDB.StructCount
End Function

' ����ļ�
Function xPack.AppendFile(sFile As ZString Ptr, iIndex As UInteger) As xPack_FileInfo Ptr XGE_EXPORT_OBJ
	If FileHdr = INVALID_HANDLE_VALUE Then
		Print "Error 1"
		Return 0
	EndIf
	If OnlyRead Then
		Print "Error 2"
		Return 0
	EndIf
	If xFile.Exists(sFile) = FALSE Then
		Print "Error 3"
		Return 0
	EndIf
	' ���ļ�
	Dim pFile As HANDLE = xFile.Open(sFile, TRUE)
	If pFile = INVALID_HANDLE_VALUE Then
		Print "Error 4"
		Return 0
	EndIf
	' ����ļ��ظ��ˣ���ɾ��֮ǰ��
	RemoveFile(iIndex)
	' ���LDB����
	Dim iPos As UInteger = LDB.AppendStruct()
	If iPos = 0 Then
		Print "Error 5"
		Return 0
	EndIf
	' �����ļ���Ϣ
	Dim FileInfo As xPack_FileInfo Ptr = LDB.GetPtrStruct(iPos)
	FileInfo->FileAddr = HeadInfo.LDB_Addr
	FileInfo->FileSize = xFile.hSize(pFile)
	FileInfo->DataSize = FileInfo->FileSize
	FileInfo->FileIndex = iIndex
	FileInfo->Compress = HeadInfo.Compress
	FileInfo->FileFlag = 0
	FileInfo->Tag_Short = 0
	FileInfo->Tag_Int = 0
	memset(@FileInfo->Tag_Str, 0, 32)
	HeadInfo.LDB_Addr += FileInfo->FileSize
	' ���ļ�����д�뵽�ļ���
	Dim pMemory As Any Ptr = Allocate(FileInfo->FileSize)
	xFile.hRead(pFile, pMemory, 0, FileInfo->FileSize)
	xFile.hWrite(FileHdr, pMemory, FileInfo->FileAddr, FileInfo->FileSize)
	xFile.Close(pFile)
	' �����ļ�HASHֵ
	FileInfo->FileHash = XXH32(pMemory, FileInfo->FileSize, 0)
	DeAllocate(pMemory)
	Return FileInfo
End Function

' ɾ���ļ�
Sub xPack.RemoveFile(iIndex As UInteger) XGE_EXPORT_OBJ
	Dim FileInfo As xPack_FileInfo Ptr
	For i As UInteger = LDB.StructCount To 1 Step -1
		FileInfo = LDB.GetPtrStruct(i)
		If FileInfo->FileIndex = iIndex Then
			RemoveFile_Pos(i)
		EndIf
	Next
End Sub

' ��ѹ�ļ�
Function xPack.UnPackFile(iIndex As UInteger, sFile As ZString Ptr) As Integer XGE_EXPORT_OBJ
	Dim iPos As UInteger = IndexToPos(iIndex)
	If iPos = 0 Then
		Return 0
	EndIf
	Dim FileInfo As xPack_FileInfo Ptr = LDB.GetPtrStruct(iPos)
	Dim pMemory As Any Ptr = Allocate(FileInfo->FileSize)
	xFile.hRead(FileHdr, pMemory, FileInfo->FileAddr, FileInfo->FileSize)
	xFile.Write(sFile, pMemory, 0, FileInfo->FileSize)
	DeAllocate(pMemory)
	Return -1
End Function

' ͨ���ļ�ID��ȡLDBλ��
Function xPack.IndexToPos(iIndex As UInteger) As UInteger
	Dim FileInfo As xPack_FileInfo Ptr
	For i As UInteger = 1 To LDB.StructCount
		FileInfo = LDB.GetPtrStruct(i)
		If FileInfo->FileIndex = iIndex Then
			Return i
		EndIf
	Next
	Return 0
End Function

' ͨ��λ��ɾ���ļ�
Sub xPack.RemoveFile_Pos(iPos As UInteger)
	LDB.DeleteStruct(iPos)
End Sub
