/'
	xywh Base Struct Memory Manage [�����ṹ���ڴ������]
	
	�����Щ��Щ��Щ��Щ��Щ��Щ��Щ��Щ��Щ��Щ��Щ��Щ�����
	��01��02��03��04��05��06��07��08��09��10��11��12�� .. ��
	�����ة��ة��ة��ة��ة��ة��ة��ة��ة��ة��ة��ة�����
'/



Function PosArraySortProc Cdecl (p1 As UInteger Ptr, p2 As UInteger Ptr) As Integer
	Return *p1 - *p2
End Function



Extern XGE_EXTERNCLASS



' ���캯��
Constructor xBsmm() XGE_EXPORT_OBJ
	StructLenght = SizeOf(Any Ptr)
	AllocStep = 32
End Constructor
Constructor xBsmm(iItemLenght As UInteger, PreassignStep As UInteger = 32, PreassignLenght As UInteger = 0) XGE_EXPORT_OBJ
	StructLenght = iItemLenght
	AllocStep = PreassignStep
	If PreassignLenght Then
		CallocMemory(PreassignLenght)
	EndIf
End Constructor

' ��������
Destructor xBsmm() XGE_EXPORT_OBJ
	ReInitManage()
End Destructor

' ��ӳ�Ա [�ɹ�����idx��ʧ�ܷ���0]
Function xBsmm.InsertStruct(iPos As UInteger, iCount As UInteger = 1) As UInteger XGE_EXPORT_OBJ
	' �������0����Ա
	If iCount = 0 Then
		Return 0
	EndIf
	' �����ڴ�
	If StructCount + iCount > AllocCount Then
		If CallocMemory(StructCount + iCount + AllocStep) = 0 Then
			Return 0
		EndIf
	EndIf
	If iPos < StructCount Then
		' ����
		memmove(StructMemory + ((iPos + iCount) * StructLenght), StructMemory + (iPos * StructLenght), (StructCount - iPos) * StructLenght)
		'Function = StructMemory + (iPos * StructLenght)
		Function = iPos + 1
		StructCount += iCount
	Else
		' ���
		'Function = StructMemory + (StructCount * StructLenght)
		Function = StructCount + 1
		StructCount += iCount
	EndIf
End Function
Function xBsmm.AppendStruct(iCount As UInteger = 1) As UInteger XGE_EXPORT_OBJ
	Return InsertStruct(StructCount, iCount)
End Function

' ɾ����Ա
Function xBsmm.DeleteStruct(iPos As UInteger, iCount As UInteger = 1) As Integer XGE_EXPORT_OBJ
	' ����ɾ��0����Ա
	If iCount Then
		' ��Χ���
		If iPos Then
			iPos -= 1
			If iPos < StructCount Then
				If iPos + iCount < StructCount Then
					' �ж�ɾ��
					memmove(StructMemory + (iPos * StructLenght), StructMemory + ((iPos + iCount) * StructLenght), (StructCount - (iPos + iCount)) * StructLenght)
					StructCount -= iCount
				Else
					' ĩβɾ��
					StructCount = iPos
				EndIf
				Return -1
			EndIf
		EndIf
	EndIf
End Function

' ����ɾ����Ա (�����ظ���û������Ļ���������bSort)
Sub xBsmm.DeleteStructs(iPosArray As UInteger Ptr, iCount As UInteger, bSort As Integer = FALSE) XGE_EXPORT_OBJ
	If iCount Then
		' ������ڰ���˳������ɾ��
		If bSort Then
			qsort(iPosArray, iCount, SizeOf(UInteger), Cast(Any Ptr, @PosArraySortProc))
		EndIf
		' ��ʼɾ��
		Dim DelCount As UInteger = 0
		For i As UInteger = 0 To (iCount - 2)
			If iPosArray[i] > 0 Then
				' ��ų�����������ݲ�����
				If iPosArray[i] > StructCount Then
					Exit For
				EndIf
				' �ƶ�����
				DelCount += 1
				Dim dattop As Any Ptr = StructMemory + (iPosArray[i] * StructLenght)
				Dim datlen As UInteger
				datlen = (iPosArray[i + 1] - iPosArray[i] - 1) * StructLenght
				If datlen Then
					memmove(dattop - (DelCount * StructLenght), dattop, datlen)
				EndIf
			EndIf
		Next
		' ���䴦��
		If iPosArray[iCount-1] < StructCount Then
			DelCount += 1
			Dim dattop As Any Ptr = StructMemory + (iPosArray[iCount-1] * StructLenght)
			Dim datlen As UInteger = (StructCount - iPosArray[iCount-1]) * StructLenght
			memmove(dattop - (DelCount * StructLenght), dattop, datlen)
		ElseIf iPosArray[iCount-1] = StructCount Then
			DelCount += 1
		EndIf
		StructCount -= DelCount
	EndIf
End Sub

' �ƶ���Ա
Function xBsmm.SwapStruct(iPosA As UInteger, iPosB As UInteger) As Integer XGE_EXPORT_OBJ
	' ��Χ���
	If (iPosA <> 0) And (iPosB <> 0) Then
		iPosA -= 1
		iPosB -= 1
		If (iPosA < StructCount) And (iPosB < StructCount) Then
			If iPosA <> iPosB Then
				' ��������
				Dim StuA As Any Ptr = malloc(StructLenght)
				memmove(StuA, StructMemory + (iPosA * StructLenght), StructLenght)
				memmove(StructMemory + (iPosA * StructLenght), StructMemory + (iPosB * StructLenght), StructLenght)
				memmove(StructMemory + (iPosB * StructLenght), StuA, StructLenght)
				free(StuA)
				Return -1
			Else
				' λ����ͬ������Ҫ����
				Return -1
			EndIf
		EndIf
	EndIf
End Function

' ��ȡ��Աָ��
Function xBsmm.GetPtrStruct(iPos As UInteger) As Any Ptr XGE_EXPORT_OBJ
	If iPos Then
		iPos -= 1
		If iPos < StructCount Then
			Return StructMemory + (iPos * StructLenght)
		EndIf
	EndIf
End Function

' �����ڴ�
Function xBsmm.CallocMemory(iCount As UInteger) As Integer XGE_EXPORT_OBJ
	If iCount > AllocCount Then
		' ����
		Dim NewMem As Any Ptr = realloc(StructMemory, iCount * StructLenght)
		If NewMem Then
			AllocCount = iCount
			StructMemory = NewMem
			Return -1
		EndIf
	ElseIf iCount < AllocCount Then
		' �ü�
		Dim NewMem As Any Ptr = realloc(StructMemory, iCount * StructLenght)
		If NewMem Then
			AllocCount = iCount
			StructMemory = NewMem
			If iCount <= StructCount Then
				' ��Ҫ�ü�����
				StructCount = iCount
			EndIf
			Return -1
		EndIf
	ElseIf iCount = 0 Then
		' ���
		ReInitManage()
		Return -1
	Else
		' ����
		Return -1
	EndIf
	Return 0
End Function

' ���ã��ͷ���Դ��
Sub xBsmm.ReInitManage() XGE_EXPORT_OBJ
	If StructMemory Then
		free(StructMemory)
		StructMemory = NULL
	EndIf
	StructCount = 0
	AllocCount = 0
End Sub



End Extern


