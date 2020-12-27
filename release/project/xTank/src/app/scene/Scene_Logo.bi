'==================================================================================
	'★ Logo 淡入淡出显示场景
	'#-------------------------------------------------------------------------------
	'# 功能 : 场景启动后淡入淡出显示一幅图片后结束
	'# 说明 : Surface 以 Param 方式传入 , 场景结束后 Surface 会被自动释放
	'# 返回 : 异常跳出返回 0 [包括用户关闭了窗口] , 正常执行完毕返回 -1
'==================================================================================



' Scene function
Function LogoScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static img As xge.Surface Ptr
	Static As Integer LogoX, LogoY, AlphaValue, IsHide
	Select Case msg
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			If IsHide=0 Then
				AlphaValue += 9
				img->Draw_Alpha2(LogoX, LogoY, AlphaValue)
				If AlphaValue > 250 Then IsHide = -1
			Else
				AlphaValue -= 9
				img->Draw_Alpha2(LogoX, LogoY, AlphaValue)
				If AlphaValue < 5 Then xge.Scene.Stop()
			EndIf
		Case XGE_MSG_LOADRES			' load resources
			img = Cast(Any Ptr, param)
			If img Then
				LogoX = (640 - img->Width) \ 2
				LogoY = (480 - img->Height) \ 2
			Else
				xge.Scene.Stop()
			EndIf
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function
