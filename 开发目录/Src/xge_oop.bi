'==================================================================================
	'�� xywh Game Engine ����ͷ�ļ�
	'#-----------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================



#Ifndef xywh_library_xge
	#Define xywh_library_xge
	#Ifndef XGE_SOURCE_NOLIB
		#Define XGE_SOURCE_NOLIB
		#Inclib "xge"
	#EndIf
	#Define XGE_EXTERNCLASS "Windows"					' Class ������ʽ
	#Define XGE_EXTERNMODULE "Windows"				' NameSpace ������ʽ
	#Define XGE_EXTERNSTDEXT "Windows"			' ��ͨ����������ʽ
	
	
	
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
	#Define XGE_BLEND_MIRR_HV			3				' ˮƽ + ��ֱ
	#Define XGE_BLEND_MIRR_VH			3				' ˮƽ + ��ֱ
	
	
	/' -------------------------- ��ʼ������ -------------------------- '/
	#Define XGE_INIT_WINDOW				&H00			' ����ģʽ
	#Define XGE_INIT_FULLSCREEN			&H01			' ȫ��ģʽ
	#Define XGE_INIT_NOSWITCH			&H04			' ������alt + enter�л�����/ȫ��
	#Define XGE_INIT_NOFRAME			&H08			' ����û�б߿�
	#Define XGE_INIT_POSTOP				&H20			' �����ö�
	#Define XGE_INIT_ALPHA				&H40			' ����alpha��϶������л�������
	#Define XGE_INIT_HIGHPRIORITY		&H80			' ������Ȩ��ͼ����
	
	
	/' -------------------------- ģ���ʼ������ -------------------------- '/
	#Define XGE_INIT_ALL				(XGE_INIT_GDI Or XGE_INIT_BASS)
	#Define XGE_INIT_GDI				&H1				' ��ʼ��GDI/GDI+
	#Define XGE_INIT_BASS				&H2				' ��ʼ�� BASS ģ��
	
	
	/' -------------------------- ������Ϣ���� -------------------------- '/
	#Define XGE_MSG_NULL				&H00			' ����Ϣ
	#Define XGE_MSG_LOADRES				&H01			' ������Դ
	#Define XGE_MSG_FREERES				&H02			' �ͷ���Դ
	#Define XGE_MSG_FRAME				&H03			' ��ܺ���
	#Define XGE_MSG_DRAW				&H04			' ��ͼ����
	#Define XGE_MSG_ERROR				&H05			' ������
	#Define XGE_MSG_MOUSE_MOVE			&H101			' ����ƶ�
	#Define XGE_MSG_MOUSE_DOWN			&H102			' ��갴��
	#Define XGE_MSG_MOUSE_UP			&H103			' ��굯��
	#Define XGE_MSG_MOUSE_CLICK			&H104			' ��굥��
	#Define XGE_MSG_MOUSE_DCLICK		&H105			' ���˫��
	#Define XGE_MSG_MOUSE_WHELL			&H106			' ���ֹ���
	#Define XGE_MSG_KEY_DOWN			&H201			' ��������
	#Define XGE_MSG_KEY_UP				&H202			' ��������
	#Define XGE_MSG_KEY_REPEAT			&H203			' ������ס
	#Define XGE_MSG_MOUSE_ENTER			&H301			' �������
	#Define XGE_MSG_MOUSE_EXIT			&H302			' ����뿪
	#Define XGE_MSG_LOSTFOCUS			&H311			' ��ʧ����
	#Define XGE_MSG_GOTFOCUS			&H312			' ��ý���
	#Define XGE_MSG_CLOSE				&H321			' ���ڹر�
	
	
	/' -------------------------- ��ͣ���� -------------------------- '/
	#Define XGE_PAUSE_DRAW				&H01			' ��ͣ����
	#Define XGE_PAUSE_FRAME				&H02			' ��ͣ�������
	
	
	/' -------------------------- �ļ����Ͷ��� -------------------------- '/
	#Define XGE_IMG_FMT_BMP				0
	#Define XGE_IMG_FMT_XGI				1
	
	
	/' -------------------------- XGI�ļ���ض��� -------------------------- '/
	#Define XGI_FLAG_LZ4		1						' �Ƿ����� LZ4 ѹ��
	#Define XGI_FLAG_B16		2						' �Ƿ�Ϊ 16 λͼ��
	
	
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
	
	
	/' -------------------------- GUI���ַ�ʽ���� -------------------------- '/
	#Define XUI_LAYOUT_COORD			0				' ����ϵͳ - �������֣������������λ��
	#Define XUI_LAYOUT_L2R				1				' ����ϵͳ - ���򲼾� [������]
	#Define XUI_LAYOUT_R2L				2				' ����ϵͳ - ���򲼾� [���ҵ���]
	#Define XUI_LAYOUT_T2B				3				' ����ϵͳ - ���򲼾� [���ϵ���]
	#Define XUI_LAYOUT_B2T				4				' ����ϵͳ - ���򲼾� [���µ���]
	
	
	/' -------------------------- GUI���ֳ߶ȶ��� -------------------------- '/
	#Define XUI_LAYOUT_RULER_COORD		-1				' ���ֳ߶� - �������� [���Ƹ��ؼ��Ĳ��ַ���]
	#Define XUI_LAYOUT_RULER_PIXEL		0				' ���ֳ߶� - ����
	#Define XUI_LAYOUT_RULER_RATIO		1				' ���ֳ߶� - ʣ��ٷֱ�
	
	
	/' -------------------------- Ԫ�� ClassID ���� -------------------------- '/
	#Define XUI_CLASS_ELEMENT			0				' ����Ԫ��
	#Define XUI_CLASS_BUTTON			1				' ��ť(������ѡ����ѡ��Ԫ��)
	#Define XUI_CLASS_USER				&H10000			' �û��Զ���Ԫ�صĿ�ʼID
	
	
	/' -------------------------- �ļ����ҹ��� -------------------------- '/
	#Define XFILE_RULE_NoAttribEx		0				' ������
	#Define XFILE_RULE_FloderOnly		0				' ֻ����Ŀ¼
	#Define XFILE_RULE_PointFloder		0				' ȥ����Ŀ¼������Ŀ¼
	
	
	
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
	Type XGE_FLOAD_PROC As Function(fd As Any Ptr, Addr As ZString Ptr, iSize As UInteger, param As Any Ptr) As Integer
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
		
		
		/' -------------------------- �ṹ���ڴ������ -------------------------- '/
		Type xBsmm
			' �������ڴ�ָ��
			StructMemory As Any Ptr
			
			' ��Առ���ڴ泤��
			StructLenght As UInteger
			
			' �������д��ڶ��ٳ�Ա
			StructCount As UInteger
			
			' �Ѿ�����Ľṹ����
			AllocCount As UInteger
			
			' Ԥ�����ڴ沽��
			AllocStep As UInteger
			
			' ���캯��
			Declare Constructor()
			Declare Constructor(iItemLenght As UInteger, PreassignStep As UInteger = 32, PreassignLenght As UInteger = 0)
			
			' ��������
			Declare Destructor()
			
			' ��ӳ�Ա
			Declare Function InsertStruct(iPos As UInteger, iCount As UInteger = 1) As UInteger
			Declare Function AppendStruct(iCount As UInteger = 1) As UInteger
			
			' ɾ����Ա
			Declare Function DeleteStruct(iPos As UInteger, iCount As UInteger = 1) As Integer
			
			' �ƶ���Ա
			Declare Function SwapStruct(iPosA As UInteger, iPosB As UInteger) As Integer
			
			' ��ȡ��Աָ��
			Declare Function GetPtrStruct(iPos As UInteger) As Any Ptr
			
			' �����ڴ�
			Declare Function CallocMemory(iCount As UInteger) As Integer
			
			' ���ã��ͷ���Դ��
			Declare Sub ReInitManage()
		End Type
	End Extern
	
	
	
	Extern XGE_EXTERNMODULE
		Namespace xge
		/' -------------------------- ���Ŀ� -------------------------- '/
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
			
			
			/' -------------------------- ������ -------------------------- '/
			Namespace Scene
				Declare Function Start(proc As XGE_SCENE_PROC, lfps As UInteger = 0, sync As Integer = FALSE, param As Integer = 0) As Integer
				Declare Function Cut(proc As XGE_SCENE_PROC, lfps As UInteger = 0, sync As Integer = FALSE, param As Integer = 0) As Integer
				Declare Sub Stop(sc As Integer = 0)
				Declare Sub StopAll(sc As Integer = 0)
				Declare Sub Pause(flag As Integer = XGE_PAUSE_DRAW Or XGE_PAUSE_FRAME)
				Declare Function State() As Integer
				Declare Sub Resume()
				Declare Function FPS() As UInteger
				Declare Function Stack() As xStack Ptr
			End Namespace
			
			
			/' -------------------------- �ҹ��� -------------------------- '/
			Namespace Hook
				Declare Sub SetDelayProc(proc As XGE_DELAY_PROC)
				Declare Sub SetEventProc(proc As XGE_EVENT_PROC)
				Declare Sub SetSceneProc(proc As XGE_SCENE_PROC)
				Declare Sub SetImageLoadProc(proc As XGE_BLOAD_PROC)
				Declare Sub SetFontLoadProc(proc As XGE_FLOAD_PROC)
			End Namespace
			
			
			/' -------------------------- ����� -------------------------- '/
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
		End Namespace
		
		
		/' -------------------------- �ļ������� -------------------------- '/
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
				Declare Sub Draw_Trans(x As Integer, y As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub DrawEx_Trans(x As Integer, y As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, sf As xge.Surface Ptr = NULL)
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
		Namespace xui
			
			' �����ݽṹ
			Type Coord
				x As Integer
				y As Integer
			End Type
			
			' �������ݽṹ
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
			
			
			' �������ݽṹ
			Type Layout
				Ruler As Integer			' ���ֳ߶� [ �ο�����ǰ׺ : XUI_LAYOUT_RULER ]
				RectBox As xui.Rect			' ����С [ ��λ�����أ���������ʱ���������Ч ]
				Rect As xui.Rect			' �������� [ ������ݻ�������ʱ���� ]
				ScreenCoord As xui.Coord	' ����Ļ�ϵ��������� [ ����Ϸ���Ͻ�Ϊ��㣬������ݻ�������ʱ���� ]
				w As Integer				' ���ֿ��
				h As Integer				' ���ָ߶�
			End Type
			
			
			' �����ṹ
			Type BackImage
				Image As xge.Surface Ptr = NULL
				BorderColor As Integer
				FillColor As Integer
				TextColor As Integer
			End Type
			
			
			' Ԫ���¼� [�����¼��������ռ��ʱ�䣬��˽���ע���Żᴦ����Щ�¼�]
			' Ԫ���¼����� -1 �����ж��¼��������������������Ŀؼ����޷����յ��¼�
			Type ElementEvent
				' ����ƶ� [������Ŀؼ��������ȴ�������¼����������������Ļ���������¼�������������Ϣ��]
				OnMouseMove As Function(ele As Any Ptr, x As Integer, y As Integer) As Integer = NULL
				' ��갴��
				OnMouseDown As Function(ele As Any Ptr, x As Integer, y As Integer, btn As Integer) As Integer = NULL
				' ��굯�� [������Ŀؼ��������ȴ�������¼����������������Ļ���������¼�������������Ϣ��]
				OnMouseUp As Function(ele As Any Ptr, x As Integer, y As Integer, btn As Integer) As Integer = NULL
				' ��굥��
				OnMouseClick As Function(ele As Any Ptr, x As Integer, y As Integer, btn As Integer) As Integer = NULL
				' ���˫��
				OnMouseDoubleClick As Function(ele As Any Ptr, x As Integer, y As Integer, btn As Integer) As Integer = NULL
				' ������Ԫ�ط�Χ
				OnMouseEnter As Sub(ele As Any Ptr) = NULL
				' ����뿪Ԫ��
				OnMouseLeave As Sub(ele As Any Ptr) = NULL
				' �����ֲ��� [���ָ������λ������Ԫ���ܹ��յ�����¼��������������Ļ������¼��ᱻת�����������Ԫ��]
				OnMouseWhell As Function(ele As Any Ptr, x As Integer, y As Integer, z As Integer, nz As Integer) As Integer = NULL
				' ���̰������� [ֻ�б������Ԫ�����յ�����¼�]
				OnKeyDown As Function(ele As Any Ptr, k As Integer, c As Integer) As Integer = NULL
				' ���̰������� [ֻ�б������Ԫ�����յ�����¼�]
				OnKeyUp As Function(ele As Any Ptr, k As Integer, c As Integer) As Integer = NULL
				' ���̰������ [ֻ�б������Ԫ�����յ�����¼�]
				OnKeyRepeat As Function(ele As Any Ptr, k As Integer, c As Integer) As Integer = NULL
				' Ԫ�ر�����
				OnGotfocus As Sub(ele As Any Ptr) = NULL
				' Ԫ�ض�ʧ����״̬
				OnLostFocus As Sub(ele As Any Ptr) = NULL
				' �����¼�����Ԫ����Ҫ������ʱ�����
				OnDraw As Sub(ele As Any Ptr) = NULL
				' �Ի��¼����� OnDraw ֮����ã����Խ��в������ [����¼�ϵͳһ�㲻��ռ��]
				OnUserDraw As Sub(ele As Any Ptr) = NULL
			End Type
			
			
			' ��ť���¼��ṹ
			Type ButtonEvent
				OnClick As Sub(ele As Any Ptr, btn As Integer)
				OnCheck As Sub(ele As Any Ptr)
			End Type
			
			
			' ��Ԫ���б���
			Type ElementList Extends xBsmm
				Parent As Any Ptr		' ��Ԫ��ָ�� [�����Ԫ�ص�ʱ����Ҫ]
				Declare Function AddElement(elePtr As Any Ptr) As Integer
				Declare Function InsElement(elePtr As Any Ptr, iPos As Integer) As Integer
				Declare Function GetElement(iPos As Integer) As Any Ptr
				Declare Function DelElement(iPos As Integer) As Integer
				Declare Function Count() As UInteger
			End Type
			
			
			' Ԫ�ػ���
			Type Element
				ClassID As Integer					' ��ʶ���ţ�������ʶ��û���������� 0x10000 ���ڵı��Ϊ����Ԥ�� [0=Element]
				LayoutMode As Integer				' ����ģʽ [ �ο�����ǰ׺ : XUI_LAYOUT ]
				Layout As xui.Layout				' ��������
				ClassEvent As ElementEvent			' �¼�
				Childs As ElementList				' ��Ԫ������
				Parent As Element Ptr = NULL		' ��Ԫ��ָ��
				Visible As Integer = -1				' �Ƿ���ʾ [���벼�ֺͻ��ƵĿ���] [ʹ�ò��ֵĻ��޸ĺ��������Ӧ�ò���]
				Image As xge.Surface Ptr			' Ԫ�ػ���
				NeedRedraw As Integer = -1			' ��Ҫ�ػ���
				Identifier As ZString * 32			' Ԫ��ID [�൱�����渽�����ݣ��û����Խ�IDӳ�䵽�ű������д����¼�]
				DrawRange As Integer = 0			' ����Ԫ�ط�Χ
				Tag As Any Ptr						' ��������
				
				' ���캯��
				Declare Constructor()
				Declare Constructor(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sIdentifier As ZString Ptr = NULL)
				
				' ��������
				Declare Destructor()
				
				Declare Sub LayoutApply()
				Declare Sub Draw(sf As xge.Surface Ptr, px As Integer = 0, py As Integer = 0)
				Declare Function EventLink(msg As Integer,param As Integer,eve As xge_event Ptr) As Integer
				
				' ���ο���
				Declare Sub DrawDebug()
			End Type
			
			
			' ��ť��
			Type Button Extends Element
				Caption As ZString Ptr							' ��ť�ı���
				CaptionOffset As xui.Coord						' ��ť��������ƫ��
				CaptionFont As UInteger							' ��ť���������
				
				Mode As Integer									' ����ģʽ [1=��ѡ��2=��ѡ������=��״̬��ť]
				Checked As Integer								' ��ť�Ƿ�ѡ��
				
				' ����ͼ
				NormalBack As BackImage							' ����״̬�ı���
				HotBack As BackImage							' ��ť������ (������)
				PressBack As BackImage							' ��ť������
				CheckBack As BackImage							' ѡ��ʱ�ı���
				
				' ����
				EnterSound As xge.Sound Ptr						' �����������
				LeaveSound As xge.Sound Ptr						' ����뿪������
				DownSound As xge.Sound Ptr						' ��갴�µ�����
				ClickSound As xge.Sound Ptr						' ��ť����������� [��갴�²��ɿ�ʱ����]
				
				'Declare Sub ApplyStyle(StyleID As Integer = 0)	' Ӧ����ʽ
				
				Event As ButtonEvent							' ��ť���¼�
				
				' ������������ [����û��������Щϸ�ڣ���������ο���]
				private_Status As Integer						' ��ť��״̬ [0=���桢1=�ȵ㡢2=����]
				private_AllowClick As Integer					' ����������¼� [��������ڰ�ť�ϰ��µ�ʱ������ΪTRUE]
			End Type
			
			
			' ��ȡ��Ԫ�� (DesktopԪ��)
			Declare Function GetRootElement() As xui.Element Ptr
			
			' ��ȡ�������Ԫ��
			Declare Function GetActiveElement() As xui.Element Ptr
			
			' ����Ԫ�� [����NULL��ȡ����ǰ�����Ԫ��]
			Declare Sub ActiveElement(ele As xui.Element Ptr)
			
			' ��ȡ���ָ���µ��ȵ�Ԫ��
			Declare Function GetHotElement() As xui.Element Ptr
			
			' Ӧ�ò���
			Declare Sub LayoutApply()
			
			' ����һ���հ׵�Ԫ��
			Declare Function CreateElement(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sIdentifier As ZString Ptr = NULL) As xui.Element Ptr
			
			' ������ť
			Declare Function CreateButton(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr
			
			' ����ѡ��ť
			Declare Function CreateCheckButton(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr
			Declare Function CreateRadioButton(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr
			
			' ������ѡ��
			Declare Function CreateCheckBox(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr
			
			' ������ѡ��
			Declare Function CreateRadioBox(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr
			
			' ����������
			Declare Function CreateHyperLink(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.Button Ptr
			
		End Namespace
		
		
		
		/' -------------------------- ����� -------------------------- '/
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
				
				' �¼�
				Event As ServerEvent
				
				' ����
				Declare Destructor()
				
				' ����
				Declare Function Create(ip As ZString Ptr, port As UShort, max As UInteger = 1000, ThreadCountt As UInteger = 1) As Integer
				
				' ����
				Declare Sub Destroy()
				
				' ״̬
				Declare Function Status() As Integer
				
				' ����
				Declare Function Send(Client As HANDLE, pack As Any Ptr, size As UInteger, sync As Integer = TRUE) As Integer
				
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
				
				' �¼�
				Event As ClientEvent
				
				' ����
				Declare Destructor()
				
				' ����
				Declare Function Connect(ip As ZString Ptr, port As UShort) As Integer
				
				' �Ͽ�
				Declare Sub Close()
				
				' ״̬
				Declare Function Status() As Integer
				
				' ����
				Declare Function Send(pack As Any Ptr, size As UInteger, sync As Integer = TRUE) As Integer
				
				Private:
					h_Client As HANDLE
			End Type
			
			Type xUDP
				' �¼�����
				RecvEvent As Sub(pack As Any Ptr, size As UInteger, ip As ZString Ptr, port As Integer)
				SendEvent As Sub(code As Integer)
				
				' ����
				Declare Destructor()
				
				' ����
				Declare Function Create(ip As ZString Ptr, port As UShort, ThreadCountt As UInteger = 1) As Integer
				
				' ����
				Declare Sub Destroy()
				
				' ״̬ [�Ѵ���=TRUE]
				Declare Function Status() As Integer
				
				' ����
				Declare Function Send(pack As Any Ptr, size As UInteger, ip As ZString Ptr, port As UShort, sync As Integer = TRUE) As Integer
				
				Private:
					h_Socket As HANDLE
			End Type
			
		End Namespace
		
	End Extern
	
	
	
	Namespace xge
		
		Namespace Text
			
			/' -------------------------- ���������ṹ�� -------------------------- '/
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
				
				' ��Ҫ�Ľӿ�
				DrawWord As Sub(fd As FontDriver Ptr, sf As xge.Surface Ptr, px As Integer, py As Integer, w As Integer, h As Integer, iCode As UInteger, iColor As Integer, Style As Integer)
				DrawWordA As Sub(fd As FontDriver Ptr, sf As xge.Surface Ptr, px As Integer, py As Integer, w As Integer, h As Integer, iCode As UInteger, iColor As Integer, Style As Integer)
				WordInfo As Sub(fd As FontDriver Ptr, iCode As Integer, Style As Integer, w As Integer Ptr, h As Integer Ptr)
				WordInfoA As Sub(fd As FontDriver Ptr, iCode As Integer, Style As Integer, w As Integer Ptr, h As Integer Ptr)
				
				' �����ֿ�(ɾ���ֿ��ʱ���ã������ͷ��ڴ�֮���)
				FreeFont As Sub(fd As FontDriver Ptr)
				
				' ���һ������
				DrawLine_Fast As Sub(fd As FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, txt As WString Ptr, iColor As Integer, Style As Integer, wd As Integer)
				DrawLineA_Fast As Sub(fd As FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, txt As ZString Ptr, iColor As Integer, Style As Integer, wd As Integer)
				
				' ���һЩ���ֵ�һ�����η�Χ�� [ align:���䷽ʽ��wd:�ּ�ࡢld:�м�� ] [��δʵ���Զ����й���]
				DrawRect_Fast As Sub(fd As FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, w As Integer, h As Integer, txt As WString Ptr, iColor As Integer, Style As Integer, align As Integer, wd As Integer, ld As Integer)
				DrawRectA_Fast As Sub(fd As FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, w As Integer, h As Integer, txt As ZString Ptr, iColor As Integer, Style As Integer, align As Integer, wd As Integer, ld As Integer)
				
			End Type
			
		End Namespace
		
	End Namespace
	
	
	
	Extern XGE_EXTERNMODULE
		
		Namespace xge
			
			/' -------------------------- ������Ⱦ�� -------------------------- '/
			Namespace Text
				
				' �������� [ Ŀǰ֧�� xrf���� �� truetype���� ] [ ttc���������ʱͨ��param����ָ�����ص�����ID ]
				Declare Function LoadFont(Addr As ZString Ptr, iSize As UInteger, param As Any Ptr = NULL) As UInteger
				
				' �Ƴ����� [�Ƴ�����������Ż�䶯������]
				Declare Function RemoveFont(idx As UInteger) As Integer
				
				' ȡ���Ѽ��ص���������
				Declare Function FontCount() As Integer
				
				' ���������С [���ttf����]
				Declare Sub SetFontSize(idx As UInteger, size As UInteger)
				
				' д��
				Declare Sub Draw(sf As xge.Surface Ptr, px As Integer, py As Integer, txt As WString Ptr, iColor As UInteger, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0)
				Declare Sub DrawA(sf As xge.Surface Ptr, px As Integer, py As Integer, txt As ZString Ptr, iColor As UInteger, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0)
				
				' ���θ�ʽ��д�� [ align:���䷽ʽ��wd:�ּ�ࡢld:�м�� ]
				Declare Sub DrawRect(sf As xge.Surface Ptr, px As Integer, py As Integer, pw As Integer, ph As Integer, txt As WString Ptr, iColor As UInteger, fontid As Integer = 1, Style As Integer = 0, align As Integer = XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, wd As Integer = 0, ld As Integer = 0)
				Declare Sub DrawRectA(sf As xge.Surface Ptr, px As Integer, py As Integer, pw As Integer, ph As Integer, txt As ZString Ptr, iColor As UInteger, fontid As Integer = 1, Style As Integer = 0, align As Integer = XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, wd As Integer = 0, ld As Integer = 0)
				
			End Namespace
			
			
			/' -------------------------- ������ -------------------------- '/
			Namespace Aux
				Declare Function ScreenShot() As xge.Surface Ptr
				Declare Function GetPixel(x As Integer, y As Integer, sf As xge.Surface Ptr = NULL) As UInteger
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
			
			
			/' -------------------------- ͼ�ο� -------------------------- '/
			Namespace Shape
				Declare Sub Pixel(x As Integer, y As Integer, c As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub Lines(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub LinesEx(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, s As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub Rect(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub RectEx(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, s As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub RectFull(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub Circ(x As Integer, y As Integer, r As Integer, c As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub CircFull(x As Integer, y As Integer, r As Integer, c As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub CircEx(x As Integer, y As Integer, r As Integer, c As Integer, a As Single, sf As xge.Surface Ptr = NULL)
				Declare Sub CircFullEx(x As Integer, y As Integer, r As Integer, c As Integer, a As Single, sf As xge.Surface Ptr = NULL)
				Declare Sub CircArc(x As Integer, y As Integer, r As Integer, c As Integer, s As Integer, e As Integer, a As Single, sf As xge.Surface Ptr = NULL)
				Declare Sub Full(x As Integer, y As Integer, c As Integer, f As Integer, sf As xge.Surface Ptr = NULL)
				Declare Sub FullEx(x As Integer, y As Integer, p As ZString Ptr, f As Integer, sf As xge.Surface Ptr = NULL)
			End Namespace
			
			
		End Namespace
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
		
		
		/' -------------------------- ���������Ժ����� -------------------------- '/
		Declare Function Split(sText As ZString Ptr, sSep As ZString Ptr) As ZString Ptr Ptr
	End Extern
	
	
	
#EndIf


