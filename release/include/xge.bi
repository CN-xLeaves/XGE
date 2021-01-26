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
	
	#Define XGE_EXTERNCLASS "Windows"				' Class ������ʽ
	#Define XGE_EXTERNMODULE "Windows"				' NameSpace ������ʽ
	#Define XGE_EXTERNSTDEXT "Windows"				' ��ͨ����������ʽ
	
	/' -------------------------- XUIԪ��ID����ַ��� -------------------------- '/
	#Define XGE_XUI_IDSIZE		32
	
	
	
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
	#Define COLOR_MASK_24				&HFF00FF
	#Define COLOR_MASK_32				&HFFFF00FF
	#Define COLOR_A						&HFF000000
	#Define COLOR_R						&H00FF0000
	#Define COLOR_G						&H0000FF00
	#Define COLOR_B						&H000000FF
	#Define COLOR_32					&HFFFFFFFF
	
	
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
	#Define XUI_CLASS_STATIC			2				' ��̬Ԫ��(������ǩ��ͼƬ��)
	#Define XUI_CLASS_SCROLLBAR			3				' ������(�������������)
	#Define XUI_CLASS_SCROLLVIEW		4				' ������ͼ
	#Define XUI_CLASS_LISTBOX			5				' �б��
	#Define XUI_CLASS_COMBOBOX			6				' ��Ͽ�
	#Define XUI_CLASS_PROGRESSBAR		7				' ������
	#Define XUI_CLASS_SLIDER			8				' ����
	#Define XUI_CLASS_ANIMATBOX			9				' ����
	#Define XUI_CLASS_LINEEDIT			10				' �б༭��
	#Define XUI_CLASS_TEXTBOX			11				' ȫ�����ı��༭��
	#Define XUI_CLASS_WINDOW			12				' ����
	#Define XUI_CLASS_USER				&H10000			' �û��Զ���Ԫ�صĿ�ʼID
	
	
	/' -------------------------- Ԫ�ع�������ʾ״̬���� -------------------------- '/
	#Define XUI_SCROLL_V				1				' ��ʾ���������
	#Define XUI_SCROLL_H				2				' ��ʾ���������
	#Define XUI_SCROLL_VH				3				' ������������������ʾ
	#Define XUI_SCROLL_HV				3				' ������������������ʾ
	
	
	/' -------------------------- Ԫ�ؽ�������ʾ״̬���� -------------------------- '/
	#Define XUI_PROGRESSBAR_HIDE		0				' ����ʾ
	#Define XUI_PROGRESSBAR_PERCENT		1				' ��ʾ�ٷֱ�
	#Define XUI_PROGRESSBAR_VALUE		2				' ��ʾ��ֵ
	
	
	/' -------------------------- XUI IME ����¼�ID���� -------------------------- '/
	#Define XUI_IME_INPUT				0				' IME������������
	#Define XUI_IME_STARTCOMPOSITION	1				' IME��ʼ����
	#Define XUI_IME_COMPTEXT			2				' IME����䶯
	#Define XUI_IME_ENDCOMPOSITION		3				' IME�������
	#Define XUI_IME_CHAR				4				' WM_CHAR
	
	
	/' -------------------------- �ļ����ҹ��� -------------------------- '/
	#Define XFILE_RULE_NoAttribEx		0				' ������
	#Define XFILE_RULE_FloderOnly		1				' ֻ����Ŀ¼
	#Define XFILE_RULE_PointFloder		2				' ȥ����Ŀ¼������Ŀ¼
	
	
	
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
	Type FBGFX_IMAGE
		tpe as UInteger
		bpp As Integer
		Width As UInteger
		Height As UInteger
		Pitch As UInteger
		reserved(1 To 12) As UByte
	End Type
	
	
	
	/' -------------------------- �����ݽṹ -------------------------- '/
	Type xge_Coord
		x As Integer
		y As Integer
	End Type
	
	
	
	/' -------------------------- �������ݽṹ -------------------------- '/
	Type xge_Rect
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
	
	
	
	/' -------------------------- �������Ͷ��� -------------------------- '/
	Type XGE_SCENE_PROC As Function(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Type XGE_EVENT_PROC As Sub(eve As XGE_EVENT Ptr)
	Type XGE_DELAY_PROC As Sub(ms As Integer)
	Type XGE_BLOAD_PROC As Function(img As Any Ptr, addr As WString Ptr, size As UInteger) As Integer
	Type XGE_FLOAD_PROC As Function(fd As Any Ptr, Addr As WString Ptr, iSize As UInteger, param As Any Ptr) As Integer
	Type XGE_DRAW_BLEND As Sub(SrcAddr As Any Ptr, SrcPitch As Integer, SrcLineS As Integer, DstAddr As Any Ptr, DstPitch As Integer, DstLineS As Integer, w As Integer, h As Integer, param As Integer)
	Type XGE_DRAW_CUSTOM As Function(src As UInteger, dst As UInteger, param As Any Ptr) As UInteger
	
	
	
	
	
	Extern XGE_EXTERNMODULE
		
		
		
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
				Dim pStackMem As Any Ptr
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
		
		
		
		/' -------------------------- �ַ��������������� [UCS2] -------------------------- '/
		Type xStringBuffer
			
			' �ڴ�ָ��
			BufferMemory As WString Ptr
			
			' ���ݳ���
			BufferLenght As UInteger
			
			' �Ѿ�������ڴ泤��
			AllocLenght As UInteger
			
			' Ԥ�����ڴ沽��
			AllocStep As UInteger
			
			' ��������
			Tag As Integer
			
			' ���캯��
			Declare Constructor()
			
			' ��������
			Declare Destructor()
			
			' ��������
			Declare Function SetText(sText As WString Ptr, iTextSize As UInteger = 0) As Integer
			
			' ׷��д����
			Declare Function AppendText(sText As WString Ptr, iTextSize As UInteger = 0) As Integer
			
			' ����д����
			Declare Function InsertText(iPos As UInteger, iSize As UInteger, sText As WString Ptr, iTextSize As UInteger = 0) As Integer
			
			' ɾ������
			Declare Function DeleteText(iPos As UInteger, iSize As UInteger) As Integer
			
			' �����ڴ�
			Declare Function MallocMemory(iLenght As UInteger) As Integer
			
			' �ͷ��ڴ�
			Declare Sub FreeMemory()
			
		End Type
		
		
		
		Namespace xge
			
			
			
			/' -------------------------- ���Ŀ� -------------------------- '/
			Declare Function InitA(w As UInteger, h As UInteger, init_gfx As Integer = XGE_INIT_WINDOW, title As ZString Ptr = NULL) As Integer
			Declare Function InitW(w As UInteger, h As UInteger, init_gfx As Integer = XGE_INIT_WINDOW, title As WString Ptr = NULL) As Integer
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
			Declare Sub SetSoundVol(tpe As Integer, vol As Integer)
			Declare Function GetSoundVol(tpe As Integer) As Integer
			
			
			
			/' -------------------------- ͼ���� -------------------------- '/
			Type Surface
				img As FBGFX_IMAGE Ptr
				
				' ���� [��]
				Declare Constructor()
				
				' ���� [����]
				Declare Constructor(w As UInteger, h As UInteger)
				
				' ���� [����]
				Declare Constructor(addr As ZString Ptr, size As UInteger = 0)
				Declare Constructor(addr As WString Ptr, size As UInteger = 0)
				
				' ����
				Declare Destructor()
				
				' ����ͼ��
				Declare Function Create(w As UInteger, h As UInteger) As Integer
				
				' ����ͼ��
				Declare Function Load(addr As ZString Ptr, size As UInteger = 0) As Integer
				Declare Function Load(addr As WString Ptr, size As UInteger = 0) As Integer
				
				' ����ͼ��
				Declare Function Save(addr As ZString Ptr, tpe As UInteger = 0, flag As Integer = 0) As Integer
				Declare Function Save(addr As WString Ptr, tpe As UInteger = 0, flag As Integer = 0) As Integer
				
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
				Declare Constructor(addr As WString Ptr, size As UInteger = 0)
				
				' ����
				Declare Destructor()
				
				' ����ͼ��
				Declare Function Create(w As UInteger, h As UInteger) As Integer
				
				' ����ͼ��
				Declare Function Load(addr As ZString Ptr, size As UInteger = 0) As Integer
				Declare Function Load(addr As WString Ptr, size As UInteger = 0) As Integer
				
				' �ͷ�ͼ��
				Declare Sub Free()
				
				' GDI ��ͼ
				Declare Sub PrintLine(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As UInteger)
				Declare Sub PrintRect(x As Integer, y As Integer, w As Integer, h As Integer, c As UInteger)
				Declare Sub PrintRectFull(x As Integer, y As Integer, w As Integer, h As Integer, c As UInteger)
				Declare Sub PrintCirc(x As Integer, y As Integer, w As Integer, h As Integer, c As UInteger)
				Declare Sub PrintCircFull(x As Integer, y As Integer, w As Integer, h As Integer, c As UInteger)
				Declare Sub PrintText(x As Integer, y As Integer, w As Integer, h As Integer, f As WString Ptr, px As Integer, flag As Integer, c As UInteger, txt As WString Ptr)
				Declare Sub PrintText(x As Integer, y As Integer, w As Integer, h As Integer, f As WString Ptr, px As Integer, flag As Integer, c As UInteger, weight As Integer, txt As WString Ptr)
				Declare Sub PrintText(x As Integer, y As Integer, w As Integer, h As Integer, f As WString Ptr, px As Integer, flag As Integer, c1 As UInteger, c2 As UInteger, weight As Integer, txt As WString Ptr)
				Declare Sub PrintText(x As Integer, y As Integer, w As Integer, h As Integer, f As WString Ptr, px As Integer, flag As Integer, addr As WString Ptr, size As Integer, txt As WString Ptr)
				Declare Sub PrintImage(x As Integer, y As Integer, addr As WString Ptr, size As Integer = 0)
				Declare Sub PrintImageDpi(x As Integer, y As Integer, addr As WString Ptr, size As Integer = 0)
				Declare Sub PrintImageZoom(x As Integer, y As Integer, w As Integer, h As Integer, addr As WString Ptr, size As Integer = 0)
				Declare Sub PrintImageEx(x As Integer, y As Integer, w As Integer, h As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer, addr As WString Ptr, size As Integer = 0)
				Declare Sub PrintImageFull(x As Integer, y As Integer, w As Integer, h As Integer, addr As WString Ptr, size As Integer = 0)
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
				Declare Constructor(tpe As Integer, flag As Integer, addr As WString Ptr, size As UInteger = 0, max As Integer = 65535)
				
				' ����
				Declare Destructor()
				
				' ��������
				Declare Function Load(tpe As Integer, flag As Integer, addr As ZString Ptr, size As UInteger = 0, max As Integer = 65535) As Integer
				Declare Function Load(tpe As Integer, flag As Integer, addr As WString Ptr, size As UInteger = 0, max As Integer = 65535) As Integer
				
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
				TagPtr As Any Ptr
				
				' ��Ҫ�Ľӿ�
				DrawWordW As Sub(fd As FontDriver Ptr, sf As xge.Surface Ptr, px As Integer, py As Integer, w As Integer, h As Integer, iCode As UInteger, iColor As Integer, Style As Integer)
				DrawWordA As Sub(fd As FontDriver Ptr, sf As xge.Surface Ptr, px As Integer, py As Integer, w As Integer, h As Integer, iCode As UInteger, iColor As Integer, Style As Integer)
				WordInfoW As Sub(fd As FontDriver Ptr, iCode As Integer, Style As Integer, w As Integer Ptr, h As Integer Ptr)
				WordInfoA As Sub(fd As FontDriver Ptr, iCode As Integer, Style As Integer, w As Integer Ptr, h As Integer Ptr)
				
				' �����ֿ�(ɾ���ֿ��ʱ���ã������ͷ��ڴ�֮���)
				FreeFont As Sub(fd As FontDriver Ptr)
				
				' ���������С
				SetFontSize As Sub(fd As FontDriver Ptr, size As UInteger)
				
				' �������ֵĿ�Ⱥ͸߶�
				GetTextWidthW_Fast As Function(fd As FontDriver Ptr, txt As WString Ptr, txtLen As UInteger, Style As Integer, wd As Integer) As Integer
				GetTextWidthA_Fast As Function(fd As FontDriver Ptr, txt As ZString Ptr, txtLen As UInteger, Style As Integer, wd As Integer) As Integer
				GetTextRectW_Fast As Function(fd As FontDriver Ptr, txt As WString Ptr, txtLen As UInteger, Style As Integer, align As Integer, wd As Integer, ld As Integer) As xge_Rect
				GetTextRectA_Fast As Function(fd As FontDriver Ptr, txt As ZString Ptr, txtLen As UInteger, Style As Integer, align As Integer, wd As Integer, ld As Integer) As xge_Rect
				
				' ����������ȷ������ֵ�λ��
				WidthToPosW_Fast As Function(fd As FontDriver Ptr, cw As Integer, txt As WString Ptr, txtLen As UInteger, Style As Integer, wd As Integer) As UInteger
				WidthToPosA_Fast As Function(fd As FontDriver Ptr, cw As Integer, txt As ZString Ptr, txtLen As UInteger, Style As Integer, wd As Integer) As UInteger
				
				' ���һ������
				DrawLineW_Fast As Function(fd As FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, txt As WString Ptr, txtLen As UInteger, iColor As Integer, Style As Integer, wd As Integer) As xge_Rect
				DrawLineA_Fast As Function(fd As FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, txt As ZString Ptr, txtLen As UInteger, iColor As Integer, Style As Integer, wd As Integer) As xge_Rect
				
				' ���һЩ���ֵ�һ�����η�Χ�� [ align:���䷽ʽ��wd:�ּ�ࡢld:�м�� ] [��δʵ���Զ����й���]
				DrawRectW_Fast As Function(fd As FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, w As Integer, h As Integer, txt As WString Ptr, txtLen As UInteger, iColor As Integer, Style As Integer, align As Integer, wd As Integer, ld As Integer) As xge_Rect
				DrawRectA_Fast As Function(fd As FontDriver Ptr, sf As xge.Surface Ptr, x As Integer, y As Integer, w As Integer, h As Integer, txt As ZString Ptr, txtLen As UInteger, iColor As Integer, Style As Integer, align As Integer, wd As Integer, ld As Integer) As xge_Rect
				
			End Type
			
			
			/' -------------------------- ������Ⱦ�� -------------------------- '/
			Namespace Text
				
				' �������� [ Ŀǰ֧�� xrf���� �� truetype���� ] [ ttc���������ʱͨ��param����ָ�����ص�����ID ]
				Declare Function LoadFontA(Addr As ZString Ptr, iSize As UInteger, param As Any Ptr = NULL) As UInteger
				Declare Function LoadFontW(Addr As WString Ptr, iSize As UInteger, param As Any Ptr = NULL) As UInteger
				
				' �Ƴ����� [�Ƴ�����������Ż�䶯������]
				Declare Function RemoveFont(idx As UInteger) As Integer
				
				' ȡ���Ѽ��ص���������
				Declare Function FontCount() As Integer
				
				' ���������С
				Declare Sub SetFontSize(idx As UInteger, size As UInteger)
				
				' ��ȡ�����С [����߶�����]
				Declare Function GetFontSize(idx As UInteger) As Integer
				
				' �������ֵĿ�Ⱥ͸߶�
				Declare Function GetTextWidthW(txt As WString Ptr, txtLen As UInteger = 0, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0) As Integer
				Declare Function GetTextWidthA(txt As ZString Ptr, txtLen As UInteger = 0, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0) As Integer
				Declare Function GetTextRectW(txt As WString Ptr, txtLen As UInteger = 0, fontid As Integer = 1, Style As Integer = 0, align As Integer = XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, wd As Integer = 0, ld As Integer = 0) As xge_Rect
				Declare Function GetTextRectA(txt As ZString Ptr, txtLen As UInteger = 0, fontid As Integer = 1, Style As Integer = 0, align As Integer = XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, wd As Integer = 0, ld As Integer = 0) As xge_Rect
				
				' ����������ȷ������ֵ�λ��
				Declare Function WidthToPosW(cw As Integer, txt As WString Ptr, txtLen As UInteger = 0, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0) As UInteger
				Declare Function WidthToPosA(cw As Integer, txt As ZString Ptr, txtLen As UInteger = 0, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0) As UInteger
				
				' д��
				Declare Function DrawW(sf As xge.Surface Ptr, px As Integer, py As Integer, txt As WString Ptr, txtLen As UInteger = 0, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0) As xge_Rect
				Declare Function DrawA(sf As xge.Surface Ptr, px As Integer, py As Integer, txt As ZString Ptr, txtLen As UInteger = 0, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, wd As Integer = 0) As xge_Rect
				
				' ���θ�ʽ��д�� [ align:���䷽ʽ��wd:�ּ�ࡢld:�м�� ]
				Declare Function DrawRectW(sf As xge.Surface Ptr, px As Integer, py As Integer, pw As Integer, ph As Integer, txt As WString Ptr, txtLen As UInteger = 0, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, align As Integer = XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, wd As Integer = 0, ld As Integer = 0) As xge_Rect
				Declare Function DrawRectA(sf As xge.Surface Ptr, px As Integer, py As Integer, pw As Integer, ph As Integer, txt As ZString Ptr, txtLen As UInteger = 0, iColor As UInteger = &HFFFFFFFF, fontid As Integer = 1, Style As Integer = 0, align As Integer = XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, wd As Integer = 0, ld As Integer = 0) As xge_Rect
				
			End Namespace
			
			
			
			/' -------------------------- ������ -------------------------- '/
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
			
			
			
			/' -------------------------- �ҹ��� -------------------------- '/
			Namespace Hook
				Declare Sub SetDelayProc(proc As XGE_DELAY_PROC)
				Declare Sub SetEventProc(proc As XGE_EVENT_PROC)
				Declare Sub SetSceneProc(proc As XGE_SCENE_PROC)
				Declare Sub SetImageLoadProc(proc As XGE_BLOAD_PROC)
				Declare Sub SetFontLoadProc(proc As XGE_FLOAD_PROC)
			End Namespace
			
			
			
			/' -------------------------- ������ -------------------------- '/
			Namespace Aux
				Declare Function ScreenShot() As xge.Surface Ptr
				Declare Function GetPixel(sf As xge.Surface Ptr, x As Integer, y As Integer) As UInteger
				Declare Function RGB2BGR(c As UInteger) As UInteger
				Declare Sub SetTitleA(title As ZString Ptr)
				Declare Sub SetTitleW(title As WString Ptr)
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
				Declare Sub FullEx(sf As xge.Surface Ptr, x As Integer, y As Integer, p As Any Ptr, f As Integer)
			End Namespace
			
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
		
		
		
		/' -------------------------- ����� -------------------------- '/
		Namespace xui
			
			
			' �������ݽṹ
			Type Layout
				Ruler As Integer			' ���ֳ߶� [ �ο�����ǰ׺ : XUI_LAYOUT_RULER ]
				RectBox As xge_Rect			' ����С [ ��λ�����أ���������ʱ���������Ч ]
				Rect As xge_Rect			' �������� [ ������ݻ�������ʱ���� ]
				ScreenCoord As xge_Coord	' ����Ļ�ϵ��������� [ ����Ϸ���Ͻ�Ϊ��㣬������ݻ�������ʱ���� ]
				w As Integer				' ���ֿ��
				h As Integer				' ���ָ߶�
			End Type
			
			
			' �����ṹ
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
				' ��С�ı��¼�
				OnSize As Sub(ele As Any Ptr) = NULL
			End Type
			
			
			' �б���ṹ��
			Type List_Item_BasicStruct							' �б���ṹ�� [�����ṹ]
				Checked As Integer								' ѡ��״̬
				Tag As Integer									' ��������
				Text As WString Ptr								' ��ʾ�ı�
				TextColor As UInteger							' �ı���ɫ
				UserData As Any Ptr								' �û��Զ������ݿ�ʼ��λ�� [��������ǲ����ڵģ�������ȡָ��]
			End Type
			
			' �б���Ϲ�����
			Type List_ItemSet Extends xBsmm						' �б���Ϲ�����
				Parent As Any Ptr								' ��Ԫ��ָ��
				
				' ���캯��
				Declare Constructor()
				
				' �б�������
				Declare Function Count() As UInteger
				
				' ����б���
				Declare Function Append(sVal As WString Ptr, Tag As Integer = 0) As UInteger
				Declare Function Insert(iPos As UInteger, sVal As WString Ptr, Tag As Integer = 0) As UInteger
				
				' ɾ���б���
				Declare Function Remove(iPos As UInteger) As Integer
				Declare Sub Clear()
				
				' ��ȡ/���� �б���ı���
				Declare Property Text(iPos As UInteger) As WString Ptr
				Declare Property Text(iPos As UInteger, sVal As WString Ptr)
				
				' ��ȡ/���� �б���ĸ�������
				Declare Property Tag(iPos As UInteger) As Integer
				Declare Property Tag(iPos As UInteger, iVal As Integer)
				
				' ѡ���б���
				Declare Property Selected(iPos As UInteger) As Integer
				Declare Property Selected(iPos As UInteger, iStk As Integer)
				
				' ͳ��ѡ���б��������
				Declare Function SelectCount() As UInteger
				
				' ѡ�������б���
				Declare Sub SelectAll()
				
				' ȡ������ѡ�е��б���
				Declare Sub SelectClear()
				
				' ��ѡ�����б���
				Declare Sub SelectInverse()
				
				' �����û��Զ������ݽṹ��С [Ĭ��Ϊ0��ֻ���ڻ�û���б���ʱ����]
				Declare Sub SetUserDataSize(bc As UInteger)
				
				' ��ȡ�û��Զ�������ָ��
				Declare Function UserData(iPos As UInteger) As Any Ptr
			End Type
			
			
			' ��ť���¼��ṹ
			Type ButtonEvent
				OnClick As Sub(ele As Any Ptr, btn As Integer)
				OnCheck As Sub(ele As Any Ptr)
			End Type
			
			
			' ���������¼��ṹ
			Type ScrollBarEvent
				OnScroll As Sub(ele As Any Ptr)
			End Type
			
			
			' ������ͼ�¼��ṹ
			Type ScrollViewEvent
				OnDrawView As Sub(ele As Any Ptr, px As Integer, py As Integer, x As Integer, y As Integer, w As Integer, h As Integer)
			End Type
			
			
			' �б���¼��ṹ
			Type ListBoxEvent
				OnDrawItem As Sub(ele As Any Ptr, iPos As UInteger, Item As List_Item_BasicStruct Ptr, stk As Integer, x As Integer, y As Integer, w As Integer, h As Integer)
				OnClickItem As Sub(ele As Any Ptr, iPos As UInteger, btn As Integer)
				OnDoubleClickItem As Sub(ele As Any Ptr, iPos As UInteger, btn As Integer)
				OnSelectChange As Sub(ele As Any Ptr, iOld As UInteger)
			End Type
			
			
			' ������¼��ṹ
			Type LineEditEvent
				OnChange As Sub(ele As Any Ptr)
				OnGotfocus As Sub(ele As Any Ptr)
				OnLostFocus As Sub(ele As Any Ptr)
				OnSubmit As Sub(ele As Any Ptr)
				OnTab As Sub(ele As Any Ptr)
			End Type
			
			
			' �����¼��ṹ
			Type WindowEvent
				OnGotfocus As Sub(ele As Any Ptr)
				OnLostFocus As Sub(ele As Any Ptr)
				OnMove As Sub(ele As Any Ptr)
				OnSize As Sub(ele As Any Ptr)		' ��δʵ��
			End Type
			
			
			' ��Ԫ���б���
			Type ElementList Extends xBsmm
				Parent As Any Ptr		' ��Ԫ��ָ�� [�����Ԫ�ص�ʱ����Ҫ]
				Declare Function AddElement(elePtr As Any Ptr) As Integer
				Declare Function InsElement(elePtr As Any Ptr, iPos As Integer) As Integer
				Declare Function GetElement(iPos As Integer) As Any Ptr
				Declare Function DelElement(iPos As Integer) As Integer
				Declare Sub Clear()
				Declare Function Count() As UInteger
			End Type
			
			
			' Ԫ�ػ���
			Type Element
				ClassID As Integer						' ��ʶ���ţ�������ʶ��û���������� 0x10000 ���ڵı��Ϊ����Ԥ�� [0=Element]
				LayoutMode As Integer					' ����ģʽ [ �ο�����ǰ׺ : XUI_LAYOUT ]
				Layout As xui.Layout					' ��������
				ClassEvent As ElementEvent				' �¼�
				Childs As ElementList					' ��Ԫ������
				Parent As Element Ptr = NULL			' ��Ԫ��ָ��
				Visible As Integer = -1					' �Ƿ���ʾ [���벼�ֺͻ��ƵĿ���] [ʹ�ò��ֵĻ��޸ĺ��������Ӧ�ò���]
				DrawBuffer As xge.Surface Ptr			' ���ƻ�����
				NeedRedraw As Integer = -1				' ��Ҫ�ػ���
				Identifier As WString * XGE_XUI_IDSIZE	' Ԫ��ID [�൱�����渽�����ݣ��û����Խ�IDӳ�䵽�ű������д����¼�]
				DrawRange As Integer = 0				' ����Ԫ�ط�Χ
				TagInt As Integer						' ��������
				TagPtr As Any Ptr						' ��������
				
				' ���캯��
				Declare Constructor()
				Declare Constructor(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sIdentifier As WString Ptr = NULL)
				
				' ��������
				Declare Destructor()
				
				' ��д��������
				Declare Sub InitElement(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sIdentifier As WString Ptr = NULL)
				
				' Ӧ�ò���
				Declare Sub LayoutApply()
				
				' ����
				Declare Sub Draw(sf As xge.Surface Ptr = NULL, px As Integer = 0, py As Integer = 0)
				
				' �¼���
				Declare Function EventLink(msg As Integer,param As Integer,eve As xge_event Ptr) As Integer
				
				' ���ο���
				Declare Sub DrawDebug()
			End Type
			
			
			' ��ť��
			Type Button Extends xui.Element
				Text As WString Ptr								' ��ť�ı���
				TextOffset As xge_Coord							' ��ť��������ƫ��
				TextFont As UInteger							' ��ť���������
				
				Mode As Integer									' ����ģʽ [1=��ѡ��2=��ѡ������=��״̬��ť]
				Checked As Integer								' ��ť�Ƿ�ѡ��
				
				' ������ʽ
				NormalStyle As BackStyle_Text_Struct			' ����״̬����ʽ
				HotStyle As BackStyle_Text_Struct				' ��ť���������ʽ (������)
				PressStyle As BackStyle_Text_Struct				' ��ť�����µ���ʽ
				CheckStyle As BackStyle_Text_Struct				' ѡ��ʱ����ʽ
				
				' ����
				EnterSound As xge.Sound Ptr						' �����������
				LeaveSound As xge.Sound Ptr						' ����뿪������
				DownSound As xge.Sound Ptr						' ��갴�µ�����
				ClickSound As xge.Sound Ptr						' ��ť����������� [��갴�²��ɿ�ʱ����]
				
				'Declare Sub ApplyStyle(StyleID As Integer = 0)	' Ӧ����ʽ
				
				Event As ButtonEvent							' ��ť���¼�
				
				' ������������ [����û��������Щϸ�ڣ�������ο���]
				private_Status As Integer						' ��ť��״̬ [0=���桢1=�ȵ㡢2=����]
				private_AllowClick As Integer					' ����������¼� [��������ڰ�ť�ϰ��µ�ʱ������ΪTRUE]
			End Type
			
			
			' ��ǩ��
			Type Label Extends xui.Element
				Text As WString Ptr								' ����
				TextOffset As xge_Coord							' ������ʾƫ��
				TextColor As UInteger							' ������ɫ
				TextFont As UInteger							' ��������
				TextAlign As Integer							' ������뷽ʽ
				LineSpace As Integer							' �м��
				WordSpace As Integer							' �ּ��
				BackStyle As xui.BackStyle_Struct				' ������ʽ
			End Type
			
			
			' ������
			Type Frame Extends xui.Element
				Text As WString Ptr								' ����
				TextColor As UInteger							' ������ɫ
				TextFont As UInteger							' ��������
				BackStyle As xui.BackStyle_Struct				' ������ʽ
			End Type
			
			
			' ͼ����
			Type Image Extends xui.Element
				Image As xge.Surface Ptr						' ͼ�����ָ��
				ImageOffset As xge_Coord						' ͼ�����ƫ��
				BorderWidth As UInteger							' �߿���
				BorderColor As UInteger							' �߿���ɫ
			End Type
			
			
			' ��������
			Type ProgressBar Extends xui.Element
				Max As Integer									' ���ֵ
				Min As Integer									' ��Сֵ
				Value As Integer								' ��ǰֵ
				TextFont As UInteger							' ����
				TextColor As UInteger							' ������ɫ
				BackStyle As xui.BackStyle_Struct				' ������ʽ
				ForeStyle As xui.BackStyle_Struct				' ǰ����ʽ
				ShowMode As Integer								' ��ʾģʽ [ 1=��ʾ�ٷֱȡ�2=��ʾ��ֵ��else=����ʾ ]
				RercentDigit As UInteger						' �ٷֱ�λ��
				BorderWidth As UInteger							' �߿���
			End Type
			
			
			' ��������
			Type ScrollBar Extends xui.Element
				Max As Integer									' ���ֵ
				Min As Integer									' ��Сֵ
				Value As Integer								' ��ǰֵ
				SmallChange As Integer							' ���û��������������°�ť���ͷ��ʱ�Ĺ�������
				LargeChange As Integer							' ���û������������հ׿ռ��PageDown��PageUpʱ�Ĺ�������
				WhellChange As Integer							' ���ֵĹ�������
				BackStyle As xui.BackStyle_Struct				' ������ʽ
				
				Event As ScrollBarEvent							' ���������¼�
				
				' ���ù�����Χ
				Declare Sub SetRange(iMin As Integer, iMax As Integer, bApplyLayout As Integer = TRUE)
				
				' ������������ [����û��������Щϸ�ڣ�������ο���]
				private_Type As Integer							' ���� [1=�����������else=���������]
				private_DragX As Integer						' �϶�����ʱ��¼�ĺ�����
				private_DragY As Integer						' �϶�����ʱ��¼��������
				private_SpaceCount As Integer					' �϶�����ʱ���ܵĿհ׿ռ�������
				private_ButtonUp As xui.Button Ptr				' �� ��ť
				private_ButtonDown As xui.Button Ptr			' �� ��ť
				private_ButtonCurPos As xui.Button Ptr			' ��ǰλ�� ��ť
				private_SpaceUp As xui.Element Ptr				' �Ϸ��ռ� Ԫ��
				private_SpaceDown As xui.Element Ptr			' �·��ռ� Ԫ��
			End Type
			
			
			' ������ͼ��
			Type ScrollView Extends xui.Element
				View As xge_Rect								' ��ͼ [ x+y=��ͼ����λ�á�w+h=��ͼ������С ]
				ScrollBar As Integer							' ��������ʾ״̬
				BorderWidth As UInteger							' �߿���
				BorderColor As UInteger							' �߿���ɫ
				BackColor As UInteger							' ������ɫ [��ֻ������������������������Ŀհ�]
				
				ViewEvent As ScrollViewEvent					' ������ͼ���¼�
				
				' ���캯��
				Declare Constructor()
				
				' ������ͼ��С
				Declare Sub SetViewSize(nw As Integer, nh As Integer, bApplyLayout As Integer = TRUE)
				
				' ������������ [����û��������Щϸ�ڣ�������ο���]
				private_VScroll As xui.ScrollBar Ptr			' ��ͼ������
				private_HScroll As xui.ScrollBar Ptr			' ��ͼ������
				DefaultScrollBar As xui.ScrollBar Ptr			' Ĭ�Ϲ����� [����ͼ�ϲ������������Ὣ��Ϣ���͸����Ԫ�أ�Ĭ��ʹ�ô�ֱ������]
			End Type
			
			
			' �б���� (�б��Χ��1��ʼ, 0����Ƿ���Χ, ѡ����0��ʾû���κ��б��ѡ��)
			Type ListBox Extends xui.Element
				List As List_ItemSet							' �б����
				TextColor As UInteger							' ������ɫ
				TextFont As UInteger							' ��������
				BackStyle As xui.BackStyle_Struct				' ������ʽ
				ItemHotStyle As xui.BackStyle_Struct			' �ȵ�����ʽ
				ItemSelStyle As xui.BackStyle_Struct			' ѡ������ʽ
				BorderWidth As UInteger							' �߿���
				ItemHeight As UInteger							' �б���߶�
				
				Event As ListBoxEvent							' �б���¼�
				
				Declare Property ListIndex As Integer
				Declare Property ListIndex(iPos As Integer)
				
				' ������������ [����û��������Щϸ�ڣ�������ο���]
				private_HotItem As UInteger						' ���ָ���Ԫ��
				private_ListIndex As UInteger					' ��ǰѡ����
				private_WordHeight As UInteger					' ���ָ߶�
				private_ShowCount As UInteger					' �б��ܹ���ʾ����Ŀ���� [���ڼ��������]
				private_Scroll As xui.ScrollBar Ptr				' ������
				private_ShowScroll As Integer					' �Ƿ���ʾ������
			End Type
			
			
			' �б༭�� [���б༭��]
			Type LineEdit Extends xui.Element
				TextFont As UInteger							' ��������
				TextColor As UInteger							' ������ɫ
				CompColor As UInteger							' ���������������ɫ
				SelTextColor As UInteger						' ѡ�����ֵ���ɫ
				SelBackColor As UInteger						' ѡ�����ֵı�����ɫ
				BorderWidth As UInteger							' �߿���
				BackStyle As xui.BackStyle_Struct				' ������ʽ
				SelStart As UInteger							' ѡ���ı���ʼ��λ��
				SelSize As UInteger								' ѡ���ı��ĳ���
				TextAlign As Integer							' ���ֶ��뷽ʽ [��δʵ��]
				EnableIME As Integer							' �Ƿ�����IME���뷨
				PassWordChar As Integer							' ����ģʽ�ַ� [Ϊ0ʱ��ʹ������ģʽ������ģʽ���޷����ƺͼ���]
				MaxLenght As UInteger							' ��󳤶ȣ�Ϊ 0 ʱ������
				
				Event As LineEditEvent
				
				' ���캯��
				Declare Constructor()
				
				' �ı�����
				Declare Property Text As WString Ptr
				Declare Property Text(sText As WString Ptr)
				
				' �ı�����
				Declare Function TextLenght() As UInteger
				
				' ȫѡ
				Declare Sub SelectAll()
				
				' ����
				Declare Sub Cut()
				
				' ����
				Declare Sub Copy()
				
				' ճ��
				Declare Sub Paste()
				
				' ɾ��ѡ������
				Declare Sub Del()
				
				' ���õ�ǰѡ�������
				Declare Sub SetSelText(sText As WString Ptr, iSize As UInteger = 0)
				
				' ��������ѡ��Χ
				Declare Sub SetSel(s As UInteger, l As Integer)
				
				' ������������ [����û��������Щϸ�ڣ�������ο���]
				private_ViewX As UInteger						' ��ͼ������ [���ڴ����������ֳ�����Χ�����] [��δʵ��]
				private_Buffer As xStringBuffer					' ���ֻ�����
				private_Offset As xge_Coord						' ���ֻ���ƫ�� [�����Ű桢��������]
				private_Caret As xge_Rect						' �����������λ�úʹ�С
				private_CaretTick As UInteger					' ������ϴ���˸��ʱ��
				private_CaretShow As Integer					' �������ʾ״̬
				private_CaretPos As UInteger					' �����λ��
				private_CaretBlink As UInteger					' �������˸��� [����]
				private_CaretColor As UInteger					' ���������ɫ
				private_compstr As WString Ptr					' IME�����ַ���
				private_comppos As UInteger						' IME�����ַ���ָ�����ڵ�λ��
				private_DragPos As UInteger						' ������϶�ѡ��ʱ������ַ�λ��
			End Type
			
			
			' ������
			Type Window Extends xui.Element
				
				Text As WString Ptr								' ����
				TextColor As UInteger							' ������ɫ
				TextFont As UInteger							' ��������
				BackStyle As xui.BackStyle_Struct				' ������ʽ
				AllowMove As Integer							' ������ק�ƶ�
				AllowSize As Integer							' ���������С [��δʵ��]
				
				Event As WindowEvent
				
				' ���캯��
				Declare Constructor()
				
				' ������������ [����û��������Щϸ�ڣ�������ο���]
				private_DragMode As Integer						' �Ƿ�ʼ�϶�
				private_Drag As xge_Coord						' �϶�����ʱ���������
				private_DragWinPos As xge_Coord					' �϶�����ʱ���ڵ�����
			End Type
			
			
			' ��ȡ��Ԫ�� (DesktopԪ��)
			Declare Function GetRootElement() As xui.Element Ptr
			
			' ��ȡ�������Ԫ��
			Declare Function GetActiveElement() As xui.Element Ptr
			
			' ����Ԫ�� [����NULL��ȡ����ǰ�����Ԫ��]
			Declare Sub ActiveElement(ele As xui.Element Ptr)
			
			' ������겶�� [����NULL���ͷ���겶��]
			' ��겶��һ���� OnMouseDown ʱ���ã�OnMouseUp ʱ�ͷ�
			' �����ڼ䣬�����Ϣ������֪ͨ�������Ԫ�ش���������Ԫ�ز�����ʱ�Ż�ַ�������Ԫ�غ�XGE����
			Declare Sub MouseCapture(ele As xui.Element Ptr)
			
			' �رպͼ������뷨
			Declare Sub DisableIME()
			Declare Sub EnableIME(proc As Any Ptr, param As Integer)
			Declare Sub EnableCharInput(proc As Any Ptr, param As Integer)
			
			' ��ȡ���ָ���µ��ȵ�Ԫ��
			Declare Function GetHotElement() As xui.Element Ptr
			
			' �ͷ�ĳ��Ԫ���µ�������Ԫ�� (Ĭ�����DesktopԪ��)
			Declare Sub FreeChilds(ui As xui.Element Ptr = NULL)
			
			' Ӧ�ò���
			Declare Sub LayoutApply()
			
			' ��������Ԫ��
			Declare Function CreateElement(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sIdentifier As WString Ptr = NULL) As xui.Element Ptr
			
			' ������ǩԪ��
			Declare Function CreateLabel(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As WString Ptr, TextColor As UInteger = &HFFFFFFFF, TextFont As UInteger = 1, sIdentifier As WString Ptr = NULL) As xui.Label Ptr
			
			' ��������Ԫ��
			Declare Function CreateFrame(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sCaption As WString Ptr = NULL, sIdentifier As WString Ptr = NULL) As xui.Frame Ptr
			
			' ����ͼ��Ԫ��
			Declare Function CreateImage(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, pImage As xge.Surface Ptr = NULL, sIdentifier As WString Ptr = NULL) As xui.Image Ptr
			
			' ������ťԪ��
			Declare Function CreateButton(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As WString Ptr, sIdentifier As WString Ptr = NULL) As xui.Button Ptr
			
			' ����ѡ��ťԪ��
			Declare Function CreateCheckButton(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As WString Ptr, sIdentifier As WString Ptr = NULL) As xui.Button Ptr
			Declare Function CreateRadioButton(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As WString Ptr, sIdentifier As WString Ptr = NULL) As xui.Button Ptr
			
			' ������ѡ��Ԫ��
			Declare Function CreateCheckBox(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As WString Ptr, sIdentifier As WString Ptr = NULL) As xui.Button Ptr
			
			' ������ѡ��Ԫ��
			Declare Function CreateRadioBox(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As WString Ptr, sIdentifier As WString Ptr = NULL) As xui.Button Ptr
			
			' ����������Ԫ��
			Declare Function CreateHyperLink(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As WString Ptr, sIdentifier As WString Ptr = NULL) As xui.Button Ptr
			
			' �������������
			Declare Function CreateVScrollBar(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 18, h As Integer = 200, sIdentifier As WString Ptr = NULL) As xui.ScrollBar Ptr
			
			' �������������
			Declare Function CreateHScrollBar(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 200, h As Integer = 18, sIdentifier As WString Ptr = NULL) As xui.ScrollBar Ptr
			
			' ����������ͼ
			Declare Function CreateScrollView(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 200, h As Integer = 200, vw As Integer = 200, vh As Integer = 200, sIdentifier As WString Ptr = NULL) As xui.ScrollView Ptr
			
			' �����б��
			Declare Function CreateListBox(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 120, h As Integer = 200, TextColor As UInteger = &HFF000000, TextFont As UInteger = 1, sIdentifier As WString Ptr = NULL) As xui.ListBox Ptr
			
			' �����б༭��
			Declare Function CreateLineEdit(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As WString Ptr, TextFont As UInteger = 1, sIdentifier As WString Ptr = NULL) As xui.LineEdit Ptr
			
			' ��������༭��
			Declare Function CreatePassWordEdit(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sCaption As WString Ptr, TextFont As UInteger = 1, sIdentifier As WString Ptr = NULL) As xui.LineEdit Ptr
			
			' ����������
			Declare Function CreateProgressBar(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sIdentifier As WString Ptr = NULL) As xui.ProgressBar Ptr
			
			' ��������
			Declare Function CreateBaseWindow(x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, iLayoutMode As Integer = XUI_LAYOUT_COORD, sCaption As WString Ptr, TextColor As UInteger = &HFFFFFFFF, TextFont As UInteger = 1, sIdentifier As WString Ptr = NULL) As xui.Window Ptr
			
		End Namespace
		
		
		
		/' -------------------------- ����� -------------------------- '/
		Namespace xSock
			
			Type Event_Server
				OnRecv As Sub(client As HANDLE, pack As Any Ptr, size As UInteger)
				OnSend As Sub(client As HANDLE, code As Integer)
				OnAccept As Sub(client As HANDLE)
				OnDisconn As Sub(client As HANDLE)
			End Type
			
			Type Event_Client
				OnRecv As Sub(pack As Any Ptr, size As UInteger)
				OnSend As Sub(code As Integer)
				OnDisconn As Sub()
			End Type
			
			Type Event_UDP
				OnRecv As Sub(pack As Any Ptr, size As UInteger, ip As Any Ptr, port As Integer)
				OnSend As Sub(code As Integer)
			End Type
			
			Type xServer
				Section As CRITICAL_SECTION
				
				' �¼�
				Event As Event_Server
				
				' ����
				Declare Destructor()
				
				' ����
				Declare Function Create(ip As ZString Ptr, port As UShort, max As UInteger = 1000, ThreadCountt As UInteger = 1) As Integer
				Declare Function Create(ip As WString Ptr, port As UShort, max As UInteger = 1000, ThreadCountt As UInteger = 1) As Integer
				
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
				Declare Function GetClientInfo(client As HANDLE, ip As WString Ptr Ptr, port As UInteger Ptr) As Integer
				
				' �ڲ��¼�����
				#Ifdef XGE_SOURCE_BUILD
					Declare Sub AcceptProc(client As HANDLE)
					Declare Sub DisconnProc(client As HANDLE)
				#EndIf
				
				' ������������ [����û��������Щϸ�ڣ�������ο���]
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
				Event As Event_Client
				
				' ����
				Declare Destructor()
				
				' ����
				Declare Function Connect(ip As ZString Ptr, port As UShort) As Integer
				Declare Function Connect(ip As WString Ptr, port As UShort) As Integer
				
				' �Ͽ�
				Declare Sub Close()
				
				' ״̬
				Declare Function Status() As Integer
				
				' ����
				Declare Function Send(pack As Any Ptr, size As UInteger, sync As Integer = TRUE) As Integer
				
				' ������������ [����û��������Щϸ�ڣ�������ο���]
				h_Client As HANDLE
			End Type
			
			Type xUDP
				' �¼�
				Event As Event_UDP
				
				' ����
				Declare Destructor()
				
				' ����
				Declare Function Create(ip As ZString Ptr, port As UShort, ThreadCountt As UInteger = 1) As HANDLE
				Declare Function Create(ip As WString Ptr, port As UShort, ThreadCountt As UInteger = 1) As HANDLE
				
				' ����
				Declare Sub Destroy()
				
				' ״̬ [�Ѵ���=TRUE]
				Declare Function Status() As Integer
				
				' ����
				Declare Function send(pack As Any Ptr, size As UInteger, ip As ZString Ptr, port As UShort, sync As Integer = TRUE) As Integer
				Declare Function send(pack As Any Ptr, size As UInteger, ip As WString Ptr, port As UShort, sync As Integer = TRUE) As Integer
				
				' ������������ [����û��������Щϸ�ڣ�������ο���]
				h_Socket As HANDLE
				private_Unicode As Integer
			End Type
			
		End Namespace
		
	End Extern
	
	
	
	' -------------------------- �����ṹ�� -------------------------- '/
	Type XGE_SCENE
		proc As XGE_SCENE_PROC
		pause As Integer
		sync As Integer
		Lockfps As UInteger
		RootElement As xui.Element Ptr
	End Type
	
	
	
	Extern XGE_EXTERNSTDEXT
		/' -------------------------- �����Ⱦ�� -------------------------- '/
		Declare Function Blend_Custom(src As xge.Surface Ptr, px As Integer, py As Integer, cx As Integer, cy As Integer, cw As Integer, ch As Integer,dst As xge.Surface Ptr, bk As XGE_DRAW_BLEND, param As Integer) As Integer
		Declare Sub SetShadeData(w As Integer, h As Integer, d As Any Ptr)
		Declare Sub MakeShadeData(sf As xge.Surface Ptr, sd As UByte Ptr)
		
		
		/' -------------------------- �ַ���ת���� -------------------------- '/
		Declare Function AsciToUnicode(ZStrPtr As ZString Ptr, ZStrLen As UInteger = 0) As WString Ptr
		Declare Function UnicodeToAsci(WStrPtr As WString Ptr, WStrLen As UInteger = 0) As ZString Ptr
		Declare Function UnicodeToUTF8(WStrPtr As WString Ptr, WStrLen As UInteger = 0) As ZString Ptr
		Declare Function UTF8ToUnicode(UTF8Ptr As ZString Ptr, UTF8Len As UInteger = 0) As WString Ptr
		Declare Function A2W(AStr As ZString Ptr, ALen As UInteger = 0) As WString Ptr
		Declare Function W2A(UStr As WString Ptr, ULen As UInteger = 0) As ZString Ptr
		Declare Function W2U(UStr As WString Ptr, ULen As UInteger = 0) As ZString Ptr
		Declare Function U2W(UStr As ZString Ptr, ULen As UInteger = 0) As WString Ptr
		Declare Function A2U(ZStr As ZString Ptr, ZLen As UInteger = 0) As ZString Ptr
		Declare Function U2A(UStr As ZString Ptr, ULen As UInteger = 0) As ZString Ptr
		
		
		/' -------------------------- ���������Ժ����� -------------------------- '/
		Declare Sub xui_DrawBackStyle(ele As xui.Element Ptr, bs As xui.BackStyle_Struct Ptr)
		Declare Sub xui_DrawBackStyle_Rect(ele As xui.Element Ptr, bs As xui.BackStyle_Struct Ptr, rc As xge_Rect Ptr)
		Declare Sub xui_DrawBackStyle_Text(ele As xui.Element Ptr, bs As xui.BackStyle_Text_Struct Ptr, sText As WString Ptr, fontid As UInteger, CaptionOffset As xge_Coord Ptr)
		
		
		/' -------------------------- �ļ������� -------------------------- '/
		Declare Function xFile_CreateA(FilePath As ZString Ptr) As Integer
		Declare Function xFile_CreateW(FilePath As WString Ptr) As Integer
		Declare Function xFile_OpenA(FilePath As ZString Ptr, OnlyRead As Integer = 0) As HANDLE
		Declare Function xFile_OpenW(FilePath As WString Ptr, OnlyRead As Integer = 0) As HANDLE
		Declare Function xFile_Close(FileHdr As HANDLE) As Integer
		Declare Function xFile_ExistsA(FilePath As ZString Ptr) As Integer
		Declare Function xFile_ExistsW(FilePath As WString Ptr) As Integer
		Declare Function xFile_hwrite(FileHdr As HANDLE, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger
		Declare Function xFile_WriteA(FilePath As ZString Ptr, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger
		Declare Function xFile_WriteW(FilePath As WString Ptr, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger
		Declare Function xFile_hRead(FileHdr As HANDLE, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger
		Declare Function xFile_ReadA(FilePath As ZString Ptr, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger
		Declare Function xFile_ReadW(FilePath As WString Ptr, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger
		Declare Function xFile_hSize(FileHdr As HANDLE) As UInteger
		Declare Function xFile_SizeA(FilePath As ZString Ptr) As UInteger
		Declare Function xFile_SizeW(FilePath As WString Ptr) As UInteger
		Declare Function xFile_hCut(FileHdr As HANDLE, FileSize As UInteger) As Integer
		Declare Function xFile_CutA(FilePath As ZString Ptr, FileSize As UInteger) As Integer
		Declare Function xFile_CutW(FilePath As WString Ptr, FileSize As UInteger) As Integer
		Declare Function xFile_ScanA(RootDir As ZString Ptr, Filter As ZString Ptr, Attrib As Integer, AttribEx As Integer, Recursive As Integer, CallBack As Function(Path As ZString Ptr, FindData As WIN32_FIND_DATAA Ptr, param As Integer) As Integer, param As Integer = 0) As Integer
		Declare Function xFile_ScanW(RootDir As WString Ptr, Filter As WString Ptr, Attrib As Integer, AttribEx As Integer, Recursive As Integer, CallBack As Function(Path As WString Ptr, FindData As WIN32_FIND_DATAW Ptr, param As Integer) As Integer, param As Integer = 0) As Integer
		
		
		/' -------------------------- ini �ļ������� -------------------------- '/
		Declare Function xIni_GetStrA(IniFile As ZString Ptr, IniSec As ZString Ptr, IniKey As ZString Ptr) As ZString Ptr
		Declare Function xIni_GetStrW(IniFile As WString Ptr, IniSec As WString Ptr, IniKey As WString Ptr) As WString Ptr
		Declare Function xIni_GetIntA(IniFile As ZString Ptr, IniSec As ZString Ptr, IniKey As ZString Ptr) As Integer
		Declare Function xIni_GetIntW(IniFile As WString Ptr, IniSec As WString Ptr, IniKey As WString Ptr) As Integer
		Declare Function xIni_SetStrA(IniFile As ZString Ptr, IniSec As ZString Ptr, IniKey As ZString Ptr, kValue As ZString Ptr) As Integer
		Declare Function xIni_SetStrW(IniFile As WString Ptr, IniSec As WString Ptr, IniKey As WString Ptr, kValue As WString Ptr) As Integer
		
		
		/' -------------------------- ����������� -------------------------- '/
		Declare Function xClip_GetTextW() As WString Ptr
		Declare Function xClip_SetTextW(Text As WString Ptr, Size As UInteger = 0) As Integer
		Declare Function xClip_GetTextA() As ZString Ptr
		Declare Function xClip_SetTextA(Text As ZString Ptr, Size As UInteger = 0) As Integer
	End Extern
	
	
	
	' Unicode
	#Ifdef UNICODE
		
		#Define xFile_Create			xFile_CreateW
		#Define xFile_Open				xFile_OpenW
		#Define xFile_Exists			xFile_ExistsW
		#Define xFile_Write				xFile_WriteW
		#Define xFile_Read				xFile_ReadW
		#Define xFile_Size				xFile_SizeW
		#Define xFile_Cut				xFile_CutW
		#Define xFile_Scan				xFile_ScanW
		
		#Define xIni_GetStr				xIni_GetStrW
		#Define xIni_GetInt				xIni_GetIntW
		#Define xIni_SetStr				xIni_SetStrW
		
		#Define xClip_GetText			xClip_GetTextW
		#Define xClip_SetText			xClip_SetTextW
		
	#Else
		
		#Define xFile_Create			xFile_CreateA
		#Define xFile_Open				xFile_OpenA
		#Define xFile_Exists			xFile_ExistsA
		#Define xFile_Write				xFile_WriteA
		#Define xFile_Read				xFile_ReadA
		#Define xFile_Size				xFile_SizeA
		#Define xFile_Cut				xFile_CutA
		#Define xFile_Scan				xFile_ScanA
		
		#Define xIni_GetStr				xIni_GetStrA
		#Define xIni_GetInt				xIni_GetIntA
		#Define xIni_SetStr				xIni_SetStrA
		
		#Define xClip_GetText			xClip_GetTextA
		#Define xClip_SetText			xClip_SetTextA
		
	#EndIf
	
	
#EndIf


