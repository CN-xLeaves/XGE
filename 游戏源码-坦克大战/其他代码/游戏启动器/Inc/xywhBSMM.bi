
/'
	xywh Basic Struct Memory Manage [基本结构化内存管理器]
'/
Type xywhBSMM
	Declare Constructor()
	Declare Constructor(ByVal ItemLenght As Integer,ByVal PreassignStep As Integer,ByVal PreassignLenght As Integer)
	Declare Destructor()
	Public:
		Count As Integer									' 管理器中存在多少成员
		
		Declare Function AddStruct() As Any Ptr																	' 添加一个结构体成员
		Declare Function AddStructs(ByVal AddCount As Integer) As Integer				' 一次性添加多个结构体成员
		Declare Function DelStruct(ByVal StructAddr As Integer) As Integer			' 删除一个结构体成员
		Declare Function GetPoint(ByVal StructAddr As Integer) As Any Ptr				' 获取指定ID成员的内存指针
		Declare Sub ClearSelect()																								' 重置查询位置
		
		Declare Function PreassignMemory(ByVal PreNum As Integer) As Integer		' 预申请内存
		Declare Function ClearFreeMemory() As Integer														' 释放空闲的内存空间
		Declare Function ClearStruct(ByVal StructAddr As Integer) As Integer		' 清除指定ID的成员内存数据
		Declare Sub ClearMemory()																								' 清除全部内存数据
		Declare Sub ReInitManage()																							' 重启管理器 [清除全部数据和内存]
		Declare Sub Dump(ByVal FileName As ZString Ptr)													' 转储数据 [用于调试]
	Protected:
		Dim Memory As Any Ptr									' 管理器内存指针
		Dim StructLenght As Integer						' 每个成员占用的内存
		Dim MemoryCount As Integer						' 已经申请多少个成员的内存
		Dim MemoryStep As Integer							' 一次申请多少成员内存
		Dim SelPtr As Integer									' 查询位置指针 [用于条件查询的二次封装]
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
	' 判断是否需要申请内存
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
	' 操作
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
		If Count=StructAddr Then			' 删除末尾项
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