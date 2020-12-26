'==================================================================================
	'★ xywh Game Engine 声音类模块
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



Extern XGE_EXTERNCLASS
	'#Ifdef XGE_BUILD_USEOOP
		Namespace xge
	'#EndIf
	
	
	
	' 构造 [空]
	Constructor Sound() XGE_EXPORT_OBJ
		
	End Constructor
	
	' 构造 [加载]
	Constructor Sound(tpe As Integer, flag As Integer, addr As ZString Ptr, size As UInteger = 0, max As Integer = 65535) XGE_EXPORT_OBJ
		Load(tpe, flag, addr, size, max)
	End Constructor
	
	' 析构
	Destructor Sound() XGE_EXPORT_OBJ
		Free()
	End Destructor
	
	' 载入声音
	Function Sound.Load(tpe As Integer, flag As Integer, addr As ZString Ptr, size As UInteger = 0, max As Integer = 65535) As Integer XGE_EXPORT_OBJ
		Free()
		Select Case tpe
			Case XGE_SOUND_SAMPLE
				If size Then
					SoundObj = BASS_SampleLoad(TRUE, addr, 0, size, max, flag)
				Else
					SoundObj = BASS_SampleLoad(FALSE, addr, 0, 0, max, flag)
				EndIf
			Case XGE_SOUND_MUSIC
				If size Then
					SoundObj = BASS_MusicLoad(TRUE, addr, 0, size, flag, 0)
				Else
					SoundObj = BASS_MusicLoad(FALSE, addr, 0, 0, flag, 0)
				EndIf
			Case XGE_SOUND_STREAM
				If flag And XGE_SUD_STE_URL Then
					SoundObj = BASS_StreamCreateURL(addr, 0, flag And Not(XGE_SUD_STE_URL), NULL, 0)
				Else
					If size Then
						SoundObj = BASS_StreamCreateFile(TRUE, addr, 0, size, flag)
					Else
						SoundObj = BASS_StreamCreateFile(FALSE, addr, 0, 0, flag)
					EndIf
				EndIf
		End Select
		If SoundObj Then
			pTpe = tpe
			Return TRUE
		EndIf
	End Function
	
	' 释放声音
	Sub Sound.Free() XGE_EXPORT_OBJ
		If SoundObj Then
			Select Case pTpe
				Case XGE_SOUND_SAMPLE
					BASS_SampleFree(SoundObj)
				Case XGE_SOUND_MUSIC
					BASS_MusicFree(SoundObj)
				Case XGE_SOUND_STREAM
					BASS_StreamFree(SoundObj)
			End Select
			SoundObj = 0
			pTpe = 0
		EndIf
	End Sub
	
	' 声音类型
	Function Sound.GetType() As Integer XGE_EXPORT_OBJ
		Return pTpe
	End Function
	
	' 声音控制
	Sub Sound.Play() XGE_EXPORT_OBJ
		Dim TempObj As UInteger = SoundObj
		If pTpe = XGE_SOUND_SAMPLE Then
			TempObj = BASS_SampleGetChannel(SoundObj,0)
		EndIf
		BASS_ChannelPlay(TempObj, 1)
	End Sub
	Sub Sound.Stop() XGE_EXPORT_OBJ
		If pTpe <> XGE_SOUND_SAMPLE Then
			BASS_ChannelStop(SoundObj)
		EndIf
	End Sub
	Sub Sound.Pause() XGE_EXPORT_OBJ
		If pTpe <> XGE_SOUND_SAMPLE Then
			BASS_ChannelPause(SoundObj)
		EndIf
	End Sub
	Sub Sound.Resume() XGE_EXPORT_OBJ
		If pTpe <> XGE_SOUND_SAMPLE Then
			BASS_ChannelPlay(SoundObj,0)
		EndIf
	End Sub
	
	
	'#Ifdef XGE_BUILD_USEOOP
		End Namespace
	'#EndIf
End Extern