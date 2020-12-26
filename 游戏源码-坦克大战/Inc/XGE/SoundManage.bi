'==================================================================================
	'★ Sound Manage 音频管理器
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================

#Include Once "Inc\SDK\File.bi"
#Include Once "Inc\SDK\xywhBSMM.bi"
#Include Once "Inc\SDK\bass.bi"



#Define xywh_library_xsom

#Define SoundObject UInteger



Type xge_SoundInfo
	ResID As Integer							' ResID
	sound As SoundObject					' sound 对象
	tpe As Integer								' 对象类型 0=Sample 1=Stream 2=Music
End Type



Type SoundManage Extends xywhBSMM
	' 当前选取的 Sound 和结构体指针
	InfoPtr As xge_SoundInfo Ptr
	
	
	#Ifdef xywh_library_xpkl
		Pack As xywhPack Ptr
	#EndIf
	
	' 添加一个 Sound 到管理器中
	Declare Function Add(ByVal ResID As Integer,ByVal sound As SoundObject,ByVal st As Integer) As Integer
	' 根据 ResID 获取 Sound 结构体指针
	Declare Function GetPtr(ByVal ID As Integer,ByVal tpe As Integer=0) As xge_SoundInfo Ptr
	
	
	' 载入一个 Misic 到管理器
	Declare Function LoadMusic(ByVal ID As Integer,ByVal FileName As ZString Ptr,ByVal Flag As Integer) As Integer
	Declare Function LoadMusic_Memory(ByVal ID As Integer,ByVal Memory As Any Ptr,ByVal SizeMEM As Integer,ByVal Flag As Integer) As Integer
	' 载入一个 Stream 到管理器
	Declare Function LoadStream(ByVal ID As Integer,ByVal FileName As ZString Ptr,ByVal Flag As Integer) As Integer
	Declare Function LoadStream_Memory(ByVal ID As Integer,ByVal Memory As Any Ptr,ByVal SizeMEM As Integer,ByVal Flag As Integer) As Integer
	Declare Function LoadStream_URL(ByVal ID As Integer,ByVal URL As ZString Ptr,ByVal Flag As Integer) As Integer
	' 载入一个 Sample 到管理器
	Declare Function LoadSample(ByVal ID As Integer,ByVal FileName As ZString Ptr,ByVal Flag As Integer,ByVal Max As Integer) As Integer
	Declare Function LoadSample_Memory(ByVal ID As Integer,ByVal Memory As Any Ptr,ByVal SizeMEM As Integer,ByVal Flag As Integer,ByVal Max As Integer) As Integer
	' 从 xywhPackL 中载入数据 [根据XPK设置自动选取载入类型]
	#Ifdef xywh_library_xpkl
		Declare Function LoadPack(ByVal ID As Integer,ByVal PassWord As ZString Ptr,ByVal Max As Integer,ByVal tpe As Integer=0) As Integer
		Declare Sub LoadPackAll(ByVal PassWord As ZString Ptr,ByVal Max As Integer)
	#EndIf
	
	
	' 声音控制
	Declare Sub Play(ByVal ID As Integer,ByVal tpe As Integer=0)
	Declare Sub Stop(ByVal ID As Integer,ByVal tpe As Integer=0)
	Declare Sub Pause(ByVal ID As Integer,ByVal tpe As Integer=0)
	Declare Sub Resume(ByVal ID As Integer,ByVal tpe As Integer=0)
	
	
	' 释放一个 Sound 占用的内存
	Declare Sub Free(ByVal ID As Integer,ByVal tpe As Integer=0)
	' 释放所有 Sound 并重启管理器
	Declare Sub FreeAll()
	
	' 构造类
	Declare Constructor()
End Type



Constructor SoundManage()
	StructLenght = SizeOf(xge_SoundInfo)
	MemoryStep = 100
End Constructor

