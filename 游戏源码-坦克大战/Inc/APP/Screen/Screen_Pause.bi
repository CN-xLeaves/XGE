'==================================================================================
	'★ Logo 等待响应场景
	'#-------------------------------------------------------------------------------
	'# 功能 : 场景启动后显示一副图片 , 等用户按下键盘任意键后返回
	'# 说明 : Surface 以 Param 方式传入 , 场景结束后 Surface 会被自动释放
	'# 返回 : 异常跳出返回 0 [包括用户关闭了窗口] , 正常执行完毕返回 -1
'==================================================================================



Function PauseScreen(ByVal message As Integer,ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Static As Integer LogoX,LogoY
	Static sf As Surface
	Select Case message
		Case xge_msg_key_dowm			' 键盘按下
			xge.Stop(-1)
		Case xge_msg_loadres			' 加载资源
			sf = Cast(Any Ptr,Param)
			If sf Then
				Dim As Integer LogoX,LogoY
				LogoX = (640 - sf->Width) \ 2
				LogoY = (480 - sf->Height) \ 2
				xge.Clear
				Put (LogoX,LogoY),sf,Trans
			Else
				xge.Stop(0)
			EndIf
		Case xge_msg_close				' 窗口关闭
			Return -1
	End Select
End Function