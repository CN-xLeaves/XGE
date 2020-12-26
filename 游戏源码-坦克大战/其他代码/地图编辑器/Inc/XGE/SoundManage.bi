'==================================================================================
	'★ Sound Manage 音频管理器
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================

#Include Once "Inc\SDK\File.bi"
#Include Once "Inc\SDK\xywhBSMM.bi"
#Include Once "Inc\SDK\bass.bi"



#Define xywh_library_somg

#Define SoundObject UInteger



Type xge_SoundInfo
	ResID As Integer							' 图像ID
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
	Declare Function Add(ByVal ID As Integer,ByVal sound As SoundObject,ByVal tpe As Integer) As xge_SoundInfo Ptr
	
	
	' 根据 ResID 获取 StuID
	Declare Function GetSID(ByVal ID As Integer) As Integer
	' 根据 ResID 获取 Sound 结构体指针
	Declare Function GetPtr(ByVal ID As Integer) As xge_SoundInfo Ptr
	
	
	' 载入一个 Misic 到管理器
	Declare Function LoadMusic(ByVal ID As Integer,ByVal FileName As ZString Ptr,ByVal Flag As Integer) As SoundObject
	Declare Function LoadMusic_Memory(ByVal ID As Integer,ByVal Memory As Any Ptr,ByVal SizeMEM As Integer,ByVal Flag As Integer) As SoundObject
	' 载入一个 Stream 到管理器
	Declare Function LoadStream(ByVal ID As Integer,ByVal FileName As ZString Ptr,ByVal Flag As Integer) As SoundObject
	Declare Function LoadStream_Memory(ByVal ID As Integer,ByVal Memory As Any Ptr,ByVal SizeMEM As Integer,ByVal Flag As Integer) As SoundObject
	Declare Function LoadStream_URL(ByVal ID As Integer,ByVal URL As ZString Ptr,ByVal Flag As Integer) As SoundObject
	' 载入一个 Sample 到管理器
	Declare Function LoadSample(ByVal ID As Integer,ByVal FileName As ZString Ptr,ByVal Flag As Integer,ByVal Max As Integer) As SoundObject
	Declare Function LoadSample_Memory(ByVal ID As Integer,ByVal Memory As Any Ptr,ByVal SizeMEM As Integer,ByVal Flag As Integer,ByVal Max As Integer) As SoundObject
	' 从 xywhPackL 中载入数据 [根据XPK设置自动选取载入类型]
	#Ifdef xywh_library_xpkl
		Declare Function LoadPack_SID(ByVal SID As UInteger,ByVal PassWord As ZString Ptr,ByVal Max As Integer) As SoundObject
		Declare Function LoadPack(ByVal Index As Integer,ByVal PassWord As ZString Ptr,ByVal Max As Integer) As SoundObject
		Declare Sub LoadPackAll(ByVal PassWord As ZString Ptr,ByVal Max As Integer)
	#EndIf
	
	
	' 声音控制
	Declare Sub Play(ByVal ID As Integer)
	Declare Sub Stop(ByVal ID As Integer)
	Declare Sub Pause(ByVal ID As Integer)
	Declare Sub Resume(ByVal ID As Integer)
	
	
	' 释放一个 Sound 占用的内存
	Declare Sub Free(ByVal ID As Integer)
	' 释放所有 Sound 并重启管理器
	Declare Sub FreeAll()
	
	' 构造类
	Declare Constructor()
End Type



Constructor SoundManage()
	StructLenght = SizeOf(xge_SoundInfo)
	MemoryStep = 100
End Constructor

Function SoundManage.GetSID(ByVal ID As Integer) As Integer
	Dim i As Integer
	Dim RetPtr As xge_SoundInfo Ptr
	For i = 1 To Count
		RetPtr = GetPoint(i)
		If RetPtr Then
			If RetPtr->ResID = ID Then Return i
		EndIf
	Next
End Function

Function SoundManage.GetPtr(ByVal ID As Integer) As xge_SoundInfo Ptr
	Dim i As Integer
	Dim RetPtr As xge_SoundInfo Ptr
	For i = 1 To Count
		RetPtr = GetPoint(i)
		If RetPtr Then
			If RetPtr->ResID = ID Then Return RetPtr
		EndIf
	Next
End Function

Function SoundManage.Add(ByVal ID As Integer,ByVal sound As SoundObject,ByVal tpe As Integer) As xge_SoundInfo Ptr
	Dim RetPtr As xge_SoundInfo Ptr = AddStruct()
	If RetPtr Then
		RetPtr->ResID = ID
		RetPtr->sound = sound
		RetPtr->tpe = tpe
		Return RetPtr
	EndIf
End Function

Function SoundManage.LoadMusic(ByVal ID As Integer,ByVal FileName As ZString Ptr,ByVal Flag As Integer) As SoundObject
	Dim MusicHdr As UInteger = BASS_MusicLoad(0,FileName,0,0,Flag,0)
	If MusicHdr Then
		Add(ID,MusicHdr,2)
		Return MusicHdr
	EndIf
End Function

Function SoundManage.LoadMusic_Memory(ByVal ID As Integer,ByVal Memory As Any Ptr,ByVal SizeMEM As Integer,ByVal Flag As Integer) As SoundObject
	Dim MusicHdr As UInteger = BASS_MusicLoad(1,Memory,0,SizeMEM,Flag,0)
	If MusicHdr Then
		Add(ID,MusicHdr,2)
		Return MusicHdr
	EndIf
End Function

Function SoundManage.LoadStream(ByVal ID As Integer,ByVal FileName As ZString Ptr,ByVal Flag As Integer) As SoundObject
	Dim MusicHdr As UInteger = BASS_StreamCreateFile(0,FileName,0,0,Flag)
	If MusicHdr Then
		Add(ID,MusicHdr,1)
		Return MusicHdr
	EndIf
