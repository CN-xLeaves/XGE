


' -------------------------- 编译开关定义
#Define XGE_BUILD_USEOOP



' -------------------------- 源码状态 [不会引用lib]
#Define XGE_SOURCE_NOLIB



' -------------------------- 构建环境
#Define XGE_SOURCE_BUILD



' -------------------------- 函数导出开关
#Define XGE_EXPORT_OBJ Export
#Define XGE_EXPORT_SDK
#Define XGE_EXPORT_ALL Export
#Define XGE_EXPORT_LIB Export



' -------------------------- 函数命名表
#Define XGE_EXPORT_Init					Init
#Define XGE_EXPORT_Unit					Unit
#Define XGE_EXPORT_SetScreen			SetScreen
#Define XGE_EXPORT_hWnd					hWnd
#Define XGE_EXPORT_Clear				Clear
#Define XGE_EXPORT_Lock					Lock
#Define XGE_EXPORT_UnLock				UnLock
#Define XGE_EXPORT_Sync					Sync
#Define XGE_EXPORT_Width				Width
#Define XGE_EXPORT_Height				Height
#Define XGE_EXPORT_PixAddr				PixAddr
#Define XGE_EXPORT_PixSize				PixSize
#Define XGE_EXPORT_Pitch				Pitch
#Define XGE_EXPORT_Driver				Driver
#Define XGE_EXPORT_SetSoundVol			SetSoundVol
#Define XGE_EXPORT_GetSoundVol			GetSoundVol
#Define XGE_EXPORT_Ver					Ver

#Define XGE_EXPORT_Scene_Start			Start
#Define XGE_EXPORT_Scene_Cut			Cut
#Define XGE_EXPORT_Scene_Stop			Stop
#Define XGE_EXPORT_Scene_StopAll		StopAll
#Define XGE_EXPORT_Scene_Pause			Pause
#Define XGE_EXPORT_Scene_State			State
#Define XGE_EXPORT_Scene_Resume			Resume
#Define XGE_EXPORT_Scene_FPS			FPS
#Define XGE_EXPORT_Scene_Stack			Stack

#Define XGE_EXPORT_Hook_SetDelayProc	SetDelayProc
#Define XGE_EXPORT_Hook_SetEventProc	SetEventProc
#Define XGE_EXPORT_Hook_SetSceneProc	SetSceneProc
#Define XGE_EXPORT_Hook_SetBLoadProc	SetImageLoadProc
#Define XGE_EXPORT_Hook_SetFLoadProc	SetFontLoadProc

#Define XGE_EXPORT_Aux_ScreenShot		ScreenShot
#Define XGE_EXPORT_Aux_GetPixel			GetPixel
#Define XGE_EXPORT_Aux_RGB2BGR			RGB2BGR
#Define XGE_EXPORT_Aux_SetTitle			SetTitle
#Define XGE_EXPORT_Aux_SetView			SetView
#Define XGE_EXPORT_Aux_ReSetView		ReSetView
#Define XGE_EXPORT_Aux_SetCoodr			SetCoodr
#Define XGE_EXPORT_Aux_ReSetCoodr		ReSetCoodr
#Define XGE_EXPORT_Aux_MapCoodr			MapCoodr
#Define XGE_EXPORT_Aux_LockMouse		LockMouse
#Define XGE_EXPORT_Aux_UnLockMouse		UnLockMouse
#Define XGE_EXPORT_Aux_HideCursor		HideCursor
#Define XGE_EXPORT_Aux_ShowCursor		ShowCursor

#Define XGE_EXPORT_Input_KeyStatus		KeyStatus
#Define XGE_EXPORT_Input_MouseStatus	MouseStatus
#Define XGE_EXPORT_Input_JoyStatus		JoyStatus
#Define XGE_EXPORT_Input_GetMousePos	GetMousePos
#Define XGE_EXPORT_Input_SetMousePos	SetMousePos
#Define XGE_EXPORT_Input_GetMouseX		GetMouseX
#Define XGE_EXPORT_Input_GetMouseY		GetMouseY
#Define XGE_EXPORT_Input_GetMouseBtn	GetMouseBtn
#Define XGE_EXPORT_Input_GetMouseBtnL	GetMouseBtnL
#Define XGE_EXPORT_Input_GetMouseBtnR	GetMouseBtnR
#Define XGE_EXPORT_Input_GetMouseBtnM	GetMouseBtnM
#Define XGE_EXPORT_Input_GetMouseWhell	GetMouseWhell

