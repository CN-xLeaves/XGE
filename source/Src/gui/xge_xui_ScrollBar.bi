


' �������� - ��ͼ
Sub xui_class_ScrollBar_OnDraw(ele As xui.ScrollBar Ptr)
	xui_DrawBackStyle(ele, @ele->BackStyle)
End Sub

' �������� - �ı��С
Sub xui_class_ScrollBar_OnSize(ele As xui.ScrollBar Ptr)
	If ele->private_Type = 1 Then
		' ���������
		ele->private_ButtonCurPos->Layout.w = (ele->Layout.Rect.w - 38) * 0.15
	Else
		' ���������
		ele->private_ButtonCurPos->Layout.h = (ele->Layout.Rect.h - 38) * 0.15
	EndIf
End Sub

' �������� - ������ǰλ��
Sub xui_class_ScrollBar_SetValue(ele As xui.ScrollBar Ptr, iVal As Integer)
	' ����ǰֵ
	ele->Value = iVal
	If ele->Value < ele->Min Then
		ele->Value = ele->Min
	EndIf
	If ele->Value > ele->Max Then
		ele->Value = ele->Max
	EndIf
	' ������
	If ele->private_Type = 1 Then
		' ���������
		ele->private_SpaceUp->Layout.w = ele->Value - ele->Min
		ele->private_SpaceDown->Layout.w = ele->Max - ele->Value
	Else
		' ���������
		ele->private_SpaceUp->Layout.h = ele->Value - ele->Min
		ele->private_SpaceDown->Layout.h = ele->Max - ele->Value
	EndIf
	ele->LayoutApply()
End Sub

' �������� - �ϡ��°�ť������
Sub xui_class_ScrollBar_ButtonUp_OnClick(ele As xui.Button Ptr, btn As Integer)
	Dim parent As xui.ScrollBar Ptr = Cast(Any Ptr, ele->Parent)
	xui_class_ScrollBar_SetValue(parent, parent->Value - parent->SmallChange)
End Sub
Sub xui_class_ScrollBar_ButtonDown_OnClick(ele As xui.Button Ptr, btn As Integer)
	Dim parent As xui.ScrollBar Ptr = Cast(Any Ptr, ele->Parent)
	xui_class_ScrollBar_SetValue(parent, parent->Value + parent->SmallChange)
End Sub

' �������� - �հ����򱻰���
Function xui_class_ScrollBar_SpaceUp_OnMouseDown(ele As xui.Element Ptr, x As Integer, y As Integer, btn As Integer) As Integer
	Dim parent As xui.ScrollBar Ptr = Cast(Any Ptr, ele->Parent)
	xui_class_ScrollBar_SetValue(parent, parent->Value - parent->LargeChange)
	Return -1
End Function
Function xui_class_ScrollBar_SpaceDown_OnMouseDown(ele As xui.Element Ptr, x As Integer, y As Integer, btn As Integer) As Integer
	Dim parent As xui.ScrollBar Ptr = Cast(Any Ptr, ele->Parent)
	xui_class_ScrollBar_SetValue(parent, parent->Value + parent->LargeChange)
	Return -1
End Function

' �������� - ���鱻�϶�
Function xui_class_ScrollBar_ButtonCurPos_OnMouseMove(ele As xui.Button Ptr, x As Integer, y As Integer) As Integer
	If xInput.GetMouseBtnL() Then
		If ele->TagInt Then
			Dim parent As xui.ScrollBar Ptr = Cast(Any Ptr, ele->Parent)
			If parent->private_Type = 1 Then
				' ���������
				Dim MoveX As Integer = x - parent->private_DragX
				Dim ratio As Single = (parent->Max - parent->Min) / parent->private_SpaceCount
				xui_class_ScrollBar_SetValue(parent, parent->Value + (MoveX * ratio))
			Else
				' ���������
				Dim MoveY As Integer = y - parent->private_DragY
				Dim ratio As Single = (parent->Max - parent->Min) / parent->private_SpaceCount
				xui_class_ScrollBar_SetValue(parent, parent->Value + (MoveY * ratio))
			EndIf
		EndIf
	Else
		' һ������ɿ��ˣ��Ͳ��������϶�
		ele->TagInt = 0
	EndIf
	Return -1
