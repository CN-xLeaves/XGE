'==================================================================================
	'★ xywh Game Engine 场景模块
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



Extern XGE_EXTERNCLASS
	Namespace xui
		Declare Function EventProc(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	End Namespace
End Extern



' 消息拦截器
Function xge_proc_scmsg(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	' GUI系统的消息优先级最高，不会被拦截，且可以决定是否将消息吃掉
	If xui.EventProc(msg, param, eve) Then
		return 0
	EndIf
	' 消息拦截器和场景机制 [消息拦截器可以决定消息是否发送给场景]
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

' 默认消息分发器
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
			' 实现鼠标单击消息
			xge_event_mouse_clickstk = -1
			xge_event_mouse_clickbtn = eve->button
		Case EVENT_MOUSE_BUTTON_RELEASE
			eve->button = eve->mx
			eve->mx = xge_event_move_x
			eve->my = xge_event_move_y
			xge_proc_scmsg(XGE_MSG_MOUSE_UP, 0, eve)
			' 实现鼠标单击消息
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

' 场景驱动器
Sub xge_proc_scene()
	Do
		' 计算FPS值
		xge_global_fps_newtick = GetTickCount()
		If xge_global_fps_newtick > (xge_global_fps_oldtick + 1000) Then
			xge_global_fps_oldtick = xge_global_fps_newtick
			xge_global_scene_fps = xge_global_fps_count
			xge_global_fps_count = 0
		Else
			xge_global_fps_count += 1
		EndIf
		' 消息处理
		Dim eve As XGE_EVENT
		Do While ScreenEvent(@eve)
			xge_global_eveproc(@eve)
			If xge_global_scene_run = FALSE Then
				Exit Do
			EndIf
		Loop
		If xge_global_scene_run Then
			' 框架处理
			If (xge_global_scene_cur.pause And XGE_PAUSE_FRAME) = 0 Then
				xge_proc_scmsg(XGE_MSG_FRAME, 0, 0)
			EndIf
			' FPS处理
			If xge_global_scene_cur.Lockfps Then
				Do While (xge_global_fps_newtick-xge_global_fps_oldtick) < ((1000/xge_global_scene_cur.Lockfps)*xge_global_fps_count)
					xge_global_dlyproc(1)
					xge_global_fps_newtick = GetTickCount()
				Loop
			EndIf
			' 绘制处理
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
	' 恢复上一个场景的数据
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
	
	
	' 启动场景
	Function XGE_EXPORT_Scene_Start(proc As XGE_SCENE_PROC, lfps As UInteger = 0, sync As Integer = FALSE, param As Integer = 0) As Integer XGE_EXPORT_ALL
		If proc Then
			' 将之前的场景压栈
			If xge_global_scene_cur.proc Then
				If xge_global_scene_stack.Push(@xge_global_scene_cur) = FALSE Then
					Return 0
				EndIf
			EndIf
			' 设置新场景数据
			xge_global_scene_cur.proc = proc
			xge_global_scene_cur.Lockfps = lfps
			xge_global_scene_cur.sync = sync
			xge_global_scene_cur.pause = 0
			' 发送资源加载消息
			xge_proc_scmsg(XGE_MSG_LOADRES, param, NULL)
			' 启动场景驱动器
			xge_global_scene_end = 0
			xge_global_scene_run = TRUE
			xge_proc_scene()
			Return xge_global_scene_end
		EndIf
	End Function
	
	' 切换场景
	Function XGE_EXPORT_Scene_Cut(proc As XGE_SCENE_PROC, lfps As UInteger, sync As Integer, param As Integer = 0) As Integer XGE_EXPORT_ALL
		If proc Then
			' 发送资源释放消息
			xge_proc_scmsg(XGE_MSG_FREERES, param, NULL)
			' 设置新场景数据
			xge_global_scene_cur.proc = proc
			xge_global_scene_cur.Lockfps = lfps
			xge_global_scene_cur.sync = sync
			xge_global_scene_cur.pause = 0
			' 发送资源加载消息
			xge_proc_scmsg(XGE_MSG_LOADRES, param, NULL)
			' 启动场景驱动器
			xge_global_scene_end = 0
			xge_global_scene_run = TRUE
			xge_proc_scene()
			Return xge_global_scene_end
		EndIf
	End Function
	
	' 结束场景
	Sub XGE_EXPORT_Scene_Stop(sc As Integer = 0) XGE_EXPORT_ALL
		' 发送资源释放消息
		xge_proc_scmsg(XGE_MSG_FREERES, sc, NULL)
		' 设置结束标记和退出代码
		xge_global_scene_end = sc
		xge_global_scene_run = FALSE
	End Sub
	
	' 结束所有场景
	Sub XGE_EXPORT_Scene_StopAll(sc As Integer = 0) XGE_EXPORT_ALL
		' 给当前场景发送资源释放消息
		xge_proc_scmsg(XGE_MSG_FREERES, sc, NULL)
		' 遍历场景发送资源释放消息
		Dim sCount As UInteger = xge_global_scene_stack.Count()
		Dim Scenes As XGE_SCENE Ptr = xge_global_scene_stack.Pop(sCount)
		If Scenes Then
			For i As Integer = 0 To sCount - 1
				xge_global_scene_cur = Scenes[i]
				xge_proc_scmsg(XGE_MSG_FREERES, sc, NULL)
			Next
		EndIf
		' 设置结束标记和退出代码
		xge_global_scene_end = sc
		xge_global_scene_run = FALSE
	End Sub
	
	' 暂停场景
	Sub XGE_EXPORT_Scene_Pause(flag As Integer = XGE_PAUSE_DRAW Or XGE_PAUSE_FRAME) XGE_EXPORT_ALL
		xge_global_scene_cur.pause = flag
	End Sub
	
	' 获取暂停状态
	Function XGE_EXPORT_Scene_State() As Integer XGE_EXPORT_ALL
		Return xge_global_scene_cur.pause
	End Function
	
	' 恢复场景
	Sub XGE_EXPORT_Scene_Resume() XGE_EXPORT_ALL
		xge_global_scene_cur.pause = 0
	End Sub
	
	' 获取场景帧率
	Function XGE_EXPORT_Scene_FPS() As UInteger XGE_EXPORT_ALL
		Return xge_global_scene_fps
	End Function
	
	' 设置场景帧率
	Sub XGE_EXPORT_Scene_SetFPS(nv As UInteger) XGE_EXPORT_ALL
		xge_global_scene_fps = nv
	End Sub
	
	' 返回场景栈对象
	Function XGE_EXPORT_Scene_Stack() As xStack Ptr XGE_EXPORT_ALL
		Return @xge_global_scene_stack
	End Function
	
	
	#Ifdef XGE_BUILD_USEOOP
			End Namespace
		End Namespace
	#EndIf
End Extern