'==================================================================================
	'�� Logo �ȴ���Ӧ����
	'#-------------------------------------------------------------------------------
	'# ���� : ������������ʾһ��ͼƬ , ���û����¼���������󷵻�
	'# ˵�� : Surface �� Param ��ʽ���� , ���������� Surface �ᱻ�Զ��ͷ�
	'# ���� : �쳣�������� 0 [�����û��ر��˴���] , ����ִ����Ϸ��� -1
'==================================================================================



Sub RetMenu_OnClick(ele As Any Ptr, btn As Integer)
	xge.Scene.Stop()
End Sub

' Scene function
Function PauseScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui
	Static As xui.Button Ptr Btn_RetMenu
	Static img As xge.Surface Ptr
	Static As Integer LogoX, LogoY
	Select Case msg
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			img->Draw_Trans(NULL, 0, 0)
			ui->Draw(NULL)
		Case XGE_MSG_LOADRES			' load resources
			img = Cast(Any Ptr, param)
			If img Then
				LogoX = (640 - img->Width) \ 2
				LogoY = (480 - img->Height) \ 2
			Else
				xge.Scene.Stop()
			EndIf
			' ����UI��ť
			ui = xui.GetRootElement()
			Btn_RetMenu  = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 360, 160, 40, !"�������˵�\n(Return Menu)")
			Btn_RetMenu->TextFont  = 2
			Btn_RetMenu->Event.OnClick  = Cast(Any Ptr, @RetMenu_OnClick)
			ui->Childs.AddElement(Btn_RetMenu)
			xui.LayoutApply()
		Case XGE_MSG_FREERES			' unload resources
			xui.FreeChilds(ui)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function
