'==================================================================================
	'★ xywh Game Engine 主文件
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================

#Include Once "windows.bi"
#Include Once "crt.bi"



#Define xywh_library_2dge



' ScreenControl 获取项
#Define GET_WINDOW_POS					0
#Define GET_WINDOW_TITLE				1
#Define GET_WINDOW_HANDLE				2
#Define GET_DESKTOP_SIZE				3
#Define GET_SCREEN_SIZE					4
#Define GET_SCREEN_DEPTH				5
#Define GET_SCREEN_BPP					6
#Define GET_SCREEN_PITCH				7
#Define GET_SCREEN_REFRESH			8
#Define GET_DRIVER_NAME					9
#Define GET_TRANSPARENT_COLOR		10
#Define GET_VIEWPORT						11
#Define GET_PEN_POS							12
#Define GET_COLOR								13
#Define GET_ALPHA_PRIMITIVES		14
#Define GET_GL_EXTENSIONS				15
#Define GET_HIGH_PRIORITY				16

' ScreenControl 设置项
#Define SET_WINDOW_POS					100
#Define SET_WINDOW_TITLE				101
#Define SET_PEN_POS							102
#Define SET_DRIVER_NAME					103
#Define SET_ALPHA_PRIMITIVES		104
#Define SET_GL_COLOR_BITS				105
#Define SET_GL_COLOR_RED_BITS		106
#Define SET_GL_COLOR_GREEN_BITS	107
#Define SET_GL_COLOR_BLUE_BITS	108
#Define SET_GL_COLOR_ALPHA_BITS	109
#Define SET_GL_DEPTH_BITS				110
#Define SET_GL_STENCIL_BITS			111
#Define SET_GL_ACCUM_BITS				112
#Define SET_GL_ACCUM_RED_BITS		113
#Define SET_GL_ACCUM_GREEN_BITS	114
#Define SET_GL_ACCUM_BLUE_BITS	115
#Define SET_GL_ACCUM_ALPHA_BITS	116
#Define SET_GL_NUM_SAMPLES			117

' ScreenControl 命令项
#Define POLL_EVENTS							200



' 颜色值 [Trans使用]
#Define MASK_COLOR_INDEX		0
#Define MASK_COLOR					&HFF00FF



Enum
	SC_ESCAPE = &H01
	SC_1
	SC_2
	SC_3
	SC_4
	SC_5
	SC_6
	SC_7
	SC_8
	SC_9
	SC_0
	SC_MINUS
	SC_EQUALS
	SC_BACKSPACE
	SC_TAB
	SC_Q
	SC_W
	SC_E
	SC_R
	SC_T
	SC_Y
	SC_U
	SC_I
	SC_O
	SC_P
	SC_LEFTBRACKET
	SC_RIGHTBRACKET
	SC_ENTER
	SC_CONTROL
	SC_A
	SC_S
	SC_D
	SC_F
	SC_G
	SC_H
	SC_J
	SC_K
	SC_L
	SC_SEMICOLON
	SC_QUOTE
	SC_TILDE
	SC_LSHIFT
	SC_BACKSLASH
	SC_Z
	SC_X
	SC_C
	SC_V
	SC_B
	SC_N
	SC_M
	SC_COMMA
	SC_PERIOD
	SC_SLASH
	SC_RSHIFT
	SC_MULTIPLY
	SC_ALT
	SC_SPACE
	SC_CAPSLOCK
	SC_F1
	SC_F2
	SC_F3
	SC_F4
	SC_F5
	SC_F6
	SC_F7
	SC_F8
	SC_F9
	SC_F10
	SC_NUMLOCK
	SC_SCROLLLOCK
	SC_HOME
	SC_UP         
	SC_PAGEUP
	SC_LEFT = &h4B
	SC_RIGHT = &h4D
	SC_PLUS
	SC_END
	SC_DOWN
	SC_PAGEDOWN
	SC_INSERT
	SC_DELETE
	SC_F11 = &h57
	SC_F12
	SC_LWIN = &h5B
	SC_RWIN
	SC_MENU
End Enum



Type BMP_Info
	Nil1 As UInteger
	nWidth As Integer
	nHeight As Integer
	Nil2 As UShort
	BitCount As UShort
End Type



' 消息结构体与常量定义 [ScreenEvent函数使用]
Type NewEvent Field = 1
	Type As Integer
	Union
		Type
			scancode As Integer
			ascii As Integer
		End Type
		Type
			x As Integer
			y As Integer
			dx As Integer
			dy As Integer
		End Type
		Type
			param1 As Integer
			param2 As Integer
			param3 As Integer
			param4 As Integer
		End Type
		button As Integer
		z As Integer
		w As Integer
	End Union
