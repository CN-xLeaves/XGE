/'
	xywh Base Struct Memory Manage [基本结构化内存管理器]
	
	┌─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬──┐
	│01│02│03│04│05│06│07│08│09│10│11│12│ .. │
	└─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴──┘
'/



Function PosArraySortProc Cdecl (p1 As UInteger Ptr, p2 As UInteger Ptr) As Integer
	Return *p1 - *p2
End Function



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

' 批量删除成员 (不能重复，没有排序的话必须设置bSort)
Sub xBsmm.DeleteStructs(iPosArray As UInteger Ptr, iCount As UInteger, bSort As Integer = FALSE) XGE_EXPORT_OBJ
	If iCount Then
		' 排序便于按照顺序依次删除
		If bSort Then
			qsort(iPosArray, iCount, SizeOf(UInteger), Cast(Any Ptr, @PosArraySortProc))
		EndIf
		' 开始删除
		Dim DelCount As UInteger = 0
		For i As UInteger = 0 To (iCount - 2)
			If iPosArray[i] > 0 Then
				' 编号超过后面的数据不处理
				If iPosArray[i] > StructCount Then
					Exit For
				EndIf
				' 移动数据
				DelCount += 1
				Dim dattop As Any Ptr = StructMemory + (iPosArray[i] * StructLenght)
				Dim datlen As UInteger
				datlen = (iPosArray[i + 1] - iPosArray[i] - 1) * StructLenght
				If datlen Then
					memmove(dattop - (DelCount * StructLenght), dattop, datlen)
				EndIf
			EndIf
		Next
		' 补充处理
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
		Return -1
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


