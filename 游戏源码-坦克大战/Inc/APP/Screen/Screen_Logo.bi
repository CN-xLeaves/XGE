'==================================================================================
	'★ Logo 淡入淡出显示场景
	'#-------------------------------------------------------------------------------
	'# 功能 : 场景启动后淡入淡出显示一幅图片后结束
	'# 说明 : Surface 以 Param 方式传入 , 场景结束后 Surface 会被自动释放
	'# 返回 : 异常跳出返回 0 [包括用户关闭了窗口] , 正常执行完毕返回 -1
'==================================================================================



Function LogoScreen(ByVal message As Integer,ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Static As Integer LogoX,LogoY,AlphaValue,IsHide
	Static sf As Surface
	Select Case message
		Case xge_msg_draw					' 绘图
			xge.Clear()
			If IsHide=0 Then
				AlphaValue += 3
				Put (LogoX,LogoY),sf,Alpha,AlphaValue
				If AlphaValue > 250 Then IsHide = -1
			Else
				AlphaValue -= 3
				Put (LogoX,LogoY),sf,Alpha,AlphaValue
				If AlphaValue < 5 Then xge.Stop(-1)
			EndIf
		Case xge_msg_loadres			' 加载资源
			sf = Cast(Any Ptr,Param)
			If sf Then
				LogoX = (640 - sf->Width) \ 2
				LogoY = (480 - sf->Height) \ 2
			Else
				xge.Stop(0)
			EndIf
		Case xge_msg_close				' 窗口关闭
			Return -1
	End Select
End Function