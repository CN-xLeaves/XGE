// ==================================================================================
	// �� xywh Game Engine ����ͷ�ļ�
	// #-----------------------------------------------------------------------------
	// # ���� :
	// # ˵�� :
// ==================================================================================



#ifndef xywh_library_xge
	#define xywh_library_xge



	/* -------------------------- ����ͷ�ļ� -------------------------- */
	#include <windows.h>



	/* -------------------------- ����ɨ���� -------------------------- */
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


	/* -------------------------- ��ɫ���� -------------------------- */
	#define MASK_COLOR_24				0xFF00FF
	#define MASK_COLOR_32				0xFFFF00FF
	#define MASK32_R					0xFF0000
	#define MASK32_G					0x00FF00
	#define MASK32_B					0x0000FF
	#define MASK32						0xFFFFFF


	/* -------------------------- ������ -------------------------- */
	#define XGE_BLEND_MIRR_H			1				// ˮƽ
	#define XGE_BLEND_MIRR_V			2				// ��ֱ
	#define XGE_BLEND_MIRR_HV			3
	#define XGE_BLEND_MIRR_VH			3


	/* -------------------------- ��ʼ������ -------------------------- */
	#define XGE_INIT_WINDOW				0x00			// ����ģʽ
	#define XGE_INIT_FULLSCREEN			0x01			// ȫ��ģʽ
	#define XGE_INIT_NOSWITCH			0x04			// ������alt + enter�л�����/ȫ��
	#define XGE_INIT_NOFRAME			0x08			// ����û�б߿�
	#define XGE_INIT_POSTOP				0x20			// �����ö�
	#define XGE_INIT_ALPHA				0x40			// ����alpha��϶������л�������
	#define XGE_INIT_HIGHPRIORITY		0x80			// ͼ��������Ȩ��ͼ����


	/* -------------------------- ģ���ʼ������ -------------------------- */
	#define XGE_INIT_ALL				(XGE_INIT_GDI | XGE_INIT_DDT | XGE_INIT_BASS)
	#define XGE_INIT_GDI				0x1				// ��ʼ��GDI/GDI+
	#define XGE_INIT_DDT				0x2				// ��ʼ�� DDT ģ�� (������Ļ��С)
	#define XGE_INIT_BASS				0x4				// ��ʼ�� BASS ģ��


	/* -------------------------- ������Ϣ���� -------------------------- */
	#define XGE_MSG_NULL				0x00			// ����Ϣ
	#define XGE_MSG_LOADRES				0x01			// ������Դ
	#define XGE_MSG_FREERES				0x02			// �ͷ���Դ
	#define XGE_MSG_FRAME				0x03			// ��ܺ���
	#define XGE_MSG_DRAW				0x04			// ��ͼ����
	#define XGE_MSG_ERROR				0x05			// ������
	#define XGE_MSG_LOSTFOCUS			0x06			// ��ʧ����
	#define XGE_MSG_GOTFOCUS			0x07			// ��ý���
	#define XGE_MSG_MOUSE_MOVE			0x08			// ����ƶ�
	#define XGE_MSG_MOUSE_DOWN			0x09			// ��갴��
	#define XGE_MSG_MOUSE_UP			0x0A			// ��굯��
	#define XGE_MSG_MOUSE_DCLICK		0x0B			// ���˫��
	#define XGE_MSG_MOUSE_WHELL			0x0C			// ���ֹ���
	#define XGE_MSG_KEY_DOWN			0x0D			// ��������
	#define XGE_MSG_KEY_UP				0x0E			// ��������
	#define XGE_MSG_KEY_REPEAT			0x0F			// ������ס
	#define XGE_MSG_MOUSE_ENTER			0x10			// �������
	#define XGE_MSG_MOUSE_EXIT			0x11			// ����뿪
	#define XGE_MSG_CLOSE				0x12			// ���ڹر�


	/* -------------------------- ��ͣ���� -------------------------- */
	#define XGE_PAUSE_DRAW				0x01			// ��ͣ����
	#define XGE_PAUSE_FRAME				0x02			// ��ͣ�������


	/* -------------------------- �ļ����Ͷ��� -------------------------- */
	#define XGE_IMG_FMT_BMP				0
	#define XGE_IMG_FMT_XGI				1


	/* -------------------------- ��Ƶ���Ͷ��� -------------------------- */
	#define XGE_SOUND_SAMPLE			1
	#define XGE_SOUND_MUSIC				2
	#define XGE_SOUND_STREAM			3


	/* -------------------------- С�������Ƕ��� -------------------------- */
	#define XGE_SUD_SMP_LOOP			4				// ѭ��
	#define XGE_SUD_SMP_MONO			2				// ������
	#define XGE_SUD_SMP_8B				1				// 8λ
	#define XGE_SUD_SMP_32B				256				// 32λ
	#define XGE_SUD_SMP_SOFT			16				// �������


	/* -------------------------- ��ý�������Ƕ��� -------------------------- */
	#define XGE_SUD_STE_LOOP			4				// ѭ��
	#define XGE_SUD_STE_MONO			2				// ������
	#define XGE_SUD_STE_32B				256				// 32λ
	#define XGE_SUD_STE_SOFT			16				// �������
	#define XGE_SUD_STE_PRES			0x20000			// Ԥɨ��
	#define XGE_SUD_STE_AFRE			0x40000			// ���Ž����Զ��ͷ�
	#define XGE_SUD_STE_BLOCK			0x100000		// �ֶ�����url��ý�� [����ѭ������]
	#define XGE_SUD_STE_URL				0x80000000		// ��URL����


	/* -------------------------- ���������Ƕ��� -------------------------- */
	#define XGE_SUD_MUS_LOOP			4				// ѭ��
	#define XGE_SUD_MUS_MONO			2				// ������
	#define XGE_SUD_MUS_32B				256				// 32λ
	#define XGE_SUD_MUS_SOFT			16				// �������
	#define XGE_SUD_MUS_PRES			0x20000			// Ԥɨ��
	#define XGE_SUD_MUS_AFRE			0x40000			// ���Ž����Զ��ͷ�
	#define XGE_SUD_MUS_SUR				0x800			// ����
	#define XGE_SUD_MUS_SUR2			0x1000			// ���� [ģʽ2]
	#define XGE_SUD_MUS_NSMP			0x100000		// ������С��


	/* -------------------------- �������ö��� -------------------------- */
	#define XGE_SUD_VOL_ALL				0x0
	#define XGE_SUD_VOL_SMP				0x4
	#define XGE_SUD_VOL_STE				0x5
	#define XGE_SUD_VOL_MUS				0x6


	/* -------------------------- �ı����붨�� -------------------------- */
	#define XGE_ALIGN_LEFT				0x0				// ���������
	#define XGE_ALIGN_CENTER			0x1				// ������ж���
	#define XGE_ALIGN_RIGHT				0x2				// �����Ҷ���
	#define XGE_ALIGN_TOP				0x0				// �����϶���
	#define XGE_ALIGN_MIDDLE			0x4				// ������ж���
	#define XGE_ALIGN_BOTTOM			0x8				// ����ײ�����


	/* -------------------------- �������� -------------------------- */
	#define XGE_FONT_BOLD				0x10			// ����
	#define XGE_FONT_ITALIC				0x20			// б��
	#define XGE_FONT_BOLDITALIC			0x30			// ���� + б��
	#define XGE_FONT_UNDERLINE			0x40			// �»���
	#define XGE_FONT_SRTIKEOUT			0x80			// ɾ����


	/* -------------------------- ��Ϣ�ṹ�� -------------------------- */
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


	/* -------------------------- ͼ��ṹ�� -------------------------- */
	struct IMAGE
	{
		unsigned int tpe;
		int bpp;
		unsigned int Width;
		unsigned int Height;
		unsigned int Pitch;
		unsigned char reserved[12];
	};


	/* -------------------------- �������Ͷ��� -------------------------- */
	typedef int (CALLBACK *XGE_SCENE_PROC)(int msg, int param, XGE_EVENT *eve);
	typedef void (CALLBACK *XGE_EVENT_PROC)(XGE_EVENT *eve);
	typedef void (CALLBACK *XGE_DELAY_PROC)(int ms);
	typedef int (CALLBACK *XGE_BLOAD_PROC)(void* img, char* addr, unsigned int size);
	typedef void (CALLBACK *XGE_DRAW_BLEND)(void* SrcAddr, int SrcPitch, int SrcLineS, void* DstAddr, int DstPitch, int DstLineS, int w, int h, int param);
	typedef unsigned int (CALLBACK *XGE_DRAW_CUSTOM)(unsigned int src, unsigned int dst, void* param);


	/* -------------------------- xSock �ص����� -------------------------- */
	typedef void (CALLBACK *XGE_SOCK_SRECV)(void* client, char* pack, unsigned int size);
	typedef void (CALLBACK *XGE_SOCK_SSEND)(void* client, int code);
	typedef void (CALLBACK *XGE_SOCK_SACCEPT)(void* client);
	typedef void (CALLBACK *XGE_SOCK_SDISCONN)(void* client);
	typedef void (CALLBACK *XGE_SOCK_CRECV)(char* pack, unsigned int size);
	typedef void (CALLBACK *XGE_SOCK_CSEND)(int code);
	typedef void (CALLBACK *XGE_SOCK_CACCEPT)();
	typedef void (CALLBACK *XGE_SOCK_URECV)(char* pack, unsigned int size, char* ip, int port);
	typedef void (CALLBACK *XGE_SOCK_USEND)(int code);




	/* -------------------------- ջ�ṹ��[�ṹ��] -------------------------- */
	class xStack
	{
	public:
		// ����/����
		xStack(unsigned int max, unsigned int unitsize);
		~xStack();

		// ��ʼ��/ж��
		int Init(unsigned int max, unsigned int unitsize);
		void Unit();

		// ѹջ
		int Push(void* dat);

		// ��ջ
		void* Pop(unsigned int c);

		// ջ��
		void* Top();

		// ѹջ����
		unsigned int Count();

	private:
		unsigned int pMaxCount;
		unsigned int pUnitSize;
		void* pStackMem;
		unsigned int pStackTop;
	};


	/* -------------------------- ջ�ṹ��[Int] -------------------------- */
	class xStack_Int
	{
	public:
		// ����/����
		xStack_Int(unsigned int max);
		~xStack_Int();

		// ��ʼ��/ж��
		int Init(unsigned int max);
		void Unit();

		// ѹջ
		int Push(int dat);

		// ��ջ
		int Pop();
		int* Pop(unsigned int c);

		// ջ��
		int Top();

		// ѹջ����
		unsigned int Count();

	private:
		unsigned int pMaxCount;
		int* pStackMem;
		unsigned int pStackTop;
	};


	/* -------------------------- ���Ŀ� -------------------------- */
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


		/* -------------------------- ������ -------------------------- */
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


		/* -------------------------- �ҹ��� -------------------------- */
		namespace Hook
		{
			void SetDelayProc(XGE_DELAY_PROC proc);
			void SetEventProc(XGE_EVENT_PROC proc);
			void SetSceneProc(XGE_SCENE_PROC proc);
			void SetBLoadProc(XGE_BLOAD_PROC proc);
		};


		/* -------------------------- ����� -------------------------- */
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


		/* -------------------------- ͼ���� -------------------------- */
		class Surface
		{
		public:
			IMAGE* img;

			// ���� [��]
			Surface();

			// ���� [����]
			Surface(unsigned int w, unsigned int h);

			// ���� [����]
			Surface(char* addr, unsigned int size = 0);

			// ����
			~Surface();

			// ����ͼ��
			int Create(unsigned int w, unsigned int h);

			// ����ͼ��
			int Load(char* addr, unsigned int size = 0);

			// ����ͼ��
			int Save(char* addr, unsigned int tpe = 0, int flag = 0);

			// �ͷ�ͼ��
			void Free();

			// ���ͼ��
			void Clear();

			// ��ȡͼ������
			unsigned int Width();
			unsigned int Height();
			void* PixAddr();
			unsigned int PixSize();
			unsigned int Pitch();

			// ����ͼ�񸱱�
			xge::Surface* Copy(int x, int y, int w, int h);

			// ����
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


		/* -------------------------- Gdiͼ���� -------------------------- */
		class GdiSurface// : public Surface
		{
		public:
			HANDLE hDC;
			HANDLE hBitmap;
			void* BitmapAddr;
			void* gfx;

			// ���� [��]
			GdiSurface();

			// ���� [����]
			GdiSurface(unsigned int w, unsigned int h);

			// ���� [����]
			GdiSurface(char* addr, unsigned int size = 0);

			// ����
			~GdiSurface();

			// ����ͼ��
			int Create(unsigned int w, unsigned int h);

			// ����ͼ��
			int Load(char* addr, unsigned int size = 0);

			// �ͷ�ͼ��
			void Free();

			// GDI ��ͼ
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


		/* -------------------------- ��Ⱦ������� -------------------------- */
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


		/* -------------------------- ��Ⱦ������ -------------------------- */
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

			// �չ���
			RenderObject();

			// ������ Surface ����
			RenderObject(xge::Surface* sf, int px = 0, int py = 0, int pl = 0, xge::Surface* p = NULL);

			// �Զ��������ͷ� Surface
			RenderObject(char* addr, unsigned int size, int px = 0, int py = 0, int pl = 0, xge::Surface* p = NULL);

			// ����
			~RenderObject();

			// �ü�
			void SetCut(int iscut, int cut_x = 0, int cut_y = 0, int cut_w = 0, int cut_h = 0);

			// ��Ⱦ
			void Draw(int px, int py);
		};


		/* -------------------------- ������ -------------------------- */
		class Sound
		{
		public:
			unsigned int SoundObj;

			// ���� [��]
			Sound();

			// ���� [����]
			Sound(int tpe, int flag, char* addr, unsigned int size = 0, int max = 65535);

			// ����
			~Sound();

			// ��������
			int Load(int tpe, int flag, char* addr, unsigned int size = 0, int max = 65535);

			// �ͷ�����
			void Free();

			// ��������
			int GetType();

			// ��������
			void Play();
			void Stop();
			void Pause();
			void Resume();

		protected:
			int pTpe;
		};


		/* -------------------------- ������ -------------------------- */
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


		/* -------------------------- ͼ�ο� -------------------------- */
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


		/* -------------------------- Gdi���ֿ� -------------------------- */
		namespace ddt
		{
			void Init(int mw, int mh);
			void Draw(int x, int y, int w, int h, char* f, int px, int flag, int c, char* txt, xge::Surface* sf = NULL);
			void Draw(int x, int y, int w, int h, char* f, int px, int flag, int c, int weight, char* txt, xge::Surface* sf = NULL);
			void Draw(int x, int y, int w, int h, char* f, int px, int flag, int c1, int c2, int weight, char* txt, xge::Surface* sf = NULL);
			void Draw(int x, int y, int w, int h, char* f, int px, int flag, char* addr, int size, char* txt, xge::Surface* sf = NULL);
		};
	};


	/* -------------------------- ����� -------------------------- */
	namespace xSock
	{
		class xServer
		{
		public:
			CRITICAL_SECTION Section;

			// �¼�����
			XGE_SOCK_SRECV RecvEvent;
			XGE_SOCK_SSEND SendEvent;
			XGE_SOCK_SACCEPT AcceptEvent;
			XGE_SOCK_SDISCONN DisconnEvent;

			// ����
			~xServer();

			// ����
			int Create(char* ip, unsigned short port, unsigned int max = 1000, unsigned int ThreadCountt = 1);

			// ����
			void Destroy();

			// ״̬
			int Status();

			// ����
			int Send(HANDLE Client, char* pack, unsigned int size, int sync = TRUE);

			// �����ͻ���
			HANDLE EnumClient(HANDLE first);

			// ��ȡ�ͻ�����Ϣ
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

            // �¼�����
            XGE_SOCK_CRECV RecvEvent;
            XGE_SOCK_CSEND SendEvent;
            XGE_SOCK_CACCEPT CloseEvent;

			// ����
			~xClient();

			// ����
			int Connect(char* ip, unsigned short port);

			// �Ͽ�
			void Close();

			// ״̬
			int Status();

			// ����
			int Send(char* pack, unsigned int size, int sync = TRUE);

		private:
			HANDLE h_Client;
		};

		class xUDP
		{
		public:
            // �¼�����
            XGE_SOCK_URECV RecvEvent;
            XGE_SOCK_USEND SendEvent;

			// ����
			~xUDP();

			// ����
			int Create(char* ip, unsigned short port, unsigned int ThreadCountt = 1);

			// ����
			void Destroy();

			// ״̬ [�Ѵ���=TRUE]
			int Status();

			// ����
			int Send(char* pack, unsigned int size, char* ip, unsigned short port, int sync = TRUE);

		private:
			HANDLE h_Socket;
		};
	};


	extern "C"
	{
		/* -------------------------- �����Ⱦ�� -------------------------- */
		int Blend_Custom(xge::Surface* src, int px, int py, int cx, int cy, int cw, int ch, xge::Surface* dst, XGE_DRAW_BLEND bk, int param);
		void Blend_Gray(void* SrcAddr, int SrcPitch, int SrcLineS, void* DstAddr, int DstPitch, int DstLineS, int w, int h, int param);
		void Blend_Mirr(void* SrcAddr, int SrcPitch, int SrcLineS, void* DstAddr, int DstPitch, int DstLineS, int w, int h, int param);
		void Blend_Shade(void* SrcAddr, int SrcPitch, int SrcLineS, void* DstAddr, int DstPitch, int DstLineS, int w, int h, int param);
		void SetShadeData(int w, int h, void* d);
		void MakeShadeData(xge::Surface* sf, char* sd);


		/* -------------------------- �ַ���ת���� -------------------------- */
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


		/* -------------------------- �ļ������� -------------------------- */
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
