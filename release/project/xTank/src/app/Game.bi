'==================================================================================
	'★ 游戏流程控制器
	'#-------------------------------------------------------------------------------
	'# 功能 : 负责控制游戏流程和场景切换 , 游戏的第一个场景在这里启动
	'# 说明 : 
'==================================================================================



' 加载全局资源
Function LoadRes() As Integer
	Res.AddPack(ExePath() & "\res.xpk")
	Res.CreateIndex()
	
	Res.LoadFont(1)
	Res.LoadFont(2)
	
	img_Logo = Res.LoadPicture(100)
	img_BackImage = Res.LoadPicture(101)
	img_PassImage = Res.LoadPicture(102)
	img_EndImage = Res.LoadPicture(103)
	
	img_Tank1 = Res.LoadPicture(200)
	img_Tank2 = Res.LoadPicture(201)
	img_Tank3 = Res.LoadPicture(202)
	img_Tank4 = Res.LoadPicture(203)
	
	img_Boom = Res.LoadPicture(300)
	img_MapTile = Res.LoadPicture(301)
	
	se_Fire = Res.LoadSample(400)
	se_Boom = Res.LoadSample(401)
	
	' 载入设置
	ViewHP = xIni_GetInt(ExePath & "\setup.ini", "option", "ViewHP")
	ViewLevel = xIni_GetInt(ExePath & "\setup.ini", "option", "ViewLevel")
	ViewHP_Value = xIni_GetInt(ExePath & "\setup.ini", "option", "ViewHP_Value")
	CheatMode = xIni_GetInt(ExePath & "\setup.ini", "option", "CheatMode")
	
	Return -1
End Function



' 释放全局资源
Sub FreeRes()
	Res.FreeAll()
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
	If xge.InitA(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, @Module.Title) = FALSE Then
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
