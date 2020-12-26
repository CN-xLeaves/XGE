
Type ModuleInfo
	' Module 设置内容 [字段:116Byte]
	Title As ZString * 60							' Module 窗口标题
	Player(3) As Integer							' 玩家坦克类型
	PlayerCount As Integer						' 支持最大玩家数量[1-3]
	PlayerLV As Integer								' 玩家初始等级
	ExpMul As Integer									' 经验倍数
	ViewHP As Integer									' 显示选项
	ViewLevel As Integer
	ViewValueHP As Integer
	GoodsCount1 As Integer						' 物品数量
	GoodsCount2 As Integer
	GoodsCount3 As Integer
	GoodsCount4 As Integer
	ScreenCount As Integer						' 地图数量
	' 隐藏选项 [字段:12Byte]
	SpeedNewAI As Integer							' AI坦克刷新速度
	TimeAddHP As Integer							' 坦克血量恢复速度
	GodMod As Integer									' 作弊开关
	' 其他数据
	ModuleType As Integer							' Module类型 [0=ini、1=xpk]
	ModulePath As ZString * 260
	' 运行时数据
	ScreenAddr As Integer							' 当前地图
End Type
Dim Shared Module As ModuleInfo


Sub LoadModule_ToIni()
	' 载入Module选项
	Module.Title = *rtl.IniFile.GetStr(Module.ModulePath & ".ini","xywhsoft","Title")
	Module.Title &= "[测试]"
	Module.Player(0) = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","Player1")
	Module.Player(1) = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","Player2")
	Module.Player(2) = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","Player3")
	Module.Player(3) = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","Player4")
	Module.PlayerLV = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","PlayerLV")
	Module.ExpMul = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","ExpMul")
	Module.ViewHP = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","ViewHP")
	Module.ViewLevel = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","ViewLevel")
	Module.ViewValueHP = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","ViewValueHP")
	Module.GoodsCount1 = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","GoodsCount1")
	Module.GoodsCount2 = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","GoodsCount2")
	Module.GoodsCount3 = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","GoodsCount3")
	Module.GoodsCount4 = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","GoodsCount4")
	Module.ScreenCount = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","ScreenCount")
	' 载入隐藏选项
	Module.SpeedNewAI = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","SpeedNewAI")
	Module.TimeAddHP = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","TimeAddHP")
	Module.GodMod = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","GodMod")
	If Module.SpeedNewAI = 0 Then Module.SpeedNewAI = 2000
	If Module.TimeAddHP = 0 Then Module.TimeAddHP = 5000
End Sub

Sub LoadModule_ToXPK()
	
End Sub

Sub AutoLoadModule(ByVal ModuleFile As ZString Ptr)
	Module.ModulePath = ExePath & "\Data\Moudle\" & *ModuleFile
	Module.ScreenAddr = 1
	If FileExists(Module.ModulePath & ".xpk") Then
		Module.ModulePath &= ".xpk"
		Module.ModuleType = 1
		LoadModule_ToXPK()
	ElseIf FileExists(Module.ModulePath & ".ini") Then
		Module.ModuleType = 0
		LoadModule_ToIni()
		Module.ModulePath &= "\"
	Else
		MessageBox(xge.hWnd,"Module 载入失败！","Error :",MB_ICONERROR)
	EndIf
End Sub