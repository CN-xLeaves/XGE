


' ��ǩ�� - ��ͼ
Sub xui_class_Label_OnDraw(ele As xui.Label Ptr)
	xui_DrawBackStyle(ele, @ele->BackStyle)
	xge.Text.DrawRectA(ele->DrawBuffer, ele->TextOffset.x, ele->TextOffset.y, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->Text, ele->TextColor, ele->TextFont, 0, ele->TextAlign, ele->LineSpace, ele->WordSpace)
End Sub

' ������ - ��ͼ
Sub xui_class_Frame_OnDraw(ele As xui.Frame Ptr)
	Dim WordHeight As Integer = xge.Text.GetFontSize(ele->TextFont)
	If ele->BackStyle.Hide = FALSE Then
		If ele->BackStyle.Image Then
			ele->BackStyle.Image->Draw(ele->DrawBuffer, 0, 0)
		Else
			If (ele->Text = NULL) Or (*ele->Text = "") Then
				xge.shape.Rect(ele->DrawBuffer, 0, 0, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->BackStyle.BorderColor)
				xge.shape.RectFull(ele->DrawBuffer, 1, 1, ele->Layout.Rect.w - 2, ele->Layout.Rect.h - 2, ele->BackStyle.FillColor)
			Else
				xge.shape.Rect(ele->DrawBuffer, 0, 0, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->BackStyle.BorderColor)
				xge.shape.RectFull(ele->DrawBuffer, 1, 1, ele->Layout.Rect.w - 2, WordHeight + 5, ele->BackStyle.BorderColor)
				xge.shape.RectFull(ele->DrawBuffer, 1, WordHeight + 6, ele->Layout.Rect.w - 2, ele->Layout.Rect.h - 2, ele->BackStyle.FillColor)
				xge.Text.DrawRectA(ele->DrawBuffer, 0, 0, ele->Layout.Rect.w - 1, WordHeight + 6, ele->Text, ele->TextColor, ele->TextFont, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
			EndIf
		EndIf
	EndIf
End Sub

' ͼ���� - ��ͼ
Sub xui_class_Image_OnDraw(ele As xui.Image Ptr)
	If ele->Image <> NULL Then
		ele->Image->Draw(ele->DrawBuffer, ele->ImageOffset.x, ele->ImageOffset.y)
		If ele->BorderWidth Then
			For i As Integer = 1 To ele->BorderWidth
				xge.shape.Rect(ele->DrawBuffer, i - 1, i - 1, ele->Layout.Rect.w - i, ele->Layout.Rect.h - i, ele->BorderColor)
			Next
		EndIf
	EndIf
End Sub



Extern XGE_EXTERNCLASS



Namespace xui
	
	
	
	' ������ǩ
	Function CreateLabel(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, TextColor As UInteger = &HFFFFFFFF, TextFont As UInteger = 1, sIdentifier As ZString Ptr = NULL) As xui.Label Ptr XGE_EXPORT_ALL
		Dim ele As xui.Label Ptr = New xui.Label()
		' �������Ը�ֵ
		ele->ClassID = XUI_CLASS_STATIC
		ele->InitElement(iLayoutRuler, x, y, w, h, XUI_LAYOUT_COORD, sIdentifier)
		' �Զ������Ը�ֵ
		ele->Text = sCaption
		ele->TextOffset.x = 0
		ele->TextOffset.y = 0
		ele->TextColor = TextColor
		ele->TextFont = TextFont
		ele->TextAlign = XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE
		ele->LineSpace = 0
		ele->WordSpace = 0
		ele->BackStyle.Hide = TRUE
		ele->BackStyle.Image = NULL
		' ���������
		ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_Label_OnDraw)
		Return ele
	End Function
	
	' ��������
	Function CreateFrame(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sCaption As ZString Ptr = NULL, sIdentifier As ZString Ptr = NULL) As xui.Frame Ptr XGE_EXPORT_ALL
		Dim ele As xui.Frame Ptr = New xui.Frame()
		' �������Ը�ֵ
		ele->ClassID = XUI_CLASS_STATIC
		ele->InitElement(iLayoutRuler, x, y, w, h, iLayoutMode, sIdentifier)
		' �Զ������Ը�ֵ
		ele->Text = sCaption
		ele->TextColor = &HFFFFFFFF
		ele->TextFont = 1
		ele->BackStyle.Hide = FALSE
		ele->BackStyle.Image = NULL
		ele->BackStyle.BorderColor = &HFF0A8ED8
		ele->BackStyle.FillColor = &HFF1CB2FA
		' ���������
		ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_Frame_OnDraw)
		Return ele
	End Function
	
	' ����ͼ����
	Function CreateImage(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, pImage As xge.Surface Ptr = NULL, sIdentifier As ZString Ptr = NULL) As xui.Image Ptr XGE_EXPORT_ALL
		Dim ele As xui.Image Ptr = New xui.Image()
		' �������Ը�ֵ
		ele->ClassID = XUI_CLASS_STATIC
		ele->InitElement(iLayoutRuler, x, y, w, h, XUI_LAYOUT_COORD, sIdentifier)
		' �Զ������Ը�ֵ
		ele->Image = pImage
		ele->ImageOffset.x = 0
		ele->ImageOffset.y = 0
		ele->BorderWidth = 0
		ele->BorderColor = &HFF0A8ED8
		' ���������
		ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_Image_OnDraw)
		Return ele
	End Function
	
	
	
End Namespace



End Extern


