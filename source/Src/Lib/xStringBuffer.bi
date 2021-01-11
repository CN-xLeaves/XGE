


Extern XGE_EXTERNCLASS



' ����
Constructor xStringBuffer() XGE_EXPORT_OBJ
	AllocStep = 64
End Constructor

' ����
Destructor xStringBuffer() XGE_EXPORT_OBJ
	FreeMemory()
End Destructor

' ��������
Function xStringBuffer.SetText(sText As WString Ptr, iTextSize As UInteger = 0) As Integer
	' �Զ������ı�����
	If iTextSize = 0 Then
		iTextSize = wcslen(sText)
	EndIf
	BufferLenght = 0
	If iTextSize Then
		Return AppendText(sText, iTextSize)
	EndIf
	Return -1
End Function

' ׷��д����
Function xStringBuffer.AppendText(sText As WString Ptr, iTextSize As UInteger = 0) As Integer XGE_EXPORT_OBJ
	' �Զ������ı�����
	If iTextSize = 0 Then
		iTextSize = wcslen(sText)
	EndIf
	If iTextSize Then
		' �ڴ治��ʱ��Ҫ�����ڴ� [ �ж� spaceMemory < 0 ���� Int �� UInt ��Ϊ����������ֹ������ ]
		Dim spaceMemory As Integer = (AllocLenght - BufferLenght) - 1
		If (spaceMemory < 0) Or (iTextSize > spaceMemory) Then
			If MallocMemory(AllocLenght + (iTextSize - spaceMemory) + AllocStep) = 0 Then
				Return 0
			EndIf
		EndIf
		' д������
		memcpy(@BufferMemory[BufferLenght], sText, iTextSize * SizeOf(WString))
		BufferLenght += iTextSize
		BufferMemory[BufferLenght] = 0
	EndIf
	Return -1
End Function

' ����д����
Function xStringBuffer.InsertText(iPos As UInteger, iSize As UInteger, sText As WString Ptr, iTextSize As UInteger = 0) As Integer XGE_EXPORT_OBJ
	' �Զ������ı�����
	If iTextSize = 0 Then
		iTextSize = wcslen(sText)
	EndIf
	If iTextSize Then
		If iPos >= BufferLenght Then
			' ������������Ϊ ĩβ׷��ģʽ
			AppendText(sText, iTextSize)
		Else
			' �����Ĳ���ģʽ [ �ڴ治��ʱ��Ҫ�����ڴ� ]
			Dim spaceMemory As Integer = (AllocLenght - BufferLenght) - 1
			Dim ChangeSize As Integer = iTextSize - iSize
			If ChangeSize > spaceMemory Then
				If MallocMemory(AllocLenght + (ChangeSize - spaceMemory) + AllocStep) = 0 Then
					Return 0
				EndIf
			EndIf
			' д������
			If ChangeSize Then
				memmove(@BufferMemory[(iPos + iSize) + ChangeSize], @BufferMemory[iPos + iSize], (BufferLenght - (iPos + iSize)) * SizeOf(WString))
			EndIf
			memcpy(@BufferMemory[iPos], sText, iTextSize * SizeOf(WString))
			BufferLenght += ChangeSize
			BufferMemory[BufferLenght] = 0
		EndIf
	Else
		' û��������֣�������ɾ��ѡ��Ĳ�������
		If iSize Then
			DeleteText(iPos, iSize)
		EndIf
	EndIf
	Return -1
End Function

' ɾ������
Function xStringBuffer.DeleteText(iPos As UInteger, iSize As UInteger) As Integer XGE_EXPORT_OBJ
	If iSize Then
		memmove(@BufferMemory[iPos], @BufferMemory[iPos + iSize], (BufferLenght - iPos) * SizeOf(WString))
		BufferLenght -= iSize
		BufferMemory[BufferLenght] = 0
	EndIf
	Return -1
End Function

' �����ڴ�
Function xStringBuffer.MallocMemory(iLenght As UInteger) As Integer XGE_EXPORT_OBJ
	If iLenght > AllocLenght Then
		' ����
		Dim NewMem As Any Ptr = realloc(BufferMemory, iLenght * SizeOf(WString))
		If NewMem Then
			AllocLenght = iLenght
			BufferMemory = NewMem
			Return -1
		EndIf
	ElseIf iLenght < AllocLenght Then
		' �ü�
		Dim NewMem As Any Ptr = realloc(BufferMemory, iLenght * SizeOf(WString))
		If NewMem Then
			AllocLenght = iLenght
			BufferMemory = NewMem
			If iLenght <= BufferLenght Then
				' ��Ҫ�ü�����
				BufferLenght = iLenght - 1
				BufferMemory[BufferLenght] = 0
			EndIf
			Return -1
		EndIf
	ElseIf iLenght = 0 Then
		' ���
		FreeMemory()
		Return -1
	Else
		' ����
		Return -1
	EndIf
	Return 0
End Function

' �ͷ��ڴ�
Sub xStringBuffer.FreeMemory() XGE_EXPORT_OBJ
	If BufferMemory Then
		free(BufferMemory)
		BufferMemory = NULL
	EndIf
	BufferLenght = 0
	AllocLenght = 0
End Sub



End Extern


