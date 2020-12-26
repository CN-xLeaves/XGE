'==================================================================================
	'★ 游戏初始化模块
	'#-------------------------------------------------------------------------------
	'# 功能 : 游戏从这里开始执行 , 负责初始化等操作 , 游戏卸载也在这里进行
	'# 说明 : 
'==================================================================================

Function AppInit() As Integer
	' 文件包初始化
	If xpk.Open(ExePath & "\Data\Game.xpk",-1) Then
		sfm.Pack = @xpk
		som.Pack = @xpk
		' 加载Module设置
		AutoLoadModule(rtl.IniFile.GetStr(ExePath & "\Data\setup.ini","Tank","LoadModule"))
		' 游戏引擎初始化
		Return xge.Init(16,640,480,xge_window,40,0,@Module.Title)
	EndIf
End Function

Sub AppUint()
	xge.Unit()
End Sub
