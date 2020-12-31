


' 滚动视图类 - 绘图
Sub xui_class_ScrollView_OnDraw(ele As xui.ScrollView Ptr)
	If ele->Event.OnDrawView Then
		Dim w As Integer = (ele->Layout.Rect.w - 4) - IIf(ele->ScrollBar And XUI_SCROLL_V, 18, 0)
		Dim h As Integer = (ele->Layout.Rect.h - 4) - IIf(ele->ScrollBar And XUI_SCROLL_H, 18, 0)
		ele->Event.OnDrawView(ele, ele->View.x, ele->View.y, w, h)
	EndIf
	xge.shape.Rect(ele->DrawBuffer, 0, 0, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->BorderColor)
End Sub

' 滚动视图类 - 纵向滚动条改变
Sub xui_class_ScrollView_OnScrollV(ele As xui.ScrollBar Ptr)
	
End Sub

' 滚动视图类 - 横向滚动条改变
Sub xui_class_ScrollView_OnScrollH(ele As xui.ScrollBar Ptr)
	
End Sub



Extern XGE_EXTERNCLASS



Namespace xui
	
	
	
	' 创建滚动视图
	Function CreateScrollView(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 200, h As Integer = 200, vw As Integer = 200, vh As Integer = 200, sIdentifier As ZString Ptr = NULL) As xui.ScrollView Ptr XGE_EXPORT_ALL
		Dim ele As xui.ScrollView Ptr = New xui.ScrollView()
		' 基础属性赋值
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
		ele->LayoutMode = XUI_LAYOUT_COORD
		If sIdentifier Then
			strncpy(@ele->Identifier, sIdentifier, 31)
			ele->Identifier[31] = 0
		EndIf
		' 自定义属性赋值
		ele->View.x = 0
		ele->View.y = 0
		ele->View.w = vw
		ele->View.h = vh
		ele->ScrollBar = XUI_SCROLL_VH
		ele->BorderWidth = 2
		ele->BorderColor = &HFF0A8ED8
		' 创建子控件
		ele->private_VScroll = xui.CreateVScrollBar(XUI_LAYOUT_RULER_PIXEL, 100, 50, 18, 500)
		ele->private_HScroll = xui.CreateHScrollBar(XUI_LAYOUT_RULER_PIXEL, 100, 50, 18, 500)
		ele->private_VScroll->Event.OnScroll = Cast(Any Ptr, @xui_class_ScrollView_OnScrollV)
		ele->private_HScroll->Event.OnScroll = Cast(Any Ptr, @xui_class_ScrollView_OnScrollH)
		' 设置类参数
		ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_ScrollView_OnDraw)
		Return ele
	End Function
	
	
	
End Namespace



End Extern


