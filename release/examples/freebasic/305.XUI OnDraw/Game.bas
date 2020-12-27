' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' draw a red dot in the upper right corner of the button
Sub OnUserDraw(ele As xui.Button Ptr)
	xge.Shape.CircFull(ele->Layout.Rect.w - 12, 12, 5, &HFFFF0000, ele->image)
End Sub

' Completely redraw the button, the drawing code of xui.CheckBox is used here
Sub OnDraw(ele As xui.Button Ptr)
	Select Case ele->private_Status
		Case 1
			xge.shape.Rect(2, 2, 18, 18, ele->HotBack.BorderColor, ele->Image)
			xge.shape.Rect(3, 3, 17, 17, ele->HotBack.BorderColor, ele->Image)
			xge.shape.RectFull(4, 4, 16, 16, (ele->HotBack.FillColor And &H00FFFFFF) Or &H40000000, ele->Image)
			xge.Text.DrawRectA(ele->Image, 24 + ele->CaptionOffset.x, ele->CaptionOffset.y, ele->Layout.Rect.w - (24 + ele->CaptionOffset.x), 20, ele->Caption, ele->HotBack.TextColor, ele->CaptionFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
		Case 2
			xge.shape.Rect(2, 2, 18, 18, ele->PressBack.BorderColor, ele->Image)
			xge.shape.Rect(3, 3, 17, 17, ele->PressBack.BorderColor, ele->Image)
			xge.shape.RectFull(4, 4, 16, 16, ele->PressBack.FillColor, ele->Image)
			xge.Text.DrawRectA(ele->Image, 24 + ele->CaptionOffset.x, ele->CaptionOffset.y, ele->Layout.Rect.w - (24 + ele->CaptionOffset.x), 20, ele->Caption, ele->PressBack.TextColor, ele->CaptionFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
		Case Else
			' judging the selected state
			If (ele->Mode <> 0) And (ele->Checked <> 0) Then
				xge.shape.Rect(2, 2, 18, 18, ele->CheckBack.FillColor, ele->Image)
				xge.shape.Rect(3, 3, 17, 17, ele->CheckBack.FillColor, ele->Image)
				xge.shape.RectFull(7, 7, 13, 13, ele->CheckBack.BorderColor, ele->Image)
				xge.Text.DrawRectA(ele->Image, 24 + ele->CaptionOffset.x, ele->CaptionOffset.y, ele->Layout.Rect.w - (24 + ele->CaptionOffset.x), 20, ele->Caption, ele->CheckBack.TextColor, ele->CaptionFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
			Else
				xge.shape.Rect(2, 2, 18, 18, ele->NormalBack.BorderColor, ele->Image)
				xge.shape.Rect(3, 3, 17, 17, ele->NormalBack.BorderColor, ele->Image)
				xge.shape.RectFull(4, 4, 16, 16, (ele->NormalBack.FillColor And &H00FFFFFF) Or &H40000000, ele->Image)
				xge.Text.DrawRectA(ele->Image, 24 + ele->CaptionOffset.x, ele->CaptionOffset.y, ele->Layout.Rect.w - (24 + ele->CaptionOffset.x), 20, ele->Caption, ele->NormalBack.TextColor, ele->CaptionFont, 0, XGE_ALIGN_LEFT Or XGE_ALIGN_MIDDLE)
			EndIf
	End Select
End Sub



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui
	Static As xui.Button Ptr Btn1, Btn2, Btn3
	Static As xge.Surface Ptr backimg
	Select Case msg
		Case XGE_MSG_FRAME				' frame Logic processing
			
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			backimg->Draw(0,0)
			ui->Draw(NULL)
		Case XGE_MSG_MOUSE_MOVE			' mouse move
			
		Case XGE_MSG_MOUSE_DOWN			' mouse down
			
		Case XGE_MSG_MOUSE_UP			' mouse up
			
		Case XGE_MSG_MOUSE_CLICK		' mouse click
			
		Case XGE_MSG_MOUSE_DCLICK		' mouse double click
			
		Case XGE_MSG_MOUSE_WHELL		' mouse whell
			
		Case XGE_MSG_KEY_DOWN			' keyboard down
			
		Case XGE_MSG_KEY_UP				' keyboard up
			
		Case XGE_MSG_KEY_REPEAT			' keyboard hold
			
		Case XGE_MSG_GOTFOCUS			' got focus
			
		Case XGE_MSG_LOSTFOCUS			' lost focus
			
		Case XGE_MSG_MOUSE_ENTER		' mouse enter
			
		Case XGE_MSG_MOUSE_EXIT			' mouse leave
			
		Case XGE_MSG_LOADRES			' load resources
			xge.Text.LoadFont("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)
			ui = xui.GetRootElement()
			Btn1 = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 280, 160, 40, "XUI Button")
			Btn2 = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 340, 160, 40, "OnUserDraw")
			Btn3 = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 400, 160, 40, "Redraw Button")
			ui->Childs.AddElement(Btn1)
			ui->Childs.AddElement(Btn2)
			ui->Childs.AddElement(Btn3)
			xui.LayoutApply()
			backimg = New xge.Surface("..\..\..\res\back.bmp", 0)
			
			' setting enents
			Btn2->ClassEvent.OnUserDraw = Cast(Any Ptr, @OnUserDraw)
			Btn3->ClassEvent.OnDraw = Cast(Any Ptr, @OnDraw)
			
			' change the working mode of button to make them selectable
			Btn3->Mode = 1
			
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - XUI Layout")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
