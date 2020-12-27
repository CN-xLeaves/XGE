


' ���ݲ������ư�ť����
Sub DrawBackImage(ele As xui.Element Ptr, bi As xui.BackImage Ptr, sCaption As ZString Ptr, fontid As UInteger, CaptionOffset As xui.Coord Ptr)
	If bi->Image Then
		bi->Image->Draw(0, 0, ele->Image)
	Else
		xge.shape.Rect(0, 0, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, bi->BorderColor, ele->Image)
		xge.shape.RectFull(1, 1, ele->Layout.Rect.w - 2, ele->Layout.Rect.h - 2, bi->FillColor, ele->Image)
	EndIf
	xge.Text.DrawRectA(ele->Image, CaptionOffset->x, CaptionOffset->y, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, sCaption, bi->TextColor, fontid)
End Sub





' ��ť�� - ��ͼ
Sub xui_class_Button_OnDraw(ele As xui.Button Ptr)
	Select Case ele->private_Status
		Case 1
			DrawBackImage(ele, @ele->HotBack, ele->Caption, ele->CaptionFont, @ele->CaptionOffset)
		Case 2
			DrawBackImage(ele, @ele->PressBack, ele->Caption, ele->CaptionFont, @ele->CaptionOffset)
		Case Else
			DrawBackImage(ele, @ele->NormalBack, ele->Caption, ele->CaptionFont, @ele->CaptionOffset)
	End Select
End Sub
Sub xui_class_CheckBox_OnDraw(ele As xui.Button Ptr)
	Select Case ele->private_Status
		Case 1
			DrawBackImage(ele, @ele->HotBack, ele->Caption, ele->CaptionFont, @ele->CaptionOffset)
		Case 2
			DrawBackImage(ele, @ele->PressBack, ele->Caption, ele->CaptionFont, @ele->CaptionOffset)
		Case Else
			DrawBackImage(ele, @ele->NormalBack, ele->Caption, ele->CaptionFont, @ele->CaptionOffset)
	End Select
End Sub
Sub xui_class_RadioBox_OnDraw(ele As xui.Button Ptr)
	Select Case ele->private_Status
		Case 1
			DrawBackImage(ele, @ele->HotBack, ele->Caption, ele->CaptionFont, @ele->CaptionOffset)
		Case 2
			DrawBackImage(ele, @ele->PressBack, ele->Caption, ele->CaptionFont, @ele->CaptionOffset)
		Case Else
			DrawBackImage(ele, @ele->NormalBack, ele->Caption, ele->CaptionFont, @ele->CaptionOffset)
	End Select
End Sub
Sub xui_class_CheckSlider_OnDraw(ele As xui.Button Ptr)
	Select Case ele->private_Status
		Case 1
			DrawBackImage(ele, @ele->HotBack, ele->Caption, ele->CaptionFont, @ele->CaptionOffset)
		Case 2
			DrawBackImage(ele, @ele->PressBack, ele->Caption, ele->CaptionFont, @ele->CaptionOffset)
		Case Else
			DrawBackImage(ele, @ele->NormalBack, ele->Caption, ele->CaptionFont, @ele->CaptionOffset)
	End Select
End Sub

' ��ťԪ�� - ������
Sub xui_class_Button_OnMouseEnter(ele As xui.Button Ptr)
	ele->private_Status = 1
	' ��������
	If ele->EnterSound Then
		ele->EnterSound->Play()
	EndIf
End Sub

' ��ťԪ�� - ����뿪
Sub xui_class_Button_OnMouseLeave(ele As xui.Button Ptr)
	ele->private_Status = 0
	' ��������
	If ele->LeaveSound Then
		ele->LeaveSound->Play()
	EndIf
End Sub

' ��ťԪ�� - ��갴��
Function xui_class_Button_OnMouseDown(ele As xui.Button Ptr, x As Integer, y As Integer, btn As Integer) As Integer
	xui.ActiveElement(ele)
	ele->private_Status = 2
	ele->private_AllowClick = -1
	' ��������
	If ele->DownSound Then
		ele->DownSound->Play()
	EndIf
	Return -1
End Function

' ��ťԪ�� - ��굯�� [����������]
Function xui_class_Button_OnMouseUp(ele As xui.Button Ptr, x As Integer, y As Integer, btn As Integer) As Integer
	If xge_xui_element_hot = ele Then
		ele->private_Status = 1
		If ele->private_AllowClick = -1 Then
			If ele->Event.OnClick Then
				ele->Event.OnClick(ele)
			EndIf
			' ��������
			If ele->ClickSound Then
				ele->ClickSound->Play()
			EndIf
		EndIf
	Else
		ele->private_Status = 0
		xui.ActiveElement(NULL)
	EndIf
	ele->private_AllowClick = 0
	Return -1
