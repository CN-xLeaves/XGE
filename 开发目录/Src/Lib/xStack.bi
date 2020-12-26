'==================================================================================
	'★ xywh Stack 栈数据管理类
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



#Ifndef xywh_library_xstack
	#Define xywh_library_xstack
	
	
	Extern XGE_EXTERNCLASS
		
		
		
		' 构造/析构
		Constructor xStack(max As UInteger, unitsize As UInteger) XGE_EXPORT_LIB
			Init(max, unitsize)
		End Constructor
		Destructor xStack() XGE_EXPORT_LIB
			Unit()
		End Destructor
		
		' 初始化/卸载
		Function xStack.Init(max As UInteger, unitsize As UInteger) As Integer XGE_EXPORT_LIB
			If pStackMem Then
				DeAllocate(pStackMem)
			EndIf
			pStackMem = Allocate(unitsize * max)
			pMaxCount = max
			pUnitSize = unitsize
			pStackTop = 0
			If pStackMem Then
				Return TRUE
			EndIf
		End Function
		Sub xStack.Unit() XGE_EXPORT_LIB
			If pStackMem Then
				DeAllocate(pStackMem)
			EndIf
			pStackMem = 0
			pMaxCount = 0
			pUnitSize = 0
			pStackTop = 0
		End Sub
		
		' 压栈
		Function xStack.Push(dat As Any Ptr) As Integer XGE_EXPORT_LIB
			If pStackMem Then
				If pStackTop < pMaxCount Then
					CopyMemory(@pStackMem[pStackTop], dat, pUnitSize)
					pStackTop += 1
					Return TRUE
				EndIf
			EndIf
		End Function
		
		' 出栈
		Function xStack.Pop(c As UInteger = 1) As Any Ptr XGE_EXPORT_LIB
			If pStackMem Then
				If pStackTop >= c Then
					pStackTop -= c
					Return @pStackMem[pStackTop]
				EndIf
			EndIf
		End Function
		
		' 栈顶
		Function xStack.Top() As Any Ptr XGE_EXPORT_LIB
			If pStackMem Then
				If pStackTop > 0 Then
					Return @pStackMem[pStackTop-1]
				EndIf
			EndIf
		End Function
		
		' 压栈数量
		Function xStack.Count() As UInteger XGE_EXPORT_LIB
			Return pStackTop
		End Function
		
		
		
		' 构造/析构
		Constructor xStack_Int(max As UInteger) XGE_EXPORT_LIB
			Init(max)
		End Constructor
		Destructor xStack_Int() XGE_EXPORT_LIB
			Unit()
		End Destructor
		
		' 初始化/卸载
		Function xStack_Int.Init(max As UInteger) As Integer XGE_EXPORT_LIB
			If pStackMem Then
				DeAllocate(pStackMem)
			EndIf
			pStackMem = Allocate(SizeOf(Integer) * max)
			pMaxCount = max
			pStackTop = 0
			If pStackMem Then
				Return TRUE
			EndIf
		End Function
		Sub xStack_Int.Unit() XGE_EXPORT_LIB
			If pStackMem Then
				DeAllocate(pStackMem)
			EndIf
			pStackMem = 0
			pMaxCount = 0
			pStackTop = 0
		End Sub
		
		' 压栈
		Function xStack_Int.Push(dat As Integer) As Integer XGE_EXPORT_LIB
			If pStackMem Then
				If pStackTop < pMaxCount Then
					pStackMem[pStackTop] = dat
					pStackTop += 1
					Return TRUE
				EndIf
			EndIf
		End Function
		
		' 出栈
		Function xStack_Int.Pop() As Integer XGE_EXPORT_LIB
			If pStackMem Then
				If pStackTop >= 1 Then
					pStackTop -= 1
					Return pStackMem[pStackTop]
				EndIf
			EndIf
		End Function
		Function xStack_Int.Pop(c As UInteger) As Integer Ptr XGE_EXPORT_LIB
			If pStackMem Then
				If pStackTop >= c Then
					pStackTop -= c
					Return @pStackMem[pStackTop]
				EndIf
			EndIf
		End Function
		
		' 栈顶
		Function xStack_Int.Top() As Integer XGE_EXPORT_LIB
			If pStackMem Then
				If pStackTop > 0 Then
					Return pStackMem[pStackTop-1]
				EndIf
			EndIf
		End Function
		
		' 压栈数量
		Function xStack_Int.Count() As UInteger XGE_EXPORT_LIB
			Return pStackTop
		End Function
	End Extern
#EndIf
