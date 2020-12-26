



Dim Shared SplitCount As Integer
Dim Shared SplitMemorySize As Integer

Function SplitChar(sText As ZString Ptr, iChar As UByte) As ZString Ptr Ptr
	Dim iPos As Integer = 0
	Dim iCount As Integer = 0
	' 统计分隔符出现的次数
	Do
		If Cast(UByte Ptr, sText)[iPos] = 0 Then
			If iChar = 0 Then
				' 如果 \0 是分隔符，则 \0\0 才是结束符
				If Cast(UByte Ptr, sText)[iPos+1] = 0 Then
					Exit Do
				EndIf
			Else
				Exit Do
			EndIf
		EndIf
		If Cast(UByte Ptr, sText)[iPos] = iChar Then
			iCount += 1
		EndIf
		iPos += 1
	Loop
	' 准备返回的数据 [分割指针 + NULL + 字符串表 + \0]
	SplitMemorySize = (iCount + 2) * SizeOf(Any Ptr) + iPos + 1
	Dim sRet As ZString Ptr Ptr
	sRet = Allocate(SplitMemorySize)
	Dim pData As UByte Ptr = Cast(UByte Ptr, @sRet[iCount + 2])
	Dim pAddr As UByte Ptr = pData
	sRet[iCount + 1] = NULL
	RtlMoveMemory(pData, sText, iPos)
	pData[iPos] = 0
	' 开始分割数据
	iCount = 0
	For i As Integer = 0 To iPos - 1
		'Print Cast(UByte Ptr, sText)[i], sText[i]
		If pData[i] = iChar Then
			pData[i] = 0
			sRet[iCount] = pAddr
			pAddr = pData + i + 1
			iCount += 1
		EndIf
	Next
	sRet[iCount] = pAddr
	SplitCount = iCount + 1
	Return sRet
End Function

Function SplitText(sText As ZString Ptr, sSep As ZString Ptr) As ZString Ptr Ptr
	Dim iSepSize As Integer = strlen(sSep)
	Dim iPos As Integer = 0
	Dim iCount As Integer = 0
	' 统计分隔符出现的次数
	Do
		If Cast(UByte Ptr, sText)[iPos] = 0 Then
			Exit Do
		EndIf
		If strncmp(@Cast(UByte Ptr, sText)[iPos], sSep, iSepSize) = 0 Then
			iCount += 1
		EndIf
		iPos += 1
	Loop
	' 准备返回的数据 [分割指针 + NULL + 字符串表 + \0]
	SplitMemorySize = (iCount + 2) * SizeOf(Any Ptr) + iPos + 1
	Dim sRet As ZString Ptr Ptr
	sRet = Allocate(SplitMemorySize)
	Dim pData As UByte Ptr = Cast(UByte Ptr, @sRet[iCount + 2])
	Dim pAddr As UByte Ptr = pData
	sRet[iCount + 1] = NULL
	RtlMoveMemory(pData, sText, iPos)
	pData[iPos] = 0
	' 开始分割数据
	iCount = 0
	For i As Integer = 0 To iPos - 1
		'Print Cast(UByte Ptr, sText)[i], sText[i]
		If strncmp(@pData[i], sSep, iSepSize) = 0 Then
			pData[i] = 0
			sRet[iCount] = pAddr
			pAddr = pData + i + iSepSize
			i += iSepSize - 1
			iCount += 1
		EndIf
	Next
	sRet[iCount] = pAddr
	SplitCount = iCount + 1
	Return sRet
End Function

Function Split(sText As ZString Ptr, sSep As ZString Ptr) As ZString Ptr Ptr XGE_EXPORT_LIB
	Dim iSize As Integer = strlen(sSep)
	If iSize = 0 Then
		' 分隔符为 \0 的情况
		Return SplitChar(sText, 0)
	ElseIf iSize = 1 Then
		' 单个字符
		Return SplitChar(sText, Cast(UByte Ptr, sSep)[0])
	Else
		' 多个字符
		Return SplitText(sText, sSep)
	EndIf
End Function
