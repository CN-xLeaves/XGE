
Namespace Module
	Dim Path As ZString * MAX_PATH					' Module 路径
	Dim File As ZString * MAX_PATH					' Module 配置文件
	Dim Title As ZString * 60						' 窗口标题
	Dim BackImage As ZString * MAX_PATH				' 背景图片 (留空则使用默认的背景图)
	Dim MapCount As Integer							' 地图数量
	Dim ExpMul As Integer							' 经验倍数 [100为1倍]
	Dim StartLevel As Integer						' 初始等级
	Dim TankModel As Integer						' 玩家坦克类型
	Dim SpawnTime As Integer						' AI坦克刷新速度
	Dim AddHPTime As Integer						' 血量恢复速度
	
	' 运行时数据
	Dim CurMapID As Integer							' 当前地图编号
End Namespace



Function InitModuleSystem() As Integer
	Module.Path = ExePath() & "\Moudle\" & *xIni.GetStr(ExePath & "\setup.ini", "option", "Module") & "\"
	Module.File = Module.Path & "moudle.ini"
	If xFile.Exists(@Module.File) Then
		Module.Title = *xIni.GetStr(@Module.File, "option", "Title")
		Module.BackImage = *xIni.GetStr(@Module.File, "option", "BackImage")
		Module.MapCount = xIni.GetInt(@Module.File, "option", "MapCount")
		Module.ExpMul = xIni.GetInt(@Module.File, "option", "ExpMul")
		Module.StartLevel = xIni.GetInt(@Module.File, "option", "StartLevel")
		Module.TankModel = xIni.GetInt(@Module.File, "option", "TankModel")
		Module.SpawnTime = xIni.GetInt(@Module.File, "option", "SpawnTime")
		Module.AddHPTime = xIni.GetInt(@Module.File, "option", "AddHPTime")
		If Module.BackImage = "" Then
			Module.BackImage = "back.bmp"
		EndIf
		If Module.SpawnTime < 2000 Then
			Module.SpawnTime = 2000
		EndIf
		If Module.AddHPTime < 5000 Then
			Module.AddHPTime = 5000
		EndIf
	Else
		Return FALSE
	EndIf
	Return TRUE
End Function
