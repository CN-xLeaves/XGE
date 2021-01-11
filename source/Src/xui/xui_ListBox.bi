


' �б���� - ��ͼ
Sub xui_class_ListBox_OnDraw(ele As xui.ListBox Ptr)
	' ������ (�������߿�)
	If ele->BackStyle.Hide = FALSE Then
		If ele->BackStyle.Image Then
			ele->BackStyle.Image->Draw(ele->DrawBuffer, 0, 0)
		Else
			xge.shape.RectFull(ele->DrawBuffer, 1, 1, ele->Layout.Rect.w - 2, ele->Layout.Rect.h - 2, ele->BackStyle.FillColor)
		EndIf
	EndIf
	' ���б�
	Dim Item As xui.List_Item_BasicStruct Ptr
	Dim y As UInteger = ele->BorderWidth
	Dim w As UInteger = IIf(ele->private_Scroll->Visible, ele->Layout.Rect.w - (17 + ele->BorderWidth + ele->BorderWidth), ele->Layout.Rect.w - (ele->BorderWidth + ele->BorderWidth))
	Dim wy As Integer = (ele->ItemHeight - ele->private_WordHeight) \ 2
	For i As UInteger = ele->private_Scroll->Value To ele->List.StructCount
		Item = ele->List.GetPtrStruct(i)
		If ele->Event.OnDrawItem Then
			' �Ի�
			If ele->private_ListIndex = i Then
				ele->Event.OnDrawItem(ele, i, Item, 2, ele->BorderWidth, y, w, ele->ItemHeight)
			ElseIf ele->private_HotItem = i Then
				ele->Event.OnDrawItem(ele, i, Item, 1, ele->BorderWidth, y, w, ele->ItemHeight)
			Else
				ele->Event.OnDrawItem(ele, i, Item, 0, ele->BorderWidth, y, w, ele->ItemHeight)
			EndIf
		Else
			' Ĭ�ϻ���
			If ele->private_ListIndex = i Then
				xge.shape.RectFull(ele->DrawBuffer, ele->BorderWidth + 1, y + 1, (ele->BorderWidth + w) - 2, (y + ele->ItemHeight) - 2, ele->ItemSelStyle.FillColor)
				xge.shape.Rect(ele->DrawBuffer, ele->BorderWidth, y, (ele->BorderWidth + w) - 1, (y + ele->ItemHeight) - 1, ele->ItemSelStyle.BorderColor)
			ElseIf ele->private_HotItem = i Then
				xge.shape.RectFull(ele->DrawBuffer, ele->BorderWidth + 1, y + 1, (ele->BorderWidth + w) - 2, (y + ele->ItemHeight) - 2, ele->ItemHotStyle.FillColor)
				xge.shape.Rect(ele->DrawBuffer, ele->BorderWidth, y, (ele->BorderWidth + w) - 1, (y + ele->ItemHeight) - 1, ele->ItemHotStyle.BorderColor)
			EndIf
			xge.Text.DrawA(ele->DrawBuffer, ele->BorderWidth + wy, y + wy, Item->Text, 0, Item->TextColor, ele->TextFont)
		EndIf
		y += ele->ItemHeight
	Next
	' �������� (�����߿�)
	xge.Shape.RectFull(ele->DrawBuffer, 1, ele->Layout.Rect.h - ele->BorderWidth, ele->BorderWidth + w, ele->Layout.Rect.h - 2, ele->BackStyle.FillColor)
	xge.Shape.Rect(ele->DrawBuffer, 0, 0, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->BackStyle.BorderColor)
End Sub

' �б���� - �ı��С
Sub xui_class_ListBox_OnSize(ele As xui.ListBox Ptr)
	ele->private_Scroll->Layout.Rect.x = ele->Layout.Rect.w - 18
	ele->private_Scroll->Layout.Rect.y = 0
	ele->private_Scroll->Layout.Rect.w = 18
	ele->private_Scroll->Layout.Rect.h = ele->Layout.Rect.h
	' �����ܹ���ʾ���ٸ��б���������ù�������С
	ele->private_ShowCount = (ele->Layout.Rect.h - (ele->BorderWidth + ele->BorderWidth)) \ ele->ItemHeight
	If ele->List.StructCount > ele->private_ShowCount Then
		ele->private_Scroll->Visible = TRUE
		ele->private_Scroll->Max = (ele->List.StructCount - ele->private_ShowCount) + 1
	Else
		ele->private_Scroll->Visible = FALSE
	EndIf
End Sub

