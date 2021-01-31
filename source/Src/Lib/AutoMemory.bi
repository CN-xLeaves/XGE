


' -------------------------- 申请循环释放的临时内存
#Define XRL_RUNTIME_MEMORY_COUNT		32
Dim Shared xge_global_memory_point(1 To XRL_RUNTIME_MEMORY_COUNT) As Any Ptr		' 内存指针数组
Dim Shared xge_global_memory_istep As Integer										' 轮转申请位置
Dim Shared xge_global_snull As ZString * 4 = !"\0\0\0"								' 空字符串



Extern XGE_EXTERNSTDEXT
	
	' 申请临时内存
	Function AllocTempMemory(size As UInteger) As Any Ptr XGE_EXPORT_ALL
		xge_global_memory_istep += 1
		If xge_global_memory_point(xge_global_memory_istep) Then
			free(xge_global_memory_point(xge_global_memory_istep))
		EndIf
		xge_global_memory_point(xge_global_memory_istep) = malloc(size)
		Function = xge_global_memory_point(xge_global_memory_istep)
		If xge_global_memory_istep >= XRL_RUNTIME_MEMORY_COUNT Then
			xge_global_memory_istep = 0
		EndIf
	End Function
	
	' 添加指针到自动释放列表
	Sub AddTempMemory(pMemory As Any Ptr) XGE_EXPORT_ALL
		xge_global_memory_istep += 1
		If xge_global_memory_point(xge_global_memory_istep) Then
			free(xge_global_memory_point(xge_global_memory_istep))
		EndIf
		xge_global_memory_point(xge_global_memory_istep) = pMemory
		If xge_global_memory_istep >= XRL_RUNTIME_MEMORY_COUNT Then
			xge_global_memory_istep = 0
		EndIf
	End Sub
	
	' 释放所有临时内存
	Sub FreeTempMemory() XGE_EXPORT_ALL
		For i As Integer = 1 To XRL_RUNTIME_MEMORY_COUNT
			If xge_global_memory_point(i) Then
				free (xge_global_memory_point(i))
				xge_global_memory_point(i) = NULL
			EndIf
		Next
		xge_global_memory_istep = 0
	End Sub
	
End Extern


