


' 根据参数绘制按钮背景
Sub DrawBackImage(ele As xui.Element Ptr, bi As xui.BackImage Ptr, sCaption As ZString Ptr, fontid As UInteger, CaptionOffset As xui.Coord Ptr)
	If bi->Image Then
		bi->Image->Draw(ele->Image, 0, 0)
	Else
		xge.shape.Rect(ele->Image, 0, 0, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, bi->BorderColor)
		xge.shape.RectFull(ele->Image, 1, 1, ele->Layout.Rect.w - 2, ele->Layout.Rect.h - 2, bi->FillColor)
	EndIf
	xge.Text.DrawRectA(ele->Image, CaptionOffset->x, CaptionOffset->y, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, sCaption, bi->TextColor, fontid, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
End Sub





' 按钮类 - 绘图
Sub xui_class_Button_OnDraw(ele As xui.Button Ptr)
	Select Case ele->private_Status
		Case 1
			DrawBackImage(ele, @ele->HotBack, ele->Caption, ele->CaptionFont, @ele->CaptionOffset)
		Case 2
			DrawBackImage(ele, @ele->PressBack, ele->Caption, ele->CaptionFont, @ele->CaptionOffset)
		Case Else
			' 处理选中的状态
			If (ele->Mode <> 0) And (ele->Checked <> 0) Then
				DrawBackImage(ele, @ele->CheckBack, ele->Caption, ele->CaptionFont, @ele->CaptionOffset)
			Else
				DrawBackImage(ele, @ele->NormalBack, ele->Caption, ele->CaptionFont, @ele->CaptionOffset)
			EndIf
	End Select
End Sub

' 标准复选框 - 绘图
Sub xui_class_CheckBox_OnDraw(ele As xui.Button Ptr)
	Select Case ele->private_Status
		Case 1
			xge.shape.Rect(ele->Image, 2, 2, 18, 18, ele->HotBack.BorderColor)
			xge.shape.Rect(ele->Image, 3, 3, 17, 17, ele->HotBack.BorderColor)
			xge.shape.RectFull(ele->Image, 4, 4, 16, 16, (ele->HotBack.FillColor And &H00FFFFFF) Or &H40000000)
			xge.Text.DrawRectA(ele->Image, 24 + ele->CaptionOffset.x, ele->CaptionOffset.y, ele->Layout.Rect.w - (24 + ele->CaptionOffset.x), 20, ele->Caption, ele->HotBack.TextColor, ele->CaptionFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
		Case 2
			xge.shape.Rect(ele->Image, 2, 2, 18, 18, ele->PressBack.BorderColor)
			xge.shape.Rect(ele->Image, 3, 3, 17, 17, ele->PressBack.BorderColor)
			xge.shape.RectFull(ele->Image, 4, 4, 16, 16, ele->PressBack.FillColor)
			xge.Text.DrawRectA(ele->Image, 24 + ele->CaptionOffset.x, ele->CaptionOffset.y, ele->Layout.Rect.w - (24 + ele->CaptionOffset.x), 20, ele->Caption, ele->PressBack.TextColor, ele->CaptionFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
		Case Else
			' 处理选中的状态
			If (ele->Mode <> 0) And (ele->Checked <> 0) Then
				xge.shape.Rect(ele->Image, 2, 2, 18, 18, ele->CheckBack.FillColor)
				xge.shape.Rect(ele->Image, 3, 3, 17, 17, ele->CheckBack.FillColor)
				xge.shape.RectFull(ele->Image, 7, 7, 13, 13, ele->CheckBack.BorderColor)
				xge.Text.DrawRectA(ele->Image, 24 + ele->CaptionOffset.x, ele->CaptionOffset.y, ele->Layout.Rect.w - (24 + ele->CaptionOffset.x), 20, ele->Caption, ele->CheckBack.TextColor, ele->CaptionFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
			Else
				xge.shape.Rect(ele->Image, 2, 2, 18, 18, ele->NormalBack.BorderColor)
				xge.shape.Rect(ele->Image, 3, 3, 17, 17, ele->NormalBack.BorderColor)
				xge.shape.RectFull(ele->Image, 4, 4, 16, 16, (ele->NormalBack.FillColor And &H00FFFFFF) Or &H40000000)
				xge.Text.DrawRectA(ele->Image, 24 + ele->CaptionOffset.x, ele->CaptionOffset.y, ele->Layout.Rect.w - (24 + ele->CaptionOffset.x), 20, ele->Caption, ele->NormalBack.TextColor, ele->CaptionFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
			EndIf
	End Select
End Sub

' 标准单选框 - 绘图
Sub xui_class_RadioBox_OnDraw(ele As xui.Button Ptr)
	Select Case ele->private_Status
		Case 1
			xge.shape.CircFull(ele->Image, 10, 10, 8, (ele->HotBack.FillColor And &H00FFFFFF) Or &H40000000)
			xge.shape.Circ(ele->Image, 10, 10, 9, ele->HotBack.BorderColor)
			xge.shape.Circ(ele->Image, 10, 10, 8, ele->HotBack.BorderColor)
			xge.Text.DrawRectA(ele->Image, 24 + ele->CaptionOffset.x, ele->CaptionOffset.y, ele->Layout.Rect.w - (24 + ele->CaptionOffset.x), 20, ele->Caption, ele->HotBack.TextColor, ele->CaptionFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
		Case 2
			xge.shape.CircFull(ele->Image, 10, 10, 8, ele->PressBack.FillColor)
			xge.shape.Circ(ele->Image, 10, 10, 9, ele->PressBack.BorderColor)
			xge.shape.Circ(ele->Image, 10, 10, 8, ele->PressBack.BorderColor)
			xge.Text.DrawRectA(ele->Image, 24 + ele->CaptionOffset.x, ele->CaptionOffset.y, ele->Layout.Rect.w - (24 + ele->CaptionOffset.x), 20, ele->Caption, ele->PressBack.TextColor, ele->CaptionFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
		Case Else
			' 处理选中的状态
			If (ele->Mode <> 0) And (ele->Checked <> 0) Then
				xge.shape.Circ(ele->Image, 10, 10, 9, ele->CheckBack.FillColor)
				xge.shape.Circ(ele->Image, 10, 10, 8, ele->CheckBack.FillColor)
				xge.shape.CircFull(ele->Image, 10, 10, 4, ele->CheckBack.BorderColor)
				xge.Text.DrawRectA(ele->Image, 24 + ele->CaptionOffset.x, ele->CaptionOffset.y, ele->Layout.Rect.w - (24 + ele->CaptionOffset.x), 20, ele->Caption, ele->CheckBack.TextColor, ele->CaptionFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
			Else
				xge.shape.CircFull(ele->Image, 10, 10, 8, (ele->NormalBack.FillColor And &H00FFFFFF) Or &H40000000)
				xge.shape.Circ(ele->Image, 10, 10, 9, ele->NormalBack.BorderColor)
				xge.shape.Circ(ele->Image, 10, 10, 8, ele->NormalBack.BorderColor)
				xge.Text.DrawRectA(ele->Image, 24 + ele->CaptionOffset.x, ele->CaptionOffset.y, ele->Layout.Rect.w - (24 + ele->CaptionOffset.x), 20, ele->Caption, ele->NormalBack.TextColor, ele->CaptionFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
			EndIf
	End Select
End Sub

' 超链接 - 绘图
Sub xui_class_HyperLink_OnDraw(ele As xui.Button Ptr)
	Select Case ele->private_Status
		Case 1
			xge.Text.DrawRectA(ele->Image, ele->CaptionOffset.x, ele->CaptionOffset.y, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->Caption, ele->HotBack.TextColor, ele->CaptionFont, XGE_FONT_UNDERLINE, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
		Case 2
			xge.Text.DrawRectA(ele->Image, ele->CaptionOffset.x, ele->CaptionOffset.y, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->Caption, ele->PressBack.TextColor, ele->CaptionFont, XGE_FONT_UNDERLINE, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
		Case Else
			' 处理选中的状态
			If (ele->Mode <> 0) And (ele->Checked <> 0) Then
				xge.Text.DrawRectA(ele->Image, ele->CaptionOffset.x, ele->CaptionOffset.y, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->Caption, ele->CheckBack.TextColor, ele->CaptionFont, XGE_FONT_UNDERLINE, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
			Else
				xge.Text.DrawRectA(ele->Image, ele->CaptionOffset.x, ele->CaptionOffset.y, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->Caption, ele->NormalBack.TextColor, ele->CaptionFont, XGE_FONT_UNDERLINE, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
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
	If xge_xui_element_hot = ele Then
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
		xui.ActiveElement(NULL)
	EndIf
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
		Dim ele As xui.Button Ptr
		ele = New xui.Button()
		ele->ClassID = XUI_CLASS_BUTTON
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
		' 应用样式
		ele->NormalBack.BorderColor = &HFF0A8ED8
		ele->NormalBack.FillColor = &HFF0A8ED8
		ele->NormalBack.TextColor = &HFFCCE8FF
		ele->PressBack.BorderColor = &HFF0A8ED8
		ele->PressBack.FillColor = &HFF0060A8
		ele->PressBack.TextColor = &HFFFFFFFF
		ele->HotBack.BorderColor = &HFF0A8ED8
		ele->HotBack.FillColor = &HFF1CB2FA
		ele->HotBack.TextColor = &HFFFFFFFF
		ele->CheckBack.BorderColor = &HFFD88E0A
		ele->CheckBack.FillColor = &HFF0A8ED8
		ele->CheckBack.TextColor = &HFFFFB866
		' 设置类参数
		ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_Button_OnDraw)
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
			ele->NormalBack.TextColor = &HFF0066CC
			ele->PressBack.TextColor = &HFF0066CC
			ele->HotBack.TextColor = &HFFD88E0A
			ele->CheckBack.TextColor = &HFF800080
		EndIf
		Return ele
	End Function
	
	
	
End Namespace



End Extern


