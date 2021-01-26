'==================================================================================
	'�� xywh Stack ջ���ݹ�����
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================



#Ifndef xywh_library_xstack
	#Define xywh_library_xstack
	
	
	Extern XGE_EXTERNCLASS
		
		
		
		' ����/����
		Constructor xStack(max As UInteger, unitsize As UInteger) XGE_EXPORT_LIB
			Init(max, unitsize)
		End Constructor
		Destructor xStack() XGE_EXPORT_LIB
			Unit()
		End Destructor
		
		' ��ʼ��/ж��
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
		
		' ѹջ
		Function xStack.Push(dat As Any Ptr) As Integer XGE_EXPORT_LIB
			If pStackMem Then
				If pStackTop < pMaxCount Then
					CopyMemory(pStackMem + (pStackTop * pUnitSize), dat, pUnitSize)
					pStackTop += 1
					Return TRUE
				EndIf
			EndIf
		End Function
		
		' ��ջ
		Function xStack.Pop(c As UInteger = 1) As Any Ptr XGE_EXPORT_LIB
			If pStackMem Then
				If pStackTop >= c Then
					pStackTop -= c
					Return pStackMem + (pStackTop * pUnitSize)
				EndIf
			EndIf
		End Function
		
		' ջ��
		Function xStack.Top() As Any Ptr XGE_EXPORT_LIB
			If pStackMem Then
				If pStackTop > 0 Then
					Return pStackMem + ((pStackTop - 1) * pUnitSize)
				EndIf
			EndIf
		End Function
		
		' ѹջ����
		Function xStack.Count() As UInteger XGE_EXPORT_LIB
			Return pStackTop
		End Function
		
	End Extern
#EndIf
