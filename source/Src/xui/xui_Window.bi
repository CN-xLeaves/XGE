


' ������ - ��ͼ
Sub xui_class_Window_OnDraw(ele As xui.Window Ptr)
	Dim WordHeight As Integer = xge.Text.GetFontSize(ele->TextFont)
	If ele->BackStyle.Hide = FALSE Then
		If ele->BackStyle.Image Then
			ele->BackStyle.Image->Draw(ele->DrawBuffer, 0, 0)
		Else
			xge.shape.Rect(ele->DrawBuffer, 0, 0, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->BackStyle.BorderColor)
			xge.shape.RectFull(ele->DrawBuffer, 1, 1, ele->Layout.Rect.w - 2, WordHeight + 5, ele->BackStyle.BorderColor)
			xge.shape.RectFull(ele->DrawBuffer, 1, WordHeight + 6, ele->Layout.Rect.w - 2, ele->Layout.Rect.h - 2, ele->BackStyle.FillColor)
			xge.Text.DrawRectW(ele->DrawBuffer, 0, 0, ele->Layout.Rect.w - 1, WordHeight + 6, ele->Text, 0, ele->TextColor, ele->TextFont, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
		EndIf
	EndIf
End Sub

' ������� - ��갴��
Function xui_class_Window_OnMouseDown(ele As xui.Window Ptr, x As Integer, y As Integer, btn As Integer) As Integer
	If btn = 1 Then
		' ����Ԫ�غ���겶��
		xui.ActiveElement(ele)
		xui.MouseCapture(ele)
		' ���������϶����������
		ele->private_DragMode = TRUE
		ele->private_Drag.x = x
		ele->private_Drag.y = y
		ele->private_DragWinPos.x = ele->Layout.Rect.x
		ele->private_DragWinPos.y = ele->Layout.Rect.y
	EndIf
	Return -1
End Function

' ������� - ��굯��
Function xui_class_Window_OnMouseUp(ele As xui.Window Ptr, x As Integer, y As Integer, btn As Integer) As Integer
	If btn = 1 Then
		xui.MouseCapture(NULL)
		ele->private_DragMode = FALSE
		ele->Layout.ScreenCoord.x = ele->Parent->Layout.ScreenCoord.x + ele->Layout.Rect.x
		ele->Layout.ScreenCoord.y = ele->Parent->Layout.ScreenCoord.y + ele->Layout.Rect.y
		ele->LayoutApply()
		If ele->Event.OnMove Then
			ele->Event.OnMove(ele)
		EndIf
	EndIf
	Return -1
End Function

' ������� - ����ƶ�
Function xui_class_Window_OnMouseMove(ele As xui.Window Ptr, x As Integer, y As Integer) As Integer
	If xInput.GetMouseBtnL() Then
		If ele->private_DragMode Then
			ele->Layout.Rect.x = ele->private_DragWinPos.x + (x - ele->private_Drag.x)
			ele->Layout.Rect.y = ele->private_DragWinPos.y + (y - ele->private_Drag.y)
		EndIf
	EndIf
	Return -1
End Function

' ������ - ���뼤��״̬
Sub xui_class_Window_OnGotFocus(ele As xui.Window Ptr)
	If ele->Event.OnGotfocus Then
		ele->Event.OnGotfocus(ele)
	EndIf
End Sub

' ������ - ʧȥ����״̬
Sub xui_class_Window_OnLostFocus(ele As xui.Window Ptr)
	If ele->Event.OnLostfocus Then
		ele->Event.OnLostfocus(ele)
	EndIf
End Sub



Extern XGE_EXTERNCLASS



Namespace xui
	
	
	
	' ��������
	Function CreateBaseWindow(x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sCaption As WString Ptr, TextColor As UInteger = &HFFFFFFFF, TextFont As UInteger = 1, sIdentifier As WString Ptr = NULL) As xui.Window Ptr XGE_EXPORT_ALL
		Dim ele As xui.Window Ptr = New xui.Window()
		' �������Ը�ֵ
		ele->InitElement(XUI_LAYOUT_RULER_COORD, x, y, w, h, iLayoutMode, sIdentifier)
		' �Զ������Ը�ֵ
		ele->Text = sCaption
		ele->TextColor = TextColor
		ele->TextFont = TextFont
		Return ele
	End Function
	
	
	
	' ���캯��
	Constructor Window()
		' �������Ը�ֵ
		ClassID = XUI_CLASS_WINDOW
		' �Զ������Ը�ֵ
		BackStyle.Hide = FALSE
		BackStyle.Image = NULL
		BackStyle.BorderColor = &HFF0A8ED8
		BackStyle.FillColor = &HFF1CB2FA
		' ���������
		ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_Window_OnDraw)
		ClassEvent.OnMouseDown = Cast(Any Ptr, @xui_class_Window_OnMouseDown)
		ClassEvent.OnMouseUp = Cast(Any Ptr, @xui_class_Window_OnMouseUp)
		ClassEvent.OnMouseMove = Cast(Any Ptr, @xui_class_Window_OnMouseMove)
		ClassEvent.OnGotFocus = Cast(Any Ptr, @xui_class_Window_OnGotFocus)
		ClassEvent.OnLostFocus = Cast(Any Ptr, @xui_class_Window_OnLostFocus)
	End Constructor
	
	
	
End Namespace



End Extern