End Type

Type IMAGE Field = 1
	tpe as UInteger
	bpp As Integer
	Width As UInteger
	Height As UInteger
	Pitch As UInteger
	reserved(1 To 12) As UByte
End Type
Type Surface As IMAGE Ptr

#Define EVENT_KEY_PRESS							1
#Define EVENT_KEY_RELEASE						2
#Define EVENT_KEY_REPEAT						3
#Define EVENT_MOUSE_MOVE						4
#Define EVENT_MOUSE_BUTTON_PRESS		5
#Define EVENT_MOUSE_BUTTON_RELEASE	6
#Define EVENT_MOUSE_DOUBLE_CLICK		7
#Define EVENT_MOUSE_WHEEL						8
#Define EVENT_MOUSE_ENTER						9
#Define EVENT_MOUSE_EXIT						10
#Define EVENT_WINDOW_GOT_FOCUS			11
#Define EVENT_WINDOW_LOST_FOCUS			12
#Define EVENT_WINDOW_CLOSE					13
#Define EVENT_MOUSE_HWHEEL					14



' 初始化标记
#Define xge_window				&H00		' 窗口模式
#Define xge_fullscreen		&H01		' 全屏模式
#Define xge_noswitch			&H04		' 不允许alt + enter切换窗口/全屏
#Define xge_noframe				&H08		' 窗口没有边框
#Define xge_postop				&H20		' 窗口置顶
#Define xge_alpha					&H40		' 开启alpha混合对于所有基础操作
#Define xge_highpriority	&H80		' 图像库高优先权给图像处理

' 回调消息
#Define xge_msg_null					&H00		' 空消息
#Define xge_msg_loadres				&H01		' 载入资源
#Define xge_msg_freeres				&H02		' 释放资源
#Define xge_msg_frame					&H03		' 框架函数
#Define xge_msg_draw					&H04		' 绘图函数
#Define xge_msg_error					&H05		' 错误处理
#Define xge_msg_killfocus			&H06		' 丢失焦点
#Define xge_msg_setfocus			&H07		' 获得焦点
#Define xge_msg_mouse_move		&H08		' 鼠标移动
#Define xge_msg_mouse_down		&H09		' 鼠标按下
#Define xge_msg_mouse_up			&H0A		' 鼠标弹起
#Define xge_msg_mouse_dclick	&H0B		' 鼠标双击
#Define xge_msg_mouse_whell		&H0C		' 滚轮滚动
#Define xge_msg_key_dowm			&H0D		' 按键按下
#Define xge_msg_key_up				&H0E		' 按键弹起
#Define xge_msg_key_repeat		&H0F		' 按键按住
#Define xge_msg_mouse_enter		&H10		' 鼠标移入
#Define xge_msg_mouse_exit		&H11		' 鼠标离开
#Define xge_msg_close					&H12		' 窗口关闭
#Define xge_msg_xgui					&H13		' GUI系统消息



' 声明函数定义
Namespace xge
	Declare Function Init(ByVal bpp As Integer,ByVal w As Integer,ByVal h As Integer,ByVal Flag As Integer,ByVal fps As Integer,ByVal OnSync As Integer,ByVal title As ZString Ptr) As Integer
	Declare Sub Unit()
	Declare Function Start(ByVal bk As Any Ptr,ByVal Param As Any Ptr = NULL) As Integer
	Declare Sub Stop(StopCode As Integer = 0)
	Declare Sub Pause()
	Declare Sub Restore()
	Declare Sub Screen(ByVal bk As Any Ptr)
	Declare Sub Clear()
	Declare Function FPS() As Integer
	Declare Function hWnd() As HANDLE
	Declare Function Tick() As Integer
	Declare Function LoadBMP(FileName As ZString Ptr) As Surface
	Declare Function LoadRAW(DPtr As Any Ptr,DSize As Integer,w As Integer,h As Integer,bpp As Integer) As Surface
	Declare Function LoadGDI_Memory(DPtr As ZString Ptr,DSize As Integer) As Surface
	Declare Function LoadGDI(FileName As ZString Ptr) As Surface
	Declare Function GetRnd(ByVal a As Integer,ByVal b As Integer) As Integer
	Declare Function RndOK(ByVal RndNum As Integer) As Integer
	Declare Function EvalRange(x1 As Integer,y1 As Integer,x2 As Integer,y2 As Integer) As Integer
