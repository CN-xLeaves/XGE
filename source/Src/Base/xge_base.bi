'==================================================================================
	'★ xywh Game Engine 核心框架
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



Declare Sub InitRes_XUI()
Declare Sub UnitRes_XUI()



Extern XGE_EXTERNMODULE
	#Ifdef XGE_BUILD_USEOOP
		Namespace xge
	#EndIf
	
	
	' 初始化 XGE 游戏引擎
	Function XGE_EXPORT_InitA(w As UInteger, h As UInteger, init_gfx As Integer = XGE_INIT_WINDOW, title As ZString Ptr = NULL) As Integer XGE_EXPORT_ALL
		If XGE_EXPORT_SetScreen(w, h, init_gfx) Then
			If title Then
				WindowTitle(*title)
			EndIf
			' 初始化 XUI 资源
			InitRes_XUI()
			' 初始化 BASS 模块
			If xge_global_bass_init = FALSE Then
				xge_global_bass_init = TRUE
				If HiWord(BASS_GetVersion()) = BASSVERSION Then
					If BASS_Init(-1, XGE_SOUND_BPS, XGE_SOUND_FLAG, XGE_PROC_hWnd, NULL) = 0 Then
						Return FALSE
					EndIf
				Else
					Return FALSE
				EndIf
			EndIf
			' 初始化 GDI/GDI+
			If xge_global_gdi_init = FALSE Then
				xge_global_gdi_init = TRUE
				xge_global_gdi_gsi.GdiplusVersion = 1
				If GdiPlus.GdiplusStartup(@xge_global_gdi_token, @xge_global_gdi_gsi, NULL) <> GdiPlus.OK Then
					Return FALSE
				EndIf
			EndIf
			Return TRUE
		EndIf
	End Function
	Function XGE_EXPORT_InitW(w As UInteger, h As UInteger, init_gfx As Integer = XGE_INIT_WINDOW, title As WString Ptr = NULL) As Integer XGE_EXPORT_ALL
		Dim st As ZString Ptr = UnicodeToAsci(title)
		Function = XGE_EXPORT_InitA(w, h, init_gfx, st)
		DeAllocate(st)
	End Function
	
	' 终止 XGE 游戏引擎
	Sub XGE_EXPORT_Unit() XGE_EXPORT_ALL
		Screen(0)
		' 重置数据
		xge_global_width = 0
		xge_global_height = 0
		xge_global_scrptr = NULL
		xge_global_scrsize = 0
		xge_global_scrpitch = 0
		' 卸载 XUI 资源
		UnitRes_XUI()
	End Sub
	
	' 调整分辨率
	Function XGE_EXPORT_SetScreen(w As UInteger, h As UInteger, init_gfx As Integer = XGE_INIT_WINDOW) As Integer XGE_EXPORT_ALL
		If ScreenRes(w, h, 32, 1, init_gfx) Then
			Return FALSE
		Else
			xge_global_width = w
			xge_global_height = h
			xge_global_scrptr = ScreenPtr
			xge_global_scrsize = w * h * 4
			xge_global_scrpitch = w * 4
			' 重新排版UI
			If xge_global_scene_cur.proc Then
				xge_global_scene_cur.RootElement->Layout.Rect.x = 0
				xge_global_scene_cur.RootElement->Layout.Rect.y = 0
				xge_global_scene_cur.RootElement->Layout.Rect.w = w
				xge_global_scene_cur.RootElement->Layout.Rect.h = h
				xge_global_scene_cur.RootElement->LayoutApply()
			EndIf
			' 设置窗口图标
			Dim hIcon As HICON = LoadIcon(hInst, Cast(Any Ptr, 100))
			Dim hWin As HANDLE = XGE_EXPORT_hWnd()
			SendMessage(hWin, WM_SETICON, ICON_BIG, Cast(Integer, hIcon))
			SendMessage(hWin, WM_SETICON, ICON_SMALL, Cast(Integer, hIcon))
			Return TRUE
		EndIf
	End Function
	
	' 获取窗口句柄
	Function XGE_EXPORT_hWnd() As HANDLE XGE_EXPORT_ALL
		Dim hWin As HANDLE
		ScreenControl(GET_WINDOW_HANDLE, Cast(Integer, hWin))
		Return hWin
	End Function
	
	' 清屏
	Sub XGE_EXPORT_Clear() XGE_EXPORT_ALL
		If xge_global_scrptr Then
			memset(xge_global_scrptr, 0, xge_global_scrsize)
		EndIf
	End Sub
	
	' 锁定画面
	Sub XGE_EXPORT_Lock() XGE_EXPORT_ALL
		ScreenLock()
	End Sub
	
	' 解锁画面
	Sub XGE_EXPORT_UnLock() XGE_EXPORT_ALL
		ScreenUnLock()
	End Sub
	
	' 等待垂直同步
	Sub XGE_EXPORT_Sync() XGE_EXPORT_ALL
		ScreenSync()
	End Sub
	
	' 获取屏幕宽度
	Function XGE_EXPORT_Width() As UInteger XGE_EXPORT_ALL
		Return xge_global_width
	End Function
	
	' 获取屏幕高度
	Function XGE_EXPORT_Height() As UInteger XGE_EXPORT_ALL
		Return xge_global_height
	End Function
	
	' 获取像素数据指针
	Function XGE_EXPORT_PixAddr() As Any Ptr XGE_EXPORT_ALL
		Return xge_global_scrptr
	End Function
	
	' 获取像素数据大小
	Function XGE_EXPORT_PixSize() As UInteger XGE_EXPORT_ALL
		Return xge_global_scrsize
	End Function
	
	' 获取扫描行数据大小
	Function XGE_EXPORT_Pitch() As UInteger XGE_EXPORT_ALL
		Return xge_global_scrpitch
	End Function
	
	' 设置音量
	Sub XGE_EXPORT_SetSoundVol(tpe As Integer, vol As Integer) XGE_EXPORT_ALL
		Select Case tpe
			Case xge_sound_sample
				BASS_SetConfig(BASS_CONFIG_GVOL_SAMPLE, vol)
			Case xge_sound_music
				BASS_SetConfig(BASS_CONFIG_GVOL_MUSIC, vol)
			Case xge_sound_stream
				BASS_SetConfig(BASS_CONFIG_GVOL_STREAM, vol)
			Case Else
				BASS_SetVolume(vol / 10000)
		End Select
	End Sub
	
	' 获取音量
	Function XGE_EXPORT_GetSoundVol(tpe As Integer) As Integer XGE_EXPORT_ALL
		Select Case tpe
			Case xge_sound_sample
				Return BASS_GetConfig(BASS_CONFIG_GVOL_SAMPLE)
			Case xge_sound_music
				Return BASS_GetConfig(BASS_CONFIG_GVOL_MUSIC)
			Case xge_sound_stream
				Return BASS_GetConfig(BASS_CONFIG_GVOL_STREAM )
			Case Else
				Return BASS_GetVolume() * 10000
		End Select
	End Function
	
	
	#Ifdef XGE_BUILD_USEOOP
		End Namespace
	#EndIf
End Extern