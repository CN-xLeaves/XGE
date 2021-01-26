


' ������� - ���뷨��Ϣ
Sub xui_class_LineEdit_OnInput(iMsg As Integer, himc As HIMC, sText As WString Ptr, iSize As UInteger, CurPos As Integer, ele As xui.LineEdit Ptr)
	Select Case iMsg
		Case XUI_IME_CHAR
			' δ�����뷨���ַ� (ͨ��)
			If CurPos = 9 Then
				If ele->Event.OnTab = NULL Then
					ele->SetSelText(sText, iSize)
				EndIf
			ElseIf CurPos > 31 Then
				ele->SetSelText(sText, iSize)
			EndIf
		Case XUI_IME_INPUT
			' ��������
			ele->SetSelText(sText, iSize)
		Case XUI_IME_COMPTEXT
			' ����ı�
			ele->private_compstr = sText
			ele->private_comppos = CurPos
		Case XUI_IME_STARTCOMPOSITION
			' ��ʼ���� [����ѡ�ʴ���������괦]
			Dim cand As CANDIDATEFORM
			cand.dwIndex = 0
			cand.dwStyle = CFS_CANDIDATEPOS
			cand.ptCurrentPos.x = ele->Layout.ScreenCoord.x + ele->private_Caret.x
			cand.ptCurrentPos.y = ele->Layout.ScreenCoord.y + ele->private_Caret.y + xge.Text.GetFontSize(ele->TextFont)
			ImmSetCandidateWindow(hImc, @cand)
		Case XUI_IME_ENDCOMPOSITION
			' ��������
			ele->private_compstr = NULL
	End Select
End Sub

