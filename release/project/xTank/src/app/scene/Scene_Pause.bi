'==================================================================================
	'★ Logo 等待响应场景
	'#-------------------------------------------------------------------------------
	'# 功能 : 场景启动后显示一副图片 , 等用户按下键盘任意键后返回
	'# 说明 : Surface 以 Param 方式传入 , 场景结束后 Surface 会被自动释放
	'# 返回 : 异常跳出返回 0 [包括用户关闭了窗口] , 正常执行完毕返回 -1
'==================================================================================



' Scene function
Function PauseScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Select Case msg
		Case XGE_MSG_KEY_DOWN			' keyboard down
			xge.Scene.Stop()
		Case XGE_MSG_LOADRES			' load resources
			Dim img As xge.Surface Ptr = Cast(Any Ptr, param)
			If img Then
				Dim As Integer LogoX, LogoY
				LogoX = (640 - img->Width) \ 2
				LogoY = (480 - img->Height) \ 2
				xge.Clear
				img->Draw_Trans(LogoX, LogoY)
			Else
				xge.Scene.Stop()
			EndIf
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function
