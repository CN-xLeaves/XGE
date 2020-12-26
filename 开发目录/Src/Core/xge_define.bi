'==================================================================================
	'�� xywh Game Engine ȫ�ֶ���
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================



' -------------------------- ScreenControl ��ȡ��
#Define GET_WINDOW_POS				0
#Define GET_WINDOW_TITLE			1
#Define GET_WINDOW_HANDLE			2
#Define GET_DESKTOP_SIZE			3
#Define GET_SCREEN_SIZE				4
#Define GET_SCREEN_DEPTH			5
#Define GET_SCREEN_BPP				6
#Define GET_SCREEN_PITCH			7
#Define GET_SCREEN_REFRESH			8
#Define GET_DRIVER_NAME				9
#Define GET_TRANSPARENT_COLOR		10
#Define GET_VIEWPORT				11
#Define GET_PEN_POS					12
#Define GET_COLOR					13
#Define GET_ALPHA_PRIMITIVES		14
#Define GET_GL_EXTENSIONS			15
#Define GET_HIGH_PRIORITY			16


' -------------------------- ScreenControl ������
#Define SET_WINDOW_POS				100
#Define SET_WINDOW_TITLE			101
#Define SET_PEN_POS					102
#Define SET_DRIVER_NAME				103
#Define SET_ALPHA_PRIMITIVES		104
#Define SET_GL_COLOR_BITS			105
#Define SET_GL_COLOR_RED_BITS		106
#Define SET_GL_COLOR_GREEN_BITS		107
#Define SET_GL_COLOR_BLUE_BITS		108
#Define SET_GL_COLOR_ALPHA_BITS		109
#Define SET_GL_DEPTH_BITS			110
#Define SET_GL_STENCIL_BITS			111
#Define SET_GL_ACCUM_BITS			112
#Define SET_GL_ACCUM_RED_BITS		113
#Define SET_GL_ACCUM_GREEN_BITS		114
#Define SET_GL_ACCUM_BLUE_BITS		115
#Define SET_GL_ACCUM_ALPHA_BITS		116
#Define SET_GL_NUM_SAMPLES			117


' -------------------------- ScreenControl ������
#Define POLL_EVENTS					200


' -------------------------- GFXԭʼ�¼�
#Define EVENT_KEY_PRESS				1
#Define EVENT_KEY_RELEASE			2
#Define EVENT_KEY_REPEAT			3
#Define EVENT_MOUSE_MOVE			4
#Define EVENT_MOUSE_BUTTON_PRESS	5
#Define EVENT_MOUSE_BUTTON_RELEASE	6
#Define EVENT_MOUSE_DOUBLE_CLICK	7
#Define EVENT_MOUSE_WHEEL			8
#Define EVENT_MOUSE_ENTER			9
#Define EVENT_MOUSE_EXIT			10
#Define EVENT_WINDOW_GOT_FOCUS		11
#Define EVENT_WINDOW_LOST_FOCUS		12
#Define EVENT_WINDOW_CLOSE			13
#Define EVENT_MOUSE_HWHEEL			14


' -------------------------- �����ṹ
Type XGE_SCENE
	proc As XGE_SCENE_PROC
	pause As Integer
	sync As Integer
	Lockfps As UInteger
End Type


' -------------------------- ��ѧ����
#Define PI		3.1415926535898



' -------------------------- Ĭ�ϴ�����
Declare Sub xge_proc_event(eve As XGE_EVENT Ptr)
Declare Function xge_proc_scmsg(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer



' -------------------------- �����������
Dim Shared xge_global_width As UInteger
Dim Shared xge_global_height As UInteger
Dim Shared xge_global_scrptr As Any Ptr
Dim Shared xge_global_scrsize As UInteger
Dim Shared xge_global_scrpitch As UInteger


' -------------------------- ��������
Dim Shared xge_global_scene_stack As xStack = xStack(XGE_MAX_SCENE, SizeOf(XGE_SCENE))
Dim Shared xge_global_scene_cur As XGE_SCENE
Dim Shared xge_global_scene_run As Integer
Dim Shared xge_global_scene_end As Integer
Dim Shared xge_global_scene_fps As UInteger


' -------------------------- �¼�����
Dim Shared xge_event_move_x As Integer
Dim Shared xge_event_move_y As Integer
Dim Shared xge_event_move_dx As Integer
Dim Shared xge_event_move_dy As Integer
Dim Shared xge_event_move_z As Integer
Dim Shared xge_event_mouse_clickstk As Integer		' ���״̬��¼�����ڲ���������Ϣ [����֮���ƶ���ֱ���ɿ�����������Ϣ]
Dim Shared xge_event_mouse_clickbtn As Integer		' ��¼��갴��ʱ�İ�ť [�����ɿ���ͬ�İ�ť�ǲ��ᴥ��������Ϣ��]


' -------------------------- ��HOOK����
Dim Shared xge_global_eveproc As XGE_EVENT_PROC = @xge_proc_event
Dim Shared xge_global_dlyproc As XGE_DELAY_PROC = @Sleep
Dim Shared xge_global_msgproc As XGE_SCENE_PROC = NULL
Dim Shared xge_global_bldproc As XGE_BLOAD_PROC = NULL
Dim Shared xge_global_fldproc As XGE_FLOAD_PROC = NULL


' -------------------------- FPS��������
Dim Shared xge_global_fps_count As UInteger
Dim Shared xge_global_fps_newtick As UInteger
Dim Shared xge_global_fps_oldtick As UInteger


' -------------------------- GDIȫ������
Dim Shared xge_global_gdi_init As Integer
Dim Shared xge_global_gdi_gsi As GdiPlus.GdiplusStartupInput
Dim Shared xge_global_gdi_token As ULONG_PTR


' -------------------------- BASSȫ������
Dim Shared xge_global_bass_init As Integer


' -------------------------- �����б�
Dim Shared xge_fontlist As xBsmm = xBsmm(SizeOf(xge.Text.FontDriver), 8)


' -------------------------- XUIϵͳ����
Dim Shared xge_xui_element_root As xui.Element Ptr = NULL
Dim Shared xge_xui_element_active As xui.Element Ptr = NULL
Dim Shared xge_xui_element_hot As xui.Element Ptr = NULL