' ������� - ��ͼ
Sub xui_class_LineEdit_OnDraw(ele As xui.LineEdit Ptr)
	' ������
	xui_DrawBackStyle(ele, @ele->BackStyle)
	' ����������
	If ele->private_Buffer.BufferLenght Then
		If ele->SelSize Then
			' ��ѡ������ [�ֶλ���]
			Dim px As Integer = 0
			Dim RetRect As xge_Rect
			If ele->SelStart > 0 Then
				RetRect = xge.Text.DrawW(ele->DrawBuffer, ele->private_Offset.x, ele->private_Offset.y, ele->private_Buffer.BufferMemory, ele->SelStart, ele->TextColor, ele->TextFont, 0, 0)
				px += RetRect.w
			EndIf
			Dim SelBackWidth As Integer = xge.Text.GetTextWidthW(@ele->private_Buffer.BufferMemory[ele->SelStart], ele->SelSize, ele->TextFont, 0, 0)
			xge.Shape.RectFull(ele->DrawBuffer, ele->private_Offset.x + px, ele->private_Offset.y, (ele->private_Offset.x + px + SelBackWidth) - 1, (ele->private_Offset.y + xge.Text.GetFontSize(ele->TextFont)) - 1, ele->SelBackColor)
			RetRect = xge.Text.DrawW(ele->DrawBuffer, ele->private_Offset.x + px, ele->private_Offset.y, @ele->private_Buffer.BufferMemory[ele->SelStart], ele->SelSize, ele->SelTextColor, ele->TextFont, 0, 0)
			px += RetRect.w
			Dim eLen As Integer = ele->private_Buffer.BufferLenght - (ele->SelStart + ele->SelSize)
			If eLen > 0 Then
				xge.Text.DrawW(ele->DrawBuffer, ele->private_Offset.x + px, ele->private_Offset.y, @ele->private_Buffer.BufferMemory[ele->SelStart + ele->SelSize], eLen, ele->TextColor, ele->TextFont, 0, 0)
			EndIf
		Else
			' ��ѡ������ [ȫ������]
			xge.Text.DrawW(ele->DrawBuffer, ele->private_Offset.x, ele->private_Offset.y, ele->private_Buffer.BufferMemory, 0, ele->TextColor, ele->TextFont, 0, 0)
		EndIf
	EndIf
	' ��IME����䶯
	If ele->private_compstr Then
		Dim BackWidth As Integer = xge.Text.GetTextWidthW(ele->private_compstr, 0, ele->TextFont, 0, 0)
		xge.Shape.RectFull(ele->DrawBuffer, ele->private_Caret.x, ele->private_Offset.y, (ele->private_Caret.x + BackWidth) - 1, (ele->private_Offset.y + xge.Text.GetFontSize(ele->TextFont)) - 1, ele->BackStyle.FillColor)
		Dim RetRect As xge_Rect = xge.Text.DrawW(ele->DrawBuffer, ele->private_Caret.x, ele->private_Caret.y, ele->private_compstr, 0, ele->CompColor, ele->TextFont, 0, 0)
		xge.shape.LinesEx(ele->DrawBuffer, ele->private_Caret.x, (ele->private_Caret.y + RetRect.h) - 1, ele->private_Caret.x + RetRect.w, (ele->private_Caret.y + RetRect.h) - 1, ele->CompColor, &B11110000111100001111000011110000)
		' ��IME�α�
		If xge_xui_element_active = ele Then
			If ele->private_CaretShow Then
				Dim px As UInteger = xge.Text.GetTextWidthW(ele->private_compstr, ele->private_comppos, ele->TextFont, 0, 0)
				xge.Shape.RectFull(ele->DrawBuffer, ele->private_Caret.x + px, ele->private_Caret.y, (ele->private_Caret.x + px + ele->private_Caret.w) - 1, (ele->private_Caret.y + ele->private_Caret.h) - 1, ele->private_CaretColor)
			EndIf
			If GetTickCount() > (ele->private_CaretTick + ele->private_CaretBlink) Then
				ele->private_CaretShow = Not(ele->private_CaretShow)
				ele->private_CaretTick = GetTickCount()
			EndIf
		EndIf
	Else
		' ���α�
		If xge_xui_element_active = ele Then
			If ele->private_CaretShow Then
				xge.Shape.RectFull(ele->DrawBuffer, ele->private_Caret.x, ele->private_Caret.y, (ele->private_Caret.x + ele->private_Caret.w) - 1, (ele->private_Caret.y + ele->private_Caret.h) - 1, ele->private_CaretColor)
			EndIf
			If GetTickCount() > (ele->private_CaretTick + ele->private_CaretBlink) Then
				ele->private_CaretShow = Not(ele->private_CaretShow)
				ele->private_CaretTick = GetTickCount()
			EndIf
		EndIf
	EndIf
End Sub