Function SoundManage.GetPtr(ByVal ID As Integer,ByVal tpe As Integer) As xge_SoundInfo Ptr
	If tpe Then				' 使用 StuID
		Return GetPoint(ID)
	Else							' 使用 ResID
		Dim i As Integer
		Dim RetPtr As xge_SoundInfo Ptr
		For i = 1 To Count
			RetPtr = GetPoint(i)
			If RetPtr Then
				If RetPtr->ResID = ID Then Return RetPtr
			EndIf
		Next
	EndIf
End Function

Function SoundManage.Add(ByVal ResID As Integer,ByVal sound As SoundObject,ByVal st As Integer) As Integer
	Dim RetPtr As xge_SoundInfo Ptr = AddStruct()
	If RetPtr Then
		RetPtr->ResID = ResID
		RetPtr->sound = sound
		RetPtr->tpe = st
		Return Count
	EndIf
End Function

Function SoundManage.LoadMusic(ByVal ID As Integer,ByVal FileName As ZString Ptr,ByVal Flag As Integer) As Integer
	Dim MusicHdr As UInteger = BASS_MusicLoad(0,FileName,0,0,Flag,0)
	If MusicHdr Then
		Add(ID,MusicHdr,0)
		Return Count
	EndIf
End Function

Function SoundManage.LoadMusic_Memory(ByVal ID As Integer,ByVal Memory As Any Ptr,ByVal SizeMEM As Integer,ByVal Flag As Integer) As Integer
	Dim MusicHdr As UInteger = BASS_MusicLoad(1,Memory,0,SizeMEM,Flag,0)
	If MusicHdr Then
		Add(ID,MusicHdr,0)
		Return Count
	EndIf
End Function

Function SoundManage.LoadStream(ByVal ID As Integer,ByVal FileName As ZString Ptr,ByVal Flag As Integer) As Integer
	Dim MusicHdr As UInteger = BASS_StreamCreateFile(0,FileName,0,0,Flag)
	If MusicHdr Then
		Add(ID,MusicHdr,0)
		Return Count
	EndIf
End Function

Function SoundManage.LoadStream_Memory(ByVal ID As Integer,ByVal Memory As Any Ptr,ByVal SizeMEM As Integer,ByVal Flag As Integer) As Integer
	Dim MusicHdr As UInteger = BASS_StreamCreateFile(1,Memory,0,SizeMEM,Flag)
	If MusicHdr Then
		Add(ID,MusicHdr,0)
		Return Count
	EndIf
End Function

Function SoundManage.LoadStream_URL(ByVal ID As Integer,ByVal URL As ZString Ptr,ByVal Flag As Integer) As Integer
	Dim MusicHdr As UInteger = BASS_StreamCreateURL(URL,0,Flag,NULL,0)
	If MusicHdr Then
		Add(ID,MusicHdr,0)
		Return Count
	EndIf
End Function

Function SoundManage.LoadSample(ByVal ID As Integer,ByVal FileName As ZString Ptr,ByVal Flag As Integer,ByVal Max As Integer) As Integer
	Dim MusicHdr As UInteger = BASS_SampleLoad(0,FileName,0,0,Max,Flag)
	If MusicHdr Then
		Add(ID,MusicHdr,0)
		Return Count
	EndIf
End Function

Function SoundManage.LoadSample_Memory(ByVal ID As Integer,ByVal Memory As Any Ptr,ByVal SizeMEM As Integer,ByVal Flag As Integer,ByVal Max As Integer) As Integer
	Dim MusicHdr As UInteger = BASS_SampleLoad(TRUE,Memory,0,SizeMEM,Max,Flag)
	If MusicHdr Then
		Add(ID,MusicHdr,0)
		Return Count
	EndIf
End Function

Sub SoundManage.Play(ByVal ID As Integer,ByVal tpe As Integer=0)
	Dim RetPtr As xge_SoundInfo Ptr = GetPtr(ID,tpe)
	If RetPtr Then
		If RetPtr->tpe Then
			BASS_ChannelPlay(RetPtr->sound,1)
		Else
			Dim CH As SoundObject = BASS_SampleGetChannel(RetPtr->sound,0)
			BASS_ChannelPlay(CH,1)
		EndIf
	EndIf
End Sub

Sub SoundManage.Stop(ByVal ID As Integer,ByVal tpe As Integer=0)
	Dim RetPtr As xge_SoundInfo Ptr = GetPtr(ID,tpe)
	If RetPtr Then
		If RetPtr->tpe Then
			BASS_ChannelStop(RetPtr->sound)
		EndIf
	EndIf
End Sub

Sub SoundManage.Pause(ByVal ID As Integer,ByVal tpe As Integer=0)
	Dim RetPtr As xge_SoundInfo Ptr = GetPtr(ID,tpe)
	If RetPtr Then
		If RetPtr->tpe Then
			BASS_ChannelPause(RetPtr->sound)
		EndIf
	EndIf
End Sub

Sub SoundManage.Resume(ByVal ID As Integer,ByVal tpe As Integer=0)
	Dim RetPtr As xge_SoundInfo Ptr = GetPtr(ID,tpe)
	If RetPtr Then
		If RetPtr->tpe Then
			BASS_ChannelPlay(RetPtr->sound,0)
		EndIf
	EndIf
End Sub

Sub SoundManage.Free(ByVal ID As Integer,ByVal tpe As Integer=0)
	Dim RetPtr As xge_SoundInfo Ptr = GetPtr(ID,tpe)
	If RetPtr Then
		Select Case RetPtr->tpe
			Case 1
				BASS_StreamFree(RetPtr->sound)
			Case 2
				BASS_MusicFree(RetPtr->sound)
			Case Else
				BASS_SampleFree(RetPtr->sound)
		End Select
		RetPtr->sound = 0
		RetPtr->ResID = 0
		RetPtr->tpe = 0
	EndIf
End Sub

Sub SoundManage.FreeAll()
	Dim i As Integer
	Dim RetPtr As xge_SoundInfo Ptr
	For i = 1 To Count
		RetPtr = GetPoint(i)
		If RetPtr Then
			Select Case RetPtr->tpe
				Case 1
					BASS_StreamFree(RetPtr->sound)
				Case 2
					BASS_MusicFree(RetPtr->sound)
				Case Else
					BASS_SampleFree(RetPtr->sound)
			End Select
		EndIf
	Next
	ReInitManage()
End Sub

#Ifdef xywh_library_xpkl
	Function SoundManage.LoadPack(ByVal ID As Integer,ByVal PassWord As ZString Ptr,ByVal Max As Integer,ByVal tpe As Integer=0) As Integer
		Dim FID As UInteger = ID
		If tpe=0 Then			' 使用 ResID
			FID = Pack->Find_ExtSrt(ID)
			Pack->Find_Over()
		EndIf
		' 开始载入
		If Pack->CheckIndex(FID) Then
			Dim Flag As Integer = Pack->File_GetExtInt(FID)
			Dim RID As Integer = Pack->File_GetExtSrt(FID)
			Dim TempInt As Integer = Pack->File_GetExtByte(FID) And 48
			Dim SizeMEM As Integer = Pack->File_Size(FID)
			Dim TempMEM As Any Ptr = Allocate(SizeMEM)
			Pack->GetFileData(FID,0,0,TempMEM,PassWord,0)
			Select Case TempInt
				Case 0			' Sample
					Return LoadSample_Memory(RID,TempMEM,SizeMEM,Flag,Max)
				Case 16			' Stream
					Return LoadStream_Memory(RID,TempMEM,SizeMEM,Flag)
				Case 32			' Music
					Return LoadMusic_Memory(RID,TempMEM,SizeMEM,Flag)
				Case 48			' 无用
					Return 0
			End Select
		EndIf
	End Function
	
	Sub SoundManage.LoadPackAll(ByVal PassWord As ZString Ptr,ByVal Max As Integer)
		Dim i As Integer
		For i = 1 To Pack->Count
			Dim ExtByte As Integer = Pack->File_GetExtByte(i)
			If (ExtByte And 12) = 8 Then
				If ExtByte And 1 Then
					LoadPack(i,PassWord,Max,-1)
				EndIf
			EndIf
		Next
	End Sub
#EndIf
