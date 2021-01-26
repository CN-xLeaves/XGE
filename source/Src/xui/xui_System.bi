'==================================================================================
	'�� xywh Game Engine �û�����ϵͳ
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================



Extern XGE_EXTERNSTDEXT

' ���ݲ������ư�ť����
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



' ��ʼ��XUI�ز�
Sub InitRes_XUI()
	' �������ϵ�������
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
	' ���洰�ں���ָ��
	xge_xui_Window_Proc = Cast(Any Ptr, GetWindowLong(xge.hWnd, GWL_WNDPROC))
	' �ر����뷨
	xge_xui_ime_state = -1
	xui.DisableIME()
	ime_global_compchar[1] = 0
End Sub
Sub UnitRes_XUI()
	' �������ϵ�������
	If xge_xui_VScroll_Triangle Then
		Delete xge_xui_VScroll_Triangle
	EndIf
	If xge_xui_HScroll_Triangle Then
		Delete xge_xui_HScroll_Triangle
	EndIf
End Sub



' XUI ������Ϣ����
Function xui_Window_Proc(hWin As HWND, uMsg As UINT, wParam As WPARAM, lParam As LPARAM) As Integer
	Select Case uMsg
		/'Case WM_IME_NOTIFY
			Select Case wParam
				Case IMN_CHANGECANDIDATE
					' ���º�ѡ���б�
				Case IMN_OPENCANDIDATE
					' �򿪺�ѡ���б�
				Case IMN_CLOSECANDIDATE
					' �رպ�ѡ���б�
			End Select'/
		Case WM_CHAR
			ime_global_compchar[0] = wParam
			xge_xui_ime_proc(XUI_IME_CHAR, NULL, @ime_global_compchar, 1, wParam, xge_xui_ime_proc_param)
		Case WM_IME_COMPOSITION
			If (lParam And GCS_RESULTSTR) Then
				' ��������
				If xge_xui_ime_prop_unicode Then
					' ֧�� Unicode �ӿ�
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
					' ��֧�� Unicode �ӿ�
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
				' ��ȡ��ʾ���ַ���
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
			' ��ʼ���� [�������뷨����λ��]
			If xge_xui_ime_proc Then
				Dim hImc As HIMC = ImmGetContext(hWin)
				xge_xui_ime_proc(XUI_IME_STARTCOMPOSITION, hImc, NULL, 0, 0, xge_xui_ime_proc_param)
				ImmReleaseContext(hWin, hImc)
			EndIf
		Case WM_IME_ENDCOMPOSITION
			' ��������
			If xge_xui_ime_proc Then
				xge_xui_ime_proc(XUI_IME_ENDCOMPOSITION, NULL, NULL, 0, 0, xge_xui_ime_proc_param)
			EndIf
		Case WM_INPUTLANGCHANGEREQUEST
			' �л����뷨 [�ⲽ��Ҫ�ύ��DefWindowProc�����򲻻ᴥ��WM_INPUTLANGCHANGE��Ϣ]
			Return DefWindowProc(hWin, uMsg, wParam, lParam)
		Case WM_INPUTLANGCHANGE
			' �л����뷨
			Dim hkl_prop As UInteger = ImmGetProperty(Cast(HKL, lParam), IGP_PROPERTY)
			xge_xui_ime_prop_unicode = hkl_prop And IME_PROP_UNICODE
		Case Else
			If xge_xui_Window_Proc Then
				Return xge_xui_Window_Proc(hWin, uMsg, wParam, lParam)
			EndIf
	End Select
	Return TRUE
End Function



' �Ե�����ƶ���Ϣ�Ĺ����¼��ص�
Function xui_class_Empty_OnMouseMove(ele As Any Ptr, x As Integer, y As Integer) As Integer
	Return -1
End Function



' GUIϵͳ����Ϣ��������������Ϣ�ַ�����Ӧ�Ŀؼ� [����0��ʾ��Ϣû�б�����]
Function xui_EventProc(root As xui.Element Ptr, msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Select Case msg
		Case XGE_MSG_MOUSE_MOVE			' ����ƶ�
			' ����֪ͨ����������Ԫ��
			If xge_xui_element_capture Then
				If xge_xui_element_capture->ClassEvent.OnMouseMove Then
					If xge_xui_element_capture->ClassEvent.OnMouseMove(xge_xui_element_capture, eve->x - xge_xui_element_capture->Layout.ScreenCoord.x, eve->y - xge_xui_element_capture->Layout.ScreenCoord.y) Then
						Return -1
					EndIf
				EndIf
			EndIf
			' �ж�����Ƿ��������ȵ�Ԫ��
			If xge_xui_element_hot Then
				If ((eve->x >= xge_xui_element_hot->Layout.ScreenCoord.x) And (eve->y >= xge_xui_element_hot->Layout.ScreenCoord.y) And (eve->x < xge_xui_element_hot->Layout.ScreenCoord.x + xge_xui_element_hot->Layout.Rect.w) And (eve->y < xge_xui_element_hot->Layout.ScreenCoord.y + xge_xui_element_hot->Layout.Rect.h)) = FALSE Then
					If xge_xui_element_hot->ClassEvent.OnMouseLeave Then
						xge_xui_element_hot->ClassEvent.OnMouseLeave(xge_xui_element_hot)
					EndIf
					xge_xui_element_hot = NULL
				EndIf
			EndIf
			Return root->EventLink(msg, param, eve)
		Case XGE_MSG_MOUSE_DOWN			' ��갴��
			' ����֪ͨ����������Ԫ��
			If xge_xui_element_capture Then
				If xge_xui_element_capture->ClassEvent.OnMouseUp Then
					If xge_xui_element_capture->ClassEvent.OnMouseUp(xge_xui_element_capture, eve->x - xge_xui_element_capture->Layout.ScreenCoord.x, eve->y - xge_xui_element_capture->Layout.ScreenCoord.y, eve->button) Then
						Return -1
					EndIf
				EndIf
			EndIf
			Return root->EventLink(msg, param, eve)
		Case XGE_MSG_MOUSE_UP			' ��굯��
			' ����֪ͨ����������Ԫ��
			If xge_xui_element_capture Then
				If xge_xui_element_capture->ClassEvent.OnMouseUp Then
					If xge_xui_element_capture->ClassEvent.OnMouseUp(xge_xui_element_capture, eve->x - xge_xui_element_capture->Layout.ScreenCoord.x, eve->y - xge_xui_element_capture->Layout.ScreenCoord.y, eve->button) Then
						Return -1
					EndIf
				EndIf
			EndIf
			Return root->EventLink(msg, param, eve)
		Case XGE_MSG_MOUSE_CLICK		' ��굥��
			Return root->EventLink(msg, param, eve)
		Case XGE_MSG_MOUSE_DCLICK		' ���˫��
			Return root->EventLink(msg, param, eve)
		Case XGE_MSG_MOUSE_WHELL		' �����ֹ���
			' ����֪ͨ����������Ԫ��
			If xge_xui_element_capture Then
				If xge_xui_element_capture->ClassEvent.OnMouseUp Then
					If xge_xui_element_capture->ClassEvent.OnMouseUp(xge_xui_element_capture, eve->x - xge_xui_element_capture->Layout.ScreenCoord.x, eve->y - xge_xui_element_capture->Layout.ScreenCoord.y, eve->button) Then
						Return -1
					EndIf
				EndIf
			EndIf
			' ����֪ͨ���ȵ�Ԫ��
			If xge_xui_element_hot Then
				If xge_xui_element_hot->ClassEvent.OnMouseWhell Then
					If xge_xui_element_hot->ClassEvent.OnMouseWhell(xge_xui_element_hot, eve->x, eve->y, eve->z, eve->nz) Then
						Return -1
					EndIf
				EndIf
			EndIf
			' ����֪ͨ���������Ԫ��
			If xge_xui_element_active Then
				If xge_xui_element_active->ClassEvent.OnMouseWhell Then
					If xge_xui_element_active->ClassEvent.OnMouseWhell(xge_xui_element_active, eve->x, eve->y, eve->z, eve->nz) Then
						Return -1
					EndIf
				EndIf
			EndIf
		Case XGE_MSG_KEY_DOWN			' ���̰���
			' ֻ�б������Ԫ�ز����յ������Ϣ
			If xge_xui_element_active Then
				If xge_xui_element_active->ClassEvent.OnKeyDown Then
					If xge_xui_element_active->ClassEvent.OnKeyDown(xge_xui_element_active, eve->scancode, eve->ascii) Then
						Return -1
					EndIf
				EndIf
			EndIf
		Case XGE_MSG_KEY_UP				' ���̵���
			' ֻ�б������Ԫ�ز����յ������Ϣ
			If xge_xui_element_active Then
				If xge_xui_element_active->ClassEvent.OnKeyUp Then
					If xge_xui_element_active->ClassEvent.OnKeyUp(xge_xui_element_active, eve->scancode, eve->ascii) Then
						Return -1
					EndIf
				EndIf
			EndIf
		Case XGE_MSG_KEY_REPEAT			' �����ظ�����
			' ֻ�б������Ԫ�ز����յ������Ϣ
			If xge_xui_element_active Then
				If xge_xui_element_active->ClassEvent.OnKeyRepeat Then
					If xge_xui_element_active->ClassEvent.OnKeyRepeat(xge_xui_element_active, eve->scancode, eve->ascii) Then
						Return -1
					EndIf
				EndIf
			EndIf
		Case XGE_MSG_GOTFOCUS			' ��ý��� [���ﲻ֪��Ϊʲô�����ڻ�ú�ʧȥ�����ʱ����������һ�£����뷨�ͻ������]
			ImmAssociateContext(xge.hWnd, NULL)
		Case XGE_MSG_LOSTFOCUS			' ʧȥ���� [ȡ�������Ԫ��]
			xui.ActiveElement(NULL)
			ImmAssociateContextEx(xge.hWnd, NULL, IACE_DEFAULT)
	End Select
	Return 0
End Function



Namespace xui
	
	
	
	' ��ȡ��Ԫ�� (DesktopԪ��)
	Function GetRootElement() As xui.Element Ptr XGE_EXPORT_ALL
		Return xge_global_scene_cur.RootElement
	End Function
	
	' ��ȡ�������Ԫ��
	Function GetActiveElement() As xui.Element Ptr XGE_EXPORT_ALL
		Return xge_xui_element_active
	End Function
	
	' ��ȡ���ָ���µ��ȵ�Ԫ��
	Function GetHotElement() As xui.Element Ptr XGE_EXPORT_ALL
		Return xge_xui_element_hot
	End Function
	
	' ���ĳ��Ԫ���µ�������Ԫ�� (Ĭ�����DesktopԪ��)
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
	
	' Ӧ�ò���
	Sub LayoutApply() XGE_EXPORT_ALL
		If xge_global_scene_cur.RootElement Then
			xge_global_scene_cur.RootElement->LayoutApply()
		EndIf
	End Sub
	
	
	
	' ����һ���հ׵�Ԫ��
	Function CreateElement(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sIdentifier As WString Ptr = NULL) As xui.Element Ptr XGE_EXPORT_ALL
		Dim ele As xui.Element Ptr
		ele = New xui.Element(iLayoutRuler, x, y, w, h, iLayoutMode, sIdentifier)
		Return ele
	End Function
	
	
	
	' ����Ԫ�� [����NULL��ȡ����ǰ�����Ԫ��]
	Sub ActiveElement(ele As xui.Element Ptr) XGE_EXPORT_ALL
		If ele <> xge_xui_element_active Then
			' ����Ԫ��һ��ʧȥ����״̬���¼�
			If xge_xui_element_active Then
				If xge_xui_element_active->ClassEvent.OnLostFocus Then
					xge_xui_element_active->ClassEvent.OnLostFocus(xge_xui_element_active)
				EndIf
			EndIf
			' ����Ԫ��һ����ü���״̬���¼�
			If ele Then
				If ele->ClassEvent.OnGotfocus Then
					ele->ClassEvent.OnGotfocus(ele)
				EndIf
			EndIf
			xge_xui_element_active = ele
		EndIf
	End Sub
	
	' ������겶��
	Sub MouseCapture(ele As xui.Element Ptr) XGE_EXPORT_ALL
		xge_xui_element_capture = ele
	End Sub
	
	' �ر����뷨
	Sub DisableIME() XGE_EXPORT_ALL
		If xge_xui_ime_state Then
			ImmAssociateContext(xge.hWnd, NULL)
			SetWindowLong(xge.hWnd, GWL_WNDPROC, Cast(Integer, xge_xui_Window_Proc))
			xge_xui_ime_state = 0
			xge_xui_ime_proc = NULL
			xge_xui_ime_proc_param = 0
		EndIf
	End Sub
	
	' �������뷨
	Sub EnableIME(proc As Any Ptr, param As Integer) XGE_EXPORT_ALL
		If xge_xui_ime_state = 0 Then
			ImmAssociateContextEx(xge.hWnd, NULL, IACE_DEFAULT)
			SetWindowLong(xge.hWnd, GWL_WNDPROC, Cast(Integer, @xui_Window_Proc))
			' ��ȡ���뷨�Ƿ�֧��UNICODE
			Dim tid As UInteger = GetWindowThreadProcessId(xge.hWnd, NULL)
			Dim hkl As HKL = GetKeyboardLayout(tid)
			Dim hkl_prop As UInteger = ImmGetProperty(hkl, IGP_PROPERTY)
			xge_xui_ime_prop_unicode = hkl_prop And IME_PROP_UNICODE
			xge_xui_ime_state = -1
			xge_xui_ime_proc = proc
			xge_xui_ime_proc_param = param
		EndIf
	End Sub
	
	' ������ WM_CHAR ����
	Sub EnableCharInput(proc As Any Ptr, param As Integer) XGE_EXPORT_ALL
		SetWindowLong(xge.hWnd, GWL_WNDPROC, Cast(Integer, @xui_Window_Proc))
		xge_xui_ime_proc = proc
		xge_xui_ime_proc_param = param
	End Sub
	
	
End Namespace



' ���Ԫ��
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

' ����Ԫ�ص�ָ��λ��
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

' ��ȡԪ��ָ��
Function xui.ElementList.GetElement(iPos As Integer) As Any Ptr XGE_EXPORT_OBJ
	Return *Cast(Any Ptr Ptr, GetPtrStruct(iPos))
End Function

' ɾ��Ԫ��
Function xui.ElementList.DelElement(iPos As Integer) As Integer XGE_EXPORT_OBJ
	Return DeleteStruct(iPos)
End Function

' ���Ԫ��
Sub xui.ElementList.Clear() XGE_EXPORT_OBJ
	ReInitManage()
End Sub

' ��ȡԪ������
Function xui.ElementList.Count() As UInteger XGE_EXPORT_OBJ
	Return StructCount
End Function



End Extern


