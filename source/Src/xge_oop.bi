'==================================================================================
	'★ xywh Game Engine 引擎头文件
	'#-----------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



#Ifndef xywh_library_xge
	#Define xywh_library_xge
	#Ifndef XGE_SOURCE_NOLIB
		#Define XGE_SOURCE_NOLIB
		#Inclib "xge"
	#EndIf
	#Define XGE_EXTERNCLASS "Windows"				' Class 导出方式
	#Define XGE_EXTERNMODULE "Windows"				' NameSpace 导出方式
	#Define XGE_EXTERNSTDEXT "Windows"				' 普通函数导出方式
	
	
	
	/' -------------------------- 基础头文件 -------------------------- '/
	#Include Once "Crt.bi"
	#Include Once "Windows.bi"
	#Include Once "Win\GdiPlus.bi"
	
	
	
	/' -------------------------- 按键扫描码 -------------------------- '/
	#Define SC_ESCAPE					&H01
	#Define SC_1						&H02
	#Define SC_2						&H03
	#Define SC_3						&H04
	#Define SC_4						&H05
	#Define SC_5						&H06
	#Define SC_6						&H07
	#Define SC_7						&H08
	#Define SC_8						&H09
	#Define SC_9						&H0A
	#Define SC_0						&H0B
	#Define SC_MINUS					&H0C
	#Define SC_EQUALS					&H0D
	#Define SC_BACKSPACE				&H0E
	#Define SC_TAB						&H0F
	#Define SC_Q						&H10
	#Define SC_W						&H11
	#Define SC_E						&H12
	#Define SC_R						&H13
	#Define SC_T						&H14
	#Define SC_Y						&H15
	#Define SC_U						&H16
	#Define SC_I						&H17
	#Define SC_O						&H18
	#Define SC_P						&H19
	#Define SC_LEFTBRACKET				&H1A
	#Define SC_RIGHTBRACKET				&H1B
	#Define SC_ENTER					&H1C
	#Define SC_CONTROL					&H1D
	#Define SC_A						&H1E
	#Define SC_S						&H1F
	#Define SC_D						&H20
	#Define SC_F						&H21
	#Define SC_G						&H22
	#Define SC_H						&H23
	#Define SC_J						&H24
	#Define SC_K						&H25
	#Define SC_L						&H26
	#Define SC_SEMICOLON				&H27
	#Define SC_QUOTE					&H28
	#Define SC_TILDE					&H29
	#Define SC_LSHIFT					&H2A
	#Define SC_BACKSLASH				&H2B
	#Define SC_Z						&H2C
	#Define SC_X						&H2D
	#Define SC_C						&H2E
	#Define SC_V						&H2F
	#Define SC_B						&H30
	#Define SC_N						&H31
	#Define SC_M						&H32
	#Define SC_COMMA					&H33
	#Define SC_PERIOD					&H34
	#Define SC_SLASH					&H35
	#Define SC_RSHIFT					&H36
	#Define SC_MULTIPLY					&H37
	#Define SC_ALT						&H38
	#Define SC_SPACE					&H39
	#Define SC_CAPSLOCK					&H3A
	#Define SC_F1						&H3B
	#Define SC_F2						&H3C
	#Define SC_F3						&H3D
	#Define SC_F4						&H3E
	#Define SC_F5						&H3F
	#Define SC_F6						&H40
	#Define SC_F7						&H41
	#Define SC_F8						&H42
	#Define SC_F9						&H43
	#Define SC_F10						&H44
	#Define SC_NUMLOCK					&H45
	#Define SC_SCROLLLOCK				&H46
	#Define SC_HOME						&H47
	#Define SC_UP						&H48
	#Define SC_PAGEUP					&H49
	#Define SC_LEFT						&H4B
	#Define SC_RIGHT					&H4D
	#Define SC_PLUS						&H4E
	#Define SC_END						&H4F
	#Define SC_DOWN						&H50
	#Define SC_PAGEDOWN					&H51
	#Define SC_INSERT					&H52
	#Define SC_DELETE					&H53
	#Define SC_F11						&H57
	#Define SC_F12						&H58
	#Define SC_LWIN						&H5B
	#Define SC_RWIN						&H5C
	#Define SC_MENU						&H5D
	
	
	/' -------------------------- 颜色定义 -------------------------- '/
	#Define MASK_COLOR_24				&HFF00FF
	#Define MASK_COLOR_32				&HFFFF00FF
	#Define MASK32_A					&HFF000000
	#Define MASK32_R					&H00FF0000
	#Define MASK32_G					&H0000FF00
	#Define MASK32_B					&H000000FF
	#Define MASK32						&HFFFFFFFF
	
	
	/' -------------------------- 镜像定义 -------------------------- '/
	#Define XGE_BLEND_MIRR_H			1				' 水平
	#Define XGE_BLEND_MIRR_V			2				' 垂直
	#Define XGE_BLEND_MIRR_HV			3				' 水平 + 垂直
	#Define XGE_BLEND_MIRR_VH			3				' 水平 + 垂直
	
	
	/' -------------------------- 初始化定义 -------------------------- '/
	#Define XGE_INIT_WINDOW				&H00			' 窗口模式
	#Define XGE_INIT_FULLSCREEN			&H01			' 全屏模式
	#Define XGE_INIT_NOSWITCH			&H04			' 不允许alt + enter切换窗口/全屏
	#Define XGE_INIT_NOFRAME			&H08			' 窗口没有边框
	#Define XGE_INIT_POSTOP				&H20			' 窗口置顶
	#Define XGE_INIT_ALPHA				&H40			' 开启alpha混合对于所有基础操作
	#Define XGE_INIT_HIGHPRIORITY		&H80			' 高优先权给图像处理
	
	
	/' -------------------------- 模块初始化定义 -------------------------- '/
	#Define XGE_INIT_ALL				(XGE_INIT_GDI Or XGE_INIT_BASS)
	#Define XGE_INIT_GDI				&H1				' 初始化GDI/GDI+
	#Define XGE_INIT_BASS				&H2				' 初始化 BASS 模块
	
	
	/' -------------------------- 场景消息定义 -------------------------- '/
	#Define XGE_MSG_NULL				&H00			' 空消息
	#Define XGE_MSG_LOADRES				&H01			' 载入资源
	#Define XGE_MSG_FREERES				&H02			' 释放资源
	#Define XGE_MSG_FRAME				&H03			' 框架函数
	#Define XGE_MSG_DRAW				&H04			' 绘图函数
	#Define XGE_MSG_ERROR				&H05			' 错误处理
	#Define XGE_MSG_MOUSE_MOVE			&H101			' 鼠标移动
	#Define XGE_MSG_MOUSE_DOWN			&H102			' 鼠标按下
	#Define XGE_MSG_MOUSE_UP			&H103			' 鼠标弹起
	#Define XGE_MSG_MOUSE_CLICK			&H104			' 鼠标单击
	#Define XGE_MSG_MOUSE_DCLICK		&H105			' 鼠标双击
	#Define XGE_MSG_MOUSE_WHELL			&H106			' 滚轮滚动
	#Define XGE_MSG_KEY_DOWN			&H201			' 按键按下
	#Define XGE_MSG_KEY_UP				&H202			' 按键弹起
	#Define XGE_MSG_KEY_REPEAT			&H203			' 按键按住
	#Define XGE_MSG_MOUSE_ENTER			&H301			' 鼠标移入
	#Define XGE_MSG_MOUSE_EXIT			&H302			' 鼠标离开
	#Define XGE_MSG_LOSTFOCUS			&H311			' 丢失焦点
	#Define XGE_MSG_GOTFOCUS			&H312			' 获得焦点
	#Define XGE_MSG_CLOSE				&H321			' 窗口关闭
	
	
	/' -------------------------- 暂停定义 -------------------------- '/
	#Define XGE_PAUSE_DRAW				&H01			' 暂停绘制
	#Define XGE_PAUSE_FRAME				&H02			' 暂停场景框架
	
	
	/' -------------------------- 文件类型定义 -------------------------- '/
	#Define XGE_IMG_FMT_BMP				0
	#Define XGE_IMG_FMT_XGI				1
	
	
	/' -------------------------- XGI文件相关定义 -------------------------- '/
	#Define XGI_FLAG_LZ4		1						' 是否启用 LZ4 压缩
	#Define XGI_FLAG_B16		2						' 是否为 16 位图像
	
	
	/' -------------------------- 音频类型定义 -------------------------- '/
	#Define XGE_SOUND_SAMPLE			1
	#Define XGE_SOUND_MUSIC				2
	#Define XGE_SOUND_STREAM			3
	
	
	/' -------------------------- 小样载入标记定义 -------------------------- '/
	#Define XGE_SUD_SMP_LOOP			4				' 循环
	#Define XGE_SUD_SMP_MONO			2				' 单声道
	#Define XGE_SUD_SMP_8B				1				' 8位
	#Define XGE_SUD_SMP_32B				256				' 32位
	#Define XGE_SUD_SMP_SOFT			16				' 软件混音
	
	
	/' -------------------------- 流媒体载入标记定义 -------------------------- '/
	#Define XGE_SUD_STE_LOOP			4				' 循环
	#Define XGE_SUD_STE_MONO			2				' 单声道
	#Define XGE_SUD_STE_32B				256				' 32位
	#Define XGE_SUD_STE_SOFT			16				' 软件混音
	#Define XGE_SUD_STE_PRES			&H20000			' 预扫描
	#Define XGE_SUD_STE_AFRE			&H40000			' 播放结束自动释放
	#Define XGE_SUD_STE_BLOCK			&H100000		' 分段下载url流媒体 [不能循环播放]
	#Define XGE_SUD_STE_URL				&H80000000		' 从URL载入
	
	
	/' -------------------------- 音乐载入标记定义 -------------------------- '/
	#Define XGE_SUD_MUS_LOOP			4				' 循环
	#Define XGE_SUD_MUS_MONO			2				' 单声道
	#Define XGE_SUD_MUS_32B				256				' 32位
	#Define XGE_SUD_MUS_SOFT			16				' 软件混音
	#Define XGE_SUD_MUS_PRES			&H20000			' 预扫描
	#Define XGE_SUD_MUS_AFRE			&H40000			' 播放结束自动释放
	#Define XGE_SUD_MUS_SUR				&H800			' 环绕
	#Define XGE_SUD_MUS_SUR2			&H1000			' 环绕 [模式2]
	#Define XGE_SUD_MUS_NSMP			&H100000		' 不加载小样
	
	
	/' -------------------------- 音量设置定义 -------------------------- '/
	#Define XGE_SUD_VOL_ALL				&H0
	#Define XGE_SUD_VOL_SMP				&H4
	#Define XGE_SUD_VOL_STE				&H5
	#Define XGE_SUD_VOL_MUS				&H6
	
	
	/' -------------------------- 文本对齐定义 -------------------------- '/
	#Define XGE_ALIGN_LEFT				&H0				' 横向左对齐
	#Define XGE_ALIGN_CENTER			&H1				' 横向居中对齐
	#Define XGE_ALIGN_RIGHT				&H2				' 横向右对齐
	#Define XGE_ALIGN_TOP				&H0				' 纵向上对齐
	#Define XGE_ALIGN_MIDDLE			&H4				' 纵向居中对齐
	#Define XGE_ALIGN_BOTTOM			&H8				' 纵向底部对齐
	
	
	/' -------------------------- 字体风格定义 -------------------------- '/
	#Define XGE_FONT_BOLD				&H10			' 粗体
	#Define XGE_FONT_ITALIC				&H20			' 斜体
	#Define XGE_FONT_BOLDITALIC			&H30			' 粗体 + 斜体
	#Define XGE_FONT_UNDERLINE			&H40			' 下划线
	#Define XGE_FONT_SRTIKEOUT			&H80			' 删除线
	
	
	/' -------------------------- GUI布局方式定义 -------------------------- '/
	#Define XUI_LAYOUT_COORD			0				' 布局系统 - 浮动布局，根据坐标决定位置
	#Define XUI_LAYOUT_L2R				1				' 布局系统 - 横向布局 [从左到右]
	#Define XUI_LAYOUT_R2L				2				' 布局系统 - 横向布局 [从右到左]
	#Define XUI_LAYOUT_T2B				3				' 布局系统 - 纵向布局 [从上到下]
	#Define XUI_LAYOUT_B2T				4				' 布局系统 - 纵向布局 [从下到上]
	
	
	/' -------------------------- GUI布局尺度定义 -------------------------- '/
	#Define XUI_LAYOUT_RULER_COORD		-1				' 布局尺度 - 绝对坐标 [打破父控件的布局方案]
	#Define XUI_LAYOUT_RULER_PIXEL		0				' 布局尺度 - 像素
	#Define XUI_LAYOUT_RULER_RATIO		1				' 布局尺度 - 剩余百分比
	
	
	/' -------------------------- 元素 ClassID 定义 -------------------------- '/
	#Define XUI_CLASS_ELEMENT			0				' 基本元素
	#Define XUI_CLASS_BUTTON			1				' 按钮(包含单选、复选类元素)
	#Define XUI_CLASS_STATIC			2				' 静态元素(包含标签、图片等)
	#Define XUI_CLASS_SCROLLBAR			3				' 滚动条(包含横向和纵向)
	#Define XUI_CLASS_SCROLLVIEW		4				' 滚动视图
	#Define XUI_CLASS_LISTBOX			5				' 列表框
	#Define XUI_CLASS_COMBOBOX			6				' 组合框
	#Define XUI_CLASS_PROGRESSBAR		7				' 进度条
	#Define XUI_CLASS_TRACKBAR			8				' 进度条
	#Define XUI_CLASS_ANIMATBOX			9				' 动画
	#Define XUI_CLASS_LINEEDIT			10				' 行编辑框
	#Define XUI_CLASS_TEXTBOX			11				' 全功能文本编辑框
	#Define XUI_CLASS_USER				&H10000			' 用户自定义元素的开始ID
	
	
	/' -------------------------- 元素滚动条显示状态定义 -------------------------- '/
	#Define XUI_SCROLL_V				1				' 显示纵向滚动条
	#Define XUI_SCROLL_H				2				' 显示横向滚动条
	#Define XUI_SCROLL_VH				3				' 横向和纵向滚动条都显示
	#Define XUI_SCROLL_HV				3				' 横向和纵向滚动条都显示
	
	
	/' -------------------------- 文件查找规则 -------------------------- '/
	#Define XFILE_RULE_NoAttribEx		0				' 不限制
	#Define XFILE_RULE_FloderOnly		0				' 只查找目录
	#Define XFILE_RULE_PointFloder		0				' 去除根目录及父级目录
	
	
	
	/' -------------------------- 消息结构体 -------------------------- '/
	Type XGE_EVENT
		tpe As Integer
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
			Type
				mx As Integer
				my As Integer
				button As Integer
			End Type
			Type
				zx As Integer
				zy As Integer
				z As Integer
				nz As Integer
			End Type
			w As Integer
		End Union
	End Type
	
	
	
	/' -------------------------- 图像结构体 -------------------------- '/
	Type IMAGE
		tpe as UInteger
		bpp As Integer
		Width As UInteger
		Height As UInteger
		Pitch As UInteger
		reserved(1 To 12) As UByte
	End Type
	
	
	
	/' -------------------------- 数据类型定义 -------------------------- '/
	Type XGE_SCENE_PROC As Function(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Type XGE_EVENT_PROC As Sub(eve As XGE_EVENT Ptr)
	Type XGE_DELAY_PROC As Sub(ms As Integer)
	Type XGE_BLOAD_PROC As Function(img As Any Ptr, addr As ZString Ptr, size As UInteger) As Integer
	Type XGE_FLOAD_PROC As Function(fd As Any Ptr, Addr As ZString Ptr, iSize As UInteger, param As Any Ptr) As Integer
	Type XGE_DRAW_BLEND As Sub(SrcAddr As Any Ptr, SrcPitch As Integer, SrcLineS As Integer, DstAddr As Any Ptr, DstPitch As Integer, DstLineS As Integer, w As Integer, h As Integer, param As Integer)
	Type XGE_DRAW_CUSTOM As Function(src As UInteger, dst As UInteger, param As Any Ptr) As UInteger
	
	
	
	
	
	Extern XGE_EXTERNCLASS
		/' -------------------------- 栈结构类[结构体] -------------------------- '/
		Type xStack
			' 构造/析构
			Declare Constructor(max As UInteger, unitsize As UInteger)
			Declare Destructor()
			
			' 初始化/卸载
			Declare Function Init(max As UInteger, unitsize As UInteger) As Integer
			Declare Sub Unit()
			
			' 压栈
			Declare Function Push(dat As Any Ptr) As Integer
			
			' 出栈
			Declare Function Pop(c As UInteger) As Any Ptr
			
			' 栈顶
			Declare Function Top() As Any Ptr
			
			' 压栈数量
			Declare Function Count() As UInteger
			
			Private:
				Dim pMaxCount As UInteger
				Dim pUnitSize As UInteger
				Dim pStackMem As Any Ptr
				Dim pStackTop As UInteger
		End Type
		
		
		/' -------------------------- 栈结构类[Int] -------------------------- '/
		Type xStack_Int
			' 构造/析构
			Declare Constructor(max As UInteger)
			Declare Destructor()
			
			' 初始化/卸载
			Declare Function Init(max As UInteger) As Integer
			Declare Sub Unit()
			
			' 压栈
			Declare Function Push(dat As Integer) As Integer
			
			' 出栈
			Declare Function Pop() As Integer
			Declare Function Pop(c As UInteger) As Integer Ptr
			
			' 栈顶
			Declare Function Top() As Integer
			
			' 压栈数量
			Declare Function Count() As UInteger
			
			Private:
				Dim pMaxCount As UInteger
				Dim pStackMem As Integer Ptr
				Dim pStackTop As UInteger
		End Type
		
		
		/' -------------------------- 结构化内存管理器 -------------------------- '/
		Type xBsmm
			' 管理器内存指针
			StructMemory As Any Ptr
			
			' 成员占用内存长度
			StructLenght As UInteger
			
			' 管理器中存在多少成员
			StructCount As UInteger
			
			' 已经申请的结构数量
			AllocCount As UInteger
			
			' 预分配内存步长
			AllocStep As UInteger
			
			' 构造函数
			Declare Constructor()
			Declare Constructor(iItemLenght As UInteger, PreassignStep As UInteger = 32, PreassignLenght As UInteger = 0)
			
			' 析构函数
			Declare Destructor()
			
			' 添加成员
			Declare Function InsertStruct(iPos As UInteger, iCount As UInteger = 1) As UInteger
			Declare Function AppendStruct(iCount As UInteger = 1) As UInteger
			
			' 删除成员
			Declare Function DeleteStruct(iPos As UInteger, iCount As UInteger = 1) As Integer
			
			' 移动成员
			Declare Function SwapStruct(iPosA As UInteger, iPosB As UInteger) As Integer
			
			' 获取成员指针
			Declare Function GetPtrStruct(iPos As UInteger) As Any Ptr
			
			' 分配内存
			Declare Function CallocMemory(iCount As UInteger) As Integer
			
			' 重置（释放资源）
			Declare Sub ReInitManage()
		End Type
	End Extern
	
	
	
	Extern XGE_EXTERNMODULE
		Namespace xge
		/' -------------------------- 核心库 -------------------------- '/
			Declare Function Init(w As UInteger, h As UInteger, init_gfx As Integer = XGE_INIT_WINDOW, init_mod As Integer = XGE_INIT_ALL, title As ZString Ptr = NULL) As Integer
			Declare Sub Unit()
			Declare Function SetScreen(w As UInteger, h As UInteger, init_gfx As Integer = XGE_INIT_WINDOW) As Integer
			Declare Function hWnd() As HANDLE
			Declare Sub Clear()
			Declare Sub Lock()
			Declare Sub UnLock()
			Declare Sub Sync()
			Declare Function Width() As UInteger
			Declare Function Height() As UInteger
			Declare Function PixAddr() As Any Ptr
			Declare Function PixSize() As UInteger
			Declare Function Pitch() As UInteger
			Declare Function Driver() As ZString Ptr
			Declare Sub SetSoundVol(tpe As Integer, vol As Integer)
			Declare Function GetSoundVol(tpe As Integer) As Integer
			Declare Function Ver(tpe As Integer = 0) As Integer
			
			
			/' -------------------------- 场景库 -------------------------- '/
			Namespace Scene
				Declare Function Start(proc As XGE_SCENE_PROC, lfps As UInteger = 0, sync As Integer = FALSE, param As Integer = 0) As Integer
				Declare Function Cut(proc As XGE_SCENE_PROC, lfps As UInteger = 0, sync As Integer = FALSE, param As Integer = 0) As Integer
				Declare Sub Stop()
				Declare Sub StopAll()
				Declare Sub Pause(flag As Integer = XGE_PAUSE_DRAW Or XGE_PAUSE_FRAME)
				Declare Function State() As Integer
				Declare Sub Resume()
				Declare Function FPS() As UInteger
				Declare Sub SetFPS(nv As UInteger)
				Declare Function Stack() As xStack Ptr
			End Namespace
			
			
			/' -------------------------- 挂钩库 -------------------------- '/
			Namespace Hook
				Declare Sub SetDelayProc(proc As XGE_DELAY_PROC)
				Declare Sub SetEventProc(proc As XGE_EVENT_PROC)
				Declare Sub SetSceneProc(proc As XGE_SCENE_PROC)
				Declare Sub SetImageLoadProc(proc As XGE_BLOAD_PROC)
				Declare Sub SetFontLoadProc(proc As XGE_FLOAD_PROC)
			End Namespace
		End Namespace
		
		
		/' -------------------------- 输入库 -------------------------- '/
		Namespace xInput
			Declare Function KeyStatus(k As Integer) As Integer
			Declare Sub MouseStatus(x As Integer Ptr, y As Integer Ptr, w As Integer Ptr, b As Integer Ptr)
			Declare Function JoyStatus(id As Integer, btn As Integer Ptr, a1 As Single Ptr, a2 As Single Ptr, a3 As Single Ptr, a4 As Single Ptr, a5 As Single Ptr, a6 As Single Ptr, a7 As Single Ptr, a8 As Single Ptr) As Integer
			Declare Function GetMousePos() As Integer
			Declare Function SetMousePos(x As Integer, y As Integer) As Integer
			Declare Function GetMouseX() As Integer
			Declare Function GetMouseY() As Integer
			Declare Function GetMouseBtn() As Integer
			Declare Function GetMouseBtnL() As Integer
			Declare Function GetMouseBtnR() As Integer
			Declare Function GetMouseBtnM() As Integer
			Declare Function GetMouseWhell() As Integer
		End Namespace
		
		
		/' -------------------------- 文件操作库 -------------------------- '/
		Namespace xFile
			Declare Function Create(FilePath As ZString Ptr) As Integer
			Declare Function Open(FilePath As ZString Ptr, OnlyRead As Integer = 0) As HANDLE
			Declare Function Close(FileHdr As HANDLE) As Integer
			Declare Function Exists(FilePath As ZString Ptr) As Integer
			Declare Function hWrite(FileHdr As HANDLE, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger
			Declare Function Write(FilePath As ZString Ptr, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger
			Declare Function hRead(FileHdr As HANDLE, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger
			Declare Function Read(FilePath As ZString Ptr, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger
			Declare Function eRead(FilePath As ZString Ptr, Buffer As Any Ptr Ptr) As UInteger
			Declare Function hSize(FileHdr As HANDLE) As UInteger
			Declare Function Size(FilePath As ZString Ptr) As UInteger
			Declare Function hCut(FileHdr As HANDLE, FileSize As UInteger) As Integer
			Declare Function Cut(FilePath As ZString Ptr, FileSize As UInteger) As Integer
			Declare Function Scan(RootDir As ZString Ptr, Filter As ZString Ptr, Attrib As Integer, AttribEx As Integer, Recursive As Integer, CallBack As Function(Path As ZString Ptr, FindData As WIN32_FIND_DATA Ptr, param As Integer) As Integer, param As Integer = 0) As Integer
		End Namespace
		
		Namespace xIni
			Declare Function GetStr(IniFile As ZString Ptr, IniSec As ZString Ptr, IniKey As ZString Ptr) As ZString Ptr
			Declare Function GetInt(IniFile As ZString Ptr, IniSec As ZString Ptr, IniKey As ZString Ptr) As Integer
			Declare Function SetStr(IniFile As ZString Ptr, IniSec As ZString Ptr, IniKey As ZString Ptr, kValue As ZString Ptr) As Integer
			Declare Function EnumSec(IniFile As ZString Ptr, OutArr As ZString Ptr Ptr Ptr) As Integer
			Declare Function EnumKey(IniFile As ZString Ptr, IniSec As ZString Ptr, OutArr As ZString Ptr Ptr Ptr) As Integer
		End Namespace
	End Extern
	
	
	
	Extern XGE_EXTERNCLASS
		Namespace xge
			/' -------------------------- 图像类 -------------------------- '/
			Type Surface
				img As IMAGE Ptr
				
				' 构造 [空]
				Declare Constructor()
				
				' 构造 [创建]
				Declare Constructor(w As UInteger, h As UInteger)
				
				' 构造 [加载]
				Declare Constructor(addr As ZString Ptr, size As UInteger = 0)
				
				' 析构
				Declare Destructor()
				
				' 创建图像
				Declare Function Create(w As UInteger, h As UInteger) As Integer
				
				' 载入图像
				Declare Function Load(addr As ZString Ptr, size As UInteger = 0) As Integer
				
				' 保存图像
				Declare Function Save(addr As ZString Ptr, tpe As UInteger = 0, flag As Integer = 0) As Integer
				
				' 释放图像
				Declare Sub Free()
				
				' 清除图像
				Declare Sub Clear()
				
				' 获取图像属性
				Declare Function Width() As UInteger
				Declare Function Height() As UInteger
				Declare Function PixAddr() As Any Ptr
				Declare Function PixSize() As UInteger
				Declare Function Pitch() As UInteger
				
				' 创建图像副本
				Declare Function Copy(x As Integer, y As Integer, w As Integer, h As Integer) As xge.Surface Ptr
				
				' 绘制
				Declare Sub Draw(sf As xge.Surface Ptr, x As Integer, y As Integer)
				Declare Sub DrawEx(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer)
				Declare Sub Draw_Add(sf As xge.Surface Ptr, x As Integer, y As Integer, mul As Integer = 255)
				Declare Sub DrawEx_Add(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, mul As Integer = 255)
				Declare Sub Draw_Alpha(sf As xge.Surface Ptr, x As Integer, y As Integer)
				Declare Sub DrawEx_Alpha(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer)
				Declare Sub Draw_Alpha2(sf As xge.Surface Ptr, x As Integer, y As Integer, a As Integer)
				Declare Sub DrawEx_Alpha2(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, a As Integer)
				Declare Sub Draw_Trans(sf As xge.Surface Ptr, x As Integer, y As Integer)
				Declare Sub DrawEx_Trans(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer)
				Declare Sub Draw_And(sf As xge.Surface Ptr, x As Integer, y As Integer)
				Declare Sub DrawEx_And(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer)
				Declare Sub Draw_Or(sf As xge.Surface Ptr, x As Integer, y As Integer)
				Declare Sub DrawEx_Or(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer)
				Declare Sub Draw_PSet(sf As xge.Surface Ptr, x As Integer, y As Integer)
				Declare Sub DrawEx_PSet(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer)
				Declare Sub Draw_Xor(sf As xge.Surface Ptr, x As Integer, y As Integer)
				Declare Sub DrawEx_Xor(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer)
				Declare Sub Draw_Gray(sf As xge.Surface Ptr, x As Integer, y As Integer)
				Declare Sub DrawEx_Gray(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer)
				Declare Sub Draw_Mirr(sf As xge.Surface Ptr, x As Integer, y As Integer, flag As Integer)
				Declare Sub DrawEx_Mirr(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, flag As Integer)
				Declare Sub Draw_Shade(sf As xge.Surface Ptr, x As Integer, y As Integer, mask As UByte)
				Declare Sub DrawEx_Shade(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, mask As UByte)
				Declare Sub Draw_Custom(sf As xge.Surface Ptr, x As Integer, y As Integer, bk As XGE_DRAW_CUSTOM, param As Any Ptr = NULL)
				Declare Sub DrawEx_Custom(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, bk As XGE_DRAW_CUSTOM, param As Any Ptr = NULL)
				Declare Sub Draw_Blend(sf As xge.Surface Ptr, x As Integer, y As Integer, bk As Any Ptr, param As Integer = 0)
				Declare Sub DrawEx_Blend(sf As xge.Surface Ptr, x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, bk As Any Ptr, param As Integer = 0)
			End Type
			
			
			/' -------------------------- Gdi图像类 -------------------------- '/
			Type GdiSurface Extends Surface
				hDC As HANDLE
				hBitmap As HANDLE
				BitmapAddr As Any Ptr
				gfx As GdiPlus.GpGraphics Ptr
				
				' 构造 [空]
				Declare Constructor()
				
				' 构造 [创建]
				Declare Constructor(w As UInteger, h As UInteger)
				
				' 构造 [加载]
				Declare Constructor(addr As ZString Ptr, size As UInteger = 0)
				
				' 析构
				Declare Destructor()
				
				' 创建图像
				Declare Function Create(w As UInteger, h As UInteger) As Integer
				
				' 载入图像
				Declare Function Load(addr As ZString Ptr, size As UInteger = 0) As Integer
				
				' 释放图像
				Declare Sub Free()
				
				' GDI 绘图
				Declare Sub PrintLine(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As UInteger)
				Declare Sub PrintRect(x As Integer, y As Integer, w As Integer, h As Integer, c As UInteger)
				Declare Sub PrintRectFull(x As Integer, y As Integer, w As Integer, h As Integer, c As UInteger)
				Declare Sub PrintCirc(x As Integer, y As Integer, w As Integer, h As Integer, c As UInteger)
				Declare Sub PrintCircFull(x As Integer, y As Integer, w As Integer, h As Integer, c As UInteger)
				Declare Sub PrintText(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, c As UInteger, txt As ZString Ptr)
				Declare Sub PrintText(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, c As UInteger, weight As Integer, txt As ZString Ptr)
				Declare Sub PrintText(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, c1 As UInteger, c2 As UInteger, weight As Integer, txt As ZString Ptr)
				Declare Sub PrintText(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, addr As ZString Ptr, size As Integer, txt As ZString Ptr)
				Declare Sub PrintImage(x As Integer, y As Integer, addr As ZString Ptr, size As Integer = 0)
				Declare Sub PrintImageDpi(x As Integer, y As Integer, addr As ZString Ptr, size As Integer = 0)
				Declare Sub PrintImageZoom(x As Integer, y As Integer, w As Integer, h As Integer, addr As ZString Ptr, size As Integer = 0)
				Declare Sub PrintImageEx(x As Integer, y As Integer, w As Integer, h As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, addr As ZString Ptr, size As Integer = 0)
				Declare Sub PrintImageFull(x As Integer, y As Integer, w As Integer, h As Integer, addr As ZString Ptr, size As Integer = 0)
			End Type
			
			
			/' -------------------------- 声音类 -------------------------- '/
			Type Sound
				SoundObj As UInteger
				
				' 构造 [空]
				Declare Constructor()
				
				' 构造 [加载]
				Declare Constructor(tpe As Integer, flag As Integer, addr As ZString Ptr, size As UInteger = 0, max As Integer = 65535)
				
				' 析构
				Declare Destructor()
				
				' 载入声音
				Declare Function Load(tpe As Integer, flag As Integer, addr As ZString Ptr, size As UInteger = 0, max As Integer = 65535) As Integer
				
				' 释放声音
				Declare Sub Free()
				
				' 声音类型
				Declare Function GetType() As Integer
				
				' 声音控制
				Declare Sub Play()
				Declare Sub Stop()
				Declare Sub Pause()
				Declare Sub Resume()
				
				Protected:
					pTpe As Integer
			End Type
		End Namespace
		
		
		/' -------------------------- 界面库 -------------------------- '/
		Namespace xui
			
			' 点数据结构
			Type Coord
				x As Integer
				y As Integer
			End Type
			
			' 矩形数据结构
			Type Rect
				Union
					x As Integer
					LeftOffset As Integer
				End Union
				Union
					y As Integer
					TopOffset As Integer
				End Union
				Union
					w As Integer
					RightOffset As Integer
				End Union
				Union
					h As Integer
					BottomOffset As Integer
				End Union
			End Type
			
			
			' 布局数据结构
			Type Layout
				Ruler As Integer			' 布局尺度 [ 参考定义前缀 : XUI_LAYOUT_RULER ]
				RectBox As xui.Rect			' 外框大小 [ 单位是像素，浮动布局时这个数据无效 ]
				Rect As xui.Rect			' 最终坐标 [ 这个数据会在运行时产生 ]
				ScreenCoord As xui.Coord	' 在屏幕上的最终坐标 [ 以游戏左上角为起点，这个数据会在运行时产生 ]
				w As Integer				' 布局宽度
				h As Integer				' 布局高度
			End Type
			
			
			' 背景结构
			Type BackStyle_Struct
				Image As xge.Surface Ptr = NULL
				BorderColor As UInteger
				FillColor As UInteger
				Hide As Integer
			End Type
			Type BackStyle_Text_Struct
				Image As xge.Surface Ptr = NULL
				BorderColor As UInteger
				FillColor As UInteger
				TextColor As UInteger
				Hide As Integer
			End Type
			
			
			' 列表项结构体
			Type List_Item_BasicStruct							' 列表项结构体 [基础结构]
				Checked As Integer								' 选中状态
				Tag As Integer									' 附加数据
				Text As ZString Ptr								' 显示文本
				TextColor As UInteger							' 文本颜色
				UserData As Any Ptr								' 用户自定义数据开始的位置 [这个数据是不存在的，用于提取指针]
			End Type
			
			' 列表项集合管理器
			Type List_ItemSet Extends xBsmm						' 列表项集合管理器
				Parent As Any Ptr								' 父元素指针
				
				' 构造函数
				Declare Constructor()
				
				' 列表项数量
				Declare Function Count() As UInteger
				
				' 添加列表项
				Declare Function Append(sVal As ZString Ptr, Tag As Integer = 0) As UInteger
				Declare Function Insert(iPos As UInteger, sVal As ZString Ptr, Tag As Integer = 0) As UInteger
				
				' 删除列表项
				Declare Function Remove(iPos As UInteger) As Integer
				Declare Sub Clear()
				
				' 获取/设置 列表项的标题
				Declare Property Text(iPos As UInteger) As ZString Ptr
				Declare Property Text(iPos As UInteger, sVal As ZString Ptr)
				
				' 获取/设置 列表项的附加数据
				Declare Property Tag(iPos As UInteger) As Integer
				Declare Property Tag(iPos As UInteger, iVal As Integer)
				
				' 选中列表项
				Declare Property Selected(iPos As UInteger) As Integer
				Declare Property Selected(iPos As UInteger, iStk As Integer)
				
				' 统计选中列表项的数量
				Declare Function SelectCount() As UInteger
				
				' 选择所有列表项
				Declare Sub SelectAll()
				
				' 取消所有选中的列表项
				Declare Sub SelectClear()
				
				' 反选所有列表项
				Declare Sub SelectInverse()
				
				' 设置用户自定义数据结构大小 [默认为0，只能在还没有列表项时调用]
				Declare Sub SetUserDataSize(bc As UInteger)
				
				' 获取用户自定义数据指针
				Declare Function UserData(iPos As UInteger) As Any Ptr
			End Type
			
			
			' 元素事件 [部分事件处理过程占用时间，因此仅在注册后才会处理这些事件]
			' 元素事件返回 -1 代表中断事件链处理，其他符合条件的控件将无法再收到事件
			Type ElementEvent
				' 鼠标移动 [被激活的控件可以优先处理这个事件，如果他放弃处理的话，则这个事件进入正常的消息链]
				OnMouseMove As Function(ele As Any Ptr, x As Integer, y As Integer) As Integer = NULL
				' 鼠标按下
				OnMouseDown As Function(ele As Any Ptr, x As Integer, y As Integer, btn As Integer) As Integer = NULL
				' 鼠标弹起 [被激活的控件可以优先处理这个事件，如果他放弃处理的话，则这个事件进入正常的消息链]
				OnMouseUp As Function(ele As Any Ptr, x As Integer, y As Integer, btn As Integer) As Integer = NULL
				' 鼠标单击
				OnMouseClick As Function(ele As Any Ptr, x As Integer, y As Integer, btn As Integer) As Integer = NULL
				' 鼠标双击
				OnMouseDoubleClick As Function(ele As Any Ptr, x As Integer, y As Integer, btn As Integer) As Integer = NULL
				' 鼠标进入元素范围
				OnMouseEnter As Sub(ele As Any Ptr) = NULL
				' 鼠标离开元素
				OnMouseLeave As Sub(ele As Any Ptr) = NULL
				' 鼠标滚轮拨动 [鼠标指针所在位置最顶层的元素能够收到这个事件，如果他不处理的话，则事件会被转发给被激活的元素]
				OnMouseWhell As Function(ele As Any Ptr, x As Integer, y As Integer, z As Integer, nz As Integer) As Integer = NULL
				' 键盘按键按下 [只有被激活的元素能收到这个事件]
				OnKeyDown As Function(ele As Any Ptr, k As Integer, c As Integer) As Integer = NULL
				' 键盘按键弹起 [只有被激活的元素能收到这个事件]
				OnKeyUp As Function(ele As Any Ptr, k As Integer, c As Integer) As Integer = NULL
				' 键盘按键点击 [只有被激活的元素能收到这个事件]
				OnKeyRepeat As Function(ele As Any Ptr, k As Integer, c As Integer) As Integer = NULL
				' 元素被激活
				OnGotfocus As Sub(ele As Any Ptr) = NULL
				' 元素丢失激活状态
				OnLostFocus As Sub(ele As Any Ptr) = NULL
				' 绘制事件，在元素需要画出的时候调用
				OnDraw As Sub(ele As Any Ptr) = NULL
				' 自绘事件，在 OnDraw 之后调用，可以进行补充绘制 [这个事件系统一般不会占用]
				OnUserDraw As Sub(ele As Any Ptr) = NULL
				' 大小改变事件
				OnSize As Sub(ele As Any Ptr) = NULL
			End Type
			
			
			' 按钮的事件结构
			Type ButtonEvent
				OnClick As Sub(ele As Any Ptr, btn As Integer)
				OnCheck As Sub(ele As Any Ptr)
			End Type
			
			
			' 滚动条的事件结构
			Type ScrollBarEvent
				OnScroll As Sub(ele As Any Ptr)
			End Type
			
			
			' 滚动视图事件结构
			Type ScrollViewEvent
				OnDrawView As Sub(ele As Any Ptr, px As Integer, py As Integer, x As Integer, y As Integer, w As Integer, h As Integer)
			End Type
			
			
			' 列表框事件结构
			Type ListBoxEvent
				OnDrawItem As Sub(ele As Any Ptr, iPos As UInteger, Item As List_Item_BasicStruct Ptr, stk As Integer, x As Integer, y As Integer, w As Integer, h As Integer)
				OnClickItem As Sub(ele As Any Ptr, iPos As UInteger, btn As Integer)
				OnDoubleClickItem As Sub(ele As Any Ptr, iPos As UInteger, btn As Integer)
				OnSelectChange As Sub(ele As Any Ptr, iOld As UInteger)
			End Type
			
			
			' 子元素列表类
			Type ElementList Extends xBsmm
				Parent As Any Ptr		' 父元素指针 [添加子元素的时候需要]
				Declare Function AddElement(elePtr As Any Ptr) As Integer
				Declare Function InsElement(elePtr As Any Ptr, iPos As Integer) As Integer
				Declare Function GetElement(iPos As Integer) As Any Ptr
				Declare Function DelElement(iPos As Integer) As Integer
				Declare Sub Clear()
				Declare Function Count() As UInteger
			End Type
			
			
			' 元素基类
			Type Element
				ClassID As Integer					' 类识别编号，仅用于识别，没有其他意义 0x10000 以内的编号为引擎预留 [0=Element]
				LayoutMode As Integer				' 布局模式 [ 参考定义前缀 : XUI_LAYOUT ]
				Layout As xui.Layout				' 布局数据
				ClassEvent As ElementEvent			' 事件
				Childs As ElementList				' 子元素数据
				Parent As Element Ptr = NULL		' 父元素指针
				Visible As Integer = -1				' 是否显示 [参与布局和绘制的开关] [使用布局的话修改后必须重新应用布局]
				DrawBuffer As xge.Surface Ptr		' 绘制缓冲区
				NeedRedraw As Integer = -1			' 需要重绘标记
				Identifier As ZString * 32			' 元素ID [相当于引擎附加数据，用户可以将ID映射到脚本语言中处理事件]
				DrawRange As Integer = 0			' 绘制元素范围
				TagInt As Integer					' 附加数据
				TagPtr As Any Ptr					' 附加数据
				
				' 构造函数
				Declare Constructor()
				Declare Constructor(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sIdentifier As ZString Ptr = NULL)
				
				' 析构函数
				Declare Destructor()
				
				' 填写基础数据
				Declare Sub InitElement(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sIdentifier As ZString Ptr = NULL)
				
				' 应用布局
				Declare Sub LayoutApply()
				
				' 绘制
				Declare Sub Draw(sf As xge.Surface Ptr = NULL, px As Integer = 0, py As Integer = 0)
				
				' 事件链
				Declare Function EventLink(msg As Integer,param As Integer,eve As xge_event Ptr) As Integer
				
				' 画参考线
				Declare Sub DrawDebug()
			End Type
			
			
			' 按钮类
			Type Button Extends xui.Element
				Text As ZString Ptr								' 按钮的标题
				TextOffset As xui.Coord							' 按钮标题坐标偏移
				TextFont As UInteger							' 按钮标题的字体
				
				Mode As Integer									' 工作模式 [1=复选框、2=单选框、其他=无状态按钮]
				Checked As Integer								' 按钮是否被选中
				
				' 背景样式
				NormalStyle As BackStyle_Text_Struct			' 正常状态的样式
				HotStyle As BackStyle_Text_Struct				' 按钮被激活的样式 (鼠标进入)
				PressStyle As BackStyle_Text_Struct				' 按钮被按下的样式
				CheckStyle As BackStyle_Text_Struct				' 选中时的样式
				
				' 声音
				EnterSound As xge.Sound Ptr						' 鼠标进入的声音
				LeaveSound As xge.Sound Ptr						' 鼠标离开的声音
				DownSound As xge.Sound Ptr						' 鼠标按下的声音
				ClickSound As xge.Sound Ptr						' 按钮被点击的声音 [鼠标按下并松开时播放]
				
				'Declare Sub ApplyStyle(StyleID As Integer = 0)	' 应用样式
				
				Event As ButtonEvent							' 按钮的事件
				
				' 不公开的属性 [但我没有隐藏这些细节，方便二次开发]
				private_Status As Integer						' 按钮的状态 [0=常规、1=热点、2=按下]
				private_AllowClick As Integer					' 允许触发点击事件 [当鼠标是在按钮上按下的时候设置为TRUE]
			End Type
			
			
			' 标签类
			Type Label Extends xui.Element
				Text As ZString Ptr								' 标题
				TextOffset As xui.Coord							' 标题显示偏移
				TextColor As UInteger							' 标题颜色
				TextFont As UInteger							' 标题字体
				TextAlign As Integer							' 标题对齐方式
				LineSpace As Integer							' 行间距
				WordSpace As Integer							' 字间距
				BackStyle As xui.BackStyle_Struct				' 背景样式
			End Type
			
			
			' 容器类
			Type Frame Extends xui.Element
				Text As ZString Ptr								' 标题
				TextColor As UInteger							' 标题颜色
				TextFont As UInteger							' 标题字体
				BackStyle As xui.BackStyle_Struct				' 背景样式
			End Type
			
			
			' 图像类
			Type Image Extends xui.Element
				Image As xge.Surface Ptr						' 图像对象指针
				ImageOffset As xui.Coord						' 图像绘制偏移
				BorderWidth As UInteger							' 边框宽度
				BorderColor As UInteger							' 边框颜色
			End Type
			
			
			' 滚动条类
			Type ScrollBar Extends xui.Element
				Max As Integer									' 最大值
				Min As Integer									' 最小值
				Value As Integer								' 当前值
				SmallChange As Integer							' 当用户单击滚动条上下按钮或箭头键时的滚动幅度
				LargeChange As Integer							' 当用户单击滚动条空白空间或PageDown、PageUp时的滚动幅度
				WhellChange As Integer							' 滚轮的滚动幅度
				BackStyle As xui.BackStyle_Struct				' 背景样式
				
				Event As ScrollBarEvent							' 滚动条的事件
				
				' 设置滚动范围
				Declare Sub SetRange(iMin As Integer, iMax As Integer, bApplyLayout As Integer = TRUE)
				
				' 不公开的属性 [但我没有隐藏这些细节，方便二次开发]
				private_Type As Integer							' 类型 [1=横向滚动条、else=纵向滚动条]
				private_DragX As Integer						' 拖动滑块时记录的横坐标
				private_DragY As Integer						' 拖动滑块时记录的纵坐标
				private_SpaceCount As Integer					' 拖动滑块时，总的空白空间像素数
				private_ButtonUp As xui.Button Ptr				' 上 按钮
				private_ButtonDown As xui.Button Ptr			' 下 按钮
				private_ButtonCurPos As xui.Button Ptr			' 当前位置 按钮
				private_SpaceUp As xui.Element Ptr				' 上方空间 元素
				private_SpaceDown As xui.Element Ptr			' 下方空间 元素
			End Type
			
			
			' 滚动视图类
			Type ScrollView Extends xui.Element
				View As xui.Rect								' 视图 [ x+y=视图绘制位置、w+h=视图完整大小 ]
				ScrollBar As Integer							' 滚动条显示状态
				BorderWidth As UInteger							' 边框宽度
				BorderColor As UInteger							' 边框颜色
				BackColor As UInteger							' 背景颜色 [它只会用来填充两个滚动条附近的空白]
				
				ViewEvent As ScrollViewEvent						' 滚动视图的事件
				
				' 构造函数
				Declare Constructor()
				
				' 设置视图大小
				Declare Sub SetViewSize(nw As Integer, nh As Integer, bApplyLayout As Integer = TRUE)
				
				' 不公开的属性 [但我没有隐藏这些细节，方便二次开发]
				private_VScroll As xui.ScrollBar Ptr			' 视图滚动条
				private_HScroll As xui.ScrollBar Ptr			' 视图滚动条
				DefaultScrollBar As xui.ScrollBar Ptr			' 默认滚动条 [在视图上拨动滚动条，会将消息发送给这个元素，默认使用垂直滚动条]
			End Type
			
			
			' 列表框类 (列表项范围从1开始, 0代表非法范围, 选择是0表示没有任何列表项被选中)
			Type ListBox Extends xui.Element
				List As List_ItemSet							' 列表项集合
				TextColor As UInteger							' 文字颜色
				TextFont As UInteger							' 文字字体
				BackStyle As xui.BackStyle_Struct				' 背景样式
				ItemHotStyle As xui.BackStyle_Struct			' 热点项样式
				ItemSelStyle As xui.BackStyle_Struct			' 选中项样式
				BorderWidth As UInteger							' 边框宽度
				ItemHeight As UInteger							' 列表项高度
				
				Event As ListBoxEvent							' 列表框事件
				
				Declare Property ListIndex As Integer
				Declare Property ListIndex(iPos As Integer)
				
				' 不公开的属性 [但我没有隐藏这些细节，方便二次开发]
				private_HotItem As UInteger						' 鼠标指向的元素
				private_ListIndex As UInteger					' 当前选择项
				private_WordHeight As UInteger					' 文字高度
				private_ShowCount As UInteger					' 列表能够显示的项目数量 [用于计算滚动条]
				private_Scroll As xui.ScrollBar Ptr				' 滚动条
				private_ShowScroll As Integer					' 是否显示滚动条
			End Type
			
			
			' 获取根元素 (Desktop元素)
			Declare Function GetRootElement() As xui.Element Ptr
			
			' 获取被激活的元素
			Declare Function GetActiveElement() As xui.Element Ptr
			
			' 激活元素 [传递NULL则取消当前激活的元素]
			Declare Sub ActiveElement(ele As xui.Element Ptr)
			
			' 获取鼠标指针下的热点元素
			Declare Function GetHotElement() As xui.Element Ptr
			
			' 释放某个元素下的所有子元素 (默认清空Desktop元素)
			Declare Sub FreeChilds(ui As xui.Element Ptr = NULL)
			
			' 应用布局
			Declare Sub LayoutApply()
			
			' 创建基础元素
			Declare Function CreateElement(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sIdentifier As ZString Ptr = NULL) As xui.Element Ptr
			
			' 创建标签元素
			Declare Function CreateLabel(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, TextColor As UInteger = &HFFFFFFFF, TextFont As UInteger = 1, sIdentifier As ZString Ptr = NULL) As xui.Label Ptr
			
			' 创建容器元素
			Declare Function CreateFrame(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sCaption As ZString Ptr = NULL, sIdentifier As ZString Ptr = NULL) As xui.Frame Ptr
			
			' 创建图像元素
			Declare Function CreateImage(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, pImage As xge.Surface Ptr = NULL, sIdentifier As ZString Ptr = NULL) As xui.Image Ptr
			
			' 创建按钮元素
			Declare Function CreateButton(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr
			
			' 创建选择按钮元素
			Declare Function CreateCheckButton(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr
			Declare Function CreateRadioButton(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr
			
			' 创建复选框元素
			Declare Function CreateCheckBox(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr
			
			' 创建单选框元素
			Declare Function CreateRadioBox(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr
			
			' 创建超链接元素
			Declare Function CreateHyperLink(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr
			
			' 创建纵向滚动条
			Declare Function CreateVScrollBar(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 18, h As Integer = 200, sIdentifier As ZString Ptr = NULL) As xui.ScrollBar Ptr
			
			' 创建横向滚动条
			Declare Function CreateHScrollBar(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 200, h As Integer = 18, sIdentifier As ZString Ptr = NULL) As xui.ScrollBar Ptr
			
			' 创建滚动视图
			Declare Function CreateScrollView(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 200, h As Integer = 200, vw As Integer = 200, vh As Integer = 200, sIdentifier As ZString Ptr = NULL) As xui.ScrollView Ptr
			
			' 创建列表框
			Declare Function CreateListBox(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 120, h As Integer = 200, TextColor As UInteger = &HFF000000, TextFont As UInteger = 1, sIdentifier As ZString Ptr = NULL) As xui.ListBox Ptr
			
		End Namespace
		
		
		
		/' -------------------------- 网络库 -------------------------- '/
		Namespace xSock
			
			Type ServerEvent
				recv As Sub(client As HANDLE, pack As Any Ptr, size As UInteger)
				send As Sub(client As HANDLE, code As Integer)
				Accept As Sub(client As HANDLE)
				Disconn As Sub(client As HANDLE)
			End Type
			
			Type ClientEvent
				recv As Sub(pack As Any Ptr, size As UInteger)
				send As Sub(code As Integer)
				Disconn As Sub()
			End Type
			
			Type xServer
				Section As CRITICAL_SECTION
				
				' 事件
				Event As ServerEvent
				
				' 析构
				Declare Destructor()
				
				' 创建
				Declare Function Create(ip As ZString Ptr, port As UShort, max As UInteger = 1000, ThreadCountt As UInteger = 1) As Integer
				
				' 销毁
				Declare Sub Destroy()
				
				' 状态
				Declare Function Status() As Integer
				
				' 发送
				Declare Function Send(Client As HANDLE, pack As Any Ptr, size As UInteger, sync As Integer = TRUE) As Integer
				
				' 遍历客户端
				Declare Function EnumClient(first As HANDLE) As HANDLE
				
				' 获取客户端信息
				Declare Function GetClientInfo(client As HANDLE, ip As ZString Ptr Ptr, port As UInteger Ptr) As Integer
				
				' 内部事件函数
				#Ifdef XGE_SOURCE_BUILD
					Declare Sub AcceptProc(client As HANDLE)
					Declare Sub DisconnProc(client As HANDLE)
				#EndIf
				
				Private:
					h_Socket As HANDLE
					c_Max As UInteger
					c_Conn As UInteger
					c_Enter As UInteger
					c_Leave As UInteger
					c_List As HANDLE Ptr
					c_FindCursor As UInteger
					c_AddIndex As UInteger
					
					' 添加到客户端列表
					Declare Function AddClientList(client As HANDLE) As Integer
					
					' 从客户端列表删除
					Declare Function DelClientList(client As HANDLE) As Integer
			End Type
	
			Type xClient
				Section As CRITICAL_SECTION
				
				' 事件
				Event As ClientEvent
				
				' 析构
				Declare Destructor()
				
				' 连接
				Declare Function Connect(ip As ZString Ptr, port As UShort) As Integer
				
				' 断开
				Declare Sub Close()
				
				' 状态
				Declare Function Status() As Integer
				
				' 发送
				Declare Function Send(pack As Any Ptr, size As UInteger, sync As Integer = TRUE) As Integer
				
				Private:
					h_Client As HANDLE
			End Type
			
			Type xUDP
				' 事件函数
				RecvEvent As Sub(pack As Any Ptr, size As UInteger, ip As ZString Ptr, port As Integer)
				SendEvent As Sub(code As Integer)
				
				' 析构
				Declare Destructor()
				
				' 创建
				Declare Function Create(ip As ZString Ptr, port As UShort, ThreadCountt As UInteger = 1) As Integer
				
				' 销毁
				Declare Sub Destroy()
				
				' 状态 [已创建=TRUE]
				Declare Function Status() As Integer
				
				' 发送
				Declare Function Send(pack As Any Ptr, size As UInteger, ip As ZString Ptr, port As UShort, sync As Integer = TRUE) As Integer
				
				Private:
					h_Socket As HANDLE
			End Type
			
		End Namespace
		
	End Extern
	
	
	
	Namespace xge
		
		Namespace Text
			
			/' -------------------------- 字体驱动结构体 -------------------------- '/
			Type FontDriver
				
				Font As Any Ptr
				
				FontSizeInt As Integer
				WidthInt As Integer
				HeightInt As Integer
				
				FontSizeFloat As Single
				WidthFloat As Single
				HeightFloat As Single
				
				Tag As Integer
				TagFloat As Single
				
				' 必要的接口
				DrawWord As Sub(fd As FontDriver Ptr, sf As xge.Surface Ptr, px As Integer, py As Integer, w As Integer, h As Integer, iCode As UInteger, iColor As Integer, Style As Integer)
				DrawWordA As Sub(fd As FontDriver Ptr, sf As xge.Surface Ptr, px As Integer, py As Integer, w As Integer, h As Integer, iCode As UInteger, iColor As Integer, Style As Integer)
				WordInfo As Sub(fd As FontDriver Ptr, iCode As Integer, Style As Integer, w As Integer Ptr, h As Integer Ptr)
				WordInfoA As Sub(fd As FontDriver Ptr, iCode As Integer, Style As Integer, w As Integer Ptr, h As Integer Ptr)
				
				' 清理字库(删除字库的时候用，比如释放内存之类的)
				FreeFont As Sub(fd As FontDriver Ptr)
				
				' 设置字体大小
				SetFontSize As Sub(fd As FontDriver Ptr, size As UInteger)
				
				' 输出一行文字
				DrawLine_Fast As Sub(fd As FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, txt As WString Ptr, iColor As Integer, Style As Integer, wd As Integer)
				DrawLineA_Fast As Sub(fd As FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, txt As ZString Ptr, iColor As Integer, Style As Integer, wd As Integer)
				
				' 输出一些文字到一个矩形范围内 [ align:对其方式、wd:字间距、ld:行间距 ] [暂未实现自动换行功能]
				DrawRect_Fast As Sub(fd As FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, w As Integer, h As Integer, txt As WString Ptr, iColor As Integer, Style As Integer, align As Integer, wd As Integer, ld As Integer)
				DrawRectA_Fast As Sub(fd As FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, w As Integer, h As Integer, txt As ZString Ptr, iColor As Integer, Style As Integer, align As Integer, wd As Integer, ld As Integer)
				
			End Type
			
		End Namespace
		
	End Namespace
	
	
	
	Extern XGE_EXTERNMODULE
		
		Namespace xge
			
			/' -------------------------- 文字渲染库 -------------------------- '/
			Namespace Text
				
				' 加载字体 [ 目前支持 xrf字体 和 truetype字体 ] [ ttc字体包加载时通过param参数指定加载的字体ID ]
				Declare Function LoadFont(Addr As ZString Ptr, iSize As UInteger, param As Any Ptr = NULL) As UInteger
				
				' 移除字体 [移除字体后字体编号会变动，慎用]
				Declare Function RemoveFont(idx As UInteger) As Integer
				
				' 取得已加载的字体数量
				Declare Function FontCount() As Integer
				
				' 设置字体大小
				Declare Sub SetFontSize(idx As UInteger, size As UInteger)
				
				' 获取字体大小 [字体高度像素]
				Declare Function GetFontSize(idx As UInteger) As Integer
				
				' 写字
				Declare Sub Draw(sf As xge.Surface Ptr, px As Integer, py As Integer, txt As WString Ptr, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0)
				Declare Sub DrawA(sf As xge.Surface Ptr, px As Integer, py As Integer, txt As ZString Ptr, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0)
				
				' 矩形格式化写字 [ align:对其方式、wd:字间距、ld:行间距 ]
				Declare Sub DrawRect(sf As xge.Surface Ptr, px As Integer, py As Integer, pw As Integer, ph As Integer, txt As WString Ptr, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, align As Integer = XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, wd As Integer = 0, ld As Integer = 0)
				Declare Sub DrawRectA(sf As xge.Surface Ptr, px As Integer, py As Integer, pw As Integer, ph As Integer, txt As ZString Ptr, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, align As Integer = XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, wd As Integer = 0, ld As Integer = 0)
				
			End Namespace
			
			
			/' -------------------------- 辅助库 -------------------------- '/
			Namespace Aux
				Declare Function ScreenShot() As xge.Surface Ptr
				Declare Function GetPixel(sf As xge.Surface Ptr, x As Integer, y As Integer) As UInteger
				Declare Function RGB2BGR(c As UInteger) As UInteger
				Declare Sub SetTitle(title As ZString Ptr)
				Declare Sub SetView(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, f As Integer)
				Declare Sub ReSetView()
				Declare Sub SetCoodr(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer = 0)
				Declare Sub ReSetCoodr()
				Declare Function MapCoodr(coodr As Integer, tpe As Integer) As Integer
				Declare Function LockMouse() As Integer
				Declare Function UnLockMouse() As Integer
				Declare Function HideCursor() As Integer
				Declare Function ShowCursor() As Integer
			End Namespace
			
			
			/' -------------------------- 图形库 -------------------------- '/
			Namespace Shape
				Declare Sub Pixel(sf As xge.Surface Ptr, x As Integer, y As Integer, c As Integer)
				Declare Sub Lines(sf As xge.Surface Ptr, x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer)
				Declare Sub LinesEx(sf As xge.Surface Ptr, x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, s As Integer)
				Declare Sub Rect(sf As xge.Surface Ptr, x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer)
				Declare Sub RectEx(sf As xge.Surface Ptr, x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, s As Integer)
				Declare Sub RectFull(sf As xge.Surface Ptr, x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer)
				Declare Sub Circ(sf As xge.Surface Ptr, x As Integer, y As Integer, r As Integer, c As Integer)
				Declare Sub CircFull(sf As xge.Surface Ptr, x As Integer, y As Integer, r As Integer, c As Integer)
				Declare Sub CircEx(sf As xge.Surface Ptr, x As Integer, y As Integer, r As Integer, c As Integer, a As Single)
				Declare Sub CircFullEx(sf As xge.Surface Ptr, x As Integer, y As Integer, r As Integer, c As Integer, a As Single)
				Declare Sub CircArc(sf As xge.Surface Ptr, x As Integer, y As Integer, r As Integer, c As Integer, s As Integer, e As Integer, a As Single)
				Declare Sub Full(sf As xge.Surface Ptr, x As Integer, y As Integer, c As Integer, f As Integer)
				Declare Sub FullEx(sf As xge.Surface Ptr, x As Integer, y As Integer, p As ZString Ptr, f As Integer)
			End Namespace
			
			
		End Namespace
	End Extern
	
	
	
	' -------------------------- 场景结构体 -------------------------- '/
	Type XGE_SCENE
		proc As XGE_SCENE_PROC
		pause As Integer
		sync As Integer
		Lockfps As UInteger
		RootElement As xui.Element Ptr
	End Type
	
	
	
	Extern XGE_EXTERNSTDEXT
		/' -------------------------- 混合渲染库 -------------------------- '/
		Declare Function Blend_Custom(src As xge.Surface Ptr, px As Integer, py As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer,dst As xge.Surface Ptr, bk As XGE_DRAW_BLEND, param As Integer) As Integer
		Declare Sub Blend_Gray(SrcAddr As Any Ptr, SrcPitch As Integer, SrcLineS As Integer, DstAddr As Any Ptr, DstPitch As Integer, DstLineS As Integer, w As Integer, h As Integer, param As Integer)
		Declare Sub Blend_Mirr(SrcAddr As Any Ptr, SrcPitch As Integer, SrcLineS As Integer, DstAddr As Any Ptr, DstPitch As Integer, DstLineS As Integer, w As Integer, h As Integer, param As Integer)
		Declare Sub Blend_Shade(SrcAddr As Any Ptr, SrcPitch As Integer, SrcLineS As Integer, DstAddr As Any Ptr, DstPitch As Integer, DstLineS As Integer, w As Integer, h As Integer, param As Integer)
		Declare Sub SetShadeData(w As Integer, h As Integer, d As Any Ptr)
		Declare Sub MakeShadeData(sf As xge.Surface Ptr, sd As UByte Ptr)
		
		
		/' -------------------------- 字符集转换库 -------------------------- '/
		Declare Function AsciToUnicode(ZStrPtr As ZString Ptr, ZStrLen As UInteger) As Any Ptr
		Declare Function UnicodeToAsci(WStrPtr As WString Ptr, WStrLen As UInteger) As Any Ptr
		Declare Function UnicodeToUTF8(WStrPtr As WString Ptr, WStrLen As UInteger) As Any Ptr
		Declare Function UTF8ToUnicode(UTF8Ptr As ZString Ptr, UTF8Len As UInteger) As Any Ptr
		Declare Function A2W(AStr As ZString Ptr, ALen As UInteger = 0) As WString Ptr
		Declare Function W2A(UStr As WString Ptr, ULen As UInteger = 0) As ZString Ptr
		Declare Function W2U(UStr As WString Ptr, ULen As UInteger = 0) As ZString Ptr
		Declare Function U2W(UStr As ZString Ptr, ULen As UInteger = 0) As ZString Ptr
		Declare Function A2U(ZStr As ZString Ptr, ZLen As UInteger = 0) As ZString Ptr
		Declare Function U2A(UStr As ZString Ptr, ULen As UInteger = 0) As ZString Ptr
		
		
		/' -------------------------- 其他易用性函数库 -------------------------- '/
		Declare Function Split(sText As ZString Ptr, sSep As ZString Ptr) As ZString Ptr Ptr
		Declare Sub xui_DrawBackStyle(ele As xui.Element Ptr, bs As xui.BackStyle_Struct Ptr)
		Declare Sub xui_DrawBackStyle_Text(ele As xui.Element Ptr, bs As xui.BackStyle_Text_Struct Ptr, sText As ZString Ptr, fontid As UInteger, CaptionOffset As xui.Coord Ptr)
	End Extern
	
	
	
#EndIf