' �б���� - ���ֲ���
Function xui_class_ListBox_OnMouseWhell(ele As xui.ListBox Ptr, x As Integer, y As Integer, z As Integer, nz As Integer) As Integer
	If ele->private_Scroll Then
		If ele->private_Scroll->ClassEvent.OnMouseWhell Then
			ele->private_Scroll->ClassEvent.OnMouseWhell(ele->private_Scroll, x, y, z, nz)
		EndIf
	EndIf
	Return -1
End Function

' �б���� - ����ƶ�
Function xui_class_ListBox_OnMouseMove(ele As xui.ListBox Ptr, x As Integer, y As Integer) As Integer
	If (x > ele->BorderWidth) And (y > ele->BorderWidth) Then
		ele->private_HotItem = ((y - ele->BorderWidth) \ ele->ItemHeight) + ele->private_Scroll->Value
		' �������
		If ele->private_HotItem > ele->List.StructCount Then
			ele->private_HotItem = 0
		EndIf
	Else
		ele->private_HotItem = 0
	EndIf
	Return -1
End Function

' �б���� - ����뿪
Sub xui_class_ListBox_OnMouseLeave(ele As xui.ListBox Ptr)
	ele->private_HotItem = 0
End Sub

' �б���� - ��갴��
Function xui_class_ListBox_OnMouseDown(ele As xui.ListBox Ptr, x As Integer, y As Integer, btn As Integer) As Integer
	If (x > ele->BorderWidth) And (y > ele->BorderWidth) Then
		Dim iPos As UInteger = ((y - ele->BorderWidth) \ ele->ItemHeight) + ele->private_Scroll->Value
		' �����¼�
		If iPos <= ele->List.StructCount Then
			If ele->private_ListIndex <> iPos Then
				Dim iOld As UInteger = ele->private_ListIndex
				ele->private_ListIndex = iPos
				If ele->Event.OnSelectChange Then
					ele->Event.OnSelectChange(ele, iOld)
				EndIf
			EndIf
		EndIf
	EndIf
	Return -1
End Function

' �б���� - ��굥��
Function xui_class_ListBox_OnMouseClick(ele As xui.ListBox Ptr, x As Integer, y As Integer, btn As Integer) As Integer
	If (x > ele->BorderWidth) And (y > ele->BorderWidth) Then
		Dim iPos As UInteger = ((y - ele->BorderWidth) \ ele->ItemHeight) + ele->private_Scroll->Value
		' �����¼�
		If iPos <= ele->List.StructCount Then
			If ele->Event.OnClickItem Then
				ele->Event.OnClickItem(ele, iPos, btn)
			EndIf
		EndIf
	EndIf
	Return -1
End Function

' �б���� - ���˫��
Function xui_class_ListBox_OnMouseDoubleClick(ele As xui.ListBox Ptr, x As Integer, y As Integer, btn As Integer) As Integer
	If (x > ele->BorderWidth) And (y > ele->BorderWidth) Then
		Dim iPos As UInteger = ((y - ele->BorderWidth) \ ele->ItemHeight) + ele->private_Scroll->Value
		' �����¼�
		If iPos <= ele->List.StructCount Then
			If ele->Event.OnDoubleClickItem Then
				ele->Event.OnDoubleClickItem(ele, iPos, btn)
			EndIf
		EndIf
	EndIf
	Return -1
End Function



Extern XGE_EXTERNCLASS