' ����������� - ��ͼ
Sub xui_class_PassWordEditEdit_OnDraw(ele As xui.LineEdit Ptr)
	' ������
	xui_DrawBackStyle(ele, @ele->BackStyle)
	' ����������
	If ele->private_Buffer.BufferLenght Then
		Dim PassWordBuffer As WString Ptr = Allocate((ele->private_Buffer.BufferLenght + 1) * SizeOf(WString))
		For i As Integer = 0 To ele->private_Buffer.BufferLenght - 1
			PassWordBuffer[i] = ele->PassWordChar
		Next
		PassWordBuffer[ele->private_Buffer.BufferLenght] = 0
		If ele->SelSize Then
			' ��ѡ������ [�ֶλ���]
			Dim px As Integer = 0
			Dim RetRect As xge_Rect
			If ele->SelStart > 0 Then
				RetRect = xge.Text.DrawW(ele->DrawBuffer, ele->private_Offset.x, ele->private_Offset.y, PassWordBuffer, ele->SelStart, ele->TextColor, ele->TextFont, 0, 0)
				px += RetRect.w
			EndIf
			Dim SelBackWidth As Integer = xge.Text.GetTextWidthW(@ele->private_Buffer.BufferMemory[ele->SelStart], ele->SelSize, ele->TextFont, 0, 0)
			xge.Shape.RectFull(ele->DrawBuffer, ele->private_Offset.x + px, ele->private_Offset.y, (ele->private_Offset.x + px + SelBackWidth) - 1, (ele->private_Offset.y + xge.Text.GetFontSize(ele->TextFont)) - 1, ele->SelBackColor)
			RetRect = xge.Text.DrawW(ele->DrawBuffer, ele->private_Offset.x + px, ele->private_Offset.y, @PassWordBuffer[ele->SelStart], ele->SelSize, ele->SelTextColor, ele->TextFont, 0, 0)
			px += RetRect.w
			Dim eLen As Integer = ele->private_Buffer.BufferLenght - (ele->SelStart + ele->SelSize)
			If eLen > 0 Then
				xge.Text.DrawW(ele->DrawBuffer, ele->private_Offset.x + px, ele->private_Offset.y, @PassWordBuffer[ele->SelStart + ele->SelSize], eLen, ele->TextColor, ele->TextFont, 0, 0)
			EndIf
		Else
			' ��ѡ������ [ȫ������]
			xge.Text.DrawW(ele->DrawBuffer, ele->private_Offset.x, ele->private_Offset.y, PassWordBuffer, 0, ele->TextColor, ele->TextFont, 0, 0)
		EndIf
		DeAllocate(PassWordBuffer)
	EndIf
	' ���α�
	If xge_xui_element_active = ele Then
		If ele->private_CaretShow Then
			xge.Shape.RectFull(ele->DrawBuffer, ele->private_Caret.x, ele->private_Caret.y, (ele->private_Caret.x + ele->private_Caret.w) - 1, (ele->private_Caret.y + ele->private_Caret.h) - 1, ele->private_CaretColor)
		EndIf
		If GetTickCount() > (ele->private_CaretTick + ele->private_CaretBlink) Then
			ele->private_CaretShow = Not(ele->private_CaretShow)
			ele->private_CaretTick = GetTickCount()
		EndIf
	EndIf
End Sub

' ������� - ��갴��
Function xui_class_LineEdit_OnMouseDown(ele As xui.LineEdit Ptr, x As Integer, y As Integer, btn As Integer) As Integer
	' ����Ԫ�غ���겶��
	xui.ActiveElement(ele)
	xui.MouseCapture(ele)
	' ������λ��
	If ele->private_Buffer.BufferLenght > 0 Then
		ele->private_CaretPos = xge.Text.WidthToPosW(x - ele->private_Offset.x, ele->private_Buffer.BufferMemory, ele->private_Buffer.BufferLenght, ele->TextFont, 0, 0)
		ele->SetSel(ele->private_CaretPos, 0)
	Else
		ele->SetSel(0, 0)
	EndIf
	' ���������϶����������
	ele->private_DragPos = ele->private_CaretPos
	Return -1
End Function

' ������� - ��굯��
Function xui_class_LineEdit_OnMouseUp(ele As xui.LineEdit Ptr, x As Integer, y As Integer, btn As Integer) As Integer
	xui.MouseCapture(NULL)
	Return -1
End Function

' ������� - ����ƶ�
Function xui_class_LineEdit_OnMouseMove(ele As xui.LineEdit Ptr, x As Integer, y As Integer) As Integer
	If xInput.GetMouseBtnL() Then
		If ele->private_Buffer.BufferLenght > 0 Then
			Dim iPos As UInteger = xge.Text.WidthToPosW(x - ele->private_Offset.x, ele->private_Buffer.BufferMemory, ele->private_Buffer.BufferLenght, ele->TextFont, 0, 0)
			ele->SetSel(ele->private_DragPos, iPos - ele->private_DragPos)
		EndIf
	EndIf
	Return -1
End Function

