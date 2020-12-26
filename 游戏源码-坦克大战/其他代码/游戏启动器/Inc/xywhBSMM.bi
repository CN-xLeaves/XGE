
/'
	xywh Basic Struct Memory Manage [�����ṹ���ڴ������]
'/
Type xywhBSMM
	Declare Constructor()
	Declare Constructor(ByVal ItemLenght As Integer,ByVal PreassignStep As Integer,ByVal PreassignLenght As Integer)
	Declare Destructor()
	Public:
		Count As Integer									' �������д��ڶ��ٳ�Ա
		
		Declare Function AddStruct() As Any Ptr																	' ���һ���ṹ���Ա
		Declare Function AddStructs(ByVal AddCount As Integer) As Integer				' һ������Ӷ���ṹ���Ա
		Declare Function DelStruct(ByVal StructAddr As Integer) As Integer			' ɾ��һ���ṹ���Ա
		Declare Function GetPoint(ByVal StructAddr As Integer) As Any Ptr				' ��ȡָ��ID��Ա���ڴ�ָ��
		Declare Sub ClearSelect()																								' ���ò�ѯλ��
		
		Declare Function PreassignMemory(ByVal PreNum As Integer) As Integer		' Ԥ�����ڴ�
		Declare Function ClearFreeMemory() As Integer														' �ͷſ��е��ڴ�ռ�
		Declare Function ClearStruct(ByVal StructAddr As Integer) As Integer		' ���ָ��ID�ĳ�Ա�ڴ�����
		Declare Sub ClearMemory()																								' ���ȫ���ڴ�����
		Declare Sub ReInitManage()																							' ���������� [���ȫ�����ݺ��ڴ�]
		Declare Sub Dump(ByVal FileName As ZString Ptr)													' ת������ [���ڵ���]
	Protected:
		Dim Memory As Any Ptr									' �������ڴ�ָ��
		Dim StructLenght As Integer						' ÿ����Առ�õ��ڴ�
		Dim MemoryCount As Integer						' �Ѿ�������ٸ���Ա���ڴ�
		Dim MemoryStep As Integer							' һ��������ٳ�Ա�ڴ�
		Dim SelPtr As Integer									' ��ѯλ��ָ�� [����������ѯ�Ķ��η�װ]
End Type



Constructor xywhBSMM()
	MemoryStep = 1024
	ClearSelect()
End Constructor

Constructor xywhBSMM(ByVal ItemLenght As Integer,ByVal PreassignStep As Integer,ByVal PreassignLenght As Integer)
	StructLenght = ItemLenght
	MemoryStep = PreassignStep
	PreassignMemory(PreassignLenght)
	ClearSelect()
End Constructor

Destructor xywhBSMM()
	ReInitManage()
End Destructor

Function xywhBSMM.AddStruct() As Any Ptr
	Dim RetInt As Integer = AddStructs(1)
	If RetInt Then
		Return GetPoint(RetInt)
	EndIf
End Function

Function xywhBSMM.AddStructs(ByVal AddCount As Integer) As Integer
	' �ж��Ƿ���Ҫ�����ڴ�
	If Count+AddCount > MemoryCount Then
		If AddCount>MemoryStep Then
			If PreassignMemory(AddCount)=0 Then
				Return 0
			EndIf
		Else
			If PreassignMemory(MemoryStep)=0 Then
				Return 0
			EndIf
		EndIf
	EndIf
	' ����
	Dim RetStructAddr As Integer = Count+1
	Count += AddCount
	Return RetStructAddr
End Function

Function xywhBSMM.DelStruct(ByVal StructAddr As Integer) As Integer
	If Memory Then
		If StructAddr > Count Then
			Return NULL
		EndIf
		If StructAddr < 1 Then
			Return NULL
		EndIf
		If Count=StructAddr Then			' ɾ��ĩβ��
			ClearStruct(StructAddr)
		Else
			RtlMoveMemory(Memory+((StructAddr-1)*StructLenght),Memory+(StructAddr*StructLenght),(Count-StructAddr)*StructLenght)
		EndIf
		Count -= 1
		Return -1
	EndIf
End Function

Function xywhBSMM.GetPoint(ByVal StructAddr As Integer) As Any Ptr
	If Memory Then
		If StructAddr > Count Then
			Return NULL
		EndIf
		If StructAddr < 1 Then
			Return NULL
		EndIf
		Return Memory + ((StructAddr-1)*StructLenght)
	EndIf
End Function

Sub xywhBSMM.ClearSelect()
	SelPtr = 1
End Sub

Function xywhBSMM.PreassignMemory(ByVal PreNum As Integer) As Integer
	Dim NewMemory As Any Ptr
	NewMemory = ReAllocate(Memory,(MemoryCount+PreNum)*StructLenght)
	If NewMemory Then
		Clear(*Cast(ZString Ptr,NewMemory+(MemoryCount*StructLenght)),0,PreNum*StructLenght)
		Memory = NewMemory
		MemoryCount += PreNum
		Return -1
	EndIf
	Return 0
End Function

Function xywhBSMM.ClearFreeMemory() As Integer
	Dim NewMemory As Any Ptr
	NewMemory = ReAllocate(Memory,Count*StructLenght)
	If NewMemory Then
		Memory = NewMemory
		MemoryCount = Count
		Return -1
	EndIf
	Return 0
End Function

Sub xywhBSMM.ClearMemory()
	If Memory Then
		Clear(*Cast(ZString Ptr,Memory),0,MemoryCount*StructLenght)
	EndIf
End Sub

Function xywhBSMM.ClearStruct(ByVal StructAddr As Integer) As Integer
	If Memory Then
		If StructAddr > Count Then
			Return 0
		EndIf
		If StructAddr < 1 Then
			Return 0
		EndIf
		Clear(*Cast(ZString Ptr,Memory+((StructAddr-1)*StructLenght)),0,StructLenght)
		Return -1
	EndIf
End Function

Sub xywhBSMM.ReInitManage()
	DeAllocate(Memory)
	Memory = NULL
	MemoryCount = 0
	Count = 0
	ClearSelect()
End Sub

Sub xywhBSMM.Dump(ByVal FileName As ZString Ptr)
	If Memory Then
		PutFile(FileName,Memory,0,MemoryCount*StructLenght)
		SetFileSize(FileName,MemoryCount*StructLenght)
	EndIf
End Sub