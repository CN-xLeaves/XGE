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
Sub xui_DrawBackStyle_Text(ele As xui.Element Ptr, bs As xui.BackStyle_Text_Struct Ptr, sText As ZString Ptr, fontid As UInteger, CaptionOffset As xui.Coord Ptr) XGE_EXPORT_ALL
	If bs->Hide = FALSE Then
		If bs->Image Then
			bs->Image->Draw(ele->DrawBuffer, 0, 0)
		Else
			xge.shape.Rect(ele->DrawBuffer, 0, 0, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, bs->BorderColor)
			xge.shape.RectFull(ele->DrawBuffer, 1, 1, ele->Layout.Rect.w - 2, ele->Layout.Rect.h - 2, bs->FillColor)
		EndIf
	EndIf
	xge.Text.DrawRectA(ele->DrawBuffer, CaptionOffset->x, CaptionOffset->y, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, sText, bs->TextColor, fontid, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
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



' �Ե�����ƶ���Ϣ�Ĺ����¼��ص�
Function xui_class_Empty_OnMouseMove(ele As Any Ptr, x As Integer, y As Integer) As Integer
	Return -1
End Function



' GUIϵͳ����Ϣ��������������Ϣ�ַ�����Ӧ�Ŀؼ� [����0��ʾ��Ϣû�б�����]
Function xui_EventProc(root As xui.Element Ptr, msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Select Case msg
		Case XGE_MSG_MOUSE_MOVE			' ����ƶ�
			' ����֪ͨ���������Ԫ��
			If xge_xui_element_active Then
				If xge_xui_element_active->ClassEvent.OnMouseMove Then
					If xge_xui_element_active->ClassEvent.OnMouseMove(xge_xui_element_active, eve->x - xge_xui_element_active->Layout.ScreenCoord.x, eve->y - xge_xui_element_active->Layout.ScreenCoord.y) Then
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
			' ���û��Ԫ�ش�������¼�����ȡ���������Ԫ�أ�������ŵ���������
			Dim RetInt As Integer = root->EventLink(msg, param, eve)
			If (RetInt = 0) And (xge_xui_element_active <> 0) Then
				xui.ActiveElement(NULL)
			EndIf
			Return RetInt
		Case XGE_MSG_MOUSE_UP			' ��굯��
			' ����֪ͨ���������Ԫ��
			If xge_xui_element_active Then
				If xge_xui_element_active->ClassEvent.OnMouseUp Then
					If xge_xui_element_active->ClassEvent.OnMouseUp(xge_xui_element_active, eve->x - xge_xui_element_active->Layout.ScreenCoord.x, eve->y - xge_xui_element_active->Layout.ScreenCoord.y, eve->button) Then
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
			' ����֪ͨ���ȵ�Ԫ�أ����֪ͨ���������Ԫ��
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
		Case XGE_MSG_LOSTFOCUS			' ʧȥ���� [ȡ�������Ԫ��]
			xui.ActiveElement(NULL)
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
	Function CreateElement(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sIdentifier As ZString Ptr = NULL) As xui.Element Ptr XGE_EXPORT_ALL
		Dim ele As xui.Element Ptr
		ele = New xui.Element(iLayoutRuler, x, y, w, h, iLayoutMode, sIdentifier)
		Return ele
	End Function
	
	
	
	' ����Ԫ�� [����NULL��ȡ����ǰ�����Ԫ��]
	Sub ActiveElement(ele As xui.Element Ptr) XGE_EXPORT_ALL
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