End Namespace
Declare Sub xywh_library_2dge_eventcall(Event As NewEvent)
Declare Function xywh_library_2dge_loop(ByVal LockFPS As Integer,ByVal IsSync As Integer,ByVal Param As Any Ptr) As Integer



Dim Shared xywh_library_2dge_bkfunc As Function(ByVal message As Integer,ByVal param1 As Integer,ByVal param2 As Any Ptr) As Integer

' 场景执行标记
Dim Shared xywh_library_2dge_IsLoop As Integer				' 场景执行标记
Dim Shared xywh_library_2dge_IsRun As Integer					' 暂停标记
' FPS相关数据
Dim Shared xywh_library_2dge_tmpfps As Integer				' 用于FPS计算
Dim Shared xywh_library_2dge_tmptime As Integer				' 用于FPS计算
Dim Shared xywh_library_2dge_drawfps As Integer				' 实际的FPS
Dim Shared xywh_library_2dge_lockfps As Integer				' 锁定的FPS
' 场景数据指针 [用于xge.Clear]
Dim Shared xywh_library_2dge_scrptr As Any Ptr				' 场景数据指针
Dim Shared xywh_library_2dge_scrsize As Integer				' 场景数据长度
' 场景信息
Dim Shared xywh_library_2dge_bpp As Integer						' 位深
Dim Shared xywh_library_2dge_issync As Integer				' 是否开启垂直同步
' 其他数据
Dim Shared xywh_library_2dge_tick As Integer					' 最后一次 GetTickCount 结果
Dim Shared xywh_library_2dge_retloop As Integer				' 场景返回值
' 消息分发器
Dim Shared xywh_library_2dge_event As Sub(Event As NewEvent) = @xywh_library_2dge_eventcall



#Ifdef XGE_USE_XPK			' 使用文件包
	#Include Once "Inc\SDK\xywhPack.bi"
#EndIf
#Ifdef XGE_USE_XPF			' 使用点阵字库
	#Include Once "Inc\XGE\xywhPointFont.bi"
#EndIf
#Ifdef XGE_USE_SFM			' 使用Surface管理器
	#Include Once "Inc\XGE\SurfaceManage.bi"
#EndIf
#Ifdef XGE_USE_SOM			' 使用Sound管理器
	#Include Once "Inc\XGE\SoundManage.bi"
#EndIf
#Ifdef XGE_USE_GUI			' 使用游戏UI系统
	#Include Once "Inc\XGE\xywhFastGameUI.bi"
#EndIf
#Ifdef XGE_USE_GDI			' 使用 GDI 图层支持
	#Include Once "Inc\XGE\GDISurface.bi"
#EndIf
#Ifdef XGE_USE_DDS			' 使用动态绘制字符串功能
	#Include Once "Inc\XGE\GDISurface.bi"
	#Include Once "Inc\XGE\DrawString.bi"
#EndIf



' 消息分发器
Sub xywh_library_2dge_eventcall(Event As NewEvent)
	Select Case Event.type
		Case EVENT_KEY_PRESS
			xywh_library_2dge_bkfunc(xge_msg_key_dowm,0,@Event)
			xywh_library_2dge_bkfunc(xge_msg_key_repeat,0,@Event)
		Case EVENT_KEY_RELEASE
			xywh_library_2dge_bkfunc(xge_msg_key_up,0,@Event)
		Case EVENT_KEY_REPEAT
			xywh_library_2dge_bkfunc(xge_msg_key_repeat,0,@Event)
		Case EVENT_MOUSE_MOVE
			If (Event.x < 60000) And (Event.y < 60000) Then
				xywh_library_2dge_bkfunc(xge_msg_mouse_move,0,@Event)
			EndIf
		Case EVENT_MOUSE_BUTTON_PRESS
			xywh_library_2dge_bkfunc(xge_msg_mouse_down,0,@Event)
		Case EVENT_MOUSE_BUTTON_RELEASE
			xywh_library_2dge_bkfunc(xge_msg_mouse_up,0,@Event)
		Case EVENT_MOUSE_DOUBLE_CLICK
			xywh_library_2dge_bkfunc(xge_msg_mouse_dclick,0,@Event)
		Case EVENT_MOUSE_WHEEL
			xywh_library_2dge_bkfunc(xge_msg_mouse_whell,0,@Event)
		Case EVENT_MOUSE_ENTER
			xywh_library_2dge_bkfunc(xge_msg_mouse_enter,0,0)
		Case EVENT_MOUSE_EXIT
			xywh_library_2dge_bkfunc(xge_msg_mouse_exit,0,0)
		Case EVENT_WINDOW_GOT_FOCUS
			xywh_library_2dge_bkfunc(xge_msg_setfocus,0,0)
		Case EVENT_WINDOW_LOST_FOCUS
			xywh_library_2dge_bkfunc(xge_msg_killfocus,0,0)
		Case EVENT_WINDOW_CLOSE
			If xywh_library_2dge_bkfunc(xge_msg_close,0,0) Then
				xge.Stop()
			EndIf
	End Select
