


' 滚动视图类 - 绘图
Sub xui_class_ScrollView_OnDraw(ele As xui.ScrollView Ptr)
	If ele->ViewEvent.OnDrawView Then
		Dim w As Integer = (ele->Layout.Rect.w - (ele->BorderWidth + ele->BorderWidth)) - IIf(ele->ScrollBar And XUI_SCROLL_V, 18, 0)
		Dim h As Integer = (ele->Layout.Rect.h - (ele->BorderWidth + ele->BorderWidth)) - IIf(ele->ScrollBar And XUI_SCROLL_H, 18, 0)
		ele->ViewEvent.OnDrawView(ele, ele->BorderWidth, ele->BorderWidth, ele->View.x, ele->View.y, w, h)
	EndIf
	If (ele->ScrollBar And XUI_SCROLL_VH) = XUI_SCROLL_VH Then
		xge.shape.RectFull(ele->DrawBuffer, ele->private_VScroll->Layout.Rect.x, ele->private_HScroll->Layout.Rect.y, ele->private_VScroll->Layout.Rect.x + 17, ele->private_HScroll->Layout.Rect.y + 17, ele->BackColor)
	EndIf
	If ele->BorderWidth > 0 Then
		xge.shape.Rect(ele->DrawBuffer, 0, 0, ele->Layout.Rect.w - 1, ele->Layout.Rect.h - 1, ele->BorderColor)
	EndIf
End Sub

' 滚动视图类 - 改变大小
Sub xui_class_ScrollView_OnSize(ele As xui.ScrollView Ptr)
	ele->SetViewSize(ele->View.w, ele->View.h, FALSE)
	ele->private_VScroll->Layout.Rect.x = ele->Layout.Rect.w - 18
	ele->private_VScroll->Layout.Rect.y = 0
	ele->private_HScroll->Layout.Rect.x = 0
	ele->private_HScroll->Layout.Rect.y = ele->Layout.Rect.h - 18
	If (ele->ScrollBar And XUI_SCROLL_VH) = XUI_SCROLL_VH Then
		ele->private_VScroll->Layout.Rect.w = 18
		ele->private_VScroll->Layout.Rect.h = ele->Layout.Rect.h - 18
		ele->private_HScroll->Layout.Rect.w = ele->Layout.Rect.w - 18
		ele->private_HScroll->Layout.Rect.h = 18
	Else
		ele->private_VScroll->Layout.Rect.w = 18
		ele->private_VScroll->Layout.Rect.h = ele->Layout.Rect.h
		ele->private_HScroll->Layout.Rect.w = ele->Layout.Rect.w
		ele->private_HScroll->Layout.Rect.h = 18
	EndIf
End Sub

' 滚动视图类 - 滚轮拨动
Function xui_class_ScrollView_OnMouseWhell(ele As xui.ScrollView Ptr, x As Integer, y As Integer, z As Integer, nz As Integer) As Integer
	If ele->DefaultScrollBar Then
		If ele->DefaultScrollBar->ClassEvent.OnMouseWhell Then
			ele->DefaultScrollBar->ClassEvent.OnMouseWhell(ele->DefaultScrollBar, x, y, z, nz)
		EndIf
	EndIf
	Return -1
End Function

' 滚动视图类 - 纵向滚动条改变
Sub xui_class_ScrollView_OnScrollV(ele As xui.ScrollBar Ptr)
	Dim parent As xui.ScrollView Ptr = Cast(Any Ptr, ele->Parent)
	parent->View.y = ele->Value
End Sub

' 滚动视图类 - 横向滚动条改变
Sub xui_class_ScrollView_OnScrollH(ele As xui.ScrollBar Ptr)
	Dim parent As xui.ScrollView Ptr = Cast(Any Ptr, ele->Parent)
	parent->View.x = ele->Value
End Sub



Extern XGE_EXTERNCLASS



Namespace xui
	
	
	
	Constructor ScrollView() XGE_EXPORT_OBJ
		' 基础属性赋值
		ClassID = XUI_CLASS_SCROLLVIEW
		' 自定义属性赋值
		View.x = 0
		View.y = 0
		BorderWidth = 2
		BorderColor = &HFF0A8ED8
		BackColor = &HFFA6DDFB
		' 创建子控件
		private_VScroll = xui.CreateVScrollBar(XUI_LAYOUT_RULER_PIXEL, 100, 50, 18, 500)
		private_HScroll = xui.CreateHScrollBar(XUI_LAYOUT_RULER_PIXEL, 100, 50, 500, 18)
		Childs.AddElement(private_VScroll)
		Childs.AddElement(private_HScroll)
		DefaultScrollBar = private_VScroll
		' 设置子控件事件
		private_VScroll->Event.OnScroll = Cast(Any Ptr, @xui_class_ScrollView_OnScrollV)
		private_HScroll->Event.OnScroll = Cast(Any Ptr, @xui_class_ScrollView_OnScrollH)
		' 设置类参数
		ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_ScrollView_OnDraw)
		ClassEvent.OnSize = Cast(Any Ptr, @xui_class_ScrollView_OnSize)
		ClassEvent.OnMouseWhell = Cast(Any Ptr, @xui_class_ScrollView_OnMouseWhell)
	End Constructor
	
	
	
	' 创建滚动视图
	Function CreateScrollView(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 200, h As Integer = 200, vw As Integer = 200, vh As Integer = 200, sIdentifier As ZString Ptr = NULL) As xui.ScrollView Ptr XGE_EXPORT_ALL
		Dim ele As xui.ScrollView Ptr = New xui.ScrollView()
		' 基础属性赋值
		ele->InitElement(iLayoutRuler, x, y, w, h, XUI_LAYOUT_COORD, sIdentifier)
		' 自定义属性赋值
		ele->View.w = vw
		ele->View.h = vh
		Return ele
	End Function
	
	
	
	' 设置视图大小
	Sub ScrollView.SetViewSize(vw As Integer, vh As Integer, bApplyLayout As Integer = TRUE) XGE_EXPORT_OBJ
		This.View.w = vw
		This.View.h = vh
		' 判断是否需要隐藏滚动条
		If (This.Layout.Rect.h - (BorderWidth + BorderWidth)) < vh Then
			ScrollBar = ScrollBar Or XUI_SCROLL_V
			private_VScroll->Visible = TRUE
			private_VScroll->SetRange(0, vh - (This.Layout.Rect.h - (BorderWidth + BorderWidth)), bApplyLayout)
		Else
			ScrollBar = ScrollBar And Not(XUI_SCROLL_V)
			private_VScroll->Visible = FALSE
		EndIf
		If (This.Layout.Rect.w - (BorderWidth + BorderWidth)) < vw Then
			ScrollBar = ScrollBar Or XUI_SCROLL_H
			private_HScroll->Visible = TRUE
			private_HScroll->SetRange(0, vw - (This.Layout.Rect.w - (BorderWidth + BorderWidth)), bApplyLayout)
		Else
			ScrollBar = ScrollBar And Not(XUI_SCROLL_H)
			private_HScroll->Visible = FALSE
		EndIf
	End Sub
	
	
	
End Namespace



End Extern


