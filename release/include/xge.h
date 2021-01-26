// ==================================================================================
	// ★ xywh Game Engine 引擎头文件
	// #-----------------------------------------------------------------------------
	// # 功能 :
	// # 说明 :
// ==================================================================================



#ifndef xywh_library_xge
	#define xywh_library_xge
	
	/* -------------------------- XUI元素ID最大字符数 -------------------------- */
	#Define XGE_XUI_IDSIZE		32
	
	
	
	/* -------------------------- 基础头文件 -------------------------- */
	#include <windows.h>
	
	
	
	/* -------------------------- 按键扫描码 -------------------------- */
	#define SC_ESCAPE					0x01
	#define SC_1						0x02
	#define SC_2						0x03
	#define SC_3						0x04
	#define SC_4						0x05
	#define SC_5						0x06
	#define SC_6						0x07
	#define SC_7						0x08
	#define SC_8						0x09
	#define SC_9						0x0A
	#define SC_0						0x0B
	#define SC_MINUS					0x0C
	#define SC_EQUALS					0x0D
	#define SC_BACKSPACE				0x0E
	#define SC_TAB						0x0F
	#define SC_Q						0x10
	#define SC_W						0x11
	#define SC_E						0x12
	#define SC_R						0x13
	#define SC_T						0x14
	#define SC_Y						0x15
	#define SC_U						0x16
	#define SC_I						0x17
	#define SC_O						0x18
	#define SC_P						0x19
	#define SC_LEFTBRACKET				0x1A
	#define SC_RIGHTBRACKET				0x1B
	#define SC_ENTER					0x1C
	#define SC_CONTROL					0x1D
	#define SC_A						0x1E
	#define SC_S						0x1F
	#define SC_D						0x20
	#define SC_F						0x21
	#define SC_G						0x22
	#define SC_H						0x23
	#define SC_J						0x24
	#define SC_K						0x25
	#define SC_L						0x26
	#define SC_SEMICOLON				0x27
	#define SC_QUOTE					0x28
	#define SC_TILDE					0x29
	#define SC_LSHIFT					0x2A
	#define SC_BACKSLASH				0x2B
	#define SC_Z						0x2C
	#define SC_X						0x2D
	#define SC_C						0x2E
	#define SC_V						0x2F
	#define SC_B						0x30
	#define SC_N						0x31
	#define SC_M						0x32
	#define SC_COMMA					0x33
	#define SC_PERIOD					0x34
	#define SC_SLASH					0x35
	#define SC_RSHIFT					0x36
	#define SC_MULTIPLY					0x37
	#define SC_ALT						0x38
	#define SC_SPACE					0x39
	#define SC_CAPSLOCK					0x3A
	#define SC_F1						0x3B
	#define SC_F2						0x3C
	#define SC_F3						0x3D
	#define SC_F4						0x3E
	#define SC_F5						0x3F
	#define SC_F6						0x40
	#define SC_F7						0x41
	#define SC_F8						0x42
	#define SC_F9						0x43
	#define SC_F10						0x44
	#define SC_NUMLOCK					0x45
	#define SC_SCROLLLOCK				0x46
	#define SC_HOME						0x47
	#define SC_UP						0x48
	#define SC_PAGEUP					0x49
	#define SC_LEFT						0x4B
	#define SC_RIGHT					0x4D
	#define SC_PLUS						0x4E
	#define SC_END						0x4F
	#define SC_DOWN						0x50
	#define SC_PAGEDOWN					0x51
	#define SC_INSERT					0x52
	#define SC_DELETE					0x53
	#define SC_F11						0x57
	#define SC_F12						0x58
	#define SC_LWIN						0x5B
	#define SC_RWIN						0x5C
	#define SC_MENU						0x5D
	
	
	/* -------------------------- 颜色定义 -------------------------- */
	#define COLOR_MASK_24				0xFF00FF
	#define COLOR_MASK_32				0xFFFF00FF
	#define COLOR_A						0xFF000000
	#define COLOR_R						0x00FF0000
	#define COLOR_G						0x0000FF00
	#define COLOR_B						0x000000FF
	#define COLOR_32					0xFFFFFFFF
	
	
	/* -------------------------- 镜像定义 -------------------------- */
	#define XGE_BLEND_MIRR_H			1				// 水平
	#define XGE_BLEND_MIRR_V			2				// 垂直
	#define XGE_BLEND_MIRR_HV			3				// 水平 + 垂直
	#define XGE_BLEND_MIRR_VH			3				// 水平 + 垂直
	
	
	/* -------------------------- 初始化定义 -------------------------- */
	#define XGE_INIT_WINDOW				0x00			// 窗口模式
	#define XGE_INIT_FULLSCREEN			0x01			// 全屏模式
	#define XGE_INIT_NOSWITCH			0x04			// 不允许alt + enter切换窗口/全屏
	#define XGE_INIT_NOFRAME			0x08			// 窗口没有边框
	#define XGE_INIT_POSTOP				0x20			// 窗口置顶
	#define XGE_INIT_ALPHA				0x40			// 开启alpha混合对于所有基础操作
	#define XGE_INIT_HIGHPRIORITY		0x80			// 图像库高优先权给图像处理
	
	
	/* -------------------------- 场景消息定义 -------------------------- */
	#define XGE_MSG_NULL				0x00			// 空消息
	#define XGE_MSG_LOADRES				0x01			// 载入资源
	#define XGE_MSG_FREERES				0x02			// 释放资源
	#define XGE_MSG_FRAME				0x03			// 框架函数
	#define XGE_MSG_DRAW				0x04			// 绘图函数
	#define XGE_MSG_ERROR				0x05			// 错误处理
	#define XGE_MSG_MOUSE_MOVE			0x101			// 鼠标移动
	#define XGE_MSG_MOUSE_DOWN			0x102			// 鼠标按下
	#define XGE_MSG_MOUSE_UP			0x103			// 鼠标弹起
	#define XGE_MSG_MOUSE_CLICK			0x104			// 鼠标单击
	#define XGE_MSG_MOUSE_DCLICK		0x105			// 鼠标双击
	#define XGE_MSG_MOUSE_WHELL			0x106			// 滚轮滚动
	#define XGE_MSG_KEY_DOWN			0x201			// 按键按下
	#define XGE_MSG_KEY_UP				0x202			// 按键弹起
	#define XGE_MSG_KEY_REPEAT			0x203			// 按键按住
	#define XGE_MSG_MOUSE_ENTER			0x301			// 鼠标移入
	#define XGE_MSG_MOUSE_EXIT			0x302			// 鼠标离开
	#define XGE_MSG_LOSTFOCUS			0x311			// 丢失焦点
	#define XGE_MSG_GOTFOCUS			0x312			// 获得焦点
	#define XGE_MSG_CLOSE				0x321			// 窗口关闭
	
	
	/* -------------------------- 暂停定义 -------------------------- */
	#define XGE_PAUSE_DRAW				0x01			// 暂停绘制
	#define XGE_PAUSE_FRAME				0x02			// 暂停场景框架


	/* -------------------------- 文件类型定义 -------------------------- */
	#define XGE_IMG_FMT_BMP				0
	#define XGE_IMG_FMT_XGI				1
	
	
	/* -------------------------- XGI文件相关定义 -------------------------- */
	#define XGI_FLAG_LZ4				1				// 是否启用 LZ4 压缩
	#define XGI_FLAG_B16				2				// 是否为 16 位图像


	/* -------------------------- 音频类型定义 -------------------------- */
	#define XGE_SOUND_SAMPLE			1
	#define XGE_SOUND_MUSIC				2
	#define XGE_SOUND_STREAM			3


	/* -------------------------- 小样载入标记定义 -------------------------- */
	#define XGE_SUD_SMP_LOOP			4				// 循环
	#define XGE_SUD_SMP_MONO			2				// 单声道
	#define XGE_SUD_SMP_8B				1				// 8位
	#define XGE_SUD_SMP_32B				256				// 32位
	#define XGE_SUD_SMP_SOFT			16				// 软件混音


	/* -------------------------- 流媒体载入标记定义 -------------------------- */
	#define XGE_SUD_STE_LOOP			4				// 循环
	#define XGE_SUD_STE_MONO			2				// 单声道
	#define XGE_SUD_STE_32B				256				// 32位
	#define XGE_SUD_STE_SOFT			16				// 软件混音
	#define XGE_SUD_STE_PRES			0x20000			// 预扫描
	#define XGE_SUD_STE_AFRE			0x40000			// 播放结束自动释放
	#define XGE_SUD_STE_BLOCK			0x100000		// 分段下载url流媒体 [不能循环播放]
	#define XGE_SUD_STE_URL				0x80000000		// 从URL载入


	/* -------------------------- 音乐载入标记定义 -------------------------- */
	#define XGE_SUD_MUS_LOOP			4				// 循环
	#define XGE_SUD_MUS_MONO			2				// 单声道
	#define XGE_SUD_MUS_32B				256				// 32位
	#define XGE_SUD_MUS_SOFT			16				// 软件混音
	#define XGE_SUD_MUS_PRES			0x20000			// 预扫描
	#define XGE_SUD_MUS_AFRE			0x40000			// 播放结束自动释放
	#define XGE_SUD_MUS_SUR				0x800			// 环绕
	#define XGE_SUD_MUS_SUR2			0x1000			// 环绕 [模式2]
	#define XGE_SUD_MUS_NSMP			0x100000		// 不加载小样


	/* -------------------------- 音量设置定义 -------------------------- */
	#define XGE_SUD_VOL_ALL				0x0
	#define XGE_SUD_VOL_SMP				0x4
	#define XGE_SUD_VOL_STE				0x5
	#define XGE_SUD_VOL_MUS				0x6


	/* -------------------------- 文本对齐定义 -------------------------- */
	#define XGE_ALIGN_LEFT				0x0				// 横向左对齐
	#define XGE_ALIGN_CENTER			0x1				// 横向居中对齐
	#define XGE_ALIGN_RIGHT				0x2				// 横向右对齐
	#define XGE_ALIGN_TOP				0x0				// 纵向上对齐
	#define XGE_ALIGN_MIDDLE			0x4				// 纵向居中对齐
	#define XGE_ALIGN_BOTTOM			0x8				// 纵向底部对齐


	/* -------------------------- 字体风格定义 -------------------------- */
	#define XGE_FONT_BOLD				0x10			// 粗体
	#define XGE_FONT_ITALIC				0x20			// 斜体
	#define XGE_FONT_BOLDITALIC			0x30			// 粗体 + 斜体
	#define XGE_FONT_UNDERLINE			0x40			// 下划线
	#define XGE_FONT_SRTIKEOUT			0x80			// 删除线
	
	
	/* -------------------------- GUI布局方式定义 -------------------------- */
	#define XUI_LAYOUT_COORD			0				' 布局系统 - 浮动布局，根据坐标决定位置
	#define XUI_LAYOUT_L2R				1				' 布局系统 - 横向布局 [从左到右]
	#define XUI_LAYOUT_R2L				2				' 布局系统 - 横向布局 [从右到左]
	#define XUI_LAYOUT_T2B				3				' 布局系统 - 纵向布局 [从上到下]
	#define XUI_LAYOUT_B2T				4				' 布局系统 - 纵向布局 [从下到上]
	
	
	/* -------------------------- GUI布局尺度定义 -------------------------- */
	#define XUI_LAYOUT_RULER_COORD		-1				' 布局尺度 - 绝对坐标 [打破父控件的布局方案]
	#define XUI_LAYOUT_RULER_PIXEL		0				' 布局尺度 - 像素
	#define XUI_LAYOUT_RULER_RATIO		1				' 布局尺度 - 剩余百分比
	
	
	/* -------------------------- 元素 ClassID 定义 -------------------------- */
	#define XUI_CLASS_ELEMENT			0				' 基本元素
	#define XUI_CLASS_BUTTON			1				' 按钮(包含单选、复选类元素)
	#define XUI_CLASS_STATIC			2				' 静态元素(包含标签、图片等)
	#define XUI_CLASS_SCROLLBAR			3				' 滚动条(包含横向和纵向)
	#define XUI_CLASS_SCROLLVIEW		4				' 滚动视图
	#define XUI_CLASS_LISTBOX			5				' 列表框
	#define XUI_CLASS_COMBOBOX			6				' 组合框
	#define XUI_CLASS_PROGRESSBAR		7				' 进度条
	#define XUI_CLASS_SLIDER			8				' 滑块
	#define XUI_CLASS_ANIMATBOX			9				' 动画
	#define XUI_CLASS_LINEEDIT			10				' 行编辑框
	#define XUI_CLASS_TEXTBOX			11				' 全功能文本编辑框
	#define XUI_CLASS_WINDOW			12				' 动画
	#define XUI_CLASS_USER				&H10000			' 用户自定义元素的开始ID
	
	
	/* -------------------------- 元素滚动条显示状态定义 -------------------------- */
	#define XUI_SCROLL_V				1				' 显示纵向滚动条
	#define XUI_SCROLL_H				2				' 显示横向滚动条
	#define XUI_SCROLL_VH				3				' 横向和纵向滚动条都显示
	#define XUI_SCROLL_HV				3				' 横向和纵向滚动条都显示
	
	
	/* -------------------------- 元素进度条显示状态定义 -------------------------- */
	#define XUI_PROGRESSBAR_HIDE		0				' 不显示
	#define XUI_PROGRESSBAR_PERCENT		1				' 显示百分比
	#define XUI_PROGRESSBAR_VALUE		2				' 显示数值
	
	
	/* -------------------------- XUI IME 相关事件ID定义 -------------------------- */
	#define XUI_IME_INPUT				0				' IME传递输入数据
	#define XUI_IME_STARTCOMPOSITION	1				' IME开始输入
	#define XUI_IME_COMPTEXT			2				' IME输入变动
	#define XUI_IME_ENDCOMPOSITION		3				' IME输入结束
	#define XUI_IME_CHAR				4				' WM_CHAR
	
	
	/* -------------------------- 文件查找规则 -------------------------- */
	#define XFILE_RULE_NoAttribEx		0				' 不限制
	#define XFILE_RULE_FloderOnly		1				' 只查找目录
	#define XFILE_RULE_PointFloder		2				' 去除根目录及父级目录


	/* -------------------------- 消息结构体 -------------------------- */
	struct XGE_EVENT
	{
		int tpe;
		union
		{
			struct
			{
				int scancode;
				int ascii;
			};
			struct
			{
				int x;
				int y;
				int dx;
				int dy;
			};
			struct
			{
				int param1;
				int param2;
				int param3;
				int param4;
			};
			struct
			{
				int mx;
				int my;
				int button;
			};
			struct
			{
				int zx;
				int zy;
				int z;
				int nz;
			};
			int w;
		};
	};


	/* -------------------------- 图像结构体 -------------------------- */
	struct FBGFX_IMAGE
	{
		unsigned int tpe;
		int bpp;
		unsigned int Width;
		unsigned int Height;
		unsigned int Pitch;
		unsigned char reserved[12];
	};
	
	
	
	/* -------------------------- 点数据结构 -------------------------- */
	struct xge_Coord
	{
		int x;
		int y;
	};
	
	
	
	/* -------------------------- 矩形数据结构 -------------------------- */
	struct xge_Rect
	{
		union
		{
			int x;
			int LeftOffset;
		};
		union
		{
			int y;
			int TopOffset;
		};
		union
		{
			int w;
			int RightOffset;
		};
		union
		{
			int h;
			int BottomOffset;
		};
	};


	/* -------------------------- 数据类型定义 -------------------------- */
	typedef int (CALLBACK *XGE_SCENE_PROC)(int msg, int param, XGE_EVENT *eve);
	typedef void (CALLBACK *XGE_EVENT_PROC)(XGE_EVENT *eve);
	typedef void (CALLBACK *XGE_DELAY_PROC)(int ms);
	typedef int (CALLBACK *XGE_BLOAD_PROC)(void* img, wchar_t* addr, unsigned int size);
	typedef int (CALLBACK *XGE_FLOAD_PROC)(void* fd, wchar_t* addr, unsigned int size, void* param);
	typedef void (CALLBACK *XGE_DRAW_BLEND)(void* SrcAddr, int SrcPitch, int SrcLineS, void* DstAddr, int DstPitch, int DstLineS, int w, int h, int param);
	typedef unsigned int (CALLBACK *XGE_DRAW_CUSTOM)(unsigned int src, unsigned int dst, void* param);


	/* -------------------------- xSock 回调定义 -------------------------- */
	typedef void (CALLBACK *XGE_SOCK_SRECV)(void* client, char* pack, unsigned int size);
	typedef void (CALLBACK *XGE_SOCK_SSEND)(void* client, int code);
	typedef void (CALLBACK *XGE_SOCK_SACCEPT)(void* client);
	typedef void (CALLBACK *XGE_SOCK_SDISCONN)(void* client);
	typedef void (CALLBACK *XGE_SOCK_CRECV)(char* pack, unsigned int size);
	typedef void (CALLBACK *XGE_SOCK_CSEND)(int code);
	typedef void (CALLBACK *XGE_SOCK_CACCEPT)();
	typedef void (CALLBACK *XGE_SOCK_URECV)(char* pack, unsigned int size, char* ip, int port);
	typedef void (CALLBACK *XGE_SOCK_USEND)(int code);




	/* -------------------------- 栈结构类[结构体] -------------------------- */
	class xStack
	{
	public:
		// 构造/析构
		_stdcall xStack(unsigned int max, unsigned int unitsize);
		_stdcall ~xStack();

		// 初始化/卸载
		_stdcall int Init(unsigned int max, unsigned int unitsize);
		_stdcall void Unit();

		// 压栈
		_stdcall int Push(void* dat);

		// 出栈
		_stdcall void* Pop(unsigned int c);

		// 栈顶
		_stdcall void* Top();

		// 压栈数量
		_stdcall unsigned int Count();

	private:
		unsigned int pMaxCount;
		unsigned int pUnitSize;
		void* pStackMem;
		unsigned int pStackTop;
	};
	
	
	
	/* -------------------------- 结构化内存管理器 -------------------------- */
	class xBsmm
	{
		// 管理器内存指针
		void* StructMemory;
		
		// 成员占用内存长度
		unsigned int StructLenght;
		
		// 管理器中存在多少成员
		unsigned int StructCount;
		
		// 已经申请的结构数量
		unsigned int AllocCount;
		
		// 预分配内存步长
		unsigned int AllocStep;
		
		// 构造函数
		_stdcall xBsmm();
		_stdcall xBsmm(unsigned int iItemLenght, unsigned int PreassignStep = 32, unsigned int PreassignLenght = 0);
		
		// 析构函数
		_stdcall ~xBsmm();
		
		// 添加成员
		_stdcall unsigned int InsertStruct(unsigned int iPos, unsigned int iCount = 1);
		_stdcall unsigned int AppendStruct(unsigned int iCount = 1);
		
		// 删除成员
		_stdcall int DeleteStruct(unsigned int iPos, unsigned int iCount = 1);
		
		// 移动成员
		_stdcall int SwapStruct(unsigned int iPosA, unsigned int iPosB);
		
		// 获取成员指针
		_stdcall void* GetPtrStruct(unsigned int iPos);
		
		// 分配内存
		_stdcall int CallocMemory(unsigned int iCount);
		
		// 重置（释放资源）
		_stdcall void ReInitManage();
	};
	
	
	
	/* -------------------------- 字符串缓冲区管理器 [UCS2] -------------------------- */
	class xStringBuffer
	{
		// 内存指针
		wcahr_t* BufferMemory;
		
		// 数据长度
		unsigned int BufferLenght;
		
		// 已经申请的内存长度
		unsigned int AllocLenght;
		
		// 预分配内存步长
		unsigned int AllocStep;
		
		// 附加数据
		int Tag;
		
		// 构造函数
		_stdcall xStringBuffer();
		
		// 析构函数
		_stdcall ~xStringBuffer();
		
		// 设置数据
		_stdcall int SetText(wcahr_t* sText, unsigned int iTextSize = 0);
		
		// 追加写数据
		_stdcall int AppendText(wcahr_t* sText, unsigned int iTextSize = 0);
		
		// 插入写数据
		_stdcall int InsertText(unsigned int iPos, unsigned int iSize, wcahr_t* sText, unsigned int iTextSize = 0);
		
		// 删除数据
		_stdcall int DeleteText(unsigned int iPos, unsigned int iSize);
		
		// 分配内存
		_stdcall int MallocMemory(unsigned int iLenght);
		
		// 释放内存
		_stdcall void FreeMemory();
	};
	
	
	/* -------------------------- 核心库 -------------------------- */
	namespace xge
	{
		_stdcall int InitA(unsigned int w, unsigned int h, int init_gfx = XGE_INIT_WINDOW, char* title = NULL);
		_stdcall int InitW(unsigned int w, unsigned int h, int init_gfx = XGE_INIT_WINDOW, wchar_t* title = NULL);
		_stdcall void Unit();
		_stdcall int SetScreen(unsigned int w, unsigned int h, int init_gfx = XGE_INIT_WINDOW);
		_stdcall HANDLE hWnd();
		_stdcall void Clear();
		_stdcall void Lock();
		_stdcall void UnLock();
		_stdcall void Sync();
		_stdcall unsigned int Width();
		_stdcall unsigned int Height();
		_stdcall void* PixAddr();
		_stdcall unsigned int PixSize();
		_stdcall unsigned int Pitch();
		_stdcall void SetSoundVol(int tpe, int vol);
		_stdcall int GetSoundVol(int tpe);


		/* -------------------------- 图像类 -------------------------- */
		class Surface
		{
		public:
			FBGFX_IMAGE* img;

			// 构造 [空]
			_stdcall Surface();

			// 构造 [创建]
			_stdcall Surface(unsigned int w, unsigned int h);

			// 构造 [加载]
			_stdcall Surface(char* addr, unsigned int size = 0);
			_stdcall Surface(wchar_t* addr, unsigned int size = 0);

			// 析构
			_stdcall ~Surface();

			// 创建图像
			_stdcall int Create(unsigned int w, unsigned int h);

			// 载入图像
			_stdcall int Load(char* addr, unsigned int size = 0);
			_stdcall int Load(wchar_t* addr, unsigned int size = 0);

			// 保存图像
			_stdcall int Save(char* addr, unsigned int tpe = 0, int flag = 0);
			_stdcall int Save(wchar_t* addr, unsigned int tpe = 0, int flag = 0);

			// 释放图像
			_stdcall void Free();

			// 清除图像
			_stdcall void Clear();

			// 获取图像属性
			_stdcall unsigned int Width();
			_stdcall unsigned int Height();
			_stdcall void* PixAddr();
			_stdcall unsigned int PixSize();
			_stdcall unsigned int Pitch();

			// 创建图像副本
			_stdcall xge::Surface* Copy(int x, int y, int w, int h);

			// 绘制
			_stdcall void Draw(int x, int y, xge::Surface* sf = NULL);
			_stdcall void DrawEx(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			_stdcall void Draw_Add(int x, int y, int mul = 255, xge::Surface* sf = NULL);
			_stdcall void DrawEx_Add(int x, int y, int cx, int cy, int cw, int ch, int mul = 255, xge::Surface* sf = NULL);
			_stdcall void Draw_Alpha(int x, int y, xge::Surface* sf = NULL);
			_stdcall void DrawEx_Alpha(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			_stdcall void Draw_Alpha2(int x, int y, int a, xge::Surface* sf = NULL);
			_stdcall void DrawEx_Alpha2(int x, int y, int cx, int cy, int cw, int ch, int a, xge::Surface* sf = NULL);
			_stdcall void Draw_Trans(int x, int y, xge::Surface* sf = NULL);
			_stdcall void DrawEx_Trans(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			_stdcall void Draw_And(int x, int y, xge::Surface* sf = NULL);
			_stdcall void DrawEx_And(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			_stdcall void Draw_Or(int x, int y, xge::Surface* sf = NULL);
			_stdcall void DrawEx_Or(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			_stdcall void Draw_PSet(int x, int y, xge::Surface* sf = NULL);
			_stdcall void DrawEx_PSet(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			_stdcall void Draw_Xor(int x, int y, xge::Surface* sf = NULL);
			_stdcall void DrawEx_Xor(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			_stdcall void Draw_Gray(int x, int y, xge::Surface* sf = NULL);
			_stdcall void DrawEx_Gray(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			_stdcall void Draw_Mirr(int x, int y, int flag, xge::Surface* sf = NULL);
			_stdcall void DrawEx_Mirr(int x, int y, int cx, int cy, int cw, int ch, int flag, xge::Surface* sf = NULL);
			_stdcall void Draw_Shade(int x, int y, unsigned char mask, xge::Surface* sf = NULL);
			_stdcall void DrawEx_Shade(int x, int y, int cx, int cy, int cw, int ch, unsigned char mask, xge::Surface* sf = NULL);
			_stdcall void Draw_Custom(int x, int y, XGE_DRAW_CUSTOM bk, int param, xge::Surface* sf = NULL);
			_stdcall void DrawEx_Custom(int x, int y, int cx, int cy, int cw, int ch, XGE_DRAW_CUSTOM bk, int param, xge::Surface* sf = NULL);
			_stdcall void Draw_Blend(int x, int y, XGE_DRAW_BLEND bk, int param, xge::Surface* sf = NULL);
			_stdcall void DrawEx_Blend(int x, int y, int cx, int cy, int cw, int ch, XGE_DRAW_BLEND bk, int param, xge::Surface* sf = NULL);
		};


		/* -------------------------- Gdi图像类 -------------------------- */
		class GdiSurface : public Surface
		{
		public:
			HANDLE hDC;
			HANDLE hBitmap;
			void* BitmapAddr;
			void* gfx;

			// 构造 [空]
			_stdcall GdiSurface();

			// 构造 [创建]
			_stdcall GdiSurface(unsigned int w, unsigned int h);

			// 构造 [加载]
			_stdcall GdiSurface(char* addr, unsigned int size = 0);
			_stdcall GdiSurface(wchar_t* addr, unsigned int size = 0);

			// 析构
			_stdcall ~GdiSurface();

			// 创建图像
			_stdcall int Create(unsigned int w, unsigned int h);

			// 载入图像
			_stdcall int Load(char* addr, unsigned int size = 0);
			_stdcall int Load(wchar_t* addr, unsigned int size = 0);

			// 释放图像
			_stdcall void Free();

			// GDI 绘图
			_stdcall void PrintLine(int x1, int y1, int x2, int y2, unsigned int c);
			_stdcall void PrintRect(int x, int y, int w, int h, unsigned int c);
			_stdcall void PrintRectFull(int x, int y, int w, int h, unsigned int c);
			_stdcall void PrintCirc(int x, int y, int w, int h, unsigned int c);
			_stdcall void PrintCircFull(int x, int y, int w, int h, unsigned int c);
			_stdcall void PrintText(int x, int y, int w, int h, wchar_t* f, int px, int flag, unsigned int c, wchar_t* txt);
			_stdcall void PrintText(int x, int y, int w, int h, wchar_t* f, int px, int flag, unsigned int c, int weight, wchar_t* txt);
			_stdcall void PrintText(int x, int y, int w, int h, wchar_t* f, int px, int flag, unsigned int c1, unsigned int c2, int weight, wchar_t* txt);
			_stdcall void PrintText(int x, int y, int w, int h, wchar_t* f, int px, int flag, wchar_t* addr, int size, wchar_t* txt);
			_stdcall void PrintImage(int x, int y, wchar_t* addr, int size);
			_stdcall void PrintImageDpi(int x, int y, wchar_t* addr, int size);
			_stdcall void PrintImageZoom(int x, int y, int w, int h, wchar_t* addr, int size);
			_stdcall void PrintImageEx(int x, int y, int w, int h, int cx, int cy, int cw, int ch, wchar_t* addr, int size);
			_stdcall void PrintImageFull(int x, int y, int w, int h, wchar_t* addr, int size);
			_stdcall void PrintText(int x, int y, int w, int h, char* f, int px, int flag, unsigned int c, char* txt);
			_stdcall void PrintText(int x, int y, int w, int h, char* f, int px, int flag, unsigned int c, int weight, char* txt);
			_stdcall void PrintText(int x, int y, int w, int h, char* f, int px, int flag, unsigned int c1, unsigned int c2, int weight, char* txt);
			_stdcall void PrintText(int x, int y, int w, int h, char* f, int px, int flag, char* addr, int size, char* txt);
			_stdcall void PrintImage(int x, int y, char* addr, int size);
			_stdcall void PrintImageDpi(int x, int y, char* addr, int size);
			_stdcall void PrintImageZoom(int x, int y, int w, int h, char* addr, int size);
			_stdcall void PrintImageEx(int x, int y, int w, int h, int cx, int cy, int cw, int ch, char* addr, int size);
			_stdcall void PrintImageFull(int x, int y, int w, int h, char* addr, int size);
		};


		/* -------------------------- 声音类 -------------------------- */
		class Sound
		{
		public:
			unsigned int SoundObj;

			// 构造 [空]
			_stdcall Sound();

			// 构造 [加载]
			_stdcall Sound(int tpe, int flag, char* addr, unsigned int size = 0, int max = 65535);
			_stdcall Sound(int tpe, int flag, wchar_t* addr, unsigned int size = 0, int max = 65535);

			// 析构
			_stdcall ~Sound();

			// 载入声音
			_stdcall int Load(int tpe, int flag, char* addr, unsigned int size = 0, int max = 65535);
			_stdcall int Load(int tpe, int flag, wchar_t* addr, unsigned int size = 0, int max = 65535);

			// 释放声音
			_stdcall void Free();

			// 声音类型
			_stdcall int GetType();

			// 声音控制
			_stdcall void Play();
			_stdcall void Stop();
			_stdcall void Pause();
			_stdcall void Resume();

		protected:
			int pTpe;
		};


		/* -------------------------- 场景库 -------------------------- */
		namespace Scene
		{
			_stdcall int Start(XGE_SCENE_PROC proc, unsigned int lfps = 0, int sync = FALSE, int param = 0);
			_stdcall int Cut(XGE_SCENE_PROC proc, unsigned int lfps = 0, int sync = FALSE, int param = 0);
			_stdcall void Stop(int sc = 0);
			_stdcall void StopAll(int sc = 0);
			_stdcall void Pause(int flag = XGE_PAUSE_DRAW | XGE_PAUSE_FRAME);
			_stdcall int State();
			_stdcall void Resume();
			_stdcall unsigned int FPS();
			_stdcall void SetFPS(unsigned int nv);
			_stdcall xStack* Stack();
		};


		/* -------------------------- 挂钩库 -------------------------- */
		namespace Hook
		{
			_stdcall void SetDelayProc(XGE_DELAY_PROC proc);
			_stdcall void SetEventProc(XGE_EVENT_PROC proc);
			_stdcall void SetSceneProc(XGE_SCENE_PROC proc);
			_stdcall void SetBLoadProc(XGE_BLOAD_PROC proc);
			_stdcall void SetFontLoadProc(XGE_FLOAD_PROC proc);
		};


		/* -------------------------- 辅助库 -------------------------- */
		namespace Aux
		{
			_stdcall xge::Surface* ScreenShot();
			_stdcall unsigned int GetPixel(int x, int y, xge::Surface* sf = NULL);
			_stdcall unsigned int RGB2BGR(unsigned int c);
			_stdcall void SetTitleA(char* title);
			_stdcall void SetTitleW(wchar_t* title);
			_stdcall void SetView(int x1, int y1, int x2, int y2, int c, int f);
			_stdcall void ReSetView();
			_stdcall void SetCoodr(int x1, int y1, int x2, int y2, int c = 0);
			_stdcall void ReSetCoodr();
			_stdcall int MapCoodr(int coodr, int tpe);
			_stdcall int LockMouse();
			_stdcall int UnLockMouse();
			_stdcall int HideCursor();
			_stdcall int ShowCursor();
		};


		/* -------------------------- 图形库 -------------------------- */
		namespace Shape
		{
			_stdcall void Pixel(int x, int y, int c, xge::Surface* sf = NULL);
			_stdcall void Lines(int x1, int y1, int x2, int y2, int c, xge::Surface* sf = NULL);
			_stdcall void LinesEx(int x1, int y1, int x2, int y2, int c, int s, xge::Surface* sf = NULL);
			_stdcall void Rect(int x1, int y1, int x2, int y2, int c, xge::Surface* sf = NULL);
			_stdcall void RectEx(int x1, int y1, int x2, int y2, int c, int s, xge::Surface* sf = NULL);
			_stdcall void RectFull(int x1, int y1, int x2, int y2, int c, xge::Surface* sf = NULL);
			_stdcall void Circ(int x, int y, int r, int c, xge::Surface* sf = NULL);
			_stdcall void CircFull(int x, int y, int r, int c, xge::Surface* sf = NULL);
			_stdcall void CircEx(int x, int y, int r, int c, float a, xge::Surface* sf = NULL);
			_stdcall void CircFullEx(int x, int y, int r, int c, float a, xge::Surface* sf = NULL);
			_stdcall void CircArc(int x, int y, int r, int c, int s, int e, float a, xge::Surface* sf = NULL);
			_stdcall void Full(int x, int y, int c, int f, xge::Surface* sf = NULL);
			_stdcall void FullEx(int x, int y, void* p, int f, xge::Surface* sf = NULL);
		};
	};


	/* -------------------------- 输入库 -------------------------- */
	namespace xInput
	{
		_stdcall int KeyStatus(int k);
		_stdcall void MouseStatus(int *x, int *y, int *w, int *b);
		_stdcall int JoystickStatus(int id, int *btn, float *a1, float *a2, float *a3, float *a4, float *a5, float *a6, float *a7, float *a8);
		_stdcall int GetMousePos();
		_stdcall int SetMousePos(int x, int y);
		_stdcall int GetMouseX();
		_stdcall int GetMouseY();
		_stdcall int GetMouseBtn();
		_stdcall int GetMouseBtnL();
		_stdcall int GetMouseBtnR();
		_stdcall int GetMouseBtnM();
		_stdcall int GetMouseWheel();
	};


	/* -------------------------- 网络库 -------------------------- */
	namespace xSock
	{
		class xServer
		{
		public:
			CRITICAL_SECTION Section;

			// 事件函数
			XGE_SOCK_SRECV RecvEvent;
			XGE_SOCK_SSEND SendEvent;
			XGE_SOCK_SACCEPT AcceptEvent;
			XGE_SOCK_SDISCONN DisconnEvent;

			// 析构
			_stdcall ~xServer();

			// 创建
			_stdcall int Create(char* ip, unsigned short port, unsigned int max = 1000, unsigned int ThreadCountt = 1);

			// 销毁
			_stdcall void Destroy();

			// 状态
			_stdcall int Status();

			// 发送
			_stdcall int Send(HANDLE Client, char* pack, unsigned int size, int sync = TRUE);

			// 遍历客户端
			_stdcall HANDLE EnumClient(HANDLE first);

			// 获取客户端信息
			_stdcall int GetClientInfo(HANDLE client, char** ip, unsigned int* port);

		private:
			HANDLE h_Socket;
			unsigned int c_Max;
			unsigned int c_Conn;
			unsigned int c_Enter;
			unsigned int c_Leave;
			HANDLE* c_List;
			unsigned int c_FindCursor;
			unsigned int c_AddIndex;
		};

		class xClient
		{
		public:
			CRITICAL_SECTION Section;

            // 事件函数
            XGE_SOCK_CRECV RecvEvent;
            XGE_SOCK_CSEND SendEvent;
            XGE_SOCK_CACCEPT CloseEvent;

			// 析构
			_stdcall ~xClient();

			// 连接
			_stdcall int Connect(char* ip, unsigned short port);

			// 断开
			_stdcall void Close();

			// 状态
			_stdcall int Status();

			// 发送
			_stdcall int Send(char* pack, unsigned int size, int sync = TRUE);

		private:
			HANDLE h_Client;
		};

		class xUDP
		{
		public:
            // 事件函数
            XGE_SOCK_URECV RecvEvent;
            XGE_SOCK_USEND SendEvent;

			// 析构
			_stdcall ~xUDP();

			// 创建
			_stdcall int Create(char* ip, unsigned short port, unsigned int ThreadCountt = 1);

			// 销毁
			_stdcall void Destroy();

			// 状态 [已创建=TRUE]
			_stdcall int Status();

			// 发送
			_stdcall int Send(char* pack, unsigned int size, char* ip, unsigned short port, int sync = TRUE);

		private:
			HANDLE h_Socket;
		};
	};


	extern "C"
	{
		/* -------------------------- 混合渲染库 -------------------------- */
		_stdcall int Blend_Custom(xge::Surface* src, int px, int py, int cx, int cy, int cw, int ch, xge::Surface* dst, XGE_DRAW_BLEND bk, int param);
		_stdcall void SetShadeData(int w, int h, void* d);
		_stdcall void MakeShadeData(xge::Surface* sf, char* sd);


		/* -------------------------- 字符集转换库 -------------------------- */
		_stdcall wchar_t* AsciToUnicode(char* ZStrPtr, unsigned int ZStrLen = 0);
		_stdcall char* UnicodeToAsci(wchar_t* WStrPtr, unsigned int WStrLen = 0);
		_stdcall char* UnicodeToUTF8(wchar_t* WStrPtr, unsigned int WStrLen = 0);
		_stdcall wchar_t* UTF8ToUnicode(char* UTF8Ptr, unsigned int UTF8Len = 0);
		_stdcall wchar_t* A2W(char* AStr, unsigned int ALen = 0);
		_stdcall char* W2A(wchar_t* UStr, unsigned int ULen = 0);
		_stdcall char* W2U(wchar_t* UStr, unsigned int ULen = 0);
		_stdcall wchar_t* U2W(char* UStr, unsigned int ULen = 0);
		_stdcall char* A2U(char* AStr, unsigned int ALen = 0);
		_stdcall char* U2A(char* UStr, unsigned int ULen = 0);


		/* -------------------------- 文件操作库 -------------------------- */
		_stdcall int PutFile(char* file, void* buffer, int addr, int lenght);
		_stdcall int GetFile(char* file, void* buffer, int addr, int lenght);
		_stdcall int NewFile(char* file);
		_stdcall int FileExists(char* file);
		_stdcall int FileLen(char* file);
		_stdcall int SetFileSize(char* file, int size);
		_stdcall HANDLE Open_File(char* file, int readonly = 0);
		_stdcall int Put_File(HANDLE file, void* buffer, int addr, int lenght);
		_stdcall int Get_File(HANDLE file, void* buffer, int addr, int lenght);
		_stdcall int File_Len(HANDLE file);
	};
#endif
