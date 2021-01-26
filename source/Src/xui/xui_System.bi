'==================================================================================
	'★ xywh Game Engine 用户界面系统
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



Extern XGE_EXTERNSTDEXT

' 根据参数绘制按钮背景
Sub xui_DrawBackStyle(ele As xui.Element Ptr, bs As xui.BackStyle_Struct Ptr) XGE_EXPORT_ALL
	If bs->Hide = FALSE Then
		If bs->Image Then
			bs->Image->Draw(ele->DrawBuffer, 0, 0)
		Else
			xge.shape.Rect(ele->DrawBuffer, 0, 0, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, bs->BorderColor)
			xge.shape.RectFull(ele->DrawBuffer, 1, 1, ele->Layout.Rect.w - 2, ele->Layout.Rect.h - 2, bs->FillColor)
		EndIf
	EndIf
End Sub
Sub xui_DrawBackStyle_Rect(ele As xui.Element Ptr, bs As xui.BackStyle_Struct Ptr, rc As xge_Rect Ptr) XGE_EXPORT_ALL
	If bs->Hide = FALSE Then
		If bs->Image Then
			bs->Image->Draw(ele->DrawBuffer, rc->x, rc->y)
		Else
			xge.shape.Rect(ele->DrawBuffer, rc->x, rc->y, rc->w - 1, rc->h - 1, bs->BorderColor)
			xge.shape.RectFull(ele->DrawBuffer, rc->x + 1, rc->y + 1, rc->w - 2, rc->h - 2, bs->FillColor)
		EndIf
	EndIf