' ������� - ��굥�� [ռ�ӱ�����Ϣ��͸]
Function xui_class_LineEdit_OnMouseClick(ele As xui.LineEdit Ptr, x As Integer, y As Integer, btn As Integer) As Integer
	Return -1
End Function

' ������� - ���˫�� [ռ�ӱ�����Ϣ��͸]
Function xui_class_LineEdit_OnMouseDoubleClick(ele As xui.LineEdit Ptr, x As Integer, y As Integer, btn As Integer) As Integer
	Return -1
End Function

' ������� - ���뼤��״̬
Sub xui_class_LineEdit_OnGotFocus(ele As xui.LineEdit Ptr)
	' �������뷨
	If ele->EnableIME Then
		xui.EnableIME(@xui_class_LineEdit_OnInput, Cast(Integer, ele))
	Else
		xui.EnableCharInput(@xui_class_LineEdit_OnInput, Cast(Integer, ele))
	EndIf
	If ele->Event.OnGotfocus Then
		ele->Event.OnGotfocus(ele)
	EndIf
End Sub

' ������� - ʧȥ����״̬
Sub xui_class_LineEdit_OnLostFocus(ele As xui.LineEdit Ptr)
	If ele->EnableIME Then
		xui.DisableIME()
	EndIf
	If ele->Event.OnLostfocus Then
		ele->Event.OnLostfocus(ele)
	EndIf
End Sub

' ������� - ���̰��¡��������� [ ���� Back Space��Delete �Ȱ��� ]
Function xui_class_LineEdit_OnKeyDown(ele As xui.LineEdit Ptr, k As Integer, c As Integer) As Integer
	Select Case k
		Case SC_BACKSPACE
			' ��ǰɾ�� [����ɾ��ѡ��]
			If ele->SelSize Then
				ele->Del()
			Else
				If ele->private_CaretPos > 0 Then
					ele->private_Buffer.DeleteText(ele->private_CaretPos - 1, 1)
					ele->SetSel(ele->private_CaretPos - 1, 0)
				EndIf
			EndIf
		Case SC_DELETE
			' ���ɾ�� [����ɾ��ѡ��]
			If ele->SelSize Then
				ele->Del()
			Else
				If ele->private_CaretPos < ele->private_Buffer.BufferLenght Then
					ele->private_Buffer.DeleteText(ele->private_CaretPos, 1)
				EndIf
			EndIf
		Case SC_LEFT
			' �����α�
			If ele->private_CaretPos > 0 Then
				ele->SetSel(ele->private_CaretPos - 1, 0)
			EndIf
		Case SC_RIGHT
			' �����α�
			If ele->private_CaretPos < ele->private_Buffer.BufferLenght Then
				ele->SetSel(ele->private_CaretPos + 1, 0)
			EndIf
		Case SC_HOME
			' �α��ƶ�����ͷ
			ele->SetSel(0, 0)
		Case SC_END
			' �α��ƶ���ĩβ
			ele->SetSel(ele->private_Buffer.BufferLenght, 0)
		Case SC_ENTER
			' Submit
			If ele->Event.OnSubmit Then
				ele->Event.OnSubmit(ele)
			EndIf
		Case SC_TAB
			If ele->Event.OnTab Then
				ele->Event.OnTab(ele)
			EndIf
		Case SC_A
			' ȫѡ
			If xInput.KeyStatus(SC_CONTROL) Then
				ele->SelectAll()
			EndIf
		Case SC_X
			' ����
			If xInput.KeyStatus(SC_CONTROL) Then
				ele->Cut()
			EndIf
		Case SC_C
			' ����
			If xInput.KeyStatus(SC_CONTROL) Then
				ele->Copy()
			EndIf
		Case SC_V
			' ճ��
			If xInput.KeyStatus(SC_CONTROL) Then
				ele->Paste()
			EndIf
	End Select
	Return -1
End Function



Extern XGE_EXTERNCLASS



