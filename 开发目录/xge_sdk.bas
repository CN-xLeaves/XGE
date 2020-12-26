


' -------------------------- 编译开关定义
#Define XGE_BUILD_USEAPI



' -------------------------- 源码状态 [不会引用lib]
#Define XGE_SOURCE_NOLIB



' -------------------------- 构建环境
#Define XGE_SOURCE_BUILD



' -------------------------- 导出开关
#Define XGE_EXPORT_OBJ
#Define XGE_EXPORT_SDK Export
#Define XGE_EXPORT_ALL Export
#Define XGE_EXPORT_LIB Export



' -------------------------- 函数命名表
#Define XGE_EXPORT_Init					xge_Init
#Define XGE_EXPORT_Unit					xge_Unit
#Define XGE_EXPORT_SetScreen			xge_SetScreen
#Define XGE_EXPORT_hWnd					xge_hWnd
#Define XGE_EXPORT_Clear				xge_Clear
#Define XGE_EXPORT_Lock					xge_Lock
#Define XGE_EXPORT_UnLock				xge_UnLock
#Define XGE_EXPORT_Sync					xge_Sync
#Define XGE_EXPORT_Width				xge_Width
#Define XGE_EXPORT_Height				xge_Height
#Define XGE_EXPORT_PixAddr				xge_PixAddr
#Define XGE_EXPORT_PixSize				xge_PixSize
#Define XGE_EXPORT_Pitch				xge_Pitch
#Define XGE_EXPORT_Driver				xge_Driver
#Define XGE_EXPORT_SetSoundVol			xge_SetSoundVol
#Define XGE_EXPORT_GetSoundVol			xge_GetSoundVol
#Define XGE_EXPORT_Ver					xge_Ver

#Define XGE_EXPORT_Scene_Start			xge_Scene_Start
#Define XGE_EXPORT_Scene_Cut			xge_Scene_Cut
#Define XGE_EXPORT_Scene_Stop			xge_Scene_Stop
#Define XGE_EXPORT_Scene_StopAll		xge_Scene_StopAll
#Define XGE_EXPORT_Scene_Pause			xge_Scene_Pause
#Define XGE_EXPORT_Scene_State			xge_Scene_State
#Define XGE_EXPORT_Scene_Resume			xge_Scene_Resume
#Define XGE_EXPORT_Scene_FPS			xge_Scene_FPS
#Define XGE_EXPORT_Scene_Stack			xge_Scene_Stack

#Define XGE_EXPORT_Hook_SetDelayProc	xge_Hook_SetDelayProc
#Define XGE_EXPORT_Hook_SetEventProc	xge_Hook_SetEventProc
#Define XGE_EXPORT_Hook_SetSceneProc	xge_Hook_SetSceneProc
#Define XGE_EXPORT_Hook_SetBLoadProc	xge_Hook_SetBLoadProc

#Define XGE_EXPORT_Aux_ScreenShot		xge_Aux_ScreenShot
#Define XGE_EXPORT_Aux_GetPixel			xge_Aux_GetPixel
#Define XGE_EXPORT_Aux_RGB2BGR			xge_Aux_RGB2BGR
#Define XGE_EXPORT_Aux_SetTitle			xge_Aux_SetTitle
#Define XGE_EXPORT_Aux_SetView			xge_Aux_SetView
#Define XGE_EXPORT_Aux_ReSetView		xge_Aux_ReSetView
#Define XGE_EXPORT_Aux_SetCoodr			xge_Aux_SetCoodr
#Define XGE_EXPORT_Aux_ReSetCoodr		xge_Aux_ReSetCoodr
#Define XGE_EXPORT_Aux_MapCoodr			xge_Aux_MapCoodr
#Define XGE_EXPORT_Aux_LockMouse		xge_Aux_LockMouse
#Define XGE_EXPORT_Aux_UnLockMouse		xge_Aux_UnLockMouse
#Define XGE_EXPORT_Aux_HideCursor		xge_Aux_HideCursor
#Define XGE_EXPORT_Aux_ShowCursor		xge_Aux_ShowCursor

