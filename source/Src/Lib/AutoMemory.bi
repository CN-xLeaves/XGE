


' -------------------------- ����ѭ���ͷŵ���ʱ�ڴ�
#Define XRL_RUNTIME_MEMORY_COUNT		32
Dim Shared xge_global_memory_point(1 To XRL_RUNTIME_MEMORY_COUNT) As Any Ptr		' �ڴ�ָ������
Dim Shared xge_global_memory_istep As Integer										' ��ת����λ��
Dim Shared xge_global_snull As ZString * 4 = !"\0\0\0"								' ���ַ���



Extern XGE_EXTERNSTDEXT
	
	' ������ʱ�ڴ�
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
	
	' ���ָ�뵽�Զ��ͷ��б�
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
	
	' �ͷ�������ʱ�ڴ�
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