Namespace xui
	
	
	
	' ������ͨ���б༭Ԫ��
	Function CreateLineEdit(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As WString Ptr, TextFont As UInteger = 1, sIdentifier As WString Ptr = NULL) As xui.LineEdit Ptr XGE_EXPORT_ALL
		Dim ele As xui.LineEdit Ptr = New xui.LineEdit()
		' �������Ը�ֵ
		ele->ClassID = XUI_CLASS_LINEEDIT
		ele->InitElement(iLayoutRuler, x, y, w, h, XUI_LAYOUT_COORD, sIdentifier)
		' �Զ������Ը�ֵ
		ele->TextFont = TextFont
		ele->private_Caret.h = xge.Text.GetFontSize(TextFont)
		ele->Text = sCaption
		Return ele
	End Function
	
	' ���������б༭Ԫ��
	Function CreatePassWordEdit(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As WString Ptr, TextFont As UInteger = 1, sIdentifier As WString Ptr = NULL) As xui.LineEdit Ptr XGE_EXPORT_ALL
		Dim ele As xui.LineEdit Ptr = New xui.LineEdit()
		' �������Ը�ֵ
		ele->ClassID = XUI_CLASS_LINEEDIT
		ele->InitElement(iLayoutRuler, x, y, w, h, XUI_LAYOUT_COORD, sIdentifier)
		' �Զ������Ը�ֵ
		ele->TextFont = TextFont
		ele->private_Caret.h = xge.Text.GetFontSize(TextFont)
		ele->EnableIME = FALSE
		ele->PassWordChar = 42			' 42 = *
		ele->MaxLenght = 256			' ������󳤶ȣ���������ʹ�ù̶�����������
		ele->Text = sCaption
		' ���������
		ele->ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_PassWordEditEdit_OnDraw)
		Return ele
	End Function
	
	
	
	' ���캯��
	Constructor LineEdit() XGE_EXPORT_OBJ
		' �Զ������Ը�ֵ
		TextColor = &HFF000000
		CompColor = &HFF606060
		SelTextColor = &HFFFFFFFF
		SelBackColor = &HFF404040
		BorderWidth = 2
		BackStyle.Hide = FALSE
		BackStyle.Image = NULL
		BackStyle.BorderColor = &HFF0A8ED8
		BackStyle.FillColor = &HFFFFFFFF
		SelStart = 0
		SelSize = 0
		TextAlign = XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE
		EnableIME = TRUE
		PassWordChar = 0
		MaxLenght = 0
		private_ViewX = 0
		private_Offset.x = 4
		private_Offset.y = 4
		private_Caret.x = 4
		private_Caret.y = 4
		private_Caret.w = 2
		private_CaretBlink = 600
		private_CaretColor = &HFF000000
		private_compstr = NULL
		' ���������
		ClassEvent.OnDraw = Cast(Any Ptr, @xui_class_LineEdit_OnDraw)
		ClassEvent.OnMouseDown = Cast(Any Ptr, @xui_class_LineEdit_OnMouseDown)
		ClassEvent.OnMouseUp = Cast(Any Ptr, @xui_class_LineEdit_OnMouseUp)
		ClassEvent.OnMouseMove = Cast(Any Ptr, @xui_class_LineEdit_OnMouseMove)
		ClassEvent.OnMouseClick = Cast(Any Ptr, @xui_class_LineEdit_OnMouseClick)
		ClassEvent.OnMouseDoubleClick = Cast(Any Ptr, @xui_class_LineEdit_OnMouseDoubleClick)
		ClassEvent.OnGotFocus = Cast(Any Ptr, @xui_class_LineEdit_OnGotFocus)
		ClassEvent.OnLostFocus = Cast(Any Ptr, @xui_class_LineEdit_OnLostFocus)
		ClassEvent.OnKeyDown = Cast(Any Ptr, @xui_class_LineEdit_OnKeyDown)
		ClassEvent.OnKeyRepeat = Cast(Any Ptr, @xui_class_LineEdit_OnKeyDown)
		' ������ѡ���б�Ԫ��
		/'
		If xui_global_ime_wordlist = NULL Then
			
		EndIf
		'/
	End Constructor
	
	' �ı�����
	Property LineEdit.Text As WString Ptr XGE_EXPORT_OBJ
		If private_Buffer.BufferMemory Then
			Return private_Buffer.BufferMemory
		Else
			Return Cast(WString Ptr, @xge_global_snull)
		EndIf
	End Property
	Property LineEdit.Text(sText As WString Ptr) XGE_EXPORT_OBJ
		If MaxLenght = 0 Then
			private_Buffer.SetText(sText)
		Else
			Dim iSize As UInteger = wcslen(sText)
			If iSize > MaxLenght Then
				iSize = MaxLenght
			EndIf
			private_Buffer.SetText(sText, iSize)
		EndIf
		If Event.OnChange Then
			Event.OnChange(@This)
		EndIf
	End Property
	
	' �ı�����
	Function LineEdit.TextLenght() As UInteger XGE_EXPORT_OBJ
		Return private_Buffer.BufferLenght
	End Function
	
	' ȫѡ
	Sub LineEdit.SelectAll() XGE_EXPORT_OBJ
		SetSel(0, private_Buffer.BufferLenght)
	End Sub
	
	' ����
	Sub LineEdit.Cut() XGE_EXPORT_OBJ
		If PassWordChar = 0 Then
			Copy()
			Del()
		EndIf
	End Sub
	
	' ����
	Sub LineEdit.Copy() XGE_EXPORT_OBJ
		If PassWordChar = 0 Then
			If SelSize Then
				xClip_SetTextW(@private_Buffer.BufferMemory[SelStart], SelSize)
			EndIf
		EndIf
	End Sub
	
	' ճ��
	Sub LineEdit.Paste() XGE_EXPORT_OBJ
		Dim ClipText As WString Ptr = xClip_GetTextW()
		SetSelText(ClipText, 0)
		DeAllocate(ClipText)
	End Sub
	
	' ɾ��ѡ������
	Sub LineEdit.Del() XGE_EXPORT_OBJ
		private_Buffer.DeleteText(SelStart, SelSize)
		SetSel(SelStart, 0)
	End Sub
	
	' ���õ�ǰѡ�������
	Sub LineEdit.SetSelText(sText As WString Ptr, iSize As UInteger = 0) XGE_EXPORT_OBJ
		If iSize = 0 Then
			iSize = wcslen(sText)
		EndIf
		If MaxLenght Then
			If ((iSize - SelSize) + private_Buffer.BufferLenght) > MaxLenght Then
				iSize = (MaxLenght - private_Buffer.BufferLenght) + SelSize
			EndIf
		EndIf
		If iSize Then
			private_Buffer.InsertText(SelStart, SelSize, sText, iSize)
			SetSel(SelStart + iSize, 0)
			If Event.OnChange Then
				Event.OnChange(@This)
			EndIf
		EndIf
	End Sub
	
	' ��������ѡ��Χ
	Sub LineEdit.SetSel(s As UInteger, l As Integer) XGE_EXPORT_OBJ
		' �����α�״̬
		private_CaretShow = -1
		private_CaretTick = GetTickCount()
		If l < 0 Then
			SelStart = s - Abs(l)
			SelSize = Abs(l)
			private_CaretPos = SelStart
		Else
			SelStart = s
			SelSize = l
			private_CaretPos = SelStart + SelSize
		EndIf
		' ���¼����α��λ��
		If private_CaretPos Then
			private_Caret.x = (private_Offset.x + xge.Text.GetTextWidthW(private_Buffer.BufferMemory, private_CaretPos, TextFont, 0, 0)) - 1
		Else
			private_Caret.x = private_Offset.x
		EndIf
	End Sub
	
	
	
End Namespace



End Extern


