'==================================================================================
	'�� xywh Game Engine ���ļ�
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================

#Include Once "windows.bi"
#Include Once "crt.bi"



#Define xywh_library_2dge



' ScreenControl ��ȡ��
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

' ScreenControl ������
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

' ScreenControl ������
#Define POLL_EVENTS							200



' ��ɫֵ [Transʹ��]
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



' ��Ϣ�ṹ���볣������ [ScreenEvent����ʹ��]
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



' ��ʼ�����
#Define xge_window				&H00		' ����ģʽ
#Define xge_fullscreen		&H01		' ȫ��ģʽ
#Define xge_noswitch			&H04		' ������alt + enter�л�����/ȫ��
#Define xge_noframe				&H08		' ����û�б߿�
#Define xge_postop				&H20		' �����ö�
#Define xge_alpha					&H40		' ����alpha��϶������л�������
#Define xge_highpriority	&H80		' ͼ��������Ȩ��ͼ����

' �ص���Ϣ
#Define xge_msg_null					&H00		' ����Ϣ
#Define xge_msg_loadres				&H01		' ������Դ
#Define xge_msg_freeres				&H02		' �ͷ���Դ
#Define xge_msg_frame					&H03		' ��ܺ���
#Define xge_msg_draw					&H04		' ��ͼ����
#Define xge_msg_error					&H05		' ������
#Define xge_msg_killfocus			&H06		' ��ʧ����
#Define xge_msg_setfocus			&H07		' ��ý���
#Define xge_msg_mouse_move		&H08		' ����ƶ�
#Define xge_msg_mouse_down		&H09		' ��갴��
#Define xge_msg_mouse_up			&H0A		' ��굯��
#Define xge_msg_mouse_dclick	&H0B		' ���˫��
#Define xge_msg_mouse_whell		&H0C		' ���ֹ���
#Define xge_msg_key_dowm			&H0D		' ��������
#Define xge_msg_key_up				&H0E		' ��������
#Define xge_msg_key_repeat		&H0F		' ������ס
#Define xge_msg_mouse_enter		&H10		' �������
#Define xge_msg_mouse_exit		&H11		' ����뿪
#Define xge_msg_close					&H12		' ���ڹر�
#Define xge_msg_xgui					&H13		' GUIϵͳ��Ϣ



' ������������
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

' ����ִ�б��
Dim Shared xywh_library_2dge_IsLoop As Integer				' ����ִ�б��
Dim Shared xywh_library_2dge_IsRun As Integer					' ��ͣ���
' FPS�������
Dim Shared xywh_library_2dge_tmpfps As Integer				' ����FPS����
Dim Shared xywh_library_2dge_tmptime As Integer				' ����FPS����
Dim Shared xywh_library_2dge_drawfps As Integer				' ʵ�ʵ�FPS
Dim Shared xywh_library_2dge_lockfps As Integer				' ������FPS
' ��������ָ�� [����xge.Clear]
Dim Shared xywh_library_2dge_scrptr As Any Ptr				' ��������ָ��
Dim Shared xywh_library_2dge_scrsize As Integer				' �������ݳ���
' ������Ϣ
Dim Shared xywh_library_2dge_bpp As Integer						' λ��
Dim Shared xywh_library_2dge_issync As Integer				' �Ƿ�����ֱͬ��
' ��������
Dim Shared xywh_library_2dge_tick As Integer					' ���һ�� GetTickCount ���
Dim Shared xywh_library_2dge_retloop As Integer				' ��������ֵ
' ��Ϣ�ַ���
Dim Shared xywh_library_2dge_event As Sub(Event As NewEvent) = @xywh_library_2dge_eventcall



#Ifdef XGE_USE_XPK			' ʹ���ļ���
	#Include Once "Inc\SDK\xywhPack.bi"
#EndIf
#Ifdef XGE_USE_XPF			' ʹ�õ����ֿ�
	#Include Once "Inc\XGE\xywhPointFont.bi"
#EndIf
#Ifdef XGE_USE_SFM			' ʹ��Surface������
	#Include Once "Inc\XGE\SurfaceManage.bi"
#EndIf
#Ifdef XGE_USE_SOM			' ʹ��Sound������
	#Include Once "Inc\XGE\SoundManage.bi"
