


' 标签类 - 绘图
Sub xui_class_Label_OnDraw(ele As xui.Label Ptr)
	xui_DrawBackStyle(ele, @ele->BackStyle)
	xge.Text.DrawRectW(ele->DrawBuffer, ele->TextOffset.x, ele->TextOffset.y, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->Text, 0, ele->TextColor, ele->TextFont, 0, ele->TextAlign, ele->LineSpace, ele->WordSpace)
End Sub

' 容器类 - 绘图
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
				xge.Text.DrawRectW(ele->DrawBuffer, 0, 0, ele->Layout.Rect.w - 1, WordHeight + 6, ele->Text, 0, ele->TextColor, ele->TextFont, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
			EndIf
		EndIf
	EndIf
End Sub

' 图像类 - 绘图
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



' 进度条类 - 绘图
Sub xui_class_ProgressBar_OnDraw(ele As xui.ProgressBar Ptr)
	xui_DrawBackStyle(ele, @ele->BackStyle)
	Dim percent As Double = (ele->Value - ele->Min) / (ele->Max - ele->Min)
	If ele->Value > ele->Min Then
		Dim ForeRect As xge_Rect = (ele->BorderWidth, ele->BorderWidth, ele->BorderWidth + ((ele->Layout.Rect.w - ele->BorderWidth) * percent), ele->Layout.Rect.h - ele->BorderWidth)
		xui_DrawBackStyle_Rect(ele, @ele->ForeStyle, @ForeRect)
	EndIf
	Select Case ele->ShowMode
		Case XUI_PROGRESSBAR_PERCENT
			' 显示百分比
			Dim c As ZString * 24
			sprintf(@c, "%0." & ele->RercentDigit & "f%%", percent * 100)
			xge.Text.DrawRectA(ele->DrawBuffer, 0, 0, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, @c, 0, ele->TextColor, ele->TextFont, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
		Case XUI_PROGRESSBAR_VALUE
			' 显示数值
			xge.Text.DrawRectW(ele->DrawBuffer, 0, 0, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->Value & "/" & ele->Max, 0, ele->TextColor, ele->TextFont, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE)
		Case Else
			' 不显示文字
	End Select
End Sub



Extern XGE_EXTERNCLASS



Namespace xui
	
	
	
	' 创建标签
	Function CreateLabel(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As WString Ptr, TextColor As UInteger = &HFFFFFFFF, TextFont As UInteger = 1, sIdentifier As WString Ptr = NULL) As xui.Label Ptr XGE_EXPORT_ALL
		Dim ele As xui.Label Ptr = New xui.Label()
		' 基础属性赋值
		ele->ClassID = XUI_CLASS_STATIC
		ele->InitElement(iLayoutRuler, x, y, w, h, XUI_LAYOUT_COORD, sIdentifier)
		' 自定义属性赋值
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
		' 设置类参数
		ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_Label_OnDraw)
		Return ele
	End Function
	
	' 创建容器
	Function CreateFrame(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sCaption As WString Ptr = NULL, sIdentifier As WString Ptr = NULL) As xui.Frame Ptr XGE_EXPORT_ALL
		Dim ele As xui.Frame Ptr = New xui.Frame()
		' 基础属性赋值
		ele->ClassID = XUI_CLASS_STATIC
		ele->InitElement(iLayoutRuler, x, y, w, h, iLayoutMode, sIdentifier)
		' 自定义属性赋值
		ele->Text = sCaption
		ele->TextColor = &HFFFFFFFF
		ele->TextFont = 1
		ele->BackStyle.Hide = FALSE
		ele->BackStyle.Image = NULL
		ele->BackStyle.BorderColor = &HFF0A8ED8
		ele->BackStyle.FillColor = &HFF1CB2FA
		' 设置类参数
		ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_Frame_OnDraw)
		Return ele
	End Function
	
	' 创建图像类
	Function CreateImage(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, pImage As xge.Surface Ptr = NULL, sIdentifier As WString Ptr = NULL) As xui.Image Ptr XGE_EXPORT_ALL
		Dim ele As xui.Image Ptr = New xui.Image()
		' 基础属性赋值
		ele->ClassID = XUI_CLASS_STATIC
		ele->InitElement(iLayoutRuler, x, y, w, h, XUI_LAYOUT_COORD, sIdentifier)
		' 自定义属性赋值
		ele->Image = pImage
		ele->ImageOffset.x = 0
		ele->ImageOffset.y = 0
		ele->BorderWidth = 0
		ele->BorderColor = &HFF0A8ED8
		' 设置类参数
		ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_Image_OnDraw)
		Return ele
	End Function
	
	' 创建进度条类
	Function CreateProgressBar(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sIdentifier As WString Ptr = NULL) As xui.ProgressBar Ptr XGE_EXPORT_ALL
		Dim ele As xui.ProgressBar Ptr = New xui.ProgressBar()
		' 基础属性赋值
		ele->ClassID = XUI_CLASS_PROGRESSBAR
		ele->InitElement(iLayoutRuler, x, y, w, h, XUI_LAYOUT_COORD, sIdentifier)
		' 自定义属性赋值
		ele->Max = 100
		ele->Min = 0
		ele->Value = 0
		ele->TextFont = 1
		ele->TextColor = &HFFFF8000
		ele->BackStyle.Hide = FALSE
		ele->BackStyle.Image = NULL
		ele->BackStyle.BorderColor = &HFF0A8ED8
		ele->BackStyle.FillColor = &HFFDBF5FF
		ele->ForeStyle.Hide = FALSE
		ele->ForeStyle.Image = NULL
		ele->ForeStyle.BorderColor = &HFF55BCF7
		ele->ForeStyle.FillColor = &HFF55BCF7
		ele->ShowMode = XUI_PROGRESSBAR_PERCENT
		ele->RercentDigit = 2
		ele->BorderWidth = 3
		' 设置类参数
		ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_ProgressBar_OnDraw)
		Return ele
	End Function
	
	
	
End Namespace



End Extern


