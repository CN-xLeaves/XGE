'==================================================================================
	'★ 程序主文件
	'#-------------------------------------------------------------------------------
	'# 功能 : 协调 XGE 引擎与开发框架构成一个整体
	'# 说明 : 尽量不要直接改动此文件 , 避免打乱框架开发结构
'==================================================================================

#LibPath "Lib"


#Define XGE_USE_XPK				' 使用 xywhPackL 文件包
'#Define XGE_USE_XPF				' 使用 xywh Point Font 点阵字体
#Define XGE_USE_SFM				' 使用 Surface 管理器
'#Define XGE_USE_SOM				' 使用 Sound 管理器
'#Define XGE_USE_GUI				' 使用 xywhFastGameUI 游戏UI系统 [GUI系统目前没完成]
#Define XGE_USE_GDI				' 使用 GDI 图层支持
#Define XGE_USE_DDS				' 使用 动态文字绘制库

#Define Use_xywhFSO				' 使用 xywh File System Object 操作文件
#Define Use_xywhSDK				' 使用 xywhSDK


#Ifdef Use_xywhFSO
	#Include "Inc\SDK\File.bi"
#EndIf
#Ifdef Use_xywhSDK
	#Include "Inc\SDK\xywhSDK.bi"
#EndIf

#Include "Inc\XGE\xywhGameEngine.bi"
#Include "GameProj.bi"
