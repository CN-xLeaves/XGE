'==================================================================================
	'★ 游戏流程控制器
	'#-------------------------------------------------------------------------------
	'# 功能 : 负责控制游戏流程和场景切换 , 游戏的第一个场景在这里启动
	'# 说明 : 
'==================================================================================


If AppInit() Then
	' 加载游戏资源
	sfm.LoadPackAll(NULL)
	som.LoadPackAll(NULL,5)
	' 启动 Logo 场景
	If xge.Start(@LogoScreen,sfm.Get(1)) Then
		' 启动 Start 场景
		If xge.Start(@PauseScreen,sfm.Get(2)) Then
			' 场景切换处理
			Do
				Select Case xge.Start(@GameScreen)
					Case 0		' 意外退出
						Exit Do
					Case 1		' 通关
						If Module.ScreenAddr >= Module.ScreenCount Then
							xge.Start(@PauseScreen,sfm.Get(3))
						Else
							Module.ScreenAddr += 1
							xge.Start(@GameScreen)
							Exit Do
						EndIf
					Case 2		' 游戏结束
						xge.Start(@PauseScreen,sfm.Get(4))
						Exit Do
				End Select
			Loop
		EndIf
	EndIf
	' 释放游戏资源
	sfm.FreeAll()
EndIf
AppUint()