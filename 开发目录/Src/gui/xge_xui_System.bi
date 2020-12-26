'==================================================================================
	'★ xywh Game Engine 用户界面系统 [nuklear库]
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



Extern XGE_EXTERNCLASS



Namespace xui
	
	
	
	' 获取根元素 (Desktop元素)
	Function GetRootElement() As xui.Element Ptr XGE_EXPORT_ALL
		Return xge_xui_element_root
	End Function
	
	' 获取被激活的元素
	Function GetActiveElement() As xui.Element Ptr XGE_EXPORT_ALL
		Return xge_xui_element_active
	End Function
	
	' 获取鼠标指针下的热点元素
	Function GetHotElement() As xui.Element Ptr XGE_EXPORT_ALL
		Return xge_xui_element_hot
	End Function
	
	' 应用布局
	Sub LayoutApply() XGE_EXPORT_ALL
		xge_xui_element_root->LayoutApply()
	End Sub
	
	
	
	' 创建一个空白的元素
	Function CreateElement(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sIdentifier As ZString Ptr = NULL) As xui.Element Ptr XGE_EXPORT_ALL
		Dim ele As xui.Element Ptr
		ele = New xui.Element(iLayoutRuler, x, y, w, h, iLayoutMode, sIdentifier)
		Return ele
	End Function
	
	
	
	' 激活元素 [传递NULL则取消当前激活的元素]
	Sub ActiveElement(ele As xui.Element Ptr) XGE_EXPORT_ALL
		' 给旧元素一个失去激活状态的事件
		If xge_xui_element_active Then
			If xge_xui_element_active->ClassEvent.OnLostFocus Then
				xge_xui_element_active->ClassEvent.OnLostFocus(xge_xui_element_active)
			EndIf
		EndIf
		' 给新元素一个获得激活状态的事件
		If ele Then
			If ele->ClassEvent.OnGotfocus Then
				ele->ClassEvent.OnGotfocus(ele)
			EndIf
		EndIf
		xge_xui_element_active = ele
	End Sub
	
	
	
	' GUI系统的消息拦截器，负责将消息分发给对应的控件 [返回0表示消息没有被拦截]
	Function EventProc(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
		Select Case msg
			Case XGE_MSG_MOUSE_MOVE			' 鼠标移动
				' 优先通知给被激活的元素
				If xge_xui_element_active Then
					If xge_xui_element_active->ClassEvent.OnMouseMove Then
						If xge_xui_element_active->ClassEvent.OnMouseMove(xge_xui_element_active, eve->x - xge_xui_element_active->Layout.ScreenCoord.x, eve->y - xge_xui_element_active->Layout.ScreenCoord.y) Then
							Return -1
						EndIf
					EndIf
				EndIf
				' 判断鼠标是否脱离了热点元素
				If xge_xui_element_hot Then
					If ((eve->x >= xge_xui_element_hot->Layout.ScreenCoord.x) And (eve->y >= xge_xui_element_hot->Layout.ScreenCoord.y) And (eve->x < xge_xui_element_hot->Layout.ScreenCoord.x + xge_xui_element_hot->Layout.Rect.w) And (eve->y < xge_xui_element_hot->Layout.ScreenCoord.y + xge_xui_element_hot->Layout.Rect.h)) = FALSE Then
						If xge_xui_element_hot->ClassEvent.OnMouseLeave Then
							xge_xui_element_hot->ClassEvent.OnMouseLeave(xge_xui_element_hot)
						EndIf
						xge_xui_element_hot = NULL
					EndIf
				EndIf
				Return xge_xui_element_root->EventLink(msg, param, eve)
			Case XGE_MSG_MOUSE_DOWN			' 鼠标按下
				' 如果没有元素处理这个事件，则取消被激活的元素，避免干扰到其他流程
				Dim RetInt As Integer = xge_xui_element_root->EventLink(msg, param, eve)
				If (RetInt = 0) And (xge_xui_element_active <> 0) Then
					ActiveElement(NULL)
				EndIf
				Return RetInt
			Case XGE_MSG_MOUSE_UP			' 鼠标弹起
				' 优先通知给被激活的元素
				If xge_xui_element_active Then
					If xge_xui_element_active->ClassEvent.OnMouseUp Then
						If xge_xui_element_active->ClassEvent.OnMouseUp(xge_xui_element_active, eve->x - xge_xui_element_active->Layout.ScreenCoord.x, eve->y - xge_xui_element_active->Layout.ScreenCoord.y, eve->button) Then
							Return -1
						EndIf
					EndIf
				EndIf
				Return xge_xui_element_root->EventLink(msg, param, eve)
			Case XGE_MSG_MOUSE_CLICK		' 鼠标单击
				Return xge_xui_element_root->EventLink(msg, param, eve)
			Case XGE_MSG_MOUSE_DCLICK		' 鼠标双击
				Return xge_xui_element_root->EventLink(msg, param, eve)
			Case XGE_MSG_MOUSE_WHELL		' 鼠标滚轮滚动
				' 优先通知给热点元素，其次通知给被激活的元素
				If xge_xui_element_hot Then
					If xge_xui_element_hot->ClassEvent.OnMouseWhell Then
						If xge_xui_element_hot->ClassEvent.OnMouseWhell(xge_xui_element_hot, eve->x, eve->y, eve->z, eve->nz) Then
							Return -1
						EndIf
					EndIf
				EndIf
				If xge_xui_element_active Then
					If xge_xui_element_active->ClassEvent.OnMouseWhell Then
						If xge_xui_element_active->ClassEvent.OnMouseWhell(xge_xui_element_active, eve->x, eve->y, eve->z, eve->nz) Then
							Return -1
						EndIf
					EndIf
				EndIf
			Case XGE_MSG_KEY_DOWN			' 键盘按下
				' 只有被激活的元素才能收到这个消息
				If xge_xui_element_active Then
					If xge_xui_element_active->ClassEvent.OnKeyDown Then
						If xge_xui_element_active->ClassEvent.OnKeyDown(xge_xui_element_active, eve->scancode, eve->ascii) Then
							Return -1
						EndIf
					EndIf
				EndIf
			Case XGE_MSG_KEY_UP				' 键盘弹起
				' 只有被激活的元素才能收到这个消息
				If xge_xui_element_active Then
					If xge_xui_element_active->ClassEvent.OnKeyUp Then
						If xge_xui_element_active->ClassEvent.OnKeyUp(xge_xui_element_active, eve->scancode, eve->ascii) Then
							Return -1
						EndIf
					EndIf
				EndIf
			Case XGE_MSG_KEY_REPEAT			' 按键重复按下
				' 只有被激活的元素才能收到这个消息
				If xge_xui_element_active Then
					If xge_xui_element_active->ClassEvent.OnKeyRepeat Then
						If xge_xui_element_active->ClassEvent.OnKeyRepeat(xge_xui_element_active, eve->scancode, eve->ascii) Then
							Return -1
						EndIf
					EndIf
				EndIf
			Case XGE_MSG_LOSTFOCUS			' 失去焦点 [取消激活的元素]
				ActiveElement(NULL)
		End Select
		Return 0
	End Function
	
End Namespace



' 添加元素
Function xui.ElementList.AddElement(elePtr As Any Ptr) As Integer XGE_EXPORT_OBJ
	If elePtr Then
		Dim idx As UInteger = InsertStruct(StructCount, 1)
		Dim ElementPoint As Element Ptr Ptr = StructMemory + ((idx - 1) * StructLenght)
		*ElementPoint = elePtr
		Cast(Element Ptr, elePtr)->Parent = Parent
		Return idx
	EndIf
	Return 0
End Function

' 插入元素到指定位置
Function xui.ElementList.InsElement(elePtr As Any Ptr, iPos As Integer) As Integer XGE_EXPORT_OBJ
	If elePtr Then
		Dim idx As UInteger = InsertStruct(iPos, 1)
		Dim ElementPoint As Element Ptr Ptr = StructMemory + ((idx - 1) * StructLenght)
		*ElementPoint = elePtr
		Cast(Element Ptr, elePtr)->Parent = Parent
		Return idx
	EndIf
	Return 0
End Function

' 获取元素指针
Function xui.ElementList.GetElement(iPos As Integer) As Any Ptr XGE_EXPORT_OBJ
	Return *Cast(Any Ptr Ptr, GetPtrStruct(iPos))
End Function

' 删除元素
Function xui.ElementList.DelElement(iPos As Integer) As Integer XGE_EXPORT_OBJ
	Return DeleteStruct(iPos)
End Function

' 获取元素数量
Function xui.ElementList.Count() As UInteger XGE_EXPORT_OBJ
	Return StructCount
End Function



End Extern


