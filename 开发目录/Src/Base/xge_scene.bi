'==================================================================================
	'�� xywh Game Engine ����ģ��
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================



Extern XGE_EXTERNCLASS
	Namespace xui
		Declare Function EventProc(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	End Namespace
End Extern



' ��Ϣ������
Function xge_proc_scmsg(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	' GUIϵͳ����Ϣ���ȼ���ߣ����ᱻ���أ��ҿ��Ծ����Ƿ���Ϣ�Ե�
	If xui.EventProc(msg, param, eve) Then
		return 0
	EndIf
	' ��Ϣ�������ͳ������� [��Ϣ���������Ծ�����Ϣ�Ƿ��͸�����]
	If xge_global_msgproc Then
		Dim RetInt As Integer = xge_global_msgproc(msg, param, eve)
		If RetInt Then
			Return RetInt
		Else
			If xge_global_scene_cur.proc Then
				Return xge_global_scene_cur.proc(msg, param, eve)
			EndIf
		EndIf
	Else
		If xge_global_scene_cur.proc Then
			Return xge_global_scene_cur.proc(msg, param, eve)
		EndIf
	EndIf
	Return 0
End Function

' Ĭ����Ϣ�ַ���
Sub xge_proc_event(eve As XGE_EVENT Ptr)
	Select Case eve->tpe
		Case EVENT_KEY_PRESS
			xge_proc_scmsg(XGE_MSG_KEY_DOWN, 0, eve)
		Case EVENT_KEY_RELEASE
			xge_proc_scmsg(XGE_MSG_KEY_UP, 0, eve)
		Case EVENT_KEY_REPEAT
			xge_proc_scmsg(XGE_MSG_KEY_REPEAT, 0, eve)
		Case EVENT_MOUSE_MOVE
			xge_event_mouse_clickstk = 0
			If (eve->x < 60000) And (eve->y < 60000) Then
				xge_event_move_x = eve->x
				xge_event_move_y = eve->y
				xge_proc_scmsg(XGE_MSG_MOUSE_MOVE, 0, eve)
			EndIf
		Case EVENT_MOUSE_BUTTON_PRESS
			eve->button = eve->mx
			eve->mx = xge_event_move_x
			eve->my = xge_event_move_y
			xge_proc_scmsg(XGE_MSG_MOUSE_DOWN, 0, eve)
			' ʵ����굥����Ϣ
			xge_event_mouse_clickstk = -1
			xge_event_mouse_clickbtn = eve->button
		Case EVENT_MOUSE_BUTTON_RELEASE
			eve->button = eve->mx
			eve->mx = xge_event_move_x
			eve->my = xge_event_move_y
			xge_proc_scmsg(XGE_MSG_MOUSE_UP, 0, eve)
			' ʵ����굥����Ϣ
			If xge_event_mouse_clickstk And (xge_event_mouse_clickbtn = eve->button) Then
				xge_event_mouse_clickstk = 0
				xge_proc_scmsg(XGE_MSG_MOUSE_CLICK, 0, eve)
			EndIf
		Case EVENT_MOUSE_DOUBLE_CLICK
			eve->button = eve->mx
			eve->mx = xge_event_move_x
			eve->my = xge_event_move_y
			xge_proc_scmsg(XGE_MSG_MOUSE_DCLICK, 0, eve)
		Case EVENT_MOUSE_WHEEL
			eve->z = eve->zx
			eve->zx = xge_event_move_x
			eve->zy = xge_event_move_y
			eve->nz = eve->z - xge_event_move_z
			xge_event_move_z = eve->z
			xge_proc_scmsg(XGE_MSG_MOUSE_WHELL, 0, eve)
		Case EVENT_MOUSE_HWHEEL
			
		Case EVENT_MOUSE_ENTER
			xge_proc_scmsg(XGE_MSG_MOUSE_ENTER, 0, 0)
		Case EVENT_MOUSE_EXIT
			xge_proc_scmsg(XGE_MSG_MOUSE_EXIT, 0, 0)
		Case EVENT_WINDOW_GOT_FOCUS
			xge_proc_scmsg(XGE_MSG_GOTFOCUS, 0, 0)
		Case EVENT_WINDOW_LOST_FOCUS
			xge_proc_scmsg(XGE_MSG_LOSTFOCUS, 0, 0)
		Case EVENT_WINDOW_CLOSE
			If xge_proc_scmsg(XGE_MSG_CLOSE, 0, 0) Then
				XGE_PROC_Scene_StopAll()
			EndIf
	End Select
End Sub

' ����������
Sub xge_proc_scene()
	Do
		' ����FPSֵ
		xge_global_fps_newtick = GetTickCount()
		If xge_global_fps_newtick > (xge_global_fps_oldtick + 1000) Then
			xge_global_fps_oldtick = xge_global_fps_newtick
			xge_global_scene_fps = xge_global_fps_count
			xge_global_fps_count = 0
		Else
			xge_global_fps_count += 1
		EndIf
		' ��Ϣ����
		Dim eve As XGE_EVENT
		Do While ScreenEvent(@eve)
			xge_global_eveproc(@eve)
			If xge_global_scene_run = FALSE Then
				Exit Do
			EndIf
		Loop
		If xge_global_scene_run Then
			' ��ܴ���
			If (xge_global_scene_cur.pause And XGE_PAUSE_FRAME) = 0 Then
				xge_proc_scmsg(XGE_MSG_FRAME, 0, 0)
			EndIf
			' FPS����
			If xge_global_scene_cur.Lockfps Then
				Do While (xge_global_fps_newtick-xge_global_fps_oldtick) < ((1000/xge_global_scene_cur.Lockfps)*xge_global_fps_count)
					xge_global_dlyproc(1)
					xge_global_fps_newtick = GetTickCount()
				Loop
			EndIf
			' ���ƴ���
			If (xge_global_scene_cur.pause And XGE_PAUSE_DRAW) = 0 Then
				If xge_global_scene_cur.sync Then
					ScreenSync()
				EndIf
				ScreenLock()
				xge_proc_scmsg(XGE_MSG_DRAW,0 , 0)
				ScreenUnLock()
			EndIf
		EndIf
	Loop While xge_global_scene_run
	' �ָ���һ������������
	If xge_global_scene_stack.Count > 0 Then
		Dim ts As XGE_SCENE Ptr = xge_global_scene_stack.Pop(1)
		If ts Then
			xge_global_scene_run = TRUE
			xge_global_scene_cur = *ts
		EndIf
	EndIf
End Sub


Extern XGE_EXTERNMODULE
	#Ifdef XGE_BUILD_USEOOP
		Namespace xge
			Namespace Scene
	#EndIf
	
	
	' ��������
	Function XGE_EXPORT_Scene_Start(proc As XGE_SCENE_PROC, lfps As UInteger = 0, sync As Integer = FALSE, param As Integer = 0) As Integer XGE_EXPORT_ALL
		If proc Then
			' ��֮ǰ�ĳ���ѹջ
			If xge_global_scene_cur.proc Then
				If xge_global_scene_stack.Push(@xge_global_scene_cur) = FALSE Then
					Return 0
				EndIf
			EndIf
			' �����³�������
			xge_global_scene_cur.proc = proc
			xge_global_scene_cur.Lockfps = lfps
			xge_global_scene_cur.sync = sync
			xge_global_scene_cur.pause = 0
			' ������Դ������Ϣ
			xge_proc_scmsg(XGE_MSG_LOADRES, param, NULL)
			' ��������������
			xge_global_scene_end = 0
			xge_global_scene_run = TRUE
			xge_proc_scene()
			Return xge_global_scene_end
		EndIf
	End Function
	
	' �л�����
	Function XGE_EXPORT_Scene_Cut(proc As XGE_SCENE_PROC, lfps As UInteger, sync As Integer, param As Integer = 0) As Integer XGE_EXPORT_ALL
		If proc Then
			' ������Դ�ͷ���Ϣ
			xge_proc_scmsg(XGE_MSG_FREERES, param, NULL)
			' �����³�������
			xge_global_scene_cur.proc = proc
			xge_global_scene_cur.Lockfps = lfps
			xge_global_scene_cur.sync = sync
			xge_global_scene_cur.pause = 0
			' ������Դ������Ϣ
			xge_proc_scmsg(XGE_MSG_LOADRES, param, NULL)
			' ��������������
			xge_global_scene_end = 0
			xge_global_scene_run = TRUE
			xge_proc_scene()
			Return xge_global_scene_end
		EndIf
	End Function
	
	' ��������
	Sub XGE_EXPORT_Scene_Stop(sc As Integer = 0) XGE_EXPORT_ALL
		' ������Դ�ͷ���Ϣ
		xge_proc_scmsg(XGE_MSG_FREERES, sc, NULL)
		' ���ý�����Ǻ��˳�����
		xge_global_scene_end = sc
		xge_global_scene_run = FALSE
	End Sub
	
	' �������г���
	Sub XGE_EXPORT_Scene_StopAll(sc As Integer = 0) XGE_EXPORT_ALL
		' ����ǰ����������Դ�ͷ���Ϣ
		xge_proc_scmsg(XGE_MSG_FREERES, sc, NULL)
		' ��������������Դ�ͷ���Ϣ
		Dim sCount As UInteger = xge_global_scene_stack.Count()
		Dim Scenes As XGE_SCENE Ptr = xge_global_scene_stack.Pop(sCount)
		If Scenes Then
			For i As Integer = 0 To sCount - 1
				xge_global_scene_cur = Scenes[i]
				xge_proc_scmsg(XGE_MSG_FREERES, sc, NULL)
			Next
		EndIf
		' ���ý�����Ǻ��˳�����
		xge_global_scene_end = sc
		xge_global_scene_run = FALSE
	End Sub
	
	' ��ͣ����
	Sub XGE_EXPORT_Scene_Pause(flag As Integer = XGE_PAUSE_DRAW Or XGE_PAUSE_FRAME) XGE_EXPORT_ALL
		xge_global_scene_cur.pause = flag
	End Sub
	
	' ��ȡ��ͣ״̬
	Function XGE_EXPORT_Scene_State() As Integer XGE_EXPORT_ALL
		Return xge_global_scene_cur.pause
	End Function
	
	' �ָ�����
	Sub XGE_EXPORT_Scene_Resume() XGE_EXPORT_ALL
		xge_global_scene_cur.pause = 0
	End Sub
	
	' ��ȡ����֡��
	Function XGE_EXPORT_Scene_FPS() As UInteger XGE_EXPORT_ALL
		Return xge_global_scene_fps
	End Function
	
	' ���ó���֡��
	Sub XGE_EXPORT_Scene_SetFPS(nv As UInteger) XGE_EXPORT_ALL
		xge_global_scene_fps = nv
	End Sub
	
	' ���س���ջ����
	Function XGE_EXPORT_Scene_Stack() As xStack Ptr XGE_EXPORT_ALL
		Return @xge_global_scene_stack
	End Function
	
	
	#Ifdef XGE_BUILD_USEOOP
			End Namespace
		End Namespace
	#EndIf
End Extern