End Sub



Function xywh_library_2dge_loop(ByVal LockFPS As Integer,ByVal IsSync As Integer,ByVal Param As Any Ptr) As Integer
	If xywh_library_2dge_bkfunc(xge_msg_loadres,Cast(Integer,Param),0) Then
		xywh_library_2dge_IsLoop = 0
	EndIf
	Do While xywh_library_2dge_IsLoop
		' 计算FPS值
		xywh_library_2dge_tick = GetTickCount()
		If xywh_library_2dge_tick > xywh_library_2dge_tmptime+1000 Then
			xywh_library_2dge_tmptime = xywh_library_2dge_tick
			xywh_library_2dge_drawfps = xywh_library_2dge_tmpfps
			xywh_library_2dge_tmpfps = 0
		Else
			xywh_library_2dge_tmpfps += 1
		EndIf
		' 消息处理
		Dim Event As NewEvent
		Do While ScreenEvent(@Event)
			xywh_library_2dge_event(Event)
		Loop
		' 框架处理
		If xywh_library_2dge_IsRun Then
			xywh_library_2dge_bkfunc(xge_msg_frame,0,0)
		EndIf
		' FPS处理
		If LockFps Then
			Do While (xywh_library_2dge_tick-xywh_library_2dge_tmptime) < ((1000/LockFps)*xywh_library_2dge_tmpfps)
				Sleep(1)
				xywh_library_2dge_tick = GetTickCount()
			Loop
		EndIf
		' 绘制处理
		If xywh_library_2dge_IsRun Then
			If IsSync Then
				ScreenSync()
			EndIf
			ScreenLock()
			xywh_library_2dge_bkfunc(xge_msg_draw,0,0)
			ScreenUnLock()
		EndIf
	Loop
	xywh_library_2dge_bkfunc(xge_msg_freeres,Cast(Integer,Param),0)
	xywh_library_2dge_bkfunc = NULL
	Return xywh_library_2dge_retloop
End Function