End Sub
Sub xui_DrawBackStyle_Text(ele As xui.Element Ptr, bs As xui.BackStyle_Text_Struct Ptr, sText As WString Ptr, fontid As UInteger, CaptionOffset As xge_Coord Ptr) XGE_EXPORT_ALL
	If bs->Hide = FALSE Then
		If bs->Image Then
			bs->Image->Draw(ele->DrawBuffer, 0, 0)
		Else
			xge.shape.Rect(ele->DrawBuffer, 0, 0, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, bs->BorderColor)
			xge.shape.RectFull(ele->DrawBuffer, 1, 1, ele->Layout.Rect.w - 2, ele->Layout.Rect.h - 2, bs->FillColor)
		EndIf
	EndIf
	xge.Text.DrawRectW(ele->DrawBuffer, CaptionOffset->x, CaptionOffset->y, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, sText, 0, bs->TextColor, fontid, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
End Sub

End Extern



Extern XGE_EXTERNCLASS



' 初始化XUI素材
Sub InitRes_XUI()
	' 滚动条上的三角形
	If xge_xui_VScroll_Triangle = NULL Then
		xge_xui_VScroll_Triangle = New xge.Surface(9, 5)
		PSet xge_xui_VScroll_Triangle->img, (4, 0), &HFFFFFFFF
		Line xge_xui_VScroll_Triangle->img, (3, 1) - (5, 1), &HFFFFFFFF
		Line xge_xui_VScroll_Triangle->img, (2, 2) - (6, 2), &HFFFFFFFF
		Line xge_xui_VScroll_Triangle->img, (1, 3) - (7, 3), &HFFFFFFFF
		Line xge_xui_VScroll_Triangle->img, (0, 4) - (8, 4), &HFFFFFFFF
	EndIf
	If xge_xui_HScroll_Triangle = NULL Then
		xge_xui_HScroll_Triangle = New xge.Surface(5, 9)
		PSet xge_xui_HScroll_Triangle->img, (0, 4), &HFFFFFFFF
		Line xge_xui_HScroll_Triangle->img, (1, 3) - (1, 5), &HFFFFFFFF
		Line xge_xui_HScroll_Triangle->img, (2, 2) - (2, 6), &HFFFFFFFF
		Line xge_xui_HScroll_Triangle->img, (3, 1) - (3, 7), &HFFFFFFFF
		Line xge_xui_HScroll_Triangle->img, (4, 0) - (4, 8), &HFFFFFFFF
	EndIf
	' 保存窗口函数指针
	xge_xui_Window_Proc = Cast(Any Ptr, GetWindowLong(xge.hWnd, GWL_WNDPROC))
	' 关闭输入法
	xge_xui_ime_state = -1
	xui.DisableIME()
	ime_global_compchar[1] = 0
End Sub
Sub UnitRes_XUI()
	' 滚动条上的三角形
	If xge_xui_VScroll_Triangle Then
		Delete xge_xui_VScroll_Triangle
	EndIf
	If xge_xui_HScroll_Triangle Then
		Delete xge_xui_HScroll_Triangle
	EndIf
End Sub



' XUI 窗口消息拦截
Function xui_Window_Proc(hWin As HWND, uMsg As UINT, wParam As WPARAM, lParam As LPARAM) As Integer
	Select Case uMsg
		/'Case WM_IME_NOTIFY
			Select Case wParam
				Case IMN_CHANGECANDIDATE
					' 更新候选词列表
				Case IMN_OPENCANDIDATE
					' 打开候选词列表
				Case IMN_CLOSECANDIDATE
					' 关闭候选词列表
			End Select'/
		Case WM_CHAR
			ime_global_compchar[0] = wParam
			xge_xui_ime_proc(XUI_IME_CHAR, NULL, @ime_global_compchar, 1, wParam, xge_xui_ime_proc_param)
		Case WM_IME_COMPOSITION
			If (lParam And GCS_RESULTSTR) Then
				' 文字上屏
				If xge_xui_ime_prop_unicode Then
					' 支持 Unicode 接口
					Dim hImc As HIMC = ImmGetContext(hWin)
					Dim iSize As Integer = ImmGetCompositionStringW(hImc, GCS_RESULTSTR, NULL, 0)
					If iSize > 0 Then
						Dim pBuff As WString Ptr = Allocate(iSize + 2)
						iSize = ImmGetCompositionStringW(hImc, GCS_RESULTSTR, pBuff, iSize)
						iSize = iSize / SizeOf(WString)
						pBuff[iSize] = 0
						If xge_xui_ime_proc Then
							xge_xui_ime_proc(XUI_IME_INPUT, hImc, pBuff, iSize, 0, xge_xui_ime_proc_param)
						EndIf
						Deallocate(pBuff)
					EndIf
					ImmReleaseContext(hWin, hImc)
				Else
					' 不支持 Unicode 接口
					Dim hImc As HIMC = ImmGetContext(hWin)
					Dim iSize As Integer = ImmGetCompositionStringA(hImc, GCS_RESULTSTR, NULL, 0)
					If iSize > 0 Then
						Dim pBuff As ZString Ptr = Allocate(iSize + 1)
						iSize = ImmGetCompositionStringA(hImc, GCS_RESULTSTR, pBuff, iSize)
						pBuff[iSize] = 0
						Dim pUniBuff As WString Ptr = AsciToUnicode(pBuff, iSize)
						If xge_xui_ime_proc Then
							xge_xui_ime_proc(XUI_IME_INPUT, hImc, pUniBuff, iSize, 0, xge_xui_ime_proc_param)
						EndIf
						Deallocate(pBuff)
						Deallocate(pUniBuff)
					EndIf
					ImmReleaseContext(hWin, hImc)
				EndIf
			ElseIf (lParam And GCS_COMPSTR) Then
				' 获取显示的字符串
				Dim hImc As HIMC = ImmGetContext(hWin)
				Dim iSize As Integer = ImmGetCompositionStringW(hImc, GCS_COMPSTR, NULL, 0)
				If iSize > 0 Then
					If ime_global_compstrptr Then
						Deallocate(ime_global_compstrptr)
					EndIf
					ime_global_compstrptr = Allocate(iSize + 2)
					iSize = ImmGetCompositionStringW(hImc, GCS_COMPSTR, ime_global_compstrptr, iSize)
					iSize = iSize / SizeOf(WString)
					ime_global_compstrptr[iSize] = 0
					Dim CurPos As UInteger = ImmGetCompositionStringW(hImc, GCS_CURSORPOS, NULL, 0)
					If xge_xui_ime_proc Then
						xge_xui_ime_proc(XUI_IME_COMPTEXT, hImc, ime_global_compstrptr, iSize, CurPos, xge_xui_ime_proc_param)
					EndIf
				EndIf
				ImmReleaseContext(hWin, hImc)
			Else
			EndIf
		Case WM_IME_STARTCOMPOSITION
			' 开始输入 [调整输入法窗口位置]
			If xge_xui_ime_proc Then
				Dim hImc As HIMC = ImmGetContext(hWin)
				xge_xui_ime_proc(XUI_IME_STARTCOMPOSITION, hImc, NULL, 0, 0, xge_xui_ime_proc_param)
				ImmReleaseContext(hWin, hImc)
			EndIf
		Case WM_IME_ENDCOMPOSITION
			' 结束输入
			If xge_xui_ime_proc Then
				xge_xui_ime_proc(XUI_IME_ENDCOMPOSITION, NULL, NULL, 0, 0, xge_xui_ime_proc_param)
			EndIf
		Case WM_INPUTLANGCHANGEREQUEST
			' 切换输入法 [这步需要提交给DefWindowProc，否则不会触发WM_INPUTLANGCHANGE消息]
			Return DefWindowProc(hWin, uMsg, wParam, lParam)
		Case WM_INPUTLANGCHANGE
			' 切换输入法
			Dim hkl_prop As UInteger = ImmGetProperty(Cast(HKL, lParam), IGP_PROPERTY)
			xge_xui_ime_prop_unicode = hkl_prop And IME_PROP_UNICODE
		Case Else
			If xge_xui_Window_Proc Then
				Return xge_xui_Window_Proc(hWin, uMsg, wParam, lParam)
			EndIf
	End Select
	Return TRUE
End Function



' 吃掉鼠标移动消息的公共事件回调
Function xui_class_Empty_OnMouseMove(ele As Any Ptr, x As Integer, y As Integer) As Integer
	Return -1
End Function



' GUI系统的消息拦截器，负责将消息分发给对应的控件 [返回0表示消息没有被拦截]
Function xui_EventProc(root As xui.Element Ptr, msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Select Case msg
		Case XGE_MSG_MOUSE_MOVE			' 鼠标移动
			' 优先通知给捕获鼠标的元素
			If xge_xui_element_capture Then
				If xge_xui_element_capture->ClassEvent.OnMouseMove Then
					If xge_xui_element_capture->ClassEvent.OnMouseMove(xge_xui_element_capture, eve->x - xge_xui_element_capture->Layout.ScreenCoord.x, eve->y - xge_xui_element_capture->Layout.ScreenCoord.y) Then
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
			Return root->EventLink(msg, param, eve)
		Case XGE_MSG_MOUSE_DOWN			' 鼠标按下
			' 优先通知给捕获鼠标的元素
			If xge_xui_element_capture Then
				If xge_xui_element_capture->ClassEvent.OnMouseUp Then
					If xge_xui_element_capture->ClassEvent.OnMouseUp(xge_xui_element_capture, eve->x - xge_xui_element_capture->Layout.ScreenCoord.x, eve->y - xge_xui_element_capture->Layout.ScreenCoord.y, eve->button) Then
						Return -1
					EndIf
				EndIf
			EndIf
			Return root->EventLink(msg, param, eve)
		Case XGE_MSG_MOUSE_UP			' 鼠标弹起
			' 优先通知给捕获鼠标的元素
			If xge_xui_element_capture Then
				If xge_xui_element_capture->ClassEvent.OnMouseUp Then
					If xge_xui_element_capture->ClassEvent.OnMouseUp(xge_xui_element_capture, eve->x - xge_xui_element_capture->Layout.ScreenCoord.x, eve->y - xge_xui_element_capture->Layout.ScreenCoord.y, eve->button) Then
						Return -1
					EndIf
				EndIf
			EndIf
			Return root->EventLink(msg, param, eve)
		Case XGE_MSG_MOUSE_CLICK		' 鼠标单击
			Return root->EventLink(msg, param, eve)
		Case XGE_MSG_MOUSE_DCLICK		' 鼠标双击
			Return root->EventLink(msg, param, eve)
		Case XGE_MSG_MOUSE_WHELL		' 鼠标滚轮滚动
			' 优先通知给捕获鼠标的元素
			If xge_xui_element_capture Then
				If xge_xui_element_capture->ClassEvent.OnMouseUp Then
					If xge_xui_element_capture->ClassEvent.OnMouseUp(xge_xui_element_capture, eve->x - xge_xui_element_capture->Layout.ScreenCoord.x, eve->y - xge_xui_element_capture->Layout.ScreenCoord.y, eve->button) Then
						Return -1
					EndIf
				EndIf
			EndIf
			' 优先通知给热点元素
			If xge_xui_element_hot Then
				If xge_xui_element_hot->ClassEvent.OnMouseWhell Then
					If xge_xui_element_hot->ClassEvent.OnMouseWhell(xge_xui_element_hot, eve->x, eve->y, eve->z, eve->nz) Then
						Return -1
					EndIf
				EndIf
			EndIf
			' 优先通知给被激活的元素
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
		Case XGE_MSG_GOTFOCUS			' 获得焦点 [这里不知道为什么，不在获得和失去焦点的时候这样处理一下，输入法就会出问题]
			ImmAssociateContext(xge.hWnd, NULL)
		Case XGE_MSG_LOSTFOCUS			' 失去焦点 [取消激活的元素]
			xui.ActiveElement(NULL)
			ImmAssociateContextEx(xge.hWnd, NULL, IACE_DEFAULT)
	End Select
	Return 0
End Function



Namespace xui
	
	
	
	' 获取根元素 (Desktop元素)
	Function GetRootElement() As xui.Element Ptr XGE_EXPORT_ALL
		Return xge_global_scene_cur.RootElement
	End Function
	
	' 获取被激活的元素
	Function GetActiveElement() As xui.Element Ptr XGE_EXPORT_ALL
		Return xge_xui_element_active
	End Function
	
	' 获取鼠标指针下的热点元素
	Function GetHotElement() As xui.Element Ptr XGE_EXPORT_ALL
		Return xge_xui_element_hot
	End Function
	
	' 清空某个元素下的所有子元素 (默认清空Desktop元素)
	Sub FreeChilds(ui As xui.Element Ptr = NULL) XGE_EXPORT_ALL
		If ui = NULL Then
			ui = xge_global_scene_cur.RootElement
		EndIf
		If ui Then
			Dim ele As xui.Element Ptr
			For i As Integer = 1 To ui->Childs.Count
				ele = ui->Childs.GetElement(i)
				If (ele <> NULL) And (ele <> xge_global_scene_cur.RootElement) Then
					FreeChilds(ele)
					Delete ele
				EndIf
			Next
		EndIf
	End Sub
	
	' 应用布局
	Sub LayoutApply() XGE_EXPORT_ALL
		If xge_global_scene_cur.RootElement Then
			xge_global_scene_cur.RootElement->LayoutApply()
		EndIf
	End Sub
	
	
	
	' 创建一个空白的元素
	Function CreateElement(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sIdentifier As WString Ptr = NULL) As xui.Element Ptr XGE_EXPORT_ALL
		Dim ele As xui.Element Ptr
		ele = New xui.Element(iLayoutRuler, x, y, w, h, iLayoutMode, sIdentifier)
		Return ele
	End Function
	
	
	
	' 激活元素 [传递NULL则取消当前激活的元素]
	Sub ActiveElement(ele As xui.Element Ptr) XGE_EXPORT_ALL
		If ele <> xge_xui_element_active Then
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
		EndIf
	End Sub
	
	' 设置鼠标捕获
	Sub MouseCapture(ele As xui.Element Ptr) XGE_EXPORT_ALL
		xge_xui_element_capture = ele
	End Sub
	
	' 关闭输入法
	Sub DisableIME() XGE_EXPORT_ALL
		If xge_xui_ime_state Then
			ImmAssociateContext(xge.hWnd, NULL)
			SetWindowLong(xge.hWnd, GWL_WNDPROC, Cast(Integer, xge_xui_Window_Proc))
			xge_xui_ime_state = 0
			xge_xui_ime_proc = NULL
			xge_xui_ime_proc_param = 0
		EndIf
	End Sub
	
	' 激活输入法
	Sub EnableIME(proc As Any Ptr, param As Integer) XGE_EXPORT_ALL
		If xge_xui_ime_state = 0 Then
			ImmAssociateContextEx(xge.hWnd, NULL, IACE_DEFAULT)
			SetWindowLong(xge.hWnd, GWL_WNDPROC, Cast(Integer, @xui_Window_Proc))
			' 获取输入法是否支持UNICODE
			Dim tid As UInteger = GetWindowThreadProcessId(xge.hWnd, NULL)
			Dim hkl As HKL = GetKeyboardLayout(tid)
			Dim hkl_prop As UInteger = ImmGetProperty(hkl, IGP_PROPERTY)
			xge_xui_ime_prop_unicode = hkl_prop And IME_PROP_UNICODE
			xge_xui_ime_state = -1
			xge_xui_ime_proc = proc
			xge_xui_ime_proc_param = param
		EndIf
	End Sub
	
	' 仅激活 WM_CHAR 输入
	Sub EnableCharInput(proc As Any Ptr, param As Integer) XGE_EXPORT_ALL
		SetWindowLong(xge.hWnd, GWL_WNDPROC, Cast(Integer, @xui_Window_Proc))
		xge_xui_ime_proc = proc
		xge_xui_ime_proc_param = param
	End Sub
	
	
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

' 清空元素
Sub xui.ElementList.Clear() XGE_EXPORT_OBJ
	ReInitManage()
End Sub

' 获取元素数量
Function xui.ElementList.Count() As UInteger XGE_EXPORT_OBJ
	Return StructCount
End Function



End Extern


