'==================================================================================
	'★ xywh Game Engine HOOK模块
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



Extern XGE_EXTERNMODULE
	#Ifdef XGE_BUILD_USEOOP
		Namespace xge
			Namespace Hook
	#EndIf
	
	
	' 修改延时函数
	Sub XGE_EXPORT_Hook_SetDelayProc(proc As XGE_DELAY_PROC) XGE_EXPORT_ALL
		If proc Then
			xge_global_dlyproc = proc
		Else
			xge_global_dlyproc = @Sleep
		EndIf
	End Sub
	
	' 修改消息分发器函数
	Sub XGE_EXPORT_Hook_SetEventProc(proc As XGE_EVENT_PROC) XGE_EXPORT_ALL
		If proc Then
			xge_global_eveproc = proc
		Else
			xge_global_eveproc = @xge_proc_event
		EndIf
	End Sub
	
	' 修改事件拦截器函数
	Sub XGE_EXPORT_Hook_SetSceneProc(proc As XGE_SCENE_PROC) XGE_EXPORT_ALL
		xge_global_msgproc = proc
	End Sub
	
	' 修改图像加载器函数
	Sub XGE_EXPORT_Hook_SetBLoadProc(proc As XGE_BLOAD_PROC) XGE_EXPORT_ALL
		xge_global_bldproc = proc
	End Sub
	
	' 修改字库加载器函数
	Sub XGE_EXPORT_Hook_SetFLoadProc(proc As XGE_FLOAD_PROC) XGE_EXPORT_ALL
		xge_global_fldproc = proc
	End Sub
	
	
	#Ifdef XGE_BUILD_USEOOP
			End Namespace
		End Namespace
	#EndIf
End Extern
