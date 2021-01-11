


Extern XGE_EXTERNCLASS



' 构造
Constructor xStringBuffer() XGE_EXPORT_OBJ
	AllocStep = 64
End Constructor

' 析构
Destructor xStringBuffer() XGE_EXPORT_OBJ
	FreeMemory()
End Destructor

' 设置数据
Function xStringBuffer.SetText(sText As WString Ptr, iTextSize As UInteger = 0) As Integer
	' 自动计算文本长度
	If iTextSize = 0 Then
		iTextSize = wcslen(sText)
	EndIf
	BufferLenght = 0
	If iTextSize Then
		Return AppendText(sText, iTextSize)
	EndIf
	Return -1
End Function

' 追加写数据
Function xStringBuffer.AppendText(sText As WString Ptr, iTextSize As UInteger = 0) As Integer XGE_EXPORT_OBJ
	' 自动计算文本长度
	If iTextSize = 0 Then
		iTextSize = wcslen(sText)
	EndIf
	If iTextSize Then
		' 内存不足时需要分配内存 [ 判断 spaceMemory < 0 避免 Int 和 UInt 因为符号问题出现诡异错误 ]
		Dim spaceMemory As Integer = (AllocLenght - BufferLenght) - 1
		If (spaceMemory < 0) Or (iTextSize > spaceMemory) Then
			If MallocMemory(AllocLenght + (iTextSize - spaceMemory) + AllocStep) = 0 Then
				Return 0
			EndIf
		EndIf
		' 写入数据
		memcpy(@BufferMemory[BufferLenght], sText, iTextSize * SizeOf(WString))
		BufferLenght += iTextSize
		BufferMemory[BufferLenght] = 0
	EndIf
	Return -1
End Function

' 插入写数据
Function xStringBuffer.InsertText(iPos As UInteger, iSize As UInteger, sText As WString Ptr, iTextSize As UInteger = 0) As Integer XGE_EXPORT_OBJ
	' 自动计算文本长度
	If iTextSize = 0 Then
		iTextSize = wcslen(sText)
	EndIf
	If iTextSize Then
		If iPos >= BufferLenght Then
			' 超出缓冲区改为 末尾追加模式
			AppendText(sText, iTextSize)
		Else
			' 正常的插入模式 [ 内存不足时需要分配内存 ]
			Dim spaceMemory As Integer = (AllocLenght - BufferLenght) - 1
			Dim ChangeSize As Integer = iTextSize - iSize
			If ChangeSize > spaceMemory Then
				If MallocMemory(AllocLenght + (ChangeSize - spaceMemory) + AllocStep) = 0 Then
					Return 0
				EndIf
			EndIf
			' 写入数据
			If ChangeSize Then
				memmove(@BufferMemory[(iPos + iSize) + ChangeSize], @BufferMemory[iPos + iSize], (BufferLenght - (iPos + iSize)) * SizeOf(WString))
			EndIf
			memcpy(@BufferMemory[iPos], sText, iTextSize * SizeOf(WString))
			BufferLenght += ChangeSize
			BufferMemory[BufferLenght] = 0
		EndIf
	Else
		' 没有添加文字，但可能删掉选择的部分文字
		If iSize Then
			DeleteText(iPos, iSize)
		EndIf
	EndIf
	Return -1
End Function

' 删除数据
Function xStringBuffer.DeleteText(iPos As UInteger, iSize As UInteger) As Integer XGE_EXPORT_OBJ
	If iSize Then
		memmove(@BufferMemory[iPos], @BufferMemory[iPos + iSize], (BufferLenght - iPos) * SizeOf(WString))
		BufferLenght -= iSize
		BufferMemory[BufferLenght] = 0
	EndIf
	Return -1
End Function

' 分配内存
Function xStringBuffer.MallocMemory(iLenght As UInteger) As Integer XGE_EXPORT_OBJ
	If iLenght > AllocLenght Then
		' 增量
		Dim NewMem As Any Ptr = realloc(BufferMemory, iLenght * SizeOf(WString))
		If NewMem Then
			AllocLenght = iLenght
			BufferMemory = NewMem
			Return -1
		EndIf
	ElseIf iLenght < AllocLenght Then
		' 裁剪
		Dim NewMem As Any Ptr = realloc(BufferMemory, iLenght * SizeOf(WString))
		If NewMem Then
			AllocLenght = iLenght
			BufferMemory = NewMem
			If iLenght <= BufferLenght Then
				' 需要裁剪数据
				BufferLenght = iLenght - 1
				BufferMemory[BufferLenght] = 0
			EndIf
			Return -1
		EndIf
	ElseIf iLenght = 0 Then
		' 清空
		FreeMemory()
		Return -1
	Else
		' 不变
		Return -1
	EndIf
	Return 0
End Function

' 释放内存
Sub xStringBuffer.FreeMemory() XGE_EXPORT_OBJ
	If BufferMemory Then
		free(BufferMemory)
		BufferMemory = NULL
	EndIf
	BufferLenght = 0
	AllocLenght = 0
End Sub



End Extern


