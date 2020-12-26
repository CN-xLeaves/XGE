'==================================================================================
	'�� xywh Game Engine ����ͷ�ļ�
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================



#Ifndef xywh_library_xge
	#Define xywh_library_xge
	#Ifndef XGE_SOURCE_NOLIB
		#Define xywh_library_xge
		#Inclib "xge"
	#EndIf
	#Define XGE_EXTERNCLASS "C++"				' Class ������ʽ
	#Define XGE_EXTERNMODULE "Windows-MS"		' NameSpace ������ʽ
	#Define XGE_EXTERNSTDEXT "Windows-MS"		' ��ͨ����������ʽ
	
	
	
	/' -------------------------- ����ͷ�ļ� -------------------------- '/
	#Include Once "Crt.bi"
	#Include Once "Windows.bi"
	#Include Once "Win\GdiPlus.bi"
	
	
	
	/' -------------------------- ����ɨ���� -------------------------- '/
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
	
	
	/' -------------------------- ��ɫ���� -------------------------- '/
	#Define MASK_COLOR_24				&HFF00FF
	#Define MASK_COLOR_32				&HFFFF00FF
	#Define MASK32_R					&HFF0000
	#Define MASK32_G					&H00FF00
	#Define MASK32_B					&H0000FF
	#Define MASK32						&HFFFFFF
	
	
	/' -------------------------- ������ -------------------------- '/
	#Define XGE_BLEND_MIRR_H			1				' ˮƽ
	#Define XGE_BLEND_MIRR_V			2				' ��ֱ
	#Define XGE_BLEND_MIRR_HV			3
	#Define XGE_BLEND_MIRR_VH			3
	
	
	/' -------------------------- ��ʼ������ -------------------------- '/
	#Define XGE_INIT_WINDOW				&H00			' ����ģʽ
	#Define XGE_INIT_FULLSCREEN			&H01			' ȫ��ģʽ
	#Define XGE_INIT_NOSWITCH			&H04			' ������alt + enter�л�����/ȫ��
	#Define XGE_INIT_NOFRAME			&H08			' ����û�б߿�
	#Define XGE_INIT_POSTOP				&H20			' �����ö�
	#Define XGE_INIT_ALPHA				&H40			' ����alpha��϶������л�������
	#Define XGE_INIT_HIGHPRIORITY		&H80			' ͼ��������Ȩ��ͼ����
	
	
	/' -------------------------- ģ���ʼ������ -------------------------- '/
	#Define XGE_INIT_ALL				(XGE_INIT_GDI)
	#Define XGE_INIT_GDI				&H1				' ��ʼ��GDI/GDI+
	#Define XGE_INIT_DDT				&H2				' ��ʼ�� DDT ģ�� (������Ļ��С)
	#Define XGE_INIT_BASS				&H4				' ��ʼ�� BASS ģ��
	
	
	/' -------------------------- ������Ϣ���� -------------------------- '/
	#Define XGE_MSG_NULL				&H00			' ����Ϣ
	#Define XGE_MSG_LOADRES				&H01			' ������Դ
	#Define XGE_MSG_FREERES				&H02			' �ͷ���Դ
	#Define XGE_MSG_FRAME				&H03			' ��ܺ���
	#Define XGE_MSG_DRAW				&H04			' ��ͼ����
	#Define XGE_MSG_ERROR				&H05			' ������
	#Define XGE_MSG_LOSTFOCUS			&H06			' ��ʧ����
	#Define XGE_MSG_GOTFOCUS			&H07			' ��ý���
	#Define XGE_MSG_MOUSE_MOVE			&H08			' ����ƶ�
	#Define XGE_MSG_MOUSE_DOWN			&H09			' ��갴��
	#Define XGE_MSG_MOUSE_UP			&H0A			' ��굯��
	#Define XGE_MSG_MOUSE_DCLICK		&H0B			' ���˫��
	#Define XGE_MSG_MOUSE_WHELL			&H0C			' ���ֹ���
	#Define XGE_MSG_KEY_DOWN			&H0D			' ��������
	#Define XGE_MSG_KEY_UP				&H0E			' ��������
	#Define XGE_MSG_KEY_REPEAT			&H0F			' ������ס
	#Define XGE_MSG_MOUSE_ENTER			&H10			' �������
	#Define XGE_MSG_MOUSE_EXIT			&H11			' ����뿪
	#Define XGE_MSG_CLOSE				&H12			' ���ڹر�
	
	
	/' -------------------------- ��ͣ���� -------------------------- '/
	#Define XGE_PAUSE_DRAW				&H01			' ��ͣ����
	#Define XGE_PAUSE_FRAME				&H02			' ��ͣ�������
	
	
	/' -------------------------- �ļ����Ͷ��� -------------------------- '/
	#Define XGE_IMG_FMT_BMP				0
	#Define XGE_IMG_FMT_XGI				1
	
	
	/' -------------------------- ��Ƶ���Ͷ��� -------------------------- '/
	#Define XGE_SOUND_SAMPLE			1
	#Define XGE_SOUND_MUSIC				2
	#Define XGE_SOUND_STREAM			3
	
	
	/' -------------------------- С�������Ƕ��� -------------------------- '/
	#Define XGE_SUD_SMP_LOOP			4				' ѭ��
	#Define XGE_SUD_SMP_MONO			2				' ������
	#Define XGE_SUD_SMP_8B				1				' 8λ
	#Define XGE_SUD_SMP_32B				256				' 32λ
	#Define XGE_SUD_SMP_SOFT			16				' �������
	
	
	/' -------------------------- ��ý�������Ƕ��� -------------------------- '/
	#Define XGE_SUD_STE_LOOP			4				' ѭ��
	#Define XGE_SUD_STE_MONO			2				' ������
	#Define XGE_SUD_STE_32B				256				' 32λ
	#Define XGE_SUD_STE_SOFT			16				' �������
	#Define XGE_SUD_STE_PRES			&H20000			' Ԥɨ��
	#Define XGE_SUD_STE_AFRE			&H40000			' ���Ž����Զ��ͷ�
	#Define XGE_SUD_STE_BLOCK			&H100000		' �ֶ�����url��ý�� [����ѭ������]
	#Define XGE_SUD_STE_URL				&H80000000		' ��URL����
	
	
	/' -------------------------- ���������Ƕ��� -------------------------- '/
	#Define XGE_SUD_MUS_LOOP			4				' ѭ��
	#Define XGE_SUD_MUS_MONO			2				' ������
	#Define XGE_SUD_MUS_32B				256				' 32λ
	#Define XGE_SUD_MUS_SOFT			16				' �������
	#Define XGE_SUD_MUS_PRES			&H20000			' Ԥɨ��
	#Define XGE_SUD_MUS_AFRE			&H40000			' ���Ž����Զ��ͷ�
	#Define XGE_SUD_MUS_SUR				&H800			' ����
	#Define XGE_SUD_MUS_SUR2			&H1000			' ���� [ģʽ2]
	#Define XGE_SUD_MUS_NSMP			&H100000		' ������С��
	
	
	/' -------------------------- �������ö��� -------------------------- '/
	#Define XGE_SUD_VOL_ALL				&H0
	#Define XGE_SUD_VOL_SMP				&H4
	#Define XGE_SUD_VOL_STE				&H5
	#Define XGE_SUD_VOL_MUS				&H6
	
	
	/' -------------------------- �ı����붨�� -------------------------- '/
	#Define XGE_ALIGN_LEFT				&H0				' ���������
	#Define XGE_ALIGN_CENTER			&H1				' ������ж���
	#Define XGE_ALIGN_RIGHT				&H2				' �����Ҷ���
	#Define XGE_ALIGN_TOP				&H0				' �����϶���
	#Define XGE_ALIGN_MIDDLE			&H4				' ������ж���
	#Define XGE_ALIGN_BOTTOM			&H8				' ����ײ�����
	
	
	/' -------------------------- �������� -------------------------- '/
	#Define XGE_FONT_BOLD				&H10			' ����
	#Define XGE_FONT_ITALIC				&H20			' б��
	#Define XGE_FONT_BOLDITALIC			&H30			' ���� + б��
	#Define XGE_FONT_UNDERLINE			&H40			' �»���
	#Define XGE_FONT_SRTIKEOUT			&H80			' ɾ����
	
	
	/' -------------------------- ��Ϣ�ṹ�� -------------------------- '/
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
	
	
	/' -------------------------- ͼ��ṹ�� -------------------------- '/
	Type IMAGE
		tpe as UInteger
		bpp As Integer
		Width As UInteger
		Height As UInteger
		Pitch As UInteger
		reserved(1 To 12) As UByte
	End Type
	
	
	/' -------------------------- �������Ͷ��� -------------------------- '/
	Type XGE_SCENE_PROC As Function(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Type XGE_EVENT_PROC As Sub(eve As XGE_EVENT Ptr)
	Type XGE_DELAY_PROC As Sub(ms As Integer)
	Type XGE_BLOAD_PROC As Function(img As Any Ptr, addr As ZString Ptr, size As UInteger) As Integer
	Type XGE_DRAW_BLEND As Sub(SrcAddr As Any Ptr, SrcPitch As Integer, SrcLineS As Integer, DstAddr As Any Ptr, DstPitch As Integer, DstLineS As Integer, w As Integer, h As Integer, param As Integer)
	Type XGE_DRAW_CUSTOM As Function(src As UInteger, dst As UInteger, param As Any Ptr) As UInteger
	
	
	
	Extern XGE_EXTERNCLASS
		/' -------------------------- ջ�ṹ��[�ṹ��] -------------------------- '/
		Type xStack
			' ����/����
			Declare Constructor(max As UInteger, unitsize As UInteger)
			Declare Destructor()
			
			' ��ʼ��/ж��
			Declare Function Init(max As UInteger, unitsize As UInteger) As Integer
			Declare Sub Unit()
			
			' ѹջ
			Declare Function Push(dat As Any Ptr) As Integer
			
			' ��ջ
			Declare Function Pop(c As UInteger) As Any Ptr
			
			' ջ��
			Declare Function Top() As Any Ptr
			
			' ѹջ����
			Declare Function Count() As UInteger
			
			Private:
				Dim pMaxCount As UInteger
				Dim pUnitSize As UInteger
				Dim pStackMem As UByte Ptr
				Dim pStackTop As UInteger
		End Type
		
		
		/' -------------------------- ջ�ṹ��[Int] -------------------------- '/
		Type xStack_Int
			' ����/����
			Declare Constructor(max As UInteger)
			Declare Destructor()
			
			' ��ʼ��/ж��
			Declare Function Init(max As UInteger) As Integer
			Declare Sub Unit()
			
			' ѹջ
			Declare Function Push(dat As Integer) As Integer
			
			' ��ջ
			Declare Function Pop() As Integer
			Declare Function Pop(c As UInteger) As Integer Ptr
			
			' ջ��
			Declare Function Top() As Integer
			
			' ѹջ����
			Declare Function Count() As UInteger
			
			Private:
				Dim pMaxCount As UInteger
				Dim pStackMem As Integer Ptr
				Dim pStackTop As UInteger
		End Type
	End Extern
	
	
	
	Extern XGE_EXTERNMODULE
		/' -------------------------- ���Ŀ� -------------------------- '/
		Declare Function xge_Init(w As UInteger, h As UInteger, init_gfx As Integer = XGE_INIT_WINDOW, init_mod As Integer = XGE_INIT_ALL, title As ZString Ptr = NULL) As Integer
		Declare Sub xge_Unit()
		Declare Function xge_SetScreen(w As UInteger, h As UInteger, init_gfx As Integer = XGE_INIT_WINDOW) As Integer
		Declare Function xge_hWnd() As HANDLE
		Declare Sub xge_Clear()
		Declare Sub xge_Lock()
		Declare Sub xge_UnLock()
		Declare Sub xge_Sync()
		Declare Function xge_Width() As UInteger
		Declare Function xge_Height() As UInteger
		Declare Function xge_PixAddr() As Any Ptr
		Declare Function xge_PixSize() As UInteger
		Declare Function xge_Pitch() As UInteger
		Declare Function xge_Driver() As ZString Ptr
		Declare Sub xge_SetSoundVol(tpe As Integer, vol As Integer)
		Declare Function xge_GetSoundVol(tpe As Integer) As Integer
		Declare Function xge_Ver(tpe As Integer = 0) As Integer
		
		
		/' -------------------------- ������ -------------------------- '/
		Declare Function xge_Scene_Start(proc As XGE_SCENE_PROC, lfps As UInteger = 0, sync As Integer = FALSE, param As Integer = 0) As Integer
		Declare Function xge_Scene_Cut(proc As XGE_SCENE_PROC, lfps As UInteger, sync As Integer, param As Integer = 0) As Integer
		Declare Sub xge_Scene_Stop(sc As Integer = 0)
		Declare Sub xge_Scene_StopAll(sc As Integer = 0)
		Declare Sub xge_Scene_Pause(flag As Integer = XGE_PAUSE_DRAW Or XGE_PAUSE_FRAME)
		Declare Function xge_Scene_State() As Integer
		Declare Sub xge_Scene_Resume()
		Declare Function xge_Scene_FPS() As UInteger
		Declare Function xge_Scene_Stack() As xStack Ptr
		
		
		/' -------------------------- �ҹ��� -------------------------- '/
		Declare Sub xge_Hook_SetDelayProc(proc As XGE_DELAY_PROC)
		Declare Sub xge_Hook_SetEventProc(proc As XGE_EVENT_PROC)
		Declare Sub xge_Hook_SetSceneProc(proc As XGE_SCENE_PROC)
		Declare Sub xge_Hook_SetBLoadProc(proc As XGE_BLOAD_PROC)
		
		
		/' -------------------------- ����� -------------------------- '/
		Declare Function xge_Input_KeyStatus(k As Integer) As Integer
		Declare Sub xge_Input_MouseStatus(x As Integer Ptr, y As Integer Ptr, w As Integer Ptr, b As Integer Ptr)
		Declare Function xge_Input_JoyStatus(id As Integer, btn As Integer Ptr, a1 As Single Ptr, a2 As Single Ptr, a3 As Single Ptr, a4 As Single Ptr, a5 As Single Ptr, a6 As Single Ptr, a7 As Single Ptr, a8 As Single Ptr) As Integer
		Declare Function xge_Input_GetMousePos() As Integer
		Declare Function xge_Input_SetMousePos(x As Integer, y As Integer) As Integer
		Declare Function xge_Input_GetMouseX() As Integer
		Declare Function xge_Input_GetMouseY() As Integer
		Declare Function xge_Input_GetMouseBtn() As Integer
		Declare Function xge_Input_GetMouseBtnL() As Integer
		Declare Function xge_Input_GetMouseBtnR() As Integer
		Declare Function xge_Input_GetMouseBtnM() As Integer
		Declare Function xge_Input_GetMouseWhell() As Integer
	End Extern
	
	
	Extern XGE_EXTERNCLASS
		Namespace xge
			/' -------------------------- ͼ���� -------------------------- '/
			Type Surface
				img As IMAGE Ptr
				
				' ���� [��]
				Declare Constructor()
				
				' ���� [����]
				Declare Constructor(w As UInteger, h As UInteger)
				
				' ���� [����]
				Declare Constructor(addr As ZString Ptr, size As UInteger = 0)
				
				' ����
				Declare Destructor()
				
				' ����ͼ��
				Declare Function Create(w As UInteger, h As UInteger) As Integer
				
				' ����ͼ��
				Declare Function Load(addr As ZString Ptr, size As UInteger = 0) As Integer
				
				' ����ͼ��
				Declare Function Save(addr As ZString Ptr, tpe As UInteger = 0, flag As Integer = 0) As Integer
				
				' �ͷ�ͼ��
				Declare Sub Free()
				
				' ���ͼ��
				Declare Sub Clear()
				
				' ��ȡͼ������
				Declare Function Width() As UInteger
				Declare Function Height() As UInteger
				Declare Function PixAddr() As Any Ptr
				Declare Function PixSize() As UInteger
				Declare Function Pitch() As UInteger
				
				' ����ͼ�񸱱�
				Declare Function Copy(x As Integer, y As Integer, w As Integer, h As Integer) As xge.Surface Ptr
				
				' ����
				Declare Sub Draw(x As Integer, y As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub DrawEx(x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub Draw_Add(x As Integer, y As Integer, mul As Integer = 255, sf As xge.Surface Ptr = NULL)
				Declare Sub DrawEx_Add(x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, mul As Integer = 255, sf As xge.Surface Ptr = NULL)
				Declare Sub Draw_Alpha(x As Integer, y As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub DrawEx_Alpha(x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub Draw_Alpha2(x As Integer, y As Integer, a As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub DrawEx_Alpha2(x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, a As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub Draw_And(x As Integer, y As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub DrawEx_And(x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub Draw_Or(x As Integer, y As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub DrawEx_Or(x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub Draw_PSet(x As Integer, y As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub DrawEx_PSet(x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub Draw_Xor(x As Integer, y As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub DrawEx_Xor(x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub Draw_Gray(x As Integer, y As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub DrawEx_Gray(x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub Draw_Mirr(x As Integer, y As Integer, flag As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub DrawEx_Mirr(x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, flag As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub Draw_Shade(x As Integer, y As Integer, mask As UByte, sf As xge.Surface Ptr = NULL)
				Declare Sub DrawEx_Shade(x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, mask As UByte, sf As xge.Surface Ptr = NULL)
				Declare Sub Draw_Custom(x As Integer, y As Integer, bk As XGE_DRAW_CUSTOM, param As Any Ptr = NULL, sf As xge.Surface Ptr = NULL)
				Declare Sub DrawEx_Custom(x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, bk As XGE_DRAW_CUSTOM, param As Any Ptr = NULL, sf As xge.Surface Ptr = NULL)
				Declare Sub Draw_Blend(x As Integer, y As Integer, bk As Any Ptr, param As Integer = 0, sf As xge.Surface Ptr = NULL)
				Declare Sub DrawEx_Blend(x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, bk As Any Ptr, param As Integer = 0, sf As xge.Surface Ptr = NULL)
			End Type
			
			
			/' -------------------------- Gdiͼ���� -------------------------- '/
			Type GdiSurface Extends Surface
				hDC As HANDLE
				hBitmap As HANDLE
				BitmapAddr As Any Ptr
				gfx As GdiPlus.GpGraphics Ptr
				
				' ���� [��]
				Declare Constructor()
				
				' ���� [����]
				Declare Constructor(w As UInteger, h As UInteger)
				
				' ���� [����]
				Declare Constructor(addr As ZString Ptr, size As UInteger = 0)
				
				' ����
				Declare Destructor()
				
				' ����ͼ��
				Declare Function Create(w As UInteger, h As UInteger) As Integer
				
				' ����ͼ��
				Declare Function Load(addr As ZString Ptr, size As UInteger = 0) As Integer
				
				' �ͷ�ͼ��
				Declare Sub Free()
				
				' GDI ��ͼ
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
			
			
			/' -------------------------- ��Ⱦ������� -------------------------- '/
			Type RenderBaseObject Extends Object
				x As Integer
				y As Integer
				Priority As Integer
				Enabled As Integer
				Visible As Integer
				
				Declare Abstract Sub Disp()
				Declare Abstract Sub Draw(px As Integer, py As Integer)
			End Type
			
			
			/' -------------------------- ��Ⱦ������ -------------------------- '/
			Type RenderObject Extends RenderBaseObject
				img As xge.Surface Ptr
				Parent As xge.Surface Ptr
				cut As Integer
				cx As Integer
				cy As Integer
				cw As Integer
				ch As Integer
				AutoFree As Integer
				
				' �չ���
				Declare Constructor()
				
				' ������ Surface ����
				Declare Constructor(sf As xge.Surface Ptr, px As Integer = 0, py As Integer = 0, pl As Integer = 0, p As xge.Surface Ptr = NULL)
				
				' �Զ��������ͷ� Surface
				Declare Constructor(addr As ZString Ptr, size As UInteger, px As Integer = 0, py As Integer = 0, pl As Integer = 0, p As xge.Surface Ptr = NULL)
				
				' ����
				Declare Destructor()
				
				' �ü�
				Declare Sub SetCut(iscut As Integer, cut_x As Integer = 0, cut_y As Integer = 0, cut_w As Integer = 0, cut_h As Integer = 0)
				
				' ��Ⱦ
				Declare Sub Draw(px As Integer, py As Integer)
			End Type
			
			
			/' -------------------------- ������ -------------------------- '/
			Type Sound
				SoundObj As UInteger
				
				' ���� [��]
				Declare Constructor()
				
				' ���� [����]
				Declare Constructor(tpe As Integer, flag As Integer, addr As ZString Ptr, size As UInteger = 0, max As Integer = 65535)
				
				' ����
				Declare Destructor()
				
				' ��������
				Declare Function Load(tpe As Integer, flag As Integer, addr As ZString Ptr, size As UInteger = 0, max As Integer = 65535) As Integer
				
				' �ͷ�����
				Declare Sub Free()
				
				' ��������
				Declare Function GetType() As Integer
				
				' ��������
				Declare Sub Play()
				Declare Sub Stop()
				Declare Sub Pause()
				Declare Sub Resume()
				
				Protected:
					pTpe As Integer
			End Type
		End Namespace
		
		
		/' -------------------------- ����� -------------------------- '/
		Namespace xSock
			Type xServer
				Section As CRITICAL_SECTION
				
				' �¼�����
				Dim RecvEvent As Sub(client As HANDLE, pack As ZString Ptr, size As UInteger)
				Dim SendEvent As Sub(client As HANDLE, code As Integer)
				Dim AcceptEvent As Sub(client As HANDLE)
				Dim DisconnEvent As Sub(client As HANDLE)
				
				' ����
				Declare Destructor()
				
				' ����
				Declare Function Create(ip As ZString Ptr, port As UShort, max As UInteger = 1000, ThreadCountt As UInteger = 1) As Integer
				
				' ����
				Declare Sub Destroy()
				
				' ״̬
				Declare Function Status() As Integer
				
				' ����
				Declare Function Send(Client As HANDLE, pack As ZString Ptr, size As UInteger, sync As Integer = TRUE) As Integer
				
				' �����ͻ���
				Declare Function EnumClient(first As HANDLE) As HANDLE
				
				' ��ȡ�ͻ�����Ϣ
				Declare Function GetClientInfo(client As HANDLE, ip As ZString Ptr Ptr, port As UInteger Ptr) As Integer
				
				' �ڲ��¼�����
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
					
					' ��ӵ��ͻ����б�
					Declare Function AddClientList(client As HANDLE) As Integer
					
					' �ӿͻ����б�ɾ��
					Declare Function DelClientList(client As HANDLE) As Integer
			End Type
	
			Type xClient
				Section As CRITICAL_SECTION
				
				' �¼�����
				Dim RecvEvent As Sub(pack As ZString Ptr, size As UInteger)
				Dim SendEvent As Sub(code As Integer)
				Dim CloseEvent As Sub()
				
				' ����
				Declare Destructor()
				
				' ����
				Declare Function Connect(ip As ZString Ptr, port As UShort) As Integer
				
				' �Ͽ�
				Declare Sub Close()
				
				' ״̬
				Declare Function Status() As Integer
				
				' ����
				Declare Function Send(pack As ZString Ptr, size As UInteger, sync As Integer = TRUE) As Integer
				
				Private:
					h_Client As HANDLE
			End Type
			
			Type xUDP
				' �¼�����
				Dim RecvEvent As Sub(pack As ZString Ptr, size As UInteger, ip As ZString Ptr, port As Integer)
				Dim SendEvent As Sub(code As Integer)
				
				' ����
				Declare Destructor()
				
				' ����
				Declare Function Create(ip As ZString Ptr, port As UShort, ThreadCountt As UInteger = 1) As Integer
				
				' ����
				Declare Sub Destroy()
				
				' ״̬ [�Ѵ���=TRUE]
				Declare Function Status() As Integer
				
				' ����
				Declare Function Send(pack As ZString Ptr, size As UInteger, ip As ZString Ptr, port As UShort, sync As Integer = TRUE) As Integer
				
				Private:
					h_Socket As HANDLE
			End Type
		End Namespace
	End Extern
	
	
	
	Extern XGE_EXTERNMODULE
		/' -------------------------- ������ -------------------------- '/
		Declare Function xge_Aux_ScreenShot() As xge.Surface Ptr
		Declare Function xge_Aux_GetPixel(x As Integer, y As Integer, sf As xge.Surface Ptr = NULL) As UInteger
		Declare Function xge_Aux_RGB2BGR(c As UInteger) As UInteger
		Declare Sub xge_Aux_SetTitle(title As ZString Ptr)
		Declare Sub xge_Aux_SetView(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, f As Integer)
		Declare Sub xge_Aux_ReSetView()
		Declare Sub xge_Aux_SetCoodr(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer = 0)
		Declare Sub xge_Aux_ReSetCoodr()
		Declare Function xge_Aux_MapCoodr(coodr As Integer, tpe As Integer) As Integer
		Declare Function xge_Aux_LockMouse() As Integer
		Declare Function xge_Aux_UnLockMouse() As Integer
		Declare Function xge_Aux_HideCursor() As Integer
		Declare Function xge_Aux_ShowCursor() As Integer
		
		
		/' -------------------------- ͼ�ο� -------------------------- '/
		Declare Sub xge_Shape_Pixel(x As Integer, y As Integer, c As Integer, sf As xge.Surface Ptr = NULL)
		Declare Sub xge_Shape_Lines(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, sf As xge.Surface Ptr = NULL)
		Declare Sub xge_Shape_LinesEx(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, s As Integer, sf As xge.Surface Ptr = NULL)
		Declare Sub xge_Shape_Rect(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, sf As xge.Surface Ptr = NULL)
		Declare Sub xge_Shape_RectEx(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, s As Integer, sf As xge.Surface Ptr = NULL)
		Declare Sub xge_Shape_RectFull(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, sf As xge.Surface Ptr = NULL)
		Declare Sub xge_Shape_Circ(x As Integer, y As Integer, r As Integer, c As Integer, sf As xge.Surface Ptr = NULL)
		Declare Sub xge_Shape_CircFull(x As Integer, y As Integer, r As Integer, c As Integer, sf As xge.Surface Ptr = NULL)
		Declare Sub xge_Shape_CircEx(x As Integer, y As Integer, r As Integer, c As Integer, a As Single, sf As xge.Surface Ptr = NULL)
		Declare Sub xge_Shape_CircFullEx(x As Integer, y As Integer, r As Integer, c As Integer, a As Single, sf As xge.Surface Ptr = NULL)
		Declare Sub xge_Shape_CircArc(x As Integer, y As Integer, r As Integer, c As Integer, s As Integer, e As Integer, a As Single, sf As xge.Surface Ptr = NULL)
		Declare Sub xge_Shape_Full(x As Integer, y As Integer, c As Integer, f As Integer, sf As xge.Surface Ptr = NULL)
		Declare Sub xge_Shape_FullEx(x As Integer, y As Integer, p As ZString Ptr, f As Integer, sf As xge.Surface Ptr = NULL)
		
		
		/' -------------------------- Gdi���ֿ� -------------------------- '/
		Declare Sub xge_ddt_Init(mw As Integer, mh As Integer)
		Declare Sub xge_ddt_Draw1(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, c As Integer, txt As ZString Ptr, sf As xge.Surface Ptr = NULL)
		Declare Sub xge_ddt_Draw2(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, c As Integer, weight As Integer, txt As ZString Ptr, sf As xge.Surface Ptr = NULL)
		Declare Sub xge_ddt_Draw3(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, c1 As Integer, c2 As Integer, weight As Integer, txt As ZString Ptr, sf As xge.Surface Ptr = NULL)
		Declare Sub xge_ddt_Draw4(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, addr As ZString Ptr, size As Integer, txt As ZString Ptr, sf As xge.Surface Ptr = NULL)
	End Extern
	
	
	
	Extern XGE_EXTERNSTDEXT
		/' -------------------------- �����Ⱦ�� -------------------------- '/
		Declare Function Blend_Custom(src As xge.Surface Ptr, px As Integer, py As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer,dst As xge.Surface Ptr, bk As XGE_DRAW_BLEND, param As Integer) As Integer
		Declare Sub Blend_Gray(SrcAddr As Any Ptr, SrcPitch As Integer, SrcLineS As Integer, DstAddr As Any Ptr, DstPitch As Integer, DstLineS As Integer, w As Integer, h As Integer, param As Integer)
		Declare Sub Blend_Mirr(SrcAddr As Any Ptr, SrcPitch As Integer, SrcLineS As Integer, DstAddr As Any Ptr, DstPitch As Integer, DstLineS As Integer, w As Integer, h As Integer, param As Integer)
		Declare Sub Blend_Shade(SrcAddr As Any Ptr, SrcPitch As Integer, SrcLineS As Integer, DstAddr As Any Ptr, DstPitch As Integer, DstLineS As Integer, w As Integer, h As Integer, param As Integer)
		Declare Sub SetShadeData(w As Integer, h As Integer, d As Any Ptr)
		Declare Sub MakeShadeData(sf As xge.Surface Ptr, sd As UByte Ptr)
		
		
		/' -------------------------- �ַ���ת���� -------------------------- '/
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
		
		
		/' -------------------------- �ļ������� -------------------------- '/
		Declare Function PutFile(FileName As ZString Ptr, Buffer As Any Ptr, Addr As Integer, Lenght As Integer) As Integer
		Declare Function GetFile(FileName As ZString Ptr, Buffer As Any Ptr, Addr As Integer, Lenght As Integer) As Integer
		Declare Function NewFile(FileName As ZString Ptr) As Integer
		Declare Function FileExists(FileName As ZString Ptr) As Integer
		Declare Function FileLen(FileName As ZString Ptr) As UInteger
		Declare Function SetFileSize(FileName As ZString Ptr, FileSize As Integer) As Integer
		Declare Function Open_File(FileName As ZString Ptr, OnlyRead As Integer = 0) As HANDLE
		Declare Function Put_File(FileHdr As HANDLE, Buffer As Any Ptr, Addr As Integer, Lenght As Integer) As Integer
		Declare Function Get_File(FileHdr As HANDLE, Buffer As Any Ptr, Addr As Integer, Lenght As Integer) As Integer
		Declare Function File_Len(FileHdr As HANDLE) As UInteger
	End Extern
#EndIf