Namespace xui
	
	
	
	' ���캯��
	Constructor List_ItemSet() XGE_EXPORT_OBJ
		StructLenght = SizeOf(List_Item_BasicStruct) - SizeOf(Any Ptr)
	End Constructor
	
	' �б�������
	Function List_ItemSet.Count() As UInteger XGE_EXPORT_OBJ
		Return StructCount
	End Function
	
	' ����б���
	Function List_ItemSet.Append(sVal As ZString Ptr, iTag As Integer = 0) As UInteger XGE_EXPORT_OBJ
		Dim iPos As UInteger = AppendStruct()
		Dim Item As List_Item_BasicStruct Ptr = GetPtrStruct(iPos)
		If Item Then
			Item->Text = sVal
			Item->Tag = iTag
			Item->TextColor = Cast(xui.ListBox Ptr, Parent)->TextColor
		EndIf
		' ����������Ƿ���ʾ
		Dim p As xui.ListBox Ptr = Parent
		If StructCount > p->private_ShowCount Then
			p->private_Scroll->Visible = TRUE
			p->private_Scroll->Max = (StructCount - p->private_ShowCount) + 1
		Else
			p->private_Scroll->Visible = FALSE
		EndIf
		Return iPos
	End Function
	Function List_ItemSet.Insert(iInsPos As UInteger, sVal As ZString Ptr, iTag As Integer = 0) As UInteger XGE_EXPORT_OBJ
		Dim iPos As UInteger = InsertStruct(iInsPos)
		Dim Item As List_Item_BasicStruct Ptr = GetPtrStruct(iPos)
		If Item Then
			Item->Text = sVal
			Item->Tag = iTag
			Item->TextColor = Cast(xui.ListBox Ptr, Parent)->TextColor
		EndIf
		' ����������Ƿ���ʾ
		Dim p As xui.ListBox Ptr = Parent
		If StructCount > p->private_ShowCount Then
			p->private_Scroll->Visible = TRUE
			p->private_Scroll->Max = (StructCount - p->private_ShowCount) + 1
		Else
			p->private_Scroll->Visible = FALSE
		EndIf
		Return iPos
	End Function
	
	' ɾ���б���
	Function List_ItemSet.Remove(iPos As UInteger) As Integer XGE_EXPORT_OBJ
		Function = DeleteStruct(iPos)
		' ����������Ƿ���ʾ
		Dim p As xui.ListBox Ptr = Parent
		If StructCount > p->private_ShowCount Then
			p->private_Scroll->Visible = TRUE
			p->private_Scroll->Max = (StructCount - p->private_ShowCount) + 1
		Else
			p->private_Scroll->Visible = FALSE
		EndIf
	End Function
	Sub List_ItemSet.Clear() XGE_EXPORT_OBJ
		ReInitManage()
		Cast(xui.ListBox Ptr, Parent)->private_Scroll->Visible = FALSE
	End Sub
	
	' ��ȡ/���� �б���ı���
	Property List_ItemSet.Text(iPos As UInteger) As ZString Ptr XGE_EXPORT_OBJ
		Dim Item As List_Item_BasicStruct Ptr = GetPtrStruct(iPos)
		If Item Then
			Return Item->Text
		Else
			Return @xge_global_snull
		EndIf
	End Property
	Property List_ItemSet.Text(iPos As UInteger, sVal As ZString Ptr) XGE_EXPORT_OBJ
		Dim Item As List_Item_BasicStruct Ptr = GetPtrStruct(iPos)
		If Item Then
			Item->Text = sVal
		EndIf
	End Property
	
	' ��ȡ/���� �б���ĸ�������
	Property List_ItemSet.Tag(iPos As UInteger) As Integer XGE_EXPORT_OBJ
		Dim Item As List_Item_BasicStruct Ptr = GetPtrStruct(iPos)
		If Item Then
			Return Item->Tag
		Else
			Return 0
		EndIf
	End Property
	Property List_ItemSet.Tag(iPos As UInteger, iVal As Integer) XGE_EXPORT_OBJ
		Dim Item As List_Item_BasicStruct Ptr = GetPtrStruct(iPos)
		If Item Then
			Item->Tag = iVal
		EndIf
	End Property
	
	' ѡ���б���
	Property List_ItemSet.Selected(iPos As UInteger) As Integer XGE_EXPORT_OBJ
		Dim Item As List_Item_BasicStruct Ptr = GetPtrStruct(iPos)
		If Item Then
			Return Item->Checked
		Else
			Return 0
		EndIf
	End Property
	Property List_ItemSet.Selected(iPos As UInteger, iStk As Integer) XGE_EXPORT_OBJ
		Dim Item As List_Item_BasicStruct Ptr = GetPtrStruct(iPos)
		If Item Then
			Item->Checked = IIf(iStk, -1, 0)
		EndIf
	End Property
	
	' ͳ��ѡ���б��������
	Function List_ItemSet.SelectCount() As UInteger XGE_EXPORT_OBJ
		Dim iRet As UInteger = 0
		Dim Item As List_Item_BasicStruct Ptr
		For i As UInteger = 1 To StructCount
			Item = GetPtrStruct(i)
			If Item->Checked Then
				iRet += 1
			EndIf
		Next
		Return iRet
	End Function
	
	' ѡ�������б���
	Sub List_ItemSet.SelectAll() XGE_EXPORT_OBJ
		Dim Item As List_Item_BasicStruct Ptr
		For i As UInteger = 1 To StructCount
			Item = GetPtrStruct(i)
			Item->Checked = -1
		Next
	End Sub
	
	' �������ѡ�е��б���
	Sub List_ItemSet.SelectClear() XGE_EXPORT_OBJ
		Dim Item As List_Item_BasicStruct Ptr
		For i As UInteger = 1 To StructCount
			Item = GetPtrStruct(i)
			Item->Checked = 0
		Next
	End Sub
	
	' ��ѡ����ѡ�е��б���
	Sub List_ItemSet.SelectInverse() XGE_EXPORT_OBJ
		Dim Item As List_Item_BasicStruct Ptr
		For i As UInteger = 1 To StructCount
			Item = GetPtrStruct(i)
			Item->Checked = Not(Item->Checked)
		Next
	End Sub
	
	' �����û��Զ������ݽṹ��С [Ĭ��Ϊ0��ֻ���ڻ�û���б���ʱ����]
	Sub List_ItemSet.SetUserDataSize(bc As UInteger) XGE_EXPORT_OBJ
		StructLenght = (SizeOf(List_Item_BasicStruct) - SizeOf(Any Ptr)) + bc
	End Sub
	
	' ��ȡ�û��Զ�������ָ��
	Function List_ItemSet.UserData(iPos As UInteger) As Any Ptr XGE_EXPORT_OBJ
		Dim Item As List_Item_BasicStruct Ptr = GetPtrStruct(iPos)
		If Item Then
			Return @Item->UserData
		Else
			Return NULL
		EndIf
	End Function
	
	
	
	' �����б��
	Function CreateListBox(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 120, h As Integer = 200, TextColor As UInteger = &HFF000000, TextFont As UInteger = 1, sIdentifier As ZString Ptr = NULL) As xui.ListBox Ptr XGE_EXPORT_ALL
		Dim ele As xui.ListBox Ptr = New xui.ListBox()
		' �������Ը�ֵ
		ele->ClassID = XUI_CLASS_LISTBOX
		ele->InitElement(iLayoutRuler, x, y, w, h, XUI_LAYOUT_COORD, sIdentifier)
		' �Զ������Ը�ֵ
		ele->private_HotItem = 0
		ele->private_ListIndex = 0
		ele->private_WordHeight = xge.Text.GetFontSize(TextFont)
		ele->private_ShowScroll = 0
		ele->List.Parent = ele
		ele->TextColor = TextColor
		ele->TextFont = TextFont
		ele->BorderWidth = 2
		ele->ItemHeight = ele->private_WordHeight + 4
		' ������ʽ
		ele->BackStyle.Hide = FALSE
		ele->BackStyle.Image = NULL
		ele->BackStyle.BorderColor = &HFF0A8ED8
		ele->BackStyle.FillColor = &HFFFFFFFF
		ele->ItemHotStyle.Hide = FALSE
		ele->ItemHotStyle.Image = NULL
		ele->ItemHotStyle.BorderColor = &HFF55BCF7
		ele->ItemHotStyle.FillColor = &HFFDBF5FF
		ele->ItemSelStyle.Hide = FALSE
		ele->ItemSelStyle.Image = NULL
		ele->ItemSelStyle.BorderColor = &HFF0A8ED8
		ele->ItemSelStyle.FillColor = &HFFA6DDFB
		' �����ӿؼ�
		ele->private_Scroll = xui.CreateVScrollBar(XUI_LAYOUT_RULER_PIXEL, 0, 0, 18, 500)
		ele->private_Scroll->Visible = FALSE
		ele->private_Scroll->Min = 1
		ele->private_Scroll->Value = 1
		ele->Childs.AddElement(ele->private_Scroll)
		' ���������
		ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_ListBox_OnDraw)
		ele->ClassEvent.OnSize = Cast(Any Ptr, @xui_class_ListBox_OnSize)
		ele->ClassEvent.OnMouseWhell = Cast(Any Ptr, @xui_class_ListBox_OnMouseWhell)
		ele->ClassEvent.OnMouseMove = Cast(Any Ptr, @xui_class_ListBox_OnMouseMove)
		ele->ClassEvent.OnMouseDown = Cast(Any Ptr, @xui_class_ListBox_OnMouseDown)
		ele->ClassEvent.OnMouseLeave = Cast(Any Ptr, @xui_class_ListBox_OnMouseLeave)
		ele->ClassEvent.OnMouseClick = Cast(Any Ptr, @xui_class_ListBox_OnMouseClick)
		ele->ClassEvent.OnMouseDoubleClick = Cast(Any Ptr, @xui_class_ListBox_OnMouseDoubleClick)
		Return ele
	End Function
	
	
	
	Property ListBox.ListIndex As Integer XGE_EXPORT_OBJ
		If private_ListIndex > List.StructCount Then
			private_ListIndex = 0
		EndIf
		Return private_ListIndex
	End Property
	Property ListBox.ListIndex(iPos As Integer) XGE_EXPORT_OBJ
		If iPos > List.StructCount Then
			private_ListIndex = 0
		Else
			private_ListIndex = iPos
		EndIf
	End Property
	
	
	
End Namespace



End Extern


