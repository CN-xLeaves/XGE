


Extern XGE_EXTERNCLASS



Namespace xui
	
	
	
	' ���캯�� [Ԫ�ػ���]
	Constructor Element() XGE_EXPORT_OBJ
		DrawBuffer = New xge.Surface()
		Childs.Parent = @This
		ClassID = XUI_CLASS_ELEMENT
	End Constructor
	Constructor Element(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sIdentifier As WString Ptr = NULL) XGE_EXPORT_OBJ
		DrawBuffer = New xge.Surface()
		Childs.Parent = @This
		ClassID = XUI_CLASS_ELEMENT
		InitElement(iLayoutRuler, x, y, w, h, iLayoutMode, sIdentifier)
	End Constructor
	
	' ��������
	Destructor Element() XGE_EXPORT_OBJ
		If DrawBuffer Then
			Delete DrawBuffer
		EndIf
	End Destructor
	
	' ��д������Ϣ
	Sub Element.InitElement(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sIdentifier As WString Ptr = NULL) XGE_EXPORT_OBJ
		Layout.Ruler = iLayoutRuler
		Layout.w = w
		Layout.h = h
		Layout.RectBox.x = x
		Layout.RectBox.y = y
		If (iLayoutRuler = XUI_LAYOUT_RULER_PIXEL) Or (iLayoutRuler = XUI_LAYOUT_RULER_COORD) Then
			Layout.Rect.x = x
			Layout.Rect.y = y
			Layout.Rect.w = w
			Layout.Rect.h = h
		EndIf
		LayoutMode = iLayoutMode
		If sIdentifier Then
			wcsncpy(@Identifier, sIdentifier, XGE_XUI_IDSIZE)
			Identifier[XGE_XUI_IDSIZE-1] = 0
		EndIf
	End Sub
	
	' Ӧ�ò���
	Sub Element.LayoutApply() XGE_EXPORT_OBJ
		' ���� OnSize �¼�
		DrawBuffer->Create(Layout.Rect.w, Layout.Rect.h)
		If ClassEvent.OnSize Then
			ClassEvent.OnSize(@This)
		EndIf
		' ������Ԫ�صĲ��ֺ�λ��
		If LayoutMode = XUI_LAYOUT_COORD Then
			' ���겼��ֻ����Ԫ�صĳ���λ��
			Dim c As Integer = Childs.StructCount
			For i As Integer = 1 To c
				Dim ele As xui.Element Ptr
				ele = *Cast(xui.Element Ptr Ptr, Childs.GetPtrStruct(i))
				ele->Layout.ScreenCoord.x = ele->Layout.Rect.x + Layout.ScreenCoord.x
				ele->Layout.ScreenCoord.y = ele->Layout.Rect.y + Layout.ScreenCoord.y
				' ����Ԫ��ҲӦ�ò���
				ele->LayoutApply()
			Next
		Else
			Dim c As Integer = Childs.StructCount
			' ��һ��ѭ������鸸�����Ƿ���ȷ [�����������Լ����Ӷ���ɾ����������ֲ��ָ��ŵ����]
			For i As Integer = c To 1 Step -1
				Dim ele As xui.Element Ptr
				ele = *Cast(xui.Element Ptr Ptr, Childs.GetPtrStruct(i))
				If ele->Parent <> @This Then
					Childs.DeleteStruct(i)
				EndIf
			Next
			' �ڶ���ѭ��������ʣ��ռ�ͱ������ܺ�
			Dim cw As Integer = 0
			Dim ch As Integer = 0
			Dim ar As Integer = 0	' �����߶�
			Dim rs As Integer = 0	' ʣ��ռ�
			c = Childs.StructCount
			For i As Integer = 1 To c
				Dim ele As xui.Element Ptr
				ele = *Cast(xui.Element Ptr Ptr, Childs.GetPtrStruct(i))
				If ele->Visible Then
					Select Case ele->Layout.Ruler
						Case XUI_LAYOUT_RULER_PIXEL
							' ��������ر�ʾ
							cw += ele->Layout.RectBox.LeftOffset + ele->Layout.RectBox.RightOffset
							cw += ele->Layout.w
							ch += ele->Layout.RectBox.TopOffset + ele->Layout.RectBox.BottomOffset
							ch += ele->Layout.h
						Case XUI_LAYOUT_RULER_RATIO
							' �����ʣ��ռ������ʾ
							cw += ele->Layout.RectBox.LeftOffset + ele->Layout.RectBox.RightOffset
							ch += ele->Layout.RectBox.TopOffset + ele->Layout.RectBox.BottomOffset
							If (LayoutMode = XUI_LAYOUT_L2R) Or (LayoutMode = XUI_LAYOUT_R2L) Then
								ar += ele->Layout.w
							EndIf
							If (LayoutMode = XUI_LAYOUT_T2B) Or (LayoutMode = XUI_LAYOUT_B2T) Then
								ar += ele->Layout.h
							EndIf
						Case XUI_LAYOUT_RULER_COORD
							' ���Ʋ��ֵ�Ԫ�أ������м��� [ǿ�Ƹ�������]
					End Select
				EndIf
			Next
			' ����ʣ��ռ�
			If (LayoutMode = XUI_LAYOUT_L2R) Or (LayoutMode = XUI_LAYOUT_R2L) Then
				rs = Layout.Rect.w - cw
			EndIf
			If (LayoutMode = XUI_LAYOUT_T2B) Or (LayoutMode = XUI_LAYOUT_B2T) Then
				rs = Layout.Rect.h - ch
			EndIf
			' ������ѭ��������ÿ��Ԫ�ص�����ʹ�С
			Dim px As Integer = 0
			Dim py As Integer = 0
			For i As Integer = 1 To c
				Dim ele As xui.Element Ptr
				ele = *Cast(xui.Element Ptr Ptr, Childs.GetPtrStruct(i))
				If ele->Visible Then
					Select Case ele->Layout.Ruler
						Case XUI_LAYOUT_RULER_PIXEL
							' ��������ر�ʾ
							ele->Layout.Rect.w = ele->Layout.w
							ele->Layout.Rect.h = ele->Layout.h
							ele->Layout.Rect.x = ele->Layout.RectBox.LeftOffset + px
							ele->Layout.Rect.y = ele->Layout.RectBox.TopOffset + py
							ele->Layout.ScreenCoord.x = ele->Layout.Rect.x + Layout.ScreenCoord.x
							ele->Layout.ScreenCoord.y = ele->Layout.Rect.y + Layout.ScreenCoord.y
							If (LayoutMode = XUI_LAYOUT_L2R) Or (LayoutMode = XUI_LAYOUT_R2L) Then
								px += ele->Layout.RectBox.LeftOffset + ele->Layout.Rect.w + ele->Layout.RectBox.RightOffset
							EndIf
							If (LayoutMode = XUI_LAYOUT_T2B) Or (LayoutMode = XUI_LAYOUT_B2T) Then
								py += ele->Layout.RectBox.TopOffset + ele->Layout.Rect.h + ele->Layout.RectBox.BottomOffset
							EndIf
						Case XUI_LAYOUT_RULER_RATIO
							' �����ʣ��ռ������ʾ
							ele->Layout.Rect.x = ele->Layout.RectBox.LeftOffset + px
							ele->Layout.Rect.y = ele->Layout.RectBox.TopOffset + py
							ele->Layout.ScreenCoord.x = ele->Layout.Rect.x + Layout.ScreenCoord.x
							ele->Layout.ScreenCoord.y = ele->Layout.Rect.y + Layout.ScreenCoord.y
							If (LayoutMode = XUI_LAYOUT_L2R) Or (LayoutMode = XUI_LAYOUT_R2L) Then
								ele->Layout.Rect.w = rs / ar * ele->Layout.w
								ele->Layout.Rect.h = Layout.Rect.h - ele->Layout.RectBox.TopOffset - ele->Layout.RectBox.BottomOffset
								px += ele->Layout.RectBox.LeftOffset + ele->Layout.Rect.w + ele->Layout.RectBox.RightOffset
							EndIf
							If (LayoutMode = XUI_LAYOUT_T2B) Or (LayoutMode = XUI_LAYOUT_B2T) Then
								ele->Layout.Rect.w = Layout.Rect.w - ele->Layout.RectBox.LeftOffset - ele->Layout.RectBox.RightOffset
								ele->Layout.Rect.h = rs / ar * ele->Layout.h
								py += ele->Layout.RectBox.TopOffset + ele->Layout.Rect.h + ele->Layout.RectBox.BottomOffset
							EndIf
						Case XUI_LAYOUT_RULER_COORD
							' ���Ʋ��ֵ�Ԫ�أ������м��� [ǿ�Ƹ�������]
							ele->Layout.ScreenCoord.x = ele->Layout.Rect.x + Layout.ScreenCoord.x
							ele->Layout.ScreenCoord.y = ele->Layout.Rect.y + Layout.ScreenCoord.y
					End Select
				EndIf
				' ����Ԫ��ҲӦ�ò���
				ele->LayoutApply()
			Next
		EndIf
		NeedRedraw = -1
	End Sub
	
	' ����Ԫ��
	Sub Element.Draw(sf As xge.Surface Ptr = NULL, px As Integer = 0, py As Integer = 0) XGE_EXPORT_OBJ
		DrawBuffer->Clear()
		If ClassEvent.OnDraw Then
			ClassEvent.OnDraw(@This)
		EndIf
		If ClassEvent.OnUserDraw Then
			ClassEvent.OnUserDraw(@This)
		EndIf
		' ������Ԫ��
		Dim c As Integer = Childs.StructCount
		For i As Integer = 1 To c
			Dim ele As xui.Element Ptr
			ele = *Cast(xui.Element Ptr Ptr, Childs.GetPtrStruct(i))
			If ele->Visible Then
				ele->Draw(DrawBuffer, 0, 0)
			EndIf
		Next
		' ����ģʽ���ο���
		If DrawRange Then
			DrawDebug()
		EndIf
		' ����������
		DrawBuffer->Draw(sf, px + Layout.Rect.x, py + Layout.Rect.y)
	End Sub
	
	' ����Ԫ�صĲο���
	Sub Element.DrawDebug() XGE_EXPORT_OBJ
		If DrawBuffer Then
			xge.shape.Rect(DrawBuffer, 0, 0, Layout.Rect.w - 1, Layout.Rect.h - 1, &HFF00FF00)
			xge.Text.DrawRectA(DrawBuffer, 0, 0, Layout.Rect.w - 1, Layout.Rect.h - 1, Identifier, 0, &HFF00FF00)
		EndIf
	End Sub
	
	' ��Ϣ������
	Function Element.EventLink(msg As Integer, param As Integer, eve As xge_event Ptr) As Integer XGE_EXPORT_OBJ
		' �����ӿؼ�����Ϣ
		Dim HotLoss As Integer = FALSE
		Dim c As Integer = Childs.StructCount
		For i As Integer = 1 To c
			Dim ele As xui.Element Ptr
			ele = *Cast(xui.Element Ptr Ptr, Childs.GetPtrStruct(i))
			If ele->Visible Then
				' ӳ���������
				Dim uieve As XGE_EVENT = *eve
				uieve.x = uieve.x - ele->Layout.Rect.x
				uieve.y = uieve.y - ele->Layout.Rect.y
				' �ж�����Ƿ���Ԫ����
				If (uieve.x >= 0) And (uieve.y >= 0) Then
					If (uieve.x < ele->Layout.Rect.w) And (uieve.y < ele->Layout.Rect.h) Then
						' ת���¼����ӿؼ�
						HotLoss = TRUE
						If ele->EventLink(msg, param, @uieve) Then
							Return -1
						EndIf
					EndIf
				EndIf
			EndIf
		Next
		' ����ؼ��������Ϣ
		Select Case msg
			Case XGE_MSG_MOUSE_MOVE			' ����ƶ�
				' ����µ�Ԫ�ؽ���Ϊ�ȵ�Ԫ��
				If (HotLoss = FALSE) And (xge_xui_element_hot <> @This) Then
					If xge_xui_element_hot Then
						If xge_xui_element_hot->ClassEvent.OnMouseLeave Then
							xge_xui_element_hot->ClassEvent.OnMouseLeave(xge_xui_element_hot)
						EndIf
					EndIf
					xge_xui_element_hot = @This
					If ClassEvent.OnMouseEnter Then
						ClassEvent.OnMouseEnter(@This)
					EndIf
				EndIf
				' �����ƶ��¼�
				If ClassEvent.OnMouseMove Then
					Return ClassEvent.OnMouseMove(@This, eve->x, eve->y)
				EndIf
			Case XGE_MSG_MOUSE_DOWN			' ��갴��
				If ClassEvent.OnMouseDown Then
					' ������ر��¼���Ԫ�ز��Ǳ������Ԫ�أ���ȡ��Ԫ�ؼ���״̬
					Dim RetInt As Integer = ClassEvent.OnMouseDown(@This, eve->x, eve->y, eve->button)
					If RetInt Then
						If xge_xui_element_active <> @This Then
							xui.ActiveElement(NULL)
						EndIf
					EndIf
					Return RetInt
				EndIf
			Case XGE_MSG_MOUSE_UP			' ��굯��
				If ClassEvent.OnMouseUp Then
					Return ClassEvent.OnMouseUp(@This, eve->x, eve->y, eve->button)
				EndIf
			Case XGE_MSG_MOUSE_CLICK		' ��굥��
				If ClassEvent.OnMouseClick Then
					Return ClassEvent.OnMouseClick(@This, eve->x, eve->y, eve->button)
				EndIf
			Case XGE_MSG_MOUSE_DCLICK		' ���˫��
				If ClassEvent.OnMouseDoubleClick Then
					Return ClassEvent.OnMouseDoubleClick(@This, eve->x, eve->y, eve->button)
				EndIf
		End Select
		Return 0
	End Function
	
	
	
End Namespace



End Extern