End Function

' ��ťԪ�� - ���̰���
Function xui_class_Button_OnKeyDown(ele As xui.Button Ptr, k As Integer, c As Integer) As Integer
	If k = SC_SPACE Then
		ele->private_Status = 2
		' ��������
		If ele->DownSound Then
			ele->DownSound->Play()
		EndIf
		Return -1
	EndIf
	Return 0
End Function

' ��ťԪ�� - ���̵��� [��ť����ʱ���¿ո���Դ�����ť]
Function xui_class_Button_OnKeyUp(ele As xui.Button Ptr, k As Integer, c As Integer) As Integer
	If k = SC_SPACE Then
		If xge_xui_element_hot = ele Then
			ele->private_Status = 1
		Else
			ele->private_Status = 0
		EndIf
		If ele->Event.OnClick Then
			ele->Event.OnClick(ele)
		EndIf
		' ��������
		If ele->ClickSound Then
			ele->ClickSound->Play()
		EndIf
		Return -1
	EndIf
	Return 0
End Function





Namespace xui
	
	' ������ť
	Function CreateButton(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr
		Dim ele As xui.Button Ptr
		ele = New xui.Button()
		ele->Layout.Ruler = iLayoutRuler
		ele->Layout.w = w
		ele->Layout.h = h
		If iLayoutRuler = XUI_LAYOUT_RULER_PIXEL Then
			ele->Layout.Rect.x = x
			ele->Layout.Rect.y = y
			ele->Layout.Rect.w = w
			ele->Layout.Rect.h = h
		EndIf
		ele->LayoutMode = XUI_LAYOUT_COORD
		If sIdentifier Then
			strncpy(@ele->Identifier, sIdentifier, 31)
			ele->Identifier[31] = 0
		EndIf
		ele->Caption = sCaption
		ele->CaptionFont = 1
		ele->CaptionOffset.x = 0
		ele->CaptionOffset.y = 0
		ele->Mode = 0
		ele->Checked = 0
		ele->EnterSound = NULL
		ele->LeaveSound = NULL
		ele->DownSound  = NULL
		ele->ClickSound = NULL
		' Ӧ����ʽ
		ele->NormalBack.BorderColor = &HFF0A8ED8
		ele->NormalBack.FillColor = &HFF0A8ED8
		ele->NormalBack.TextColor = &HFFFFFFFF
		ele->PressBack.BorderColor = &HFF0A8ED8
		ele->PressBack.FillColor = &HFF0060A8
		ele->PressBack.TextColor = &HFFFFFFFF
		ele->HotBack.BorderColor = &HFF0A8ED8
		ele->HotBack.FillColor = &HFF1CB2FA
		ele->HotBack.TextColor = &HFFFFFFFF
		ele->CheckBack.BorderColor = &HFF0A8ED8
		ele->CheckBack.FillColor = &HFF0060A8
		ele->CheckBack.TextColor = &HFFFFFFFF
		' ���������
		ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_Button_OnDraw)
		ele->ClassEvent.OnMouseEnter = Cast(Any Ptr, @xui_class_Button_OnMouseEnter)
		ele->ClassEvent.OnMouseLeave = Cast(Any Ptr, @xui_class_Button_OnMouseLeave)
		ele->ClassEvent.OnMouseDown = Cast(Any Ptr, @xui_class_Button_OnMouseDown)
		ele->ClassEvent.OnMouseUp = Cast(Any Ptr, @xui_class_Button_OnMouseUp)
		ele->ClassEvent.OnKeyDown = Cast(Any Ptr, @xui_class_Button_OnKeyDown)
		ele->ClassEvent.OnKeyUp = Cast(Any Ptr, @xui_class_Button_OnKeyUp)
		Return ele
	End Function
	
	' ������ѡ��
	Function CreateCheckBox(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr
		Dim ele As xui.Button Ptr = CreateButton(iLayoutRuler, x, y, w, h, sCaption, sIdentifier)
		If ele Then
			' ���������
			ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_CheckBox_OnDraw)
		EndIf
		Return ele
	End Function
	
	' ������ѡ��
	Function CreateRadioBox(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr
		Dim ele As xui.Button Ptr = CreateButton(iLayoutRuler, x, y, w, h, sCaption, sIdentifier)
		If ele Then
			' ���������
			ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_RadioBox_OnDraw)
		EndIf
		Return ele
	End Function
	
	' ����ѡ�񻬿�
	Function CreateCheckSlider(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr
		Dim ele As xui.Button Ptr = CreateButton(iLayoutRuler, x, y, w, h, sCaption, sIdentifier)
		If ele Then
			' ���������
			ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_CheckSlider_OnDraw)
		EndIf
		Return ele
	End Function
	
End Namespace


