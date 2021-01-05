/'
	xywh Base Struct Memory Manage [基本结构化内存管理器]
	
	┌─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬──┐
	│01│02│03│04│05│06│07│08│09│10│11│12│ .. │
	└─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴──┘
'/



Extern XGE_EXTERNCLASS



' 构造函数
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

' 析构函数
Destructor xBsmm() XGE_EXPORT_OBJ
	ReInitManage()
End Destructor

' 添加成员 [成功返回idx，失败返回0]
Function xBsmm.InsertStruct(iPos As UInteger, iCount As UInteger = 1) As UInteger XGE_EXPORT_OBJ
	' 不能添加0个成员
	If iCount = 0 Then
		Return 0
	EndIf
	' 分配内存
	If StructCount + iCount > AllocCount Then
		If CallocMemory(StructCount + iCount + AllocStep) = 0 Then
			Return 0
		EndIf
	EndIf
	If iPos < StructCount Then
		' 插入
		memmove(StructMemory + ((iPos + iCount) * StructLenght), StructMemory + (iPos * StructLenght), (StructCount - iPos) * StructLenght)
		'Function = StructMemory + (iPos * StructLenght)
		Function = iPos + 1
		StructCount += iCount
	Else
		' 添加
		'Function = StructMemory + (StructCount * StructLenght)
		Function = StructCount + 1
		StructCount += iCount
	EndIf
End Function
Function xBsmm.AppendStruct(iCount As UInteger = 1) As UInteger XGE_EXPORT_OBJ
	Return InsertStruct(StructCount, iCount)
End Function

' 删除成员
Function xBsmm.DeleteStruct(iPos As UInteger, iCount As UInteger = 1) As Integer XGE_EXPORT_OBJ
	' 不能删除0个成员
	If iCount Then
		' 范围检查
		If iPos Then
			iPos -= 1
			If iPos < StructCount Then
				If iPos + iCount < StructCount Then
					' 中段删除
					memmove(StructMemory + (iPos * StructLenght), StructMemory + ((iPos + iCount) * StructLenght), (StructCount - (iPos + iCount)) * StructLenght)
					StructCount -= iCount
				Else
					' 末尾删除
					StructCount = iPos
				EndIf
				Return -1
			EndIf
		EndIf
	EndIf
End Function

' 移动成员
Function xBsmm.SwapStruct(iPosA As UInteger, iPosB As UInteger) As Integer XGE_EXPORT_OBJ
	' 范围检查
	If (iPosA <> 0) And (iPosB <> 0) Then
		iPosA -= 1
		iPosB -= 1
		If (iPosA < StructCount) And (iPosB < StructCount) Then
			If iPosA <> iPosB Then
				' 交换数据
				Dim StuA As Any Ptr = malloc(StructLenght)
				memmove(StuA, StructMemory + (iPosA * StructLenght), StructLenght)
				memmove(StructMemory + (iPosA * StructLenght), StructMemory + (iPosB * StructLenght), StructLenght)
				memmove(StructMemory + (iPosB * StructLenght), StuA, StructLenght)
				free(StuA)
				Return -1
			Else
				' 位置相同，不需要交换
				Return -1
			EndIf
		EndIf
	EndIf
End Function

' 获取成员指针
Function xBsmm.GetPtrStruct(iPos As UInteger) As Any Ptr XGE_EXPORT_OBJ
	If iPos Then
		iPos -= 1
		If iPos < StructCount Then
			Return StructMemory + (iPos * StructLenght)
		EndIf
	EndIf
End Function

' 分配内存
Function xBsmm.CallocMemory(iCount As UInteger) As Integer XGE_EXPORT_OBJ
	If iCount > AllocCount Then
		' 增量
		Dim NewMem As Any Ptr = realloc(StructMemory, iCount * StructLenght)
		If NewMem Then
			AllocCount = iCount
			StructMemory = NewMem
			Return -1
		EndIf
	ElseIf iCount < AllocCount Then
		' 裁剪
		Dim NewMem As Any Ptr = realloc(StructMemory, iCount * StructLenght)
		If NewMem Then
			AllocCount = iCount
			StructMemory = NewMem
			If iCount <= StructCount Then
				' 需要裁剪数据
				StructCount = iCount
			EndIf
			Return -1
		EndIf
	ElseIf iCount = 0 Then
		' 清空
		ReInitManage()
	Else
		' 不变
		Return -1
	EndIf
	Return 0
End Function

' 重置（释放资源）
Sub xBsmm.ReInitManage() XGE_EXPORT_OBJ
	If StructMemory Then
		free(StructMemory)
		StructMemory = NULL
	EndIf
	StructCount = 0
	AllocCount = 0
End Sub



End Extern


