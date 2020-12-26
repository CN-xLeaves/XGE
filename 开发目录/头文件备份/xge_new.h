// ==================================================================================
	// ★ xywh Game Engine 引擎头文件
	// #-----------------------------------------------------------------------------
	// # 功能 :
	// # 说明 :
// ==================================================================================



#ifndef xywh_library_xge
	#define xywh_library_xge



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
	#define MASK_COLOR_24				0xFF00FF
	#define MASK_COLOR_32				0xFFFF00FF
	#define MASK32_R					0xFF0000
	#define MASK32_G					0x00FF00
	#define MASK32_B					0x0000FF
	#define MASK32						0xFFFFFF


	/* -------------------------- 镜像定义 -------------------------- */
	#define XGE_BLEND_MIRR_H			1				// 水平
	#define XGE_BLEND_MIRR_V			2				// 垂直
	#define XGE_BLEND_MIRR_HV			3
	#define XGE_BLEND_MIRR_VH			3


	/* -------------------------- 初始化定义 -------------------------- */
	#define XGE_INIT_WINDOW				0x00			// 窗口模式
	#define XGE_INIT_FULLSCREEN			0x01			// 全屏模式
	#define XGE_INIT_NOSWITCH			0x04			// 不允许alt + enter切换窗口/全屏
	#define XGE_INIT_NOFRAME			0x08			// 窗口没有边框
	#define XGE_INIT_POSTOP				0x20			// 窗口置顶
	#define XGE_INIT_ALPHA				0x40			// 开启alpha混合对于所有基础操作
	#define XGE_INIT_HIGHPRIORITY		0x80			// 图像库高优先权给图像处理


	/* -------------------------- 模块初始化定义 -------------------------- */
	#define XGE_INIT_ALL				(XGE_INIT_GDI | XGE_INIT_DDT | XGE_INIT_BASS)
	#define XGE_INIT_GDI				0x1				// 初始化GDI/GDI+
	#define XGE_INIT_DDT				0x2				// 初始化 DDT 模块 (按照屏幕大小)
	#define XGE_INIT_BASS				0x4				// 初始化 BASS 模块


	/* -------------------------- 场景消息定义 -------------------------- */
	#define XGE_MSG_NULL				0x00			// 空消息
	#define XGE_MSG_LOADRES				0x01			// 载入资源
	#define XGE_MSG_FREERES				0x02			// 释放资源
	#define XGE_MSG_FRAME				0x03			// 框架函数
	#define XGE_MSG_DRAW				0x04			// 绘图函数
	#define XGE_MSG_ERROR				0x05			// 错误处理
	#define XGE_MSG_LOSTFOCUS			0x06			// 丢失焦点
	#define XGE_MSG_GOTFOCUS			0x07			// 获得焦点
	#define XGE_MSG_MOUSE_MOVE			0x08			// 鼠标移动
	#define XGE_MSG_MOUSE_DOWN			0x09			// 鼠标按下
	#define XGE_MSG_MOUSE_UP			0x0A			// 鼠标弹起
	#define XGE_MSG_MOUSE_DCLICK		0x0B			// 鼠标双击
	#define XGE_MSG_MOUSE_WHELL			0x0C			// 滚轮滚动
	#define XGE_MSG_KEY_DOWN			0x0D			// 按键按下
	#define XGE_MSG_KEY_UP				0x0E			// 按键弹起
	#define XGE_MSG_KEY_REPEAT			0x0F			// 按键按住
	#define XGE_MSG_MOUSE_ENTER			0x10			// 鼠标移入
	#define XGE_MSG_MOUSE_EXIT			0x11			// 鼠标离开
	#define XGE_MSG_CLOSE				0x12			// 窗口关闭


	/* -------------------------- 暂停定义 -------------------------- */
	#define XGE_PAUSE_DRAW				0x01			// 暂停绘制
	#define XGE_PAUSE_FRAME				0x02			// 暂停场景框架


	/* -------------------------- 文件类型定义 -------------------------- */
	#define XGE_IMG_FMT_BMP				0
	#define XGE_IMG_FMT_XGI				1


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
			int button;
			int z;
			int w;
		};
	};


	/* -------------------------- 图像结构体 -------------------------- */
	struct IMAGE
	{
		unsigned int tpe;
		int bpp;
		unsigned int Width;
		unsigned int Height;
		unsigned int Pitch;
		unsigned char reserved[12];
	};


	/* -------------------------- 数据类型定义 -------------------------- */
	typedef int (CALLBACK *XGE_SCENE_PROC)(int msg, int param, XGE_EVENT *eve);
	typedef void (CALLBACK *XGE_EVENT_PROC)(XGE_EVENT *eve);
	typedef void (CALLBACK *XGE_DELAY_PROC)(int ms);
	typedef int (CALLBACK *XGE_BLOAD_PROC)(void* img, char* addr, unsigned int size);
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
		xStack(unsigned int max, unsigned int unitsize);
		~xStack();

		// 初始化/卸载
		int Init(unsigned int max, unsigned int unitsize);
		void Unit();

		// 压栈
		int Push(void* dat);

		// 出栈
		void* Pop(unsigned int c);

		// 栈顶
		void* Top();

		// 压栈数量
		unsigned int Count();

	private:
		unsigned int pMaxCount;
		unsigned int pUnitSize;
		void* pStackMem;
		unsigned int pStackTop;
	};


	/* -------------------------- 栈结构类[Int] -------------------------- */
	class xStack_Int
	{
	public:
		// 构造/析构
		xStack_Int(unsigned int max);
		~xStack_Int();

		// 初始化/卸载
		int Init(unsigned int max);
		void Unit();

		// 压栈
		int Push(int dat);

		// 出栈
		int Pop();
		int* Pop(unsigned int c);

		// 栈顶
		int Top();

		// 压栈数量
		unsigned int Count();

	private:
		unsigned int pMaxCount;
		int* pStackMem;
		unsigned int pStackTop;
	};


	/* -------------------------- 核心库 -------------------------- */
	namespace xge
	{
		int Init(unsigned int w, unsigned int h, int init_gfx = XGE_INIT_WINDOW, int init_mod = XGE_INIT_ALL, char* title = NULL);
		void Unit();
		HANDLE hWnd();
		void Clear();
		void Lock();
		void UnLock();
		void Sync();
		unsigned int Width();
		unsigned int Height();
		void* PixAddr();
		unsigned int PixSize();
		unsigned int Pitch();
		char* Driver();
		void SetSoundVol(int tpe, int vol);
		int GetSoundVol(int tpe);
		int Ver(int tpe = 0);


		/* -------------------------- 场景库 -------------------------- */
		namespace Scene
		{
			int Start(XGE_SCENE_PROC proc, unsigned int lfps = 0, int sync = FALSE, int param = 0);
			int Cut(XGE_SCENE_PROC proc, unsigned int lfps = 0, int sync = FALSE, int param = 0);
			void Stop(int sc = 0);
			void StopAll(int sc = 0);
			void Pause(int flag = XGE_PAUSE_DRAW | XGE_PAUSE_FRAME);
			int State();
			void Resume();
			unsigned int FPS();
			xStack* Stack();
		};


		/* -------------------------- 挂钩库 -------------------------- */
		namespace Hook
		{
			void SetDelayProc(XGE_DELAY_PROC proc);
			void SetEventProc(XGE_EVENT_PROC proc);
			void SetSceneProc(XGE_SCENE_PROC proc);
			void SetBLoadProc(XGE_BLOAD_PROC proc);
		};


		/* -------------------------- 输入库 -------------------------- */
		namespace xInput
		{
			int KeyStatus(int k);
			void MouseStatus(int *x, int *y, int *w, int *b);
			int JoystickStatus(int id, int *btn, float *a1, float *a2, float *a3, float *a4, float *a5, float *a6, float *a7, float *a8);
			int GetMousePos();
			int SetMousePos(int x, int y);
			int GetMouseX();
			int GetMouseY();
			int GetMouseBtn();
			int GetMouseBtnL();
			int GetMouseBtnR();
			int GetMouseBtnM();
			int GetMouseWheel();
		};


		/* -------------------------- 图像类 -------------------------- */
		class Surface
		{
		public:
			IMAGE* img;

			// 构造 [空]
			Surface();

			// 构造 [创建]
			Surface(unsigned int w, unsigned int h);

			// 构造 [加载]
			Surface(char* addr, unsigned int size = 0);

			// 析构
			~Surface();

			// 创建图像
			int Create(unsigned int w, unsigned int h);

			// 载入图像
			int Load(char* addr, unsigned int size = 0);

			// 保存图像
			int Save(char* addr, unsigned int tpe = 0, int flag = 0);

			// 释放图像
			void Free();

			// 清除图像
			void Clear();

			// 获取图像属性
			unsigned int Width();
			unsigned int Height();
			void* PixAddr();
			unsigned int PixSize();
			unsigned int Pitch();

			// 创建图像副本
			xge::Surface* Copy(int x, int y, int w, int h);

			// 绘制
			void Draw(int x, int y, xge::Surface* sf = NULL);
			void DrawEx(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			void Draw_Add(int x, int y, int mul = 255, xge::Surface* sf = NULL);
			void DrawEx_Add(int x, int y, int cx, int cy, int cw, int ch, int mul = 255, xge::Surface* sf = NULL);
			void Draw_Alpha(int x, int y, xge::Surface* sf = NULL);
			void DrawEx_Alpha(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			void Draw_Alpha2(int x, int y, int a, xge::Surface* sf = NULL);
			void DrawEx_Alpha2(int x, int y, int cx, int cy, int cw, int ch, int a, xge::Surface* sf = NULL);
			void Draw_And(int x, int y, xge::Surface* sf = NULL);
			void DrawEx_And(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			void Draw_Or(int x, int y, xge::Surface* sf = NULL);
			void DrawEx_Or(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			void Draw_PSet(int x, int y, xge::Surface* sf = NULL);
			void DrawEx_PSet(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			void Draw_Xor(int x, int y, xge::Surface* sf = NULL);
			void DrawEx_Xor(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			void Draw_Gray(int x, int y, xge::Surface* sf = NULL);
			void DrawEx_Gray(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			void Draw_Mirr(int x, int y, int flag, xge::Surface* sf = NULL);
			void DrawEx_Mirr(int x, int y, int cx, int cy, int cw, int ch, int flag, xge::Surface* sf = NULL);
			void Draw_Shade(int x, int y, unsigned char mask, xge::Surface* sf = NULL);
			void DrawEx_Shade(int x, int y, int cx, int cy, int cw, int ch, unsigned char mask, xge::Surface* sf = NULL);
			void Draw_Custom(int x, int y, XGE_DRAW_CUSTOM bk, int param, xge::Surface* sf = NULL);
			void DrawEx_Custom(int x, int y, int cx, int cy, int cw, int ch, XGE_DRAW_CUSTOM bk, int param, xge::Surface* sf = NULL);
			void Draw_Blend(int x, int y, XGE_DRAW_BLEND bk, int param, xge::Surface* sf = NULL);
			void DrawEx_Blend(int x, int y, int cx, int cy, int cw, int ch, XGE_DRAW_BLEND bk, int param, xge::Surface* sf = NULL);
		};


		/* -------------------------- Gdi图像类 -------------------------- */
		class GdiSurface// : public Surface
		{
		public:
			HANDLE hDC;
			HANDLE hBitmap;
			void* BitmapAddr;
			void* gfx;

			// 构造 [空]
			GdiSurface();

			// 构造 [创建]
			GdiSurface(unsigned int w, unsigned int h);

			// 构造 [加载]
			GdiSurface(char* addr, unsigned int size = 0);

			// 析构
			~GdiSurface();

			// 创建图像
			int Create(unsigned int w, unsigned int h);

			// 载入图像
			int Load(char* addr, unsigned int size = 0);

			// 释放图像
			void Free();

			// GDI 绘图
			void PrintLine(int x1, int y1, int x2, int y2, unsigned int c);
			void PrintRect(int x, int y, int w, int h, unsigned int c);
			void PrintRectFull(int x, int y, int w, int h, unsigned int c);
			void PrintCirc(int x, int y, int w, int h, unsigned int c);
			void PrintCircFull(int x, int y, int w, int h, unsigned int c);
			void PrintText(int x, int y, int w, int h, char* f, int px, int flag, unsigned int c, char* txt);
			void PrintText(int x, int y, int w, int h, char* f, int px, int flag, unsigned int c, int weight, char* txt);
			void PrintText(int x, int y, int w, int h, char* f, int px, int flag, unsigned int c1, unsigned int c2, int weight, char* txt);
			void PrintText(int x, int y, int w, int h, char* f, int px, int flag, char* addr, int size, char* txt);
			void PrintImage(int x, int y, char* addr, int size);
			void PrintImageDpi(int x, int y, char* addr, int size);
			void PrintImageZoom(int x, int y, int w, int h, char* addr, int size);
			void PrintImageEx(int x, int y, int w, int h, int cx, int cy, int cw, int ch, char* addr, int size);
			void PrintImageFull(int x, int y, int w, int h, char* addr, int size);
		};


		/* -------------------------- 渲染对象基类 -------------------------- */
		class RenderBaseObject
		{
		public:
			int x;
			int y;
			int Priority;
			int Enabled;
			int Visible;

			virtual void Disp() = 0;
			virtual void Draw(int px, int py) = 0;
		};


		/* -------------------------- 渲染对象类 -------------------------- */
		class RenderObject : public RenderBaseObject
		{
		public:
			xge::Surface* img;
			xge::Surface* Parent;
			int cut;
			int cx;
			int cy;
			int cw;
			int ch;
			int AutoFree;

			// 空构造
			RenderObject();

			// 从现有 Surface 创建
			RenderObject(xge::Surface* sf, int px = 0, int py = 0, int pl = 0, xge::Surface* p = NULL);

			// 自动创建和释放 Surface
			RenderObject(char* addr, unsigned int size, int px = 0, int py = 0, int pl = 0, xge::Surface* p = NULL);

			// 析构
			~RenderObject();

			// 裁剪
			void SetCut(int iscut, int cut_x = 0, int cut_y = 0, int cut_w = 0, int cut_h = 0);

			// 渲染
			void Draw(int px, int py);
		};


		/* -------------------------- 声音类 -------------------------- */
		class Sound
		{
		public:
			unsigned int SoundObj;

			// 构造 [空]
			Sound();

			// 构造 [加载]
			Sound(int tpe, int flag, char* addr, unsigned int size = 0, int max = 65535);

			// 析构
			~Sound();

			// 载入声音
			int Load(int tpe, int flag, char* addr, unsigned int size = 0, int max = 65535);

			// 释放声音
			void Free();

			// 声音类型
			int GetType();

			// 声音控制
			void Play();
			void Stop();
			void Pause();
			void Resume();

		protected:
			int pTpe;
		};


		/* -------------------------- 辅助库 -------------------------- */
		namespace Aux
		{
			xge::Surface* ScreenShot();
			unsigned int GetPixel(int x, int y, xge::Surface* sf = NULL);
			unsigned int RGB2BGR(unsigned int c);
			void SetTitle(char* title);
			void SetView(int x1, int y1, int x2, int y2, int c, int f);
			void ReSetView();
			void SetCoodr(int x1, int y1, int x2, int y2, int c = 0);
			void ReSetCoodr();
			int MapCoodr(int coodr, int tpe);
			int LockMouse();
			int UnLockMouse();
			int HideCursor();
			int ShowCursor();
		};


		/* -------------------------- 图形库 -------------------------- */
		namespace Shape
		{
			void Pixel(int x, int y, int c, xge::Surface* sf = NULL);
			void Lines(int x1, int y1, int x2, int y2, int c, xge::Surface* sf = NULL);
			void LinesEx(int x1, int y1, int x2, int y2, int c, int s, xge::Surface* sf = NULL);
			void Rect(int x1, int y1, int x2, int y2, int c, xge::Surface* sf = NULL);
			void RectEx(int x1, int y1, int x2, int y2, int c, int s, xge::Surface* sf = NULL);
			void RectFull(int x1, int y1, int x2, int y2, int c, xge::Surface* sf = NULL);
			void Circ(int x, int y, int r, int c, xge::Surface* sf = NULL);
			void CircFull(int x, int y, int r, int c, xge::Surface* sf = NULL);
			void CircEx(int x, int y, int r, int c, float a, xge::Surface* sf = NULL);
			void CircFullEx(int x, int y, int r, int c, float a, xge::Surface* sf = NULL);
			void CircArc(int x, int y, int r, int c, int s, int e, float a, xge::Surface* sf = NULL);
			void Full(int x, int y, int c, int f, xge::Surface* sf = NULL);
			void FullEx(int x, int y, char* p, int f, xge::Surface* sf = NULL);
		};


		/* -------------------------- Gdi画字库 -------------------------- */
		namespace ddt
		{
			void Init(int mw, int mh);
			void Draw(int x, int y, int w, int h, char* f, int px, int flag, int c, char* txt, xge::Surface* sf = NULL);
			void Draw(int x, int y, int w, int h, char* f, int px, int flag, int c, int weight, char* txt, xge::Surface* sf = NULL);
			void Draw(int x, int y, int w, int h, char* f, int px, int flag, int c1, int c2, int weight, char* txt, xge::Surface* sf = NULL);
			void Draw(int x, int y, int w, int h, char* f, int px, int flag, char* addr, int size, char* txt, xge::Surface* sf = NULL);
		};
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
			~xServer();

			// 创建
			int Create(char* ip, unsigned short port, unsigned int max = 1000, unsigned int ThreadCountt = 1);

			// 销毁
			void Destroy();

			// 状态
			int Status();

			// 发送
			int Send(HANDLE Client, char* pack, unsigned int size, int sync = TRUE);

			// 遍历客户端
			HANDLE EnumClient(HANDLE first);

			// 获取客户端信息
			int GetClientInfo(HANDLE client, char** ip, unsigned int* port);

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
			~xClient();

			// 连接
			int Connect(char* ip, unsigned short port);

			// 断开
			void Close();

			// 状态
			int Status();

			// 发送
			int Send(char* pack, unsigned int size, int sync = TRUE);

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
			~xUDP();

			// 创建
			int Create(char* ip, unsigned short port, unsigned int ThreadCountt = 1);

			// 销毁
			void Destroy();

			// 状态 [已创建=TRUE]
			int Status();

			// 发送
			int Send(char* pack, unsigned int size, char* ip, unsigned short port, int sync = TRUE);

		private:
			HANDLE h_Socket;
		};
	};


	extern "C"
	{
		/* -------------------------- 混合渲染库 -------------------------- */
		int Blend_Custom(xge::Surface* src, int px, int py, int cx, int cy, int cw, int ch, xge::Surface* dst, XGE_DRAW_BLEND bk, int param);
		void Blend_Gray(void* SrcAddr, int SrcPitch, int SrcLineS, void* DstAddr, int DstPitch, int DstLineS, int w, int h, int param);
		void Blend_Mirr(void* SrcAddr, int SrcPitch, int SrcLineS, void* DstAddr, int DstPitch, int DstLineS, int w, int h, int param);
		void Blend_Shade(void* SrcAddr, int SrcPitch, int SrcLineS, void* DstAddr, int DstPitch, int DstLineS, int w, int h, int param);
		void SetShadeData(int w, int h, void* d);
		void MakeShadeData(xge::Surface* sf, char* sd);


		/* -------------------------- 字符集转换库 -------------------------- */
		wchar_t* AsciToUnicode(char* ZStrPtr, unsigned int ZStrLen = 0);
		char* UnicodeToAsci(wchar_t* WStrPtr, unsigned int WStrLen = 0);
		char* UnicodeToUTF8(wchar_t* WStrPtr, unsigned int WStrLen = 0);
		wchar_t* UTF8ToUnicode(char* UTF8Ptr, unsigned int UTF8Len = 0);
		wchar_t* A2W(char* AStr, unsigned int ALen = 0);
		char* W2A(wchar_t* UStr, unsigned int ULen = 0);
		char* W2U(wchar_t* UStr, unsigned int ULen = 0);
		wchar_t* U2W(char* UStr, unsigned int ULen = 0);
		char* A2U(char* AStr, unsigned int ALen = 0);
		char* U2A(char* UStr, unsigned int ULen = 0);


		/* -------------------------- 文件操作库 -------------------------- */
		int PutFile(char* file, void* buffer, int addr, int lenght);
		int GetFile(char* file, void* buffer, int addr, int lenght);
		int NewFile(char* file);
		int FileExists(char* file);
		int FileLen(char* file);
		int SetFileSize(char* file, int size);
		HANDLE Open_File(char* file, int readonly = 0);
		int Put_File(HANDLE file, void* buffer, int addr, int lenght);
		int Get_File(HANDLE file, void* buffer, int addr, int lenght);
		int File_Len(HANDLE file);
	};
#endif
