'==================================================================================
	'★ 框架主文件
	'#-------------------------------------------------------------------------------
	'# 功能 : 引入与管理游戏所有文件 , 公共定义 , 直接负责整个游戏框架
	'# 说明 : 为保证框架开发的可维护性 , 游戏所有文件都应在这里引入
'==================================================================================



' 游戏定义 [游戏所使用的各种定义应放在 Define 目录下 , 并在这里统一引入]
#Include "Inc\APP\Define\Define.bi"


' 公用代码 [游戏多出使用的公用代码应放在 Public 目录下 , 并在这里统一引入]
#Include "Inc\APP\Public\Module.bi"


' 游戏对象类 [游戏对象类的代码应放在 Object 目录下 , 并在这里统一引入]
#Include "Inc\APP\Object\Object_Ammo.bi"
#Include "Inc\APP\Object\Object_Map.bi"
#Include "Inc\APP\Object\Object_Tank.bi"
#Include "Inc\APP\Object\Object_Game.bi"


' 游戏场景 [游戏场景应放在 Screen 目录下 , 并在这里统一引入]
#Include "Inc\APP\Screen\Screen_Logo.bi"
#Include "Inc\APP\Screen\Screen_Pause.bi"
#Include "Inc\APP\Screen\Screen_Game.bi"


' 游戏初始化\流程控制器
#Include "Inc\APP\Init.bi"
#Include "Inc\APP\Game.bi"
