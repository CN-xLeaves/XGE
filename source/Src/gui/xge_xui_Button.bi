


' 按钮类 - 绘图
Sub xui_class_Button_OnDraw(ele As xui.Button Ptr)
	Select Case ele->private_Status
		Case 1
			xui_DrawBackStyle_Text(ele, @ele->HotStyle, ele->Text, ele->TextFont, @ele->TextOffset)
		Case 2
			xui_DrawBackStyle_Text(ele, @ele->PressStyle, ele->Text, ele->TextFont, @ele->TextOffset)
		Case Else
			' 处理选中的状态
			If (ele->Mode <> 0) And (ele->Checked <> 0) Then
				xui_DrawBackStyle_Text(ele, @ele->CheckStyle, ele->Text, ele->TextFont, @ele->TextOffset)
			Else
				xui_DrawBackStyle_Text(ele, @ele->NormalStyle, ele->Text, ele->TextFont, @ele->TextOffset)
			EndIf
	End Select
End Sub

' 标准复选框 - 绘图
Sub xui_class_CheckBox_OnDraw(ele As xui.Button Ptr)
	Select Case ele->private_Status
		Case 1
			xge.shape.Rect(ele->DrawBuffer, 2, 2, 18, 18, ele->HotStyle.BorderColor)
			xge.shape.Rect(ele->DrawBuffer, 3, 3, 17, 17, ele->HotStyle.BorderColor)
			xge.shape.RectFull(ele->DrawBuffer, 4, 4, 16, 16, (ele->HotStyle.FillColor And &H00FFFFFF) Or &H40000000)
			xge.Text.DrawRectA(ele->DrawBuffer, 24 + ele->TextOffset.x, ele->TextOffset.y, ele->Layout.Rect.w - (24 + ele->TextOffset.x), 20, ele->Text, ele->HotStyle.TextColor, ele->TextFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
		Case 2
			xge.shape.Rect(ele->DrawBuffer, 2, 2, 18, 18, ele->PressStyle.BorderColor)
			xge.shape.Rect(ele->DrawBuffer, 3, 3, 17, 17, ele->PressStyle.BorderColor)
			xge.shape.RectFull(ele->DrawBuffer, 4, 4, 16, 16, ele->PressStyle.FillColor)
			xge.Text.DrawRectA(ele->DrawBuffer, 24 + ele->TextOffset.x, ele->TextOffset.y, ele->Layout.Rect.w - (24 + ele->TextOffset.x), 20, ele->Text, ele->PressStyle.TextColor, ele->TextFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
		Case Else
			' 处理选中的状态
			If (ele->Mode <> 0) And (ele->Checked <> 0) Then
				xge.shape.Rect(ele->DrawBuffer, 2, 2, 18, 18, ele->CheckStyle.FillColor)
				xge.shape.Rect(ele->DrawBuffer, 3, 3, 17, 17, ele->CheckStyle.FillColor)
				xge.shape.RectFull(ele->DrawBuffer, 7, 7, 13, 13, ele->CheckStyle.BorderColor)
				xge.Text.DrawRectA(ele->DrawBuffer, 24 + ele->TextOffset.x, ele->TextOffset.y, ele->Layout.Rect.w - (24 + ele->TextOffset.x), 20, ele->Text, ele->CheckStyle.TextColor, ele->TextFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
			Else
				xge.shape.Rect(ele->DrawBuffer, 2, 2, 18, 18, ele->NormalStyle.BorderColor)
				xge.shape.Rect(ele->DrawBuffer, 3, 3, 17, 17, ele->NormalStyle.BorderColor)
				xge.shape.RectFull(ele->DrawBuffer, 4, 4, 16, 16, (ele->NormalStyle.FillColor And &H00FFFFFF) Or &H40000000)
				xge.Text.DrawRectA(ele->DrawBuffer, 24 + ele->TextOffset.x, ele->TextOffset.y, ele->Layout.Rect.w - (24 + ele->TextOffset.x), 20, ele->Text, ele->NormalStyle.TextColor, ele->TextFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
			EndIf
	End Select
End Sub

' 标准单选框 - 绘图
Sub xui_class_RadioBox_OnDraw(ele As xui.Button Ptr)
	Select Case ele->private_Status
		Case 1
			xge.shape.CircFull(ele->DrawBuffer, 10, 10, 8, (ele->HotStyle.FillColor And &H00FFFFFF) Or &H40000000)
			xge.shape.Circ(ele->DrawBuffer, 10, 10, 9, ele->HotStyle.BorderColor)
			xge.shape.Circ(ele->DrawBuffer, 10, 10, 8, ele->HotStyle.BorderColor)
			xge.Text.DrawRectA(ele->DrawBuffer, 24 + ele->TextOffset.x, ele->TextOffset.y, ele->Layout.Rect.w - (24 + ele->TextOffset.x), 20, ele->Text, ele->HotStyle.TextColor, ele->TextFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
		Case 2
			xge.shape.CircFull(ele->DrawBuffer, 10, 10, 8, ele->PressStyle.FillColor)
			xge.shape.Circ(ele->DrawBuffer, 10, 10, 9, ele->PressStyle.BorderColor)
			xge.shape.Circ(ele->DrawBuffer, 10, 10, 8, ele->PressStyle.BorderColor)
			xge.Text.DrawRectA(ele->DrawBuffer, 24 + ele->TextOffset.x, ele->TextOffset.y, ele->Layout.Rect.w - (24 + ele->TextOffset.x), 20, ele->Text, ele->PressStyle.TextColor, ele->TextFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
		Case Else
			' 处理选中的状态
			If (ele->Mode <> 0) And (ele->Checked <> 0) Then
				xge.shape.Circ(ele->DrawBuffer, 10, 10, 9, ele->CheckStyle.FillColor)
				xge.shape.Circ(ele->DrawBuffer, 10, 10, 8, ele->CheckStyle.FillColor)
				xge.shape.CircFull(ele->DrawBuffer, 10, 10, 4, ele->CheckStyle.BorderColor)
				xge.Text.DrawRectA(ele->DrawBuffer, 24 + ele->TextOffset.x, ele->TextOffset.y, ele->Layout.Rect.w - (24 + ele->TextOffset.x), 20, ele->Text, ele->CheckStyle.TextColor, ele->TextFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
			Else
				xge.shape.CircFull(ele->DrawBuffer, 10, 10, 8, (ele->NormalStyle.FillColor And &H00FFFFFF) Or &H40000000)
				xge.shape.Circ(ele->DrawBuffer, 10, 10, 9, ele->NormalStyle.BorderColor)
				xge.shape.Circ(ele->DrawBuffer, 10, 10, 8, ele->NormalStyle.BorderColor)
				xge.Text.DrawRectA(ele->DrawBuffer, 24 + ele->TextOffset.x, ele->TextOffset.y, ele->Layout.Rect.w - (24 + ele->TextOffset.x), 20, ele->Text, ele->NormalStyle.TextColor, ele->TextFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
			EndIf
	End Select
End Sub

' 超链接 - 绘图
Sub xui_class_HyperLink_OnDraw(ele As xui.Button Ptr)
	Select Case ele->private_Status
		Case 1
			xge.Text.DrawRectA(ele->DrawBuffer, ele->TextOffset.x, ele->TextOffset.y, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->Text, ele->HotStyle.TextColor, ele->TextFont, XGE_FONT_UNDERLINE, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
		Case 2
			xge.Text.DrawRectA(ele->DrawBuffer, ele->TextOffset.x, ele->TextOffset.y, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->Text, ele->PressStyle.TextColor, ele->TextFont, XGE_FONT_UNDERLINE, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
		Case Else
			' 处理选中的状态
			If (ele->Mode <> 0) And (ele->Checked <> 0) Then
				xge.Text.DrawRectA(ele->DrawBuffer, ele->TextOffset.x, ele->TextOffset.y, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->Text, ele->CheckStyle.TextColor, ele->TextFont, XGE_FONT_UNDERLINE, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
			Else
				xge.Text.DrawRectA(ele->DrawBuffer, ele->TextOffset.x, ele->TextOffset.y, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->Text, ele->NormalStyle.TextColor, ele->TextFont, XGE_FONT_UNDERLINE, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
			EndIf
	End Select
End Sub



' 按钮元素 - 鼠标进入
Sub xui_class_Button_OnMouseEnter(ele As xui.Button Ptr)
	ele->private_Status = 1
	' 播放声音
	If ele->EnterSound Then
		ele->EnterSound->Play()
	EndIf
End Sub

' 按钮元素 - 鼠标离开
Sub xui_class_Button_OnMouseLeave(ele As xui.Button Ptr)
	ele->private_Status = 0
	' 播放声音
	If ele->LeaveSound Then
		ele->LeaveSound->Play()
	EndIf
End Sub

' 按钮元素 - 鼠标按下
Function xui_class_Button_OnMouseDown(ele As xui.Button Ptr, x As Integer, y As Integer, btn As Integer) As Integer
	xui.ActiveElement(ele)
	ele->private_Status = 2
	ele->private_AllowClick = -1
	' 播放声音
	If ele->DownSound Then
		ele->DownSound->Play()
	EndIf
	Return -1
End Function

' 按钮元素 - 取消同级控件的选择
Sub xui_class_Button_UncheckBrother(parent As xui.Element Ptr, source As xui.Element Ptr)
	Dim ele As xui.Button Ptr
	If parent Then
		Dim c As Integer = Parent->Childs.Count()
		For i As Integer = 1 To c
			ele = parent->Childs.GetElement(i)
			If ele->ClassID = XUI_CLASS_BUTTON Then
				If ele->Mode = 2 Then
					If ele <> source Then
						If ele->Checked Then
							ele->Checked = 0
							If ele->Event.OnCheck Then
								ele->Event.OnCheck(ele)
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		Next
	EndIf
End Sub

' 按钮元素 - 鼠标弹起 [如果鼠标仍在]
Function xui_class_Button_OnMouseUp(ele As xui.Button Ptr, x As Integer, y As Integer, btn As Integer) As Integer
	Dim mx As Integer = xInput.GetMouseX()
	Dim my As Integer = xInput.GetMouseY()
	If (mx >= ele->Layout.ScreenCoord.x) And (my >= ele->Layout.ScreenCoord.y) And (mx <= (ele->Layout.ScreenCoord.x + ele->Layout.Rect.w)) And (my <= (ele->Layout.ScreenCoord.y + ele->Layout.Rect.h)) Then
		If ele->Mode = 0 Then
			ele->private_Status = 1
		Else
			ele->private_Status = 0
		EndIf
		If ele->private_AllowClick = -1 Then
			If ele->Event.OnClick Then
				ele->Event.OnClick(ele, btn)
			EndIf
			' 处理选中
			Select Case ele->Mode
				Case 1		' 复选模式
					ele->Checked = IIf(ele->Checked, 0, -1)
					If ele->Event.OnCheck Then
						ele->Event.OnCheck(ele)
					EndIf
				Case 2		' 单选模式
					If ele->Checked = 0 Then
						xui_class_Button_UncheckBrother(ele->Parent, ele)
						ele->Checked = -1
						If ele->Event.OnCheck Then
							ele->Event.OnCheck(ele)
						EndIf
					EndIf
				Case 3		' 超链接模式 [首次点击后永远是选中状态，也可以用于礼包按钮]
					ele->Checked = -1
			End Select
			' 播放声音
			If ele->ClickSound Then
				ele->ClickSound->Play()
			EndIf
		EndIf
	Else
		ele->private_Status = 0
	EndIf
	xui.ActiveElement(NULL)
	ele->private_AllowClick = 0
	Return -1
End Function

' 按钮元素 - 键盘按下
Function xui_class_Button_OnKeyDown(ele As xui.Button Ptr, k As Integer, c As Integer) As Integer
	If k = SC_SPACE Then
		ele->private_Status = 2
		' 播放声音
		If ele->DownSound Then
			ele->DownSound->Play()
		EndIf
		Return -1
	EndIf
	Return 0
End Function

' 按钮元素 - 键盘弹起 [按钮激活时按下空格可以触发按钮]
Function xui_class_Button_OnKeyUp(ele As xui.Button Ptr, k As Integer, c As Integer) As Integer
	If k = SC_SPACE Then
		If ele->Mode = 0 Then
			If xge_xui_element_hot = ele Then
				ele->private_Status = 1
			Else
				ele->private_Status = 0
			EndIf
		Else
			ele->private_Status = 0
		EndIf
		If ele->Event.OnClick Then
			ele->Event.OnClick(ele, 32)
		EndIf
		' 处理选中
		Select Case ele->Mode
			Case 1		' 复选模式
				ele->Checked = IIf(ele->Checked, 0, -1)
				If ele->Event.OnCheck Then
					ele->Event.OnCheck(ele)
				EndIf
			Case 2		' 单选模式
				If ele->Checked = 0 Then
					xui_class_Button_UncheckBrother(ele->Parent, ele)
					ele->Checked = -1
					If ele->Event.OnCheck Then
						ele->Event.OnCheck(ele)
					EndIf
				EndIf
			Case 3		' 超链接模式 [首次点击后永远是选中状态，也可以用于礼包按钮]
				ele->Checked = -1
		End Select
		' 播放声音
		If ele->ClickSound Then
			ele->ClickSound->Play()
		EndIf
		Return -1
	EndIf
	Return 0
End Function





Extern XGE_EXTERNCLASS



Namespace xui
	
	' 创建按钮
	Function CreateButton(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr XGE_EXPORT_ALL
		Dim ele As xui.Button Ptr = New xui.Button()
		' 基础属性赋值
		ele->ClassID = XUI_CLASS_BUTTON
		ele->InitElement(iLayoutRuler, x, y, w, h, XUI_LAYOUT_COORD, sIdentifier)
		' 自定义属性赋值
		ele->Text = sCaption
		ele->TextFont = 1
		ele->TextOffset.x = 0
		ele->TextOffset.y = 0
		ele->Mode = 0
		ele->Checked = 0
		ele->EnterSound = NULL
		ele->LeaveSound = NULL
		ele->DownSound  = NULL
		ele->ClickSound = NULL
		' 应用样式
		ele->NormalStyle.BorderColor = &HFF0A8ED8
		ele->NormalStyle.FillColor = &HFF0A8ED8
		ele->NormalStyle.TextColor = &HFFCCE8FF
		ele->PressStyle.BorderColor = &HFF0A8ED8
		ele->PressStyle.FillColor = &HFF0060A8
		ele->PressStyle.TextColor = &HFFFFFFFF
		ele->HotStyle.BorderColor = &HFF0A8ED8
		ele->HotStyle.FillColor = &HFF1CB2FA
		ele->HotStyle.TextColor = &HFFFFFFFF
		ele->CheckStyle.BorderColor = &HFFD88E0A
		ele->CheckStyle.FillColor = &HFF0A8ED8
		ele->CheckStyle.TextColor = &HFFFFB866
		' 设置类参数
		ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_Button_OnDraw)
		ele->ClassEvent.OnMouseMove = Cast(Any Ptr, @xui_class_Empty_OnMouseMove)
		ele->ClassEvent.OnMouseEnter = Cast(Any Ptr, @xui_class_Button_OnMouseEnter)
		ele->ClassEvent.OnMouseLeave = Cast(Any Ptr, @xui_class_Button_OnMouseLeave)
		ele->ClassEvent.OnMouseDown = Cast(Any Ptr, @xui_class_Button_OnMouseDown)
		ele->ClassEvent.OnMouseUp = Cast(Any Ptr, @xui_class_Button_OnMouseUp)
		ele->ClassEvent.OnKeyDown = Cast(Any Ptr, @xui_class_Button_OnKeyDown)
		ele->ClassEvent.OnKeyUp = Cast(Any Ptr, @xui_class_Button_OnKeyUp)
		Return ele
	End Function
	
	' 创建选择按钮
	Function CreateCheckButton(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr XGE_EXPORT_ALL
		Dim ele As xui.Button Ptr = CreateButton(iLayoutRuler, x, y, w, h, sCaption, sIdentifier)
		If ele Then
			' 设置类参数
			ele->Mode = 1
		EndIf
		Return ele
	End Function
	Function CreateRadioButton(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr XGE_EXPORT_ALL
		Dim ele As xui.Button Ptr = CreateButton(iLayoutRuler, x, y, w, h, sCaption, sIdentifier)
		If ele Then
			' 设置类参数
			ele->Mode = 2
		EndIf
		Return ele
	End Function
	
	' 创建复选框
	Function CreateCheckBox(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr XGE_EXPORT_ALL
		Dim ele As xui.Button Ptr = CreateButton(iLayoutRuler, x, y, w, h, sCaption, sIdentifier)
		If ele Then
			' 设置类参数
			ele->Mode = 1
			ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_CheckBox_OnDraw)
		EndIf
		Return ele
	End Function
	
	' 创建单选框
	Function CreateRadioBox(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr XGE_EXPORT_ALL
		Dim ele As xui.Button Ptr = CreateButton(iLayoutRuler, x, y, w, h, sCaption, sIdentifier)
		If ele Then
			' 设置类参数
			ele->Mode = 2
			ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_RadioBox_OnDraw)
		EndIf
		Return ele
	End Function
	
	' 创建超链接
	Function CreateHyperLink(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr XGE_EXPORT_ALL
		Dim ele As xui.Button Ptr = CreateButton(iLayoutRuler, x, y, w, h, sCaption, sIdentifier)
		If ele Then
			' 设置类参数
			ele->Mode = 3
			ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_HyperLink_OnDraw)
			' 应用样式
			ele->NormalStyle.TextColor = &HFF0066CC
			ele->PressStyle.TextColor = &HFF0066CC
			ele->HotStyle.TextColor = &HFFD88E0A
			ele->CheckStyle.TextColor = &HFF800080
		EndIf
		Return ele
	End Function
	
	
	
End Namespace



End Extern