End Function

' �������� - ���鰴���¼�HOOK
Function xui_class_ScrollBar_ButtonCurPos_OnMouseDown(ele As xui.Button Ptr, x As Integer, y As Integer, btn As Integer) As Integer
	' ��¼��ǰ���������
	Dim parent As xui.ScrollBar Ptr = Cast(Any Ptr, ele->Parent)
	parent->private_DragX = x
	parent->private_DragY = y
	If parent->private_Type = 1 Then
		' ���������
		parent->private_SpaceCount = parent->private_SpaceUp->Layout.Rect.w + parent->private_SpaceDown->Layout.Rect.w
	Else
		' ���������
		parent->private_SpaceCount = parent->private_SpaceUp->Layout.Rect.h + parent->private_SpaceDown->Layout.Rect.h
	EndIf
	' �ø������ݴ洢�����϶���״̬
	ele->TagInt = -1
	Dim SuperClass_OnMouseDown As Function(ele As Any Ptr, x As Integer, y As Integer, btn As Integer) As Integer = ele->TagPtr
	Return SuperClass_OnMouseDown(ele, x, y, btn)
End Function

' �������� - �����¼�
Function xui_class_ScrollBar_OnMouseWhell(ele As xui.Element Ptr, x As Integer, y As Integer, z As Integer, nz As Integer) As Integer
	Dim parent As xui.ScrollBar Ptr
	If ele->ClassID = XUI_CLASS_SCROLLBAR Then
		parent = Cast(Any Ptr, ele)
	Else
		parent = Cast(Any Ptr, ele->Parent)
	EndIf
	xui_class_ScrollBar_SetValue(parent, parent->Value - (nz * parent->WhellChange))
	Return -1
End Function

' �����롢�뿪 [����ռ��ؼ��ȵ�״̬���޸İ�ť����ʾ״̬]
Sub xui_class_ScrollBar_Space_OnMouseEnter(ele As xui.Element Ptr)
	Dim parent As xui.ScrollBar Ptr
	If ele->ClassID = XUI_CLASS_SCROLLBAR Then
		parent = Cast(Any Ptr, ele)
	Else
		parent = Cast(Any Ptr, ele->Parent)
	EndIf
	parent->private_ButtonCurPos->private_Status = 1
End Sub
Sub xui_class_ScrollBar_Space_OnMouseLeave(ele As xui.Element Ptr)
	Dim parent As xui.ScrollBar Ptr
	If ele->ClassID = XUI_CLASS_SCROLLBAR Then
		parent = Cast(Any Ptr, ele)
	Else
		parent = Cast(Any Ptr, ele->Parent)
	EndIf
	parent->private_ButtonCurPos->private_Status = 0
End Sub



Extern XGE_EXTERNCLASS



