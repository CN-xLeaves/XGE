'==================================================================================
	'�� xywh Game Engine ���Ŀ��
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================



Extern XGE_EXTERNMODULE
	#Ifdef XGE_BUILD_USEOOP
		Namespace xge
	#EndIf
	
	
	' ��ʼ�� XGE ��Ϸ����
	Function XGE_EXPORT_Init(w As UInteger, h As UInteger, init_gfx As Integer = XGE_INIT_WINDOW, init_mod As Integer = XGE_INIT_ALL, title As ZString Ptr = NULL) As Integer XGE_EXPORT_ALL
		If XGE_EXPORT_SetScreen(w, h, init_gfx) Then
			If title Then
				WindowTitle(*title)
			EndIf
			' ��ʼ�� BASS ģ��
			If init_mod And XGE_INIT_BASS Then
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
			EndIf
			' ��ʼ�� GDI/GDI+
			If init_mod And XGE_INIT_GDI Then
				If xge_global_gdi_init = FALSE Then
					xge_global_gdi_init = TRUE
					xge_global_gdi_gsi.GdiplusVersion = 1
					If GdiPlus.GdiplusStartup(@xge_global_gdi_token, @xge_global_gdi_gsi, NULL) <> GdiPlus.OK Then
						Return FALSE
					EndIf
				EndIf
			EndIf
			Return TRUE
		EndIf
	End Function
	
	' ��ֹ XGE ��Ϸ����
	Sub XGE_EXPORT_Unit() XGE_EXPORT_ALL
		Screen(0)
		' ��������
		xge_global_width = 0
		xge_global_height = 0
		xge_global_scrptr = NULL
		xge_global_scrsize = 0
		xge_global_scrpitch = 0
	End Sub
	
	' �����ֱ���
	Function XGE_EXPORT_SetScreen(w As UInteger, h As UInteger, init_gfx As Integer = XGE_INIT_WINDOW) As Integer XGE_EXPORT_ALL
		If ScreenRes(w, h, 32, 1, init_gfx) Then
			Return FALSE
		Else
			xge_global_width = w
			xge_global_height = h
			xge_global_scrptr = ScreenPtr
			xge_global_scrsize = w * h * 4
			xge_global_scrpitch = w * 4
			' ��ʼ�� XUI ����
			If xge_xui_element_root = NULL Then
				xge_xui_element_root = New xui.Element(XUI_LAYOUT_RULER_PIXEL, 0, 0, w, h, XUI_LAYOUT_COORD, "xui_Desktop")
			EndIf
			xge_xui_element_root->Layout.Rect.x = 0
			xge_xui_element_root->Layout.Rect.y = 0
			xge_xui_element_root->Layout.Rect.w = w
			xge_xui_element_root->Layout.Rect.h = h
			Return TRUE
		EndIf
	End Function
	
	' ��ȡ���ھ��
	Function XGE_EXPORT_hWnd() As HANDLE XGE_EXPORT_ALL
		Dim hWin As HANDLE
		ScreenControl(GET_WINDOW_HANDLE,Cast(Integer,hWin))
		Return hWin
	End Function
	
	' ����
	Sub XGE_EXPORT_Clear() XGE_EXPORT_ALL
		If xge_global_scrptr Then
			memset(xge_global_scrptr, 0, xge_global_scrsize)
		EndIf
	End Sub
	
	' ��������
	Sub XGE_EXPORT_Lock() XGE_EXPORT_ALL
		ScreenLock()
	End Sub
	
	' ��������
	Sub XGE_EXPORT_UnLock() XGE_EXPORT_ALL
		ScreenUnLock()
	End Sub
	
	' �ȴ���ֱͬ��
	Sub XGE_EXPORT_Sync() XGE_EXPORT_ALL
		ScreenSync()
	End Sub
	
	' ��ȡ��Ļ���
	Function XGE_EXPORT_Width() As UInteger XGE_EXPORT_ALL
		Return xge_global_width
	End Function
	
	' ��ȡ��Ļ�߶�
	Function XGE_EXPORT_Height() As UInteger XGE_EXPORT_ALL
		Return xge_global_height
	End Function
	
	' ��ȡ��������ָ��
	Function XGE_EXPORT_PixAddr() As Any Ptr XGE_EXPORT_ALL
		Return xge_global_scrptr
	End Function
	
	' ��ȡ�������ݴ�С
	Function XGE_EXPORT_PixSize() As UInteger XGE_EXPORT_ALL
		Return xge_global_scrsize
	End Function
	
	' ��ȡɨ�������ݴ�С
	Function XGE_EXPORT_Pitch() As UInteger XGE_EXPORT_ALL
		Return xge_global_scrpitch
	End Function
	
	' ��ȡͼ������
	Function XGE_EXPORT_Driver() As ZString Ptr XGE_EXPORT_ALL
		DeAllocate(xywh_library_auto_memory)
		xywh_library_auto_memory = Allocate(32)
		Dim d As String
		ScreenInfo( , , , , , , d)
		*Cast(ZString Ptr, xywh_library_auto_memory) = d
		Return xywh_library_auto_memory
	End Function
	
	' ��������
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
	
	' ��ȡ����
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