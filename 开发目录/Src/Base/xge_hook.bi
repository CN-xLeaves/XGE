'==================================================================================
	'�� xywh Game Engine HOOKģ��
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================



Extern XGE_EXTERNMODULE
	#Ifdef XGE_BUILD_USEOOP
		Namespace xge
			Namespace Hook
	#EndIf
	
	
	' �޸���ʱ����
	Sub XGE_EXPORT_Hook_SetDelayProc(proc As XGE_DELAY_PROC) XGE_EXPORT_ALL
		If proc Then
			xge_global_dlyproc = proc
		Else
			xge_global_dlyproc = @Sleep
		EndIf
	End Sub
	
	' �޸���Ϣ�ַ�������
	Sub XGE_EXPORT_Hook_SetEventProc(proc As XGE_EVENT_PROC) XGE_EXPORT_ALL
		If proc Then
			xge_global_eveproc = proc
		Else
			xge_global_eveproc = @xge_proc_event
		EndIf
	End Sub
	
	' �޸��¼�����������
	Sub XGE_EXPORT_Hook_SetSceneProc(proc As XGE_SCENE_PROC) XGE_EXPORT_ALL
		xge_global_msgproc = proc
	End Sub
	
	' �޸�ͼ�����������
	Sub XGE_EXPORT_Hook_SetBLoadProc(proc As XGE_BLOAD_PROC) XGE_EXPORT_ALL
		xge_global_bldproc = proc
	End Sub
	
	' �޸��ֿ����������
	Sub XGE_EXPORT_Hook_SetFLoadProc(proc As XGE_FLOAD_PROC) XGE_EXPORT_ALL
		xge_global_fldproc = proc
	End Sub
	
	
	#Ifdef XGE_BUILD_USEOOP
			End Namespace
		End Namespace
	#EndIf
End Extern
