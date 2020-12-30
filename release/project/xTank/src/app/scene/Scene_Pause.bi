'==================================================================================
	'★ Logo 等待响应场景
	'#-------------------------------------------------------------------------------
	'# 功能 : 场景启动后显示一副图片 , 等用户按下键盘任意键后返回
	'# 说明 : Surface 以 Param 方式传入 , 场景结束后 Surface 会被自动释放
	'# 返回 : 异常跳出返回 0 [包括用户关闭了窗口] , 正常执行完毕返回 -1
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
			' 创建UI按钮
			ui = xui.GetRootElement()
			Btn_RetMenu  = xui.CreateButton(XUI_LAYOUT_RULER_PIXEL, 240, 360, 160, 40, !"返回主菜单\n(Return Menu)")
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