#Define XGE_EXPORT_Input_KeyStatus		xge_Input_KeyStatus
#Define XGE_EXPORT_Input_MouseStatus	xge_Input_MouseStatus
#Define XGE_EXPORT_Input_JoyStatus		xge_Input_JoyStatus
#Define XGE_EXPORT_Input_GetMousePos	xge_Input_GetMousePos
#Define XGE_EXPORT_Input_SetMousePos	xge_Input_SetMousePos
#Define XGE_EXPORT_Input_GetMouseX		xge_Input_GetMouseX
#Define XGE_EXPORT_Input_GetMouseY		xge_Input_GetMouseY
#Define XGE_EXPORT_Input_GetMouseBtn	xge_Input_GetMouseBtn
#Define XGE_EXPORT_Input_GetMouseBtnL	xge_Input_GetMouseBtnL
#Define XGE_EXPORT_Input_GetMouseBtnR	xge_Input_GetMouseBtnR
#Define XGE_EXPORT_Input_GetMouseBtnM	xge_Input_GetMouseBtnM
#Define XGE_EXPORT_Input_GetMouseWhell	xge_Input_GetMouseWhell

#Define XGE_EXPORT_Shape_Pixel			xge_Shape_Pixel
#Define XGE_EXPORT_Shape_Lines			xge_Shape_Lines
#Define XGE_EXPORT_Shape_LinesEx		xge_Shape_LinesEx
#Define XGE_EXPORT_Shape_Rect			xge_Shape_Rect
#Define XGE_EXPORT_Shape_RectEx			xge_Shape_RectEx
#Define XGE_EXPORT_Shape_RectFull		xge_Shape_RectFull
#Define XGE_EXPORT_Shape_Circ			xge_Shape_Circ
#Define XGE_EXPORT_Shape_CircFull		xge_Shape_CircFull
#Define XGE_EXPORT_Shape_CircEx			xge_Shape_CircEx
#Define XGE_EXPORT_Shape_CircFullEx		xge_Shape_CircFullEx
#Define XGE_EXPORT_Shape_CircArc		xge_Shape_CircArc
#Define XGE_EXPORT_Shape_Full			xge_Shape_Full
#Define XGE_EXPORT_Shape_FullEx			xge_Shape_FullEx

#Define XGE_EXPORT_DDT_Init				xge_ddt_Init
#Define XGE_EXPORT_DDT_Draw1			xge_ddt_Draw1
#Define XGE_EXPORT_DDT_Draw2			xge_ddt_Draw2
#Define XGE_EXPORT_DDT_Draw3			xge_ddt_Draw3
#Define XGE_EXPORT_DDT_Draw4			xge_ddt_Draw4




' -------------------------- 函数映射表
#Define XGE_PROC_Scene_StopAll			xge_Scene_StopAll
#Define XGE_PROC_DDT_Init				xge_ddt_Init
#Define XGE_PROC_hWnd					xge_hWnd
#Define XGE_PROC_PixAddr				xge_PixAddr
#Define XGE_PROC_PixSize				xge_PixSize






' 环境初始化 头文件
#Include "Src\xge_setup.bi"


' XGE 头文件
#Include "Src\xge_api.bi"


' 基础 SDK 引用
#Include "Src\LIB\File.bi"
#Include "Src\LIB\Charset.bi"
#Include "Src\LIB\xStack.bi"
#Include "Src\LIB\Bass.bi"
#Include "Src\LIB\Iocp.bi"


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


' xywh Game Engine 扩展库
#Include "Src\Ext\xge_gdi.bi"
#Include "Src\Ext\xge_sound.bi"
#Include "Src\Ext\xge_renderobj.bi"
#Include "Src\Ext\xge_ddt.bi"
#Include "Src\Ext\xge_xSock.bi"
#Include "Src\Ext\xge_xSock_UDP.bi"









' 初始化
#If __FB_OUT_EXE__
	
	xge_Library_Init(GetModuleHandle(NULL))
	
	/' EXE 测试代码 开始 '/
	
	#Include "Src\xge_test.bi"
	xge_test_init()
	xge_test_sdk()
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
