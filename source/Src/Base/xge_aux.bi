'==================================================================================
	'★ xywh Game Engine 辅助库模块
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



Extern XGE_EXTERNMODULE
	#Ifdef XGE_BUILD_USEOOP
		Namespace xge
			Namespace Aux
	#EndIf
	
	
	' 截图
	Function XGE_EXPORT_Aux_ScreenShot() As xge.Surface Ptr XGE_EXPORT_ALL
		Dim NewSurface As xge.Surface Ptr = New xge.Surface(xge_global_width, xge_global_height)
		If NewSurface->img Then
			memcpy(NewSurface->PixAddr, XGE_PROC_PixAddr, XGE_PROC_PixSize)
			Return NewSurface
		Else
			Delete(NewSurface)
		EndIf
	End Function
	
	' 取色
	Function XGE_EXPORT_Aux_GetPixel(sf As xge.Surface Ptr, x As Integer, y As Integer) As UInteger XGE_EXPORT_ALL
		If sf Then
			Return Point(x, y, sf->img)
		Else
			Return Point(x, y)
		EndIf
	End Function
	
	' 颜色转换
	Function XGE_EXPORT_Aux_RGB2BGR(c As UInteger) As UInteger XGE_EXPORT_ALL
		Asm
			mov eax,[c]
			bswap eax
			ror eax,8
			mov [c],eax
		End Asm
		Return c
	End Function
	
	' 获取随机数
	Function XGE_EXPORT_Aux_RandInt(min As UInteger = 0, max As UInteger = &HFFFFFFFF) As Integer XGE_EXPORT_ALL
		Dim uint As UInteger = (Rnd * (max - min)) + min
		Return Cast(Integer, uint)
	End Function
	Function XGE_EXPORT_Aux_RandDouble() As Double XGE_EXPORT_ALL
		Return Rnd()
	End Function
	
	' 改变窗口标题
	Sub XGE_EXPORT_Aux_SetTitleA(title As ZString Ptr) XGE_EXPORT_ALL
		WindowTitle(*title)
	End Sub
	
	' 改变窗口标题
	Sub XGE_EXPORT_Aux_SetTitleW(title As WString Ptr) XGE_EXPORT_ALL
		Dim st As ZString Ptr = UnicodeToAsci(title)
		WindowTitle(*st)
		DeAllocate(st)
	End Sub
	
	' 设置可视区域
	Sub XGE_EXPORT_Aux_SetView(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, f As Integer) XGE_EXPORT_ALL
		View (x1, y1) - (x2, y2), c, f
	End Sub
	
	' 清除可视区域设置
	Sub XGE_EXPORT_Aux_ReSetView() XGE_EXPORT_ALL
		View
	End Sub
	
	' 设置坐标系
	Sub XGE_EXPORT_Aux_SetCoodr(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer = 0) XGE_EXPORT_ALL
		If c Then
			Window (x1, y1) - (x2, y2)
		Else
			Window Screen (x1, y1) - (x2, y2)
		EndIf
	End Sub
	
	' 清除坐标系设置
	Sub XGE_EXPORT_Aux_ReSetCoodr() XGE_EXPORT_ALL
		Window
	End Sub
	
	' 获取坐标映射关系
	Function XGE_EXPORT_Aux_MapCoodr(coodr As Integer, tpe As Integer) As Integer XGE_EXPORT_ALL
		Return PMap(coodr, tpe)
	End Function
	
	' 锁定鼠标
	Function XGE_EXPORT_Aux_LockMouse() As Integer XGE_EXPORT_ALL
		Return SetMouse( , , , 1)
	End Function
	
	' 解锁鼠标
	Function XGE_EXPORT_Aux_UnLockMouse() As Integer XGE_EXPORT_ALL
		Return SetMouse( , , , 0)
	End Function
	
	' 隐藏光标
	Function XGE_EXPORT_Aux_HideCursor() As Integer XGE_EXPORT_ALL
		Return SetMouse( , , 0)
	End Function
	
	' 显示光标
	Function XGE_EXPORT_Aux_ShowCursor() As Integer XGE_EXPORT_ALL
		Return SetMouse( , , 1)
	End Function
	
	
	#Ifdef XGE_BUILD_USEOOP
			End Namespace
		End Namespace
	#EndIf
End Extern