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
		_stdcall xStack(unsigned int max, unsigned int unitsize);
		_stdcall ~xStack();

		// ��ʼ��/ж��
		_stdcall int Init(unsigned int max, unsigned int unitsize);
		_stdcall void Unit();

		// ѹջ
		_stdcall int Push(void* dat);

		// ��ջ
		_stdcall void* Pop(unsigned int c);

		// ջ��
		_stdcall void* Top();

		// ѹջ����
		_stdcall unsigned int Count();

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
		_stdcall xStack_Int(unsigned int max);
		_stdcall ~xStack_Int();

		// ��ʼ��/ж��
		_stdcall int Init(unsigned int max);
		_stdcall void Unit();

		// ѹջ
		_stdcall int Push(int dat);

		// ��ջ
		_stdcall int Pop();
		_stdcall int* Pop(unsigned int c);

		// ջ��
		_stdcall int Top();

		// ѹջ����
		_stdcall unsigned int Count();

	private:
		unsigned int pMaxCount;
		int* pStackMem;
		unsigned int pStackTop;
	};


	/* -------------------------- ���Ŀ� -------------------------- */
	namespace xge
	{
		_stdcall int Init(unsigned int w, unsigned int h, int init_gfx = XGE_INIT_WINDOW, int init_mod = XGE_INIT_ALL, char* title = NULL);
		_stdcall void Unit();
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
		_stdcall char* Driver();
		_stdcall void SetSoundVol(int tpe, int vol);
		_stdcall int GetSoundVol(int tpe);
		_stdcall int Ver(int tpe = 0);


		/* -------------------------- ������ -------------------------- */
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
			_stdcall xStack* Stack();
		};


		/* -------------------------- �ҹ��� -------------------------- */
		namespace Hook
		{
			_stdcall void SetDelayProc(XGE_DELAY_PROC proc);
			_stdcall void SetEventProc(XGE_EVENT_PROC proc);
			_stdcall void SetSceneProc(XGE_SCENE_PROC proc);
			_stdcall void SetBLoadProc(XGE_BLOAD_PROC proc);
		};


		/* -------------------------- ����� -------------------------- */
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


		/* -------------------------- ͼ���� -------------------------- */
		class Surface
		{
		public:
			IMAGE* img;

			// ���� [��]
			_stdcall Surface();

			// ���� [����]
			_stdcall Surface(unsigned int w, unsigned int h);

			// ���� [����]
			_stdcall Surface(char* addr, unsigned int size = 0);

			// ����
			_stdcall ~Surface();

			// ����ͼ��
			_stdcall int Create(unsigned int w, unsigned int h);

			// ����ͼ��
			_stdcall int Load(char* addr, unsigned int size = 0);

			// ����ͼ��
			_stdcall int Save(char* addr, unsigned int tpe = 0, int flag = 0);

			// �ͷ�ͼ��
			_stdcall void Free();

			// ���ͼ��
			_stdcall void Clear();

			// ��ȡͼ������
			_stdcall unsigned int Width();
			_stdcall unsigned int Height();
			_stdcall void* PixAddr();
			_stdcall unsigned int PixSize();
			_stdcall unsigned int Pitch();

			// ����ͼ�񸱱�
			_stdcall xge::Surface* Copy(int x, int y, int w, int h);

			// ����
			_stdcall void Draw(int x, int y, xge::Surface* sf = NULL);
			_stdcall void DrawEx(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			_stdcall void Draw_Add(int x, int y, int mul = 255, xge::Surface* sf = NULL);
			_stdcall void DrawEx_Add(int x, int y, int cx, int cy, int cw, int ch, int mul = 255, xge::Surface* sf = NULL);
			_stdcall void Draw_Alpha(int x, int y, xge::Surface* sf = NULL);
			_stdcall void DrawEx_Alpha(int x, int y, int cx, int cy, int cw, int ch, xge::Surface* sf = NULL);
			_stdcall void Draw_Alpha2(int x, int y, int a, xge::Surface* sf = NULL);
			_stdcall void DrawEx_Alpha2(int x, int y, int cx, int cy, int cw, int ch, int a, xge::Surface* sf = NULL);
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


		/* -------------------------- Gdiͼ���� -------------------------- */
		class GdiSurface// : public Surface
		{
		public:
			HANDLE hDC;
			HANDLE hBitmap;
			void* BitmapAddr;
			void* gfx;

			// ���� [��]
			_stdcall GdiSurface();

			// ���� [����]
			_stdcall GdiSurface(unsigned int w, unsigned int h);

			// ���� [����]
			_stdcall GdiSurface(char* addr, unsigned int size = 0);

			// ����
			_stdcall ~GdiSurface();

			// ����ͼ��
			_stdcall int Create(unsigned int w, unsigned int h);

			// ����ͼ��
			_stdcall int Load(char* addr, unsigned int size = 0);

			// �ͷ�ͼ��
			_stdcall void Free();

			// GDI ��ͼ
			_stdcall void PrintLine(int x1, int y1, int x2, int y2, unsigned int c);
			_stdcall void PrintRect(int x, int y, int w, int h, unsigned int c);
			_stdcall void PrintRectFull(int x, int y, int w, int h, unsigned int c);
			_stdcall void PrintCirc(int x, int y, int w, int h, unsigned int c);
			_stdcall void PrintCircFull(int x, int y, int w, int h, unsigned int c);
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


		/* -------------------------- ��Ⱦ������� -------------------------- */
		class RenderBaseObject
		{
		public:
			int x;
			int y;
			int Priority;
			int Enabled;
			int Visible;

			_stdcall virtual void Disp() = 0;
			_stdcall virtual void Draw(int px, int py) = 0;
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
			_stdcall RenderObject();

			// ������ Surface ����
			_stdcall RenderObject(xge::Surface* sf, int px = 0, int py = 0, int pl = 0, xge::Surface* p = NULL);

			// �Զ��������ͷ� Surface
			_stdcall RenderObject(char* addr, unsigned int size, int px = 0, int py = 0, int pl = 0, xge::Surface* p = NULL);

			// ����
			_stdcall ~RenderObject();

			// �ü�
			_stdcall void SetCut(int iscut, int cut_x = 0, int cut_y = 0, int cut_w = 0, int cut_h = 0);

			// ��Ⱦ
			_stdcall void Draw(int px, int py);
		};


		/* -------------------------- ������ -------------------------- */
		class Sound
		{
		public:
			unsigned int SoundObj;

			// ���� [��]
			_stdcall Sound();

			// ���� [����]
			_stdcall Sound(int tpe, int flag, char* addr, unsigned int size = 0, int max = 65535);

			// ����
			_stdcall ~Sound();

			// ��������
			_stdcall int Load(int tpe, int flag, char* addr, unsigned int size = 0, int max = 65535);

			// �ͷ�����
			_stdcall void Free();

			// ��������
			_stdcall int GetType();

			// ��������
			_stdcall void Play();
			_stdcall void Stop();
			_stdcall void Pause();
			_stdcall void Resume();

		protected:
			int pTpe;
		};


		/* -------------------------- ������ -------------------------- */
		namespace Aux
		{
			_stdcall xge::Surface* ScreenShot();
			_stdcall unsigned int GetPixel(int x, int y, xge::Surface* sf = NULL);
			_stdcall unsigned int RGB2BGR(unsigned int c);
			_stdcall void SetTitle(char* title);
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


		/* -------------------------- ͼ�ο� -------------------------- */
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
			_stdcall void FullEx(int x, int y, char* p, int f, xge::Surface* sf = NULL);
		};


		/* -------------------------- Gdi���ֿ� -------------------------- */
		namespace ddt
		{
			_stdcall void Init(int mw, int mh);
			_stdcall void Draw(int x, int y, int w, int h, char* f, int px, int flag, int c, char* txt, xge::Surface* sf = NULL);
			_stdcall void Draw(int x, int y, int w, int h, char* f, int px, int flag, int c, int weight, char* txt, xge::Surface* sf = NULL);
			_stdcall void Draw(int x, int y, int w, int h, char* f, int px, int flag, int c1, int c2, int weight, char* txt, xge::Surface* sf = NULL);
			_stdcall void Draw(int x, int y, int w, int h, char* f, int px, int flag, char* addr, int size, char* txt, xge::Surface* sf = NULL);
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
			_stdcall ~xServer();

			// ����
			_stdcall int Create(char* ip, unsigned short port, unsigned int max = 1000, unsigned int ThreadCountt = 1);

			// ����
			_stdcall void Destroy();

			// ״̬
			_stdcall int Status();

			// ����
			_stdcall int Send(HANDLE Client, char* pack, unsigned int size, int sync = TRUE);

			// �����ͻ���
			_stdcall HANDLE EnumClient(HANDLE first);

			// ��ȡ�ͻ�����Ϣ
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

            // �¼�����
            XGE_SOCK_CRECV RecvEvent;
            XGE_SOCK_CSEND SendEvent;
            XGE_SOCK_CACCEPT CloseEvent;

			// ����
			_stdcall ~xClient();

			// ����
			_stdcall int Connect(char* ip, unsigned short port);

			// �Ͽ�
			_stdcall void Close();

			// ״̬
			_stdcall int Status();

			// ����
			_stdcall int Send(char* pack, unsigned int size, int sync = TRUE);

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
			_stdcall ~xUDP();

			// ����
			_stdcall int Create(char* ip, unsigned short port, unsigned int ThreadCountt = 1);

			// ����
			_stdcall void Destroy();

			// ״̬ [�Ѵ���=TRUE]
			_stdcall int Status();

			// ����
			_stdcall int Send(char* pack, unsigned int size, char* ip, unsigned short port, int sync = TRUE);

		private:
			HANDLE h_Socket;
		};
	};


	extern "C"
	{
		/* -------------------------- �����Ⱦ�� -------------------------- */
		_stdcall int Blend_Custom(xge::Surface* src, int px, int py, int cx, int cy, int cw, int ch, xge::Surface* dst, XGE_DRAW_BLEND bk, int param);
		_stdcall void Blend_Gray(void* SrcAddr, int SrcPitch, int SrcLineS, void* DstAddr, int DstPitch, int DstLineS, int w, int h, int param);
		_stdcall void Blend_Mirr(void* SrcAddr, int SrcPitch, int SrcLineS, void* DstAddr, int DstPitch, int DstLineS, int w, int h, int param);
		_stdcall void Blend_Shade(void* SrcAddr, int SrcPitch, int SrcLineS, void* DstAddr, int DstPitch, int DstLineS, int w, int h, int param);
		_stdcall void SetShadeData(int w, int h, void* d);
		_stdcall void MakeShadeData(xge::Surface* sf, char* sd);


		/* -------------------------- �ַ���ת���� -------------------------- */
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


		/* -------------------------- �ļ������� -------------------------- */
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
