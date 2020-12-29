'==================================================================================
	'★ 游戏流程控制器
	'#-------------------------------------------------------------------------------
	'# 功能 : 负责控制游戏流程和场景切换 , 游戏的第一个场景在这里启动
	'# 说明 : 
'==================================================================================



' 加载全局资源
Function LoadRes() As Integer
	ResPath = ExePath() & "\Res\"
	img_Logo = New xge.Surface(ResPath & "Logo.bmp", 0)
	img_MapTile = New xge.Surface(ResPath & "map.bmp", 0)
	img_Boom = New xge.Surface(ResPath & "boom.bmp", 0)
	img_Tank1 = New xge.Surface(ResPath & "tank01.bmp", 0)
	img_Tank2 = New xge.Surface(ResPath & "tank02.bmp", 0)
	img_Tank3 = New xge.Surface(ResPath & "tank03.bmp", 0)
	img_Tank4 = New xge.Surface(ResPath & "tank04.bmp", 0)
	img_BackImage = New xge.Surface(ResPath & Module.BackImage, 0)
	img_PassImage = New xge.Surface(ResPath & "Pass.bmp", 0)
	img_EndImage = New xge.Surface(ResPath & "End.bmp", 0)
	
	se_Boom = New xge.Sound(XGE_SOUND_SAMPLE, 0, ResPath & "boom.ogg", 0)
	se_Fire = New xge.Sound(XGE_SOUND_SAMPLE, 0, ResPath & "fire.ogg", 0)
	
	xge.Text.LoadFont(ResPath & "simsun_12px_gb2312.xrf", 0)
	xge.Text.LoadFont(ResPath & "simsun_16px_gb2312.xrf", 0)
	
	' 载入设置
	ViewHP = xIni.GetInt(ExePath & "\setup.ini", "option", "ViewHP")
	ViewLevel = xIni.GetInt(ExePath & "\setup.ini", "option", "ViewLevel")
	ViewHP_Value = xIni.GetInt(ExePath & "\setup.ini", "option", "ViewHP_Value")
	CheatMode = xIni.GetInt(ExePath & "\setup.ini", "option", "CheatMode")
	
	Return -1
End Function



' 释放全局资源
Sub FreeRes()
	Delete img_Logo
	Delete img_MapTile
	Delete img_Boom
	Delete img_Tank1
	Delete img_Tank2
	Delete img_Tank3
	Delete img_Tank4
	Delete img_BackImage
	Delete img_PassImage
	Delete img_EndImage
	
	Delete se_Boom
	Delete se_Fire
	
	xge.Text.RemoveFont(2)
	xge.Text.RemoveFont(1)
End Sub



' 初始化应用
Function AppInit() As Integer
	' 加载Module设置
	If InitModuleSystem() = FALSE Then
		MessageBox(0, "游戏模组载入失败！", "xTank", MB_ICONERROR)
		Return 0
	EndIf
	' 初始化XGE游戏引擎
	If xge.Init(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, @Module.Title) = FALSE Then
		MessageBox(0, "xywh Game Engine 初始化失败！", "xTank", MB_ICONERROR)
		Return 0
	EndIf
	' 加载游戏资源
	If LoadRes() = FALSE Then
		MessageBox(0, "游戏资源加载失败，请确保游戏客户端完整！", "xTank", MB_ICONERROR)
		Return 0
	EndIf
	If Command(1) = "-e" Then
		' 地图编辑器模式启动
		MapPath = Command(2)
		xge.Scene.Cut(@MapEditScene, 40)
	Else
		' 游戏模式启动
		xge.Scene.Cut(@LogoScene, 40, FALSE, Cast(Integer, img_Logo))
		xge.Scene.Cut(@MenuScene, 40, FALSE, Cast(Integer, img_BackImage))
	EndIf
End Function



' 释放应用资源
Sub AppUint()
	FreeRes()
	xge.Unit()
End Sub
