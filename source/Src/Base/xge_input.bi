'==================================================================================
	'★ xywh Game Engine 输入检测模块
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



Extern XGE_EXTERNMODULE
	#Ifdef XGE_BUILD_USEOOP
		Namespace xge
			Namespace xInput
	#EndIf
	
	
	' 获取按键状态
	Function XGE_EXPORT_Input_KeyStatus(k As Integer) As Integer XGE_EXPORT_ALL
		Return MultiKey(k)
	End Function
	
	' 获取鼠标状态
	Sub XGE_EXPORT_Input_MouseStatus(x As Integer Ptr, y As Integer Ptr, w As Integer Ptr, b As Integer Ptr) XGE_EXPORT_ALL
		Dim As Integer tx, ty, tw, tb
		GetMouse(tx, ty, tw, tb)
		If x Then *x = tx
		If y Then *y = ty
		If w Then *w = tw
		If b Then *b = tb
	End Sub
	
	' 取操纵杆状态
	Function XGE_EXPORT_Input_JoyStatus(id As Integer, btn As Integer Ptr, a1 As Single Ptr, a2 As Single Ptr, a3 As Single Ptr, a4 As Single Ptr, a5 As Single Ptr, a6 As Single Ptr, a7 As Single Ptr, a8 As Single Ptr) As Integer XGE_EXPORT_ALL
		Dim As Integer tid, tbtn, tret
		Dim As Single ta1, ta2, ta3, ta4, ta5, ta6, ta7, ta8
		tret = GetJoystick(tid, tbtn, ta1, ta2, ta3, ta4, ta5, ta6, ta7, ta8)
		If btn Then *btn = tbtn
		If a1 Then *a1 = ta1
		If a2 Then *a2 = ta2
		If a3 Then *a3 = ta3
		If a4 Then *a4 = ta4
		If a5 Then *a5 = ta5
		If a6 Then *a6 = ta6
		If a7 Then *a7 = ta7
		If a8 Then *a8 = ta8
		Return tret
	End Function
	
	' 取鼠标位置
	Function XGE_EXPORT_Input_GetMousePos() As Integer XGE_EXPORT_ALL
		Dim As Integer x, y
		GetMouse(x, y)
		Return (x Shl 16) Or y
	End Function
	
	' 设置鼠标位置
	Function XGE_EXPORT_Input_SetMousePos(x As Integer, y As Integer) As Integer XGE_EXPORT_ALL
		Return SetMouse(x, y)
	End Function
	
	' 取鼠标横坐标
	Function XGE_EXPORT_Input_GetMouseX() As Integer XGE_EXPORT_ALL
		Dim As Integer x, y
		GetMouse(x, y)
		Return x
	End Function
	
	' 取鼠标纵坐标
	Function XGE_EXPORT_Input_GetMouseY() As Integer XGE_EXPORT_ALL
		Dim As Integer x, y
		GetMouse(x, y)
		Return y
	End Function
	
	' 取鼠标按钮状态
	Function XGE_EXPORT_Input_GetMouseBtn() As Integer XGE_EXPORT_ALL
		Dim As Integer x, y, b
		GetMouse(x, y, , b)
		Return b
	End Function
	
	' 取鼠标左键状态
	Function XGE_EXPORT_Input_GetMouseBtnL() As Integer XGE_EXPORT_ALL
		Dim As Integer x, y, b
		GetMouse(x, y, , b)
		Return b And 1
	End Function
	
	' 取鼠标右键状态
	Function XGE_EXPORT_Input_GetMouseBtnR() As Integer XGE_EXPORT_ALL
		Dim As Integer x, y, b
		GetMouse(x, y, , b)
		Return b And 2
	End Function
	
	' 取鼠标中键状态
	Function XGE_EXPORT_Input_GetMouseBtnM() As Integer XGE_EXPORT_ALL
		Dim As Integer x, y, b
		GetMouse(x, y, , b)
		Return b And 4
	End Function
	
	' 获取滚轮计数
	Function XGE_EXPORT_Input_GetMouseWhell() As Integer XGE_EXPORT_ALL
		Dim As Integer x, y, w
		GetMouse(x, y, w)
		Return w
	End Function
	
	
	#Ifdef XGE_BUILD_USEOOP
			End Namespace
		End Namespace
	#EndIf
End Extern