Namespace xui
	
	
	
	' �������������
	Function CreateVScrollBar(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 18, h As Integer = 200, sIdentifier As ZString Ptr = NULL) As xui.ScrollBar Ptr XGE_EXPORT_ALL
		Dim ele As xui.ScrollBar Ptr = New xui.ScrollBar()
		' �������Ը�ֵ
		ele->ClassID = XUI_CLASS_SCROLLBAR
		ele->Layout.Ruler = iLayoutRuler
		ele->Layout.w = w
		ele->Layout.h = h
		If iLayoutRuler = XUI_LAYOUT_RULER_PIXEL Then
			ele->Layout.Rect.x = x
			ele->Layout.Rect.y = y
			ele->Layout.Rect.w = w
			ele->Layout.Rect.h = h
		EndIf
		ele->LayoutMode = XUI_LAYOUT_T2B
		If sIdentifier Then
			strncpy(@ele->Identifier, sIdentifier, 31)
			ele->Identifier[31] = 0
		EndIf
		' �Զ������Ը�ֵ
		ele->Max = 100
		ele->Min = 0
		ele->Value = 0
		ele->SmallChange = 1
		ele->LargeChange = 10
		ele->WhellChange = 3
		ele->BackStyle.Hide = FALSE
		ele->BackStyle.Image = NULL
		ele->BackStyle.BorderColor = &HFF0A8ED8
		ele->BackStyle.FillColor = &HFFA6DDFB
		ele->private_Type = 0
		' �����ӿؼ�
		ele->private_ButtonUp = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 0, 0, w, 18, "")
		ele->private_SpaceUp = xui.CreateElement(XUI_LAYOUT_RULER_RATIO, 0, 1, 1, 0)
		ele->private_ButtonCurPos = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 2, 0, w - 4, (h - 38) * 0.15, "")
		ele->private_SpaceDown = xui.CreateElement(XUI_LAYOUT_RULER_RATIO, 0, 1, 1, 100)
		ele->private_ButtonDown = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 0, 0, w, 18, "")
		ele->Childs.AddElement(ele->private_ButtonUp)
		ele->Childs.AddElement(ele->private_SpaceUp)
		ele->Childs.AddElement(ele->private_ButtonCurPos)
		ele->Childs.AddElement(ele->private_SpaceDown)
		ele->Childs.AddElement(ele->private_ButtonDown)
		' ȡ������Ҫ���ӿؼ��¼�
		ele->private_ButtonUp->ClassEvent.OnKeyDown = NULL
		ele->private_ButtonUp->ClassEvent.OnKeyUp = NULL
		ele->private_ButtonDown->ClassEvent.OnKeyDown = NULL
		ele->private_ButtonDown->ClassEvent.OnKeyUp = NULL
		ele->private_ButtonCurPos->ClassEvent.OnKeyDown = NULL
		ele->private_ButtonCurPos->ClassEvent.OnKeyUp = NULL
		' �ҽ��ӿؼ��¼�
		ele->private_ButtonUp->Event.OnClick = Cast(Any Ptr, @xui_class_ScrollBar_ButtonUp_OnClick)
		ele->private_ButtonDown->Event.OnClick = Cast(Any Ptr, @xui_class_ScrollBar_ButtonDown_OnClick)
		ele->private_SpaceUp->ClassEvent.OnMouseDown = Cast(Any Ptr, @xui_class_ScrollBar_SpaceUp_OnMouseDown)
		ele->private_SpaceDown->ClassEvent.OnMouseDown = Cast(Any Ptr, @xui_class_ScrollBar_SpaceDown_OnMouseDown)
		ele->private_ButtonCurPos->ClassEvent.OnMouseMove = Cast(Any Ptr, @xui_class_ScrollBar_ButtonCurPos_OnMouseMove)
		' �ҽ��������뿪�¼� [���ڼ���顢ռ���ȵ�]
		ele->ClassEvent.OnMouseEnter = Cast(Any Ptr, @xui_class_ScrollBar_Space_OnMouseEnter)
		ele->private_SpaceUp->ClassEvent.OnMouseEnter = Cast(Any Ptr, @xui_class_ScrollBar_Space_OnMouseEnter)
		ele->private_SpaceDown->ClassEvent.OnMouseEnter = Cast(Any Ptr, @xui_class_ScrollBar_Space_OnMouseEnter)
		ele->ClassEvent.OnMouseLeave = Cast(Any Ptr, @xui_class_ScrollBar_Space_OnMouseLeave)
		ele->private_SpaceUp->ClassEvent.OnMouseLeave = Cast(Any Ptr, @xui_class_ScrollBar_Space_OnMouseLeave)
		ele->private_SpaceDown->ClassEvent.OnMouseLeave = Cast(Any Ptr, @xui_class_ScrollBar_Space_OnMouseLeave)
		' �ҽӹ����¼�
		ele->ClassEvent.OnMouseWhell = Cast(Any Ptr, @xui_class_ScrollBar_OnMouseWhell)
		ele->private_ButtonUp->ClassEvent.OnMouseWhell = Cast(Any Ptr, @xui_class_ScrollBar_OnMouseWhell)
		ele->private_SpaceUp->ClassEvent.OnMouseWhell = Cast(Any Ptr, @xui_class_ScrollBar_OnMouseWhell)
		ele->private_ButtonCurPos->ClassEvent.OnMouseWhell = Cast(Any Ptr, @xui_class_ScrollBar_OnMouseWhell)
		ele->private_SpaceDown->ClassEvent.OnMouseWhell = Cast(Any Ptr, @xui_class_ScrollBar_OnMouseWhell)
		ele->private_ButtonDown->ClassEvent.OnMouseWhell = Cast(Any Ptr, @xui_class_ScrollBar_OnMouseWhell)
		' HOOK�ӿؼ��¼�
		ele->private_ButtonCurPos->TagPtr = ele->private_ButtonCurPos->ClassEvent.OnMouseDown
		ele->private_ButtonCurPos->ClassEvent.OnMouseDown = Cast(Any Ptr, @xui_class_ScrollBar_ButtonCurPos_OnMouseDown)
		' ���������
		ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_ScrollBar_OnDraw)
		ele->ClassEvent.OnSize = Cast(Any Ptr, @xui_class_ScrollBar_OnSize)
		Return ele
	End Function
	
	' �������������
	Function CreateHScrollBar(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 200, h As Integer = 18, sIdentifier As ZString Ptr = NULL) As xui.ScrollBar Ptr XGE_EXPORT_ALL
		Dim ele As xui.ScrollBar Ptr = New xui.ScrollBar()
		' �������Ը�ֵ
		ele->ClassID = XUI_CLASS_SCROLLBAR
		ele->Layout.Ruler = iLayoutRuler
		ele->Layout.w = w
		ele->Layout.h = h
		If iLayoutRuler = XUI_LAYOUT_RULER_PIXEL Then
			ele->Layout.Rect.x = x
			ele->Layout.Rect.y = y
			ele->Layout.Rect.w = w
			ele->Layout.Rect.h = h
		EndIf
		ele->LayoutMode = XUI_LAYOUT_L2R
		If sIdentifier Then
			strncpy(@ele->Identifier, sIdentifier, 31)
			ele->Identifier[31] = 0
		EndIf
		' �Զ������Ը�ֵ
		ele->Max = 100
		ele->Min = 0
		ele->Value = 0
		ele->SmallChange = 1
		ele->LargeChange = 10
		ele->WhellChange = 3
		ele->BackStyle.Hide = FALSE
		ele->BackStyle.Image = NULL
		ele->BackStyle.BorderColor = &HFF0A8ED8
		ele->BackStyle.FillColor = &HFFA6DDFB
		ele->private_Type = 1
		' �����ӿؼ�
		ele->private_ButtonUp = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 0, 0, 18, h, "")
		ele->private_SpaceUp = xui.CreateElement(XUI_LAYOUT_RULER_RATIO, 1, 0, 0, 1)
		ele->private_ButtonCurPos = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 0, 2, (w - 38) * 0.15, h - 4, "")
		ele->private_SpaceDown = xui.CreateElement(XUI_LAYOUT_RULER_RATIO, 1, 0, 100, 1)
		ele->private_ButtonDown = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 0, 0, 18, w, "")
		ele->Childs.AddElement(ele->private_ButtonUp)
		ele->Childs.AddElement(ele->private_SpaceUp)
		ele->Childs.AddElement(ele->private_ButtonCurPos)
		ele->Childs.AddElement(ele->private_SpaceDown)
		ele->Childs.AddElement(ele->private_ButtonDown)
		' ȡ������Ҫ���ӿؼ��¼�
		ele->private_ButtonUp->ClassEvent.OnKeyDown = NULL
		ele->private_ButtonUp->ClassEvent.OnKeyUp = NULL
		ele->private_ButtonDown->ClassEvent.OnKeyDown = NULL
		ele->private_ButtonDown->ClassEvent.OnKeyUp = NULL
		ele->private_ButtonCurPos->ClassEvent.OnKeyDown = NULL
		ele->private_ButtonCurPos->ClassEvent.OnKeyUp = NULL
		' �ҽ��ӿؼ��¼�
		ele->private_ButtonUp->Event.OnClick = Cast(Any Ptr, @xui_class_ScrollBar_ButtonUp_OnClick)
		ele->private_ButtonDown->Event.OnClick = Cast(Any Ptr, @xui_class_ScrollBar_ButtonDown_OnClick)
		ele->private_SpaceUp->ClassEvent.OnMouseDown = Cast(Any Ptr, @xui_class_ScrollBar_SpaceUp_OnMouseDown)
		ele->private_SpaceDown->ClassEvent.OnMouseDown = Cast(Any Ptr, @xui_class_ScrollBar_SpaceDown_OnMouseDown)
		ele->private_ButtonCurPos->ClassEvent.OnMouseMove = Cast(Any Ptr, @xui_class_ScrollBar_ButtonCurPos_OnMouseMove)
		' �ҽ��������뿪�¼� [���ڼ���顢ռ���ȵ�]
		ele->ClassEvent.OnMouseEnter = Cast(Any Ptr, @xui_class_ScrollBar_Space_OnMouseEnter)
		ele->private_SpaceUp->ClassEvent.OnMouseEnter = Cast(Any Ptr, @xui_class_ScrollBar_Space_OnMouseEnter)
		ele->private_SpaceDown->ClassEvent.OnMouseEnter = Cast(Any Ptr, @xui_class_ScrollBar_Space_OnMouseEnter)
		ele->ClassEvent.OnMouseLeave = Cast(Any Ptr, @xui_class_ScrollBar_Space_OnMouseLeave)
		ele->private_SpaceUp->ClassEvent.OnMouseLeave = Cast(Any Ptr, @xui_class_ScrollBar_Space_OnMouseLeave)
		ele->private_SpaceDown->ClassEvent.OnMouseLeave = Cast(Any Ptr, @xui_class_ScrollBar_Space_OnMouseLeave)
		' �ҽӹ����¼�
		ele->ClassEvent.OnMouseWhell = Cast(Any Ptr, @xui_class_ScrollBar_OnMouseWhell)
		ele->private_ButtonUp->ClassEvent.OnMouseWhell = Cast(Any Ptr, @xui_class_ScrollBar_OnMouseWhell)
		ele->private_SpaceUp->ClassEvent.OnMouseWhell = Cast(Any Ptr, @xui_class_ScrollBar_OnMouseWhell)
		ele->private_ButtonCurPos->ClassEvent.OnMouseWhell = Cast(Any Ptr, @xui_class_ScrollBar_OnMouseWhell)
		ele->private_SpaceDown->ClassEvent.OnMouseWhell = Cast(Any Ptr, @xui_class_ScrollBar_OnMouseWhell)
		ele->private_ButtonDown->ClassEvent.OnMouseWhell = Cast(Any Ptr, @xui_class_ScrollBar_OnMouseWhell)
		' HOOK�ӿؼ��¼�
		ele->private_ButtonCurPos->TagPtr = ele->private_ButtonCurPos->ClassEvent.OnMouseDown
		ele->private_ButtonCurPos->ClassEvent.OnMouseDown = Cast(Any Ptr, @xui_class_ScrollBar_ButtonCurPos_OnMouseDown)
		' ���������
		ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_ScrollBar_OnDraw)
		ele->ClassEvent.OnSize = Cast(Any Ptr, @xui_class_ScrollBar_OnSize)
		Return ele
	End Function
	
	' ���ù�����Χ
	Sub ScrollBar.SetRange(iMin As Integer, iMax As Integer, bApplyLayout As Integer = TRUE)
		Max = iMax
		Min = iMin
		If Value < Min Then
			Value = Min
		EndIf
		If Value > Max Then
			Value = Max
		EndIf
		If private_Type = 1 Then
			' ���������
			private_SpaceUp->Layout.w = Value - Min
			private_SpaceDown->Layout.w = Max - Value
		Else
			' ���������
			private_SpaceUp->Layout.h = Value - Min
			private_SpaceDown->Layout.h = Max - Value
		EndIf
		If bApplyLayout Then
			LayoutApply()
		EndIf
	End Sub
	
	
	
End Namespace



End Extern