#Define XGE_EXPORT_Shape_Pixel			Pixel
#Define XGE_EXPORT_Shape_Lines			Lines
#Define XGE_EXPORT_Shape_LinesEx		LinesEx
#Define XGE_EXPORT_Shape_Rect			Rect
#Define XGE_EXPORT_Shape_RectEx			RectEx
#Define XGE_EXPORT_Shape_RectFull		RectFull
#Define XGE_EXPORT_Shape_Circ			Circ
#Define XGE_EXPORT_Shape_CircFull		CircFull
#Define XGE_EXPORT_Shape_CircEx			CircEx
#Define XGE_EXPORT_Shape_CircFullEx		CircFullEx
#Define XGE_EXPORT_Shape_CircArc		CircArc
#Define XGE_EXPORT_Shape_Full			Full
#Define XGE_EXPORT_Shape_FullEx			FullEx



' -------------------------- 函数映射表
#Define XGE_PROC_Scene_StopAll			xge.Scene.StopAll
#Define XGE_PROC_DDT_Init				xge.ddt.Init
#Define XGE_PROC_hWnd					xge.hWnd
#Define XGE_PROC_PixAddr				xge.PixAddr
#Define XGE_PROC_PixSize				xge.PixSize





' 环境初始化 头文件
#Include "Src\xge_setup.bi"


' XGE 头文件
#Include "Src\xge_oop.bi"


' 基础 SDK 引用
#Include "Src\LIB\File.bi"
#Include "Src\Lib\ini.bi"
#Include "Src\LIB\Charset.bi"
#Include "Src\LIB\xStack.bi"
#Include "Src\LIB\Bass.bi"
#Include "Src\LIB\Iocp.bi"
#Include "Src\Lib\xBsmm.bi"
#Include "Src\Lib\Split.bi"


' xywh Game Engine 引擎核心配置
#Include "Src\Core\xge_config.bi"
#Include "Src\Core\xge_define.bi"


' xywh Game Engine 引擎基础功能
#Include "Src\Base\xge_base.bi"
#Include "Src\Base\xge_scene.bi"
#Include "Src\Base\xge_hook.bi"
#Include "Src\Base\xge_surface.bi"
#Include "Src\Base\xge_aux.bi"
#Include "Src\Base\xge_input.bi"
#Include "Src\Base\xge_shape.bi"
#Include "Src\Base\xge_Text.bi"


' xywh Game Engine 扩展库
#Include "Src\Ext\xge_gdi.bi"
#Include "Src\Ext\xge_sound.bi"
#Include "Src\Ext\xge_xSock.bi"
#Include "Src\Ext\xge_xSock_UDP.bi"
'#Include "Src\Ext\xge_ddt.bi"
'#Include "Src\Ext\xge_renderobj.bi"


' xywh Game Engine 界面库
#Include "Src\gui\xge_xui_System.bi"
#Include "Src\gui\xge_xui_Element.bi"
#Include "Src\gui\xge_xui_Button.bi"









' 初始化
#If __FB_OUT_EXE__
	
	xge_Library_Init(GetModuleHandle(NULL))
	
	/' EXE 测试代码 开始 '/
	
	#Include "Src\xge_test.bi"
	xge_test_init()
	xge_test_oop()
	xge_test_unit()
	
	/' EXE 测试代码 结束 '/
	
	xge_Library_Unit()
	
#ElseIf __FB_OUT_DLL__
	
	Function DllMain Alias "DllMain" (hinstDLL As HINSTANCE, fdwReason As DWORD, lpvReserved As LPVOID) As BOOL
		Select Case fdwReason
			Case DLL_PROCESS_ATTACH
				xge_Library_Init(hinstDLL)
			Case DLL_PROCESS_DETACH
				xge_Library_Unit()
			Case DLL_THREAD_ATTACH
				
			Case DLL_THREAD_DETACH
				
		End Select
		Return 1
	End Function
	
#ElseIf __FB_OUT_LIB__
	
	/' Library 编译模式下需要调用 xge_Library_Init 和 xge_Library_Unit 初始化环境 '/
	
#EndIf