#EndIf
#Ifdef XGE_USE_GUI			' ʹ����ϷUIϵͳ
	#Include Once "Inc\XGE\xywhFastGameUI.bi"
#EndIf
#Ifdef XGE_USE_GDI			' ʹ�� GDI ͼ��֧��
	#Include Once "Inc\XGE\GDISurface.bi"
#EndIf
#Ifdef XGE_USE_DDS			' ʹ�ö�̬�����ַ�������
	#Include Once "Inc\XGE\GDISurface.bi"
	#Include Once "Inc\XGE\DrawString.bi"
#EndIf



' ��Ϣ�ַ���
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
		' ����FPSֵ
		xywh_library_2dge_tick = GetTickCount()
		If xywh_library_2dge_tick > xywh_library_2dge_tmptime+1000 Then
			xywh_library_2dge_tmptime = xywh_library_2dge_tick
			xywh_library_2dge_drawfps = xywh_library_2dge_tmpfps
			xywh_library_2dge_tmpfps = 0
		Else
			xywh_library_2dge_tmpfps += 1
		EndIf
		' ��Ϣ����
		Dim Event As NewEvent
		Do While ScreenEvent(@Event)
			xywh_library_2dge_event(Event)
		Loop
		' ��ܴ���
		If xywh_library_2dge_IsRun Then
			xywh_library_2dge_bkfunc(xge_msg_frame,0,0)
		EndIf
		' FPS����
		If LockFps Then
			Do While (xywh_library_2dge_tick-xywh_library_2dge_tmptime) < ((1000/LockFps)*xywh_library_2dge_tmpfps)
				Sleep(1)
				xywh_library_2dge_tick = GetTickCount()
			Loop
		EndIf
		' ���ƴ���
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
	' ����
	Function Start(ByVal bk As Any Ptr,ByVal Param As Any Ptr = NULL) As Integer
		If xywh_library_2dge_bkfunc=NULL Then
			xywh_library_2dge_IsLoop = -1
			xywh_library_2dge_IsRun = -1
			xywh_library_2dge_bkfunc = bk
			Return xywh_library_2dge_loop(xywh_library_2dge_lockfps,xywh_library_2dge_issync,Param)
		EndIf
	End Function
	
	' ��ֹ
	Sub Stop(StopCode As Integer = 0)
		xywh_library_2dge_retloop = StopCode
		xywh_library_2dge_IsLoop = 0
	End Sub
	
	' ��ͣ
	Sub Pause()
		xywh_library_2dge_IsRun = 0
	End Sub
	
	' �ָ�
	Sub Restore()
		xywh_library_2dge_IsRun = -1
	End Sub
	
	' ֱ���л�����
	Sub Screen(ByVal bk As Any Ptr)
		xywh_library_2dge_bkfunc = bk
	End Sub
	
	
	
	Function hWnd() As HANDLE
		Dim hWin As HANDLE
		ScreenControl(GET_WINDOW_HANDLE,Cast(Integer,hWin))
		Return hWin
	End Function
	
	
	
	' ��ʼ������
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
	
	' ж������
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
' XGE����ģ��
Function MainScreen(ByVal message As Integer,ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Select Case message
		Case xge_msg_frame				' �߼�����
			
		Case xge_msg_draw					' ��ͼ
			
		Case xge_msg_mouse_move		' ����ƶ�
			
		Case xge_msg_mouse_down		' ��갴��
			
		Case xge_msg_mouse_up			' ��굯��
			
		Case xge_msg_mouse_dclick	' ���˫��
			
		Case xge_msg_mouse_whell	' �����ֹ���
			
		Case xge_msg_key_dowm			' ���̰���
			
		Case xge_msg_key_up				' ���̵���
			
		Case xge_msg_key_repeat		' �����ظ�����
			
		Case xge_msg_setfocus			' ӵ�н���
			
		Case xge_msg_killfocus		' ʧȥ����
			
		Case xge_msg_mouse_enter	' �������
			
		Case xge_msg_mouse_exit		' ����Ƴ�
			
		Case xge_msg_loadres			' ������Դ
			
		Case xge_msg_freeres			' ж����Դ
			
		Case xge_msg_close				' ���ڹر�
			Return -1
	End Select
End Function
'/