End Function

Function SoundManage.LoadStream_Memory(ByVal ID As Integer,ByVal Memory As Any Ptr,ByVal SizeMEM As Integer,ByVal Flag As Integer) As SoundObject
	Dim MusicHdr As UInteger = BASS_StreamCreateFile(1,Memory,0,SizeMEM,Flag)
	If MusicHdr Then
		Add(ID,MusicHdr,1)
		Return MusicHdr
	EndIf
End Function

Function SoundManage.LoadStream_URL(ByVal ID As Integer,ByVal URL As ZString Ptr,ByVal Flag As Integer) As SoundObject
	Dim MusicHdr As UInteger = BASS_StreamCreateURL(URL,0,Flag,NULL,0)
	If MusicHdr Then
		Add(ID,MusicHdr,1)
		Return MusicHdr
	EndIf
End Function

Function SoundManage.LoadSample(ByVal ID As Integer,ByVal FileName As ZString Ptr,ByVal Flag As Integer,ByVal Max As Integer) As SoundObject
	Dim MusicHdr As UInteger = BASS_SampleLoad(0,FileName,0,0,Max,Flag)
	If MusicHdr Then
		Add(ID,MusicHdr,0)
		Return MusicHdr
	EndIf
End Function

Function SoundManage.LoadSample_Memory(ByVal ID As Integer,ByVal Memory As Any Ptr,ByVal SizeMEM As Integer,ByVal Flag As Integer,ByVal Max As Integer) As SoundObject
	Dim MusicHdr As UInteger = BASS_SampleLoad(1,Memory,0,SizeMEM,Max,Flag)
	If MusicHdr Then
		Add(ID,MusicHdr,0)
		Return MusicHdr
	EndIf
End Function

Sub SoundManage.Play(ByVal ID As Integer)
	Dim RetPtr As xge_SoundInfo Ptr = GetPtr(ID)
	If RetPtr Then
		If RetPtr->tpe Then
			BASS_ChannelPlay(RetPtr->sound,1)
		Else
			Dim CH As SoundObject = BASS_SampleGetChannel(RetPtr->sound,0)
			BASS_ChannelPlay(CH,1)
		EndIf
	EndIf
End Sub

Sub SoundManage.Stop(ByVal ID As Integer)
	Dim RetPtr As xge_SoundInfo Ptr = GetPtr(ID)
	If RetPtr Then
		If RetPtr->tpe Then
			BASS_ChannelStop(RetPtr->sound)
		EndIf
	EndIf
End Sub

Sub SoundManage.Pause(ByVal ID As Integer)
	Dim RetPtr As xge_SoundInfo Ptr = GetPtr(ID)
	If RetPtr Then
		If RetPtr->tpe Then
			BASS_ChannelPause(RetPtr->sound)
		EndIf
	EndIf
End Sub

Sub SoundManage.Resume(ByVal ID As Integer)
	Dim RetPtr As xge_SoundInfo Ptr = GetPtr(ID)
	If RetPtr Then
		If RetPtr->tpe Then
			BASS_ChannelPlay(RetPtr->sound,0)
		EndIf
	EndIf
End Sub

Sub SoundManage.Free(ByVal ID As Integer)
	Dim StuID As Integer = GetSID(ID)
	Dim RetPtr As xge_SoundInfo Ptr = GetPoint(StuID)
	If RetPtr Then
		Select Case RetPtr->tpe
			Case 1
				BASS_StreamFree(RetPtr->sound)
			Case 2
				BASS_MusicFree(RetPtr->sound)
			Case Else
				BASS_SampleFree(RetPtr->sound)
		End Select
		DelStruct(StuID)
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
	Function SoundManage.LoadPack_SID(ByVal SID As UInteger,ByVal PassWord As ZString Ptr,ByVal Max As Integer) As SoundObject
		If Pack->CheckIndex(SID) Then
			Dim Flag As Integer = Pack->File_GetExtInt(SID)
			Dim id As Integer = Pack->File_GetExtSrt(SID)
			Dim TempInt As Integer = Pack->File_GetExtByte(SID) And 48
			Dim SizeMEM As Integer = Pack->File_Size(SID)
			Print SizeMEM
			Dim TempMEM As Any Ptr = Allocate(SizeMEM)
			Pack->GetFileData(SID,0,0,TempMEM,PassWord,0)
			Select Case TempInt
				Case 0			' Sample
					Return LoadSample_Memory(id,TempMEM,SizeMEM,Flag,Max)
				Case 16			' Stream
					Return LoadStream_Memory(id,TempMEM,SizeMEM,Flag)
				Case 32			' Music
					Return LoadMusic_Memory(id,TempMEM,SizeMEM,Flag)
				Case 48			' 无用
					Return 0
			End Select
		EndIf
	End Function
	
	Function SoundManage.LoadPack(ByVal Index As Integer,ByVal PassWord As ZString Ptr,ByVal Max As Integer) As SoundObject
		Dim SID As Integer = Pack->Find_ExtSrt(Index)
		Pack->Find_Over()
		If SID Then
			Return LoadPack_SID(SID,PassWord,Max)
		EndIf
	End Function
	
	Sub SoundManage.LoadPackAll(ByVal PassWord As ZString Ptr,ByVal Max As Integer)
		Dim i As Integer
		For i = 1 To Pack->Count
			Dim ExtByte As Integer = Pack->File_GetExtByte(i)
			If (ExtByte And 12) = 8 Then
				If ExtByte And 1 Then
					LoadPack_SID(i,PassWord,Max)
				EndIf
			EndIf
		Next
	End Sub
#EndIf