Namespace xge
	' 启动
	Function Start(ByVal bk As Any Ptr,ByVal Param As Any Ptr = NULL) As Integer
		If xywh_library_2dge_bkfunc=NULL Then
			xywh_library_2dge_IsLoop = -1
			xywh_library_2dge_IsRun = -1
			xywh_library_2dge_bkfunc = bk
			Return xywh_library_2dge_loop(xywh_library_2dge_lockfps,xywh_library_2dge_issync,Param)
		EndIf
	End Function
	
	' 终止
	Sub Stop(StopCode As Integer = 0)
		xywh_library_2dge_retloop = StopCode
		xywh_library_2dge_IsLoop = 0
	End Sub
	
	' 暂停
	Sub Pause()
		xywh_library_2dge_IsRun = 0
	End Sub
	
	' 恢复
	Sub Restore()
		xywh_library_2dge_IsRun = -1
	End Sub
	
	' 直接切换场景
	Sub Screen(ByVal bk As Any Ptr)
		xywh_library_2dge_bkfunc = bk
	End Sub
	
	
	
	Function hWnd() As HANDLE
		Dim hWin As HANDLE
		ScreenControl(GET_WINDOW_HANDLE,Cast(Integer,hWin))
		Return hWin
	End Function
	
	
	
	' 初始化引擎
	Function Init(ByVal bpp As Integer,ByVal w As Integer,ByVal h As Integer,ByVal Flag As Integer,ByVal lockfps As Integer,ByVal OnSync As Integer,ByVal title As ZString Ptr) As Integer
		ScreenRes w,h,bpp,,Flag
		If title Then
			WindowTitle(*title)
		EndIf
		xywh_library_2dge_lockfps = lockfps
		xywh_library_2dge_issync = OnSync
		xywh_library_2dge_bpp = bpp
		xywh_library_2dge_scrptr = ScreenPtr
		xywh_library_2dge_scrsize = w*h*bpp/8
		Return -1
	End Function
	
	' 卸载引擎
	Sub Unit()
		xge.Stop()
		Screen(0)
	End Sub
	
	Function FPS() As Integer
		Return xywh_library_2dge_drawfps
	End Function
	
	Sub Clear()
		memset(xywh_library_2dge_scrptr,0,xywh_library_2dge_scrsize)
	End Sub
	
	Function GetRnd(ByVal a As Integer,ByVal b As Integer) As Integer
		Randomize
		Return CInt(Rnd*(b-a)) + a
	End Function
	
	Function RndOK(ByVal RndNum As Integer) As Integer
		Dim GetNum As Integer = xge.GetRnd(0,9999)
		If GetNum < RndNum Then
			Return -1
		EndIf
	End Function
	
	Function EvalRange(x1 As Integer,y1 As Integer,x2 As Integer,y2 As Integer) As Integer
		Return Fix(Sqr((x2-x1)^2+(y2-y1)^2))
	End Function
	
	Function Tick() As Integer
		Return xywh_library_2dge_tick
	End Function
	
	Function LoadBMP(FileName As ZString Ptr) As Surface
		Dim BmpInfo As BMP_Info
		GetFile(FileName,@BmpInfo,14,SizeOf(BmpInfo))
		Dim TempSurface As Surface = ImageCreate(BmpInfo.nWidth,BmpInfo.nHeight)
		If TempSurface Then
			BLoad(*FileName,TempSurface)
			Return TempSurface
		EndIf
	End Function
	
	Function LoadRAW(DPtr As Any Ptr,DSize As Integer,w As Integer,h As Integer,bpp As Integer) As Surface
		Dim TempSurface As Surface = ImageCreate(w,h,,bpp)
		If TempSurface Then
			Dim BitMap As Any Ptr
			Dim MemSize As Integer
			ImageInfo(TempSurface,,,,,BitMap,MemSize)
			CopyMemory(BitMap,DPtr,IIf(DSize<MemSize,DSize,MemSize))
			Return TempSurface
		EndIf
	End Function
	
	#Ifdef XGE_USE_GDI
		Function LoadGDI_Memory(DPtr As ZString Ptr,DSize As Integer) As Surface
			Dim hBmp As HBITMAP = BitmapFromMemory(DPtr,DSize)
			If hBmp Then
				Dim Bmp As BITMAP
				GetObject(hBmp,SizeOf(BITMAP),@Bmp)
				Dim TempSurface As Surface = ImageCreate(Bmp.bmWidth,Bmp.bmHeight)
				If TempSurface Then
					Dim GDI As XGE_GDISurface = XGE_GDISurface(Bmp.bmWidth,Bmp.bmHeight)
					Dim DSKDC As HDC = GetDC(GetDesktopWindow())
					Dim MDC As HDC = CreateCompatibleDC(DSKDC)
					SelectObject(MDC,hBmp)
					BitBlt(GDI.DC,0,0,Bmp.bmWidth,Bmp.bmHeight,MDC,0,0,SRCCOPY)
					GDI.Draw(TempSurface,0,0,0,0,Bmp.bmWidth,Bmp.bmHeight)
					GDI.Destroy()
					Return TempSurface
				EndIf
			EndIf
		End Function
		
		Function LoadGDI(FileName As ZString Ptr) As Surface
			Dim tl As Integer = FileLen(FileName)
			Dim tb As Any Ptr = Allocate(tl)
			GetFile(FileName,tb,0,tl)
			Return LoadGDI_Memory(tb,tl)
			DeAllocate(tb)
		End Function
	#EndIf
End Namespace





/'
' XGE场景模版
Function MainScreen(ByVal message As Integer,ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Select Case message
		Case xge_msg_frame				' 逻辑处理
			
		Case xge_msg_draw					' 绘图
			
		Case xge_msg_mouse_move		' 鼠标移动
			
		Case xge_msg_mouse_down		' 鼠标按下
			
		Case xge_msg_mouse_up			' 鼠标弹起
			
		Case xge_msg_mouse_dclick	' 鼠标双击
			
		Case xge_msg_mouse_whell	' 鼠标滚轮滚动
			
		Case xge_msg_key_dowm			' 键盘按下
			
		Case xge_msg_key_up				' 键盘弹起
			
		Case xge_msg_key_repeat		' 按键重复按下
			
		Case xge_msg_setfocus			' 拥有焦点
			
		Case xge_msg_killfocus		' 失去焦点
			
		Case xge_msg_mouse_enter	' 鼠标移入
			
		Case xge_msg_mouse_exit		' 鼠标移出
			
		Case xge_msg_loadres			' 加载资源
			
		Case xge_msg_freeres			' 卸载资源
			
		Case xge_msg_close				' 窗口关闭
			Return -1
	End Select
End Function
'/