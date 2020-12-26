'==================================================================================
	'★ Surface Manage 图像管理器
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================

#Include Once "Inc\SDK\File.bi"
#Include Once "Inc\SDK\xywhBSMM.bi"



#Define xywh_library_xsfm



Type xge_SurfaceInfo
	ResID As Integer							' 图像ID
	sf As Surface									' Surface 指针
	BitMap As Any Ptr							' 数据指针
	MemSize As Integer						' 数据尺寸
End Type



Type SurfaceManage Extends xywhBSMM
	' 当前选取的 Surface 和结构体指针
	SelImg As Surface
	SelPtr As xge_SurfaceInfo Ptr
	
	
	#Ifdef xywh_library_xpkl
		Pack As xywhPack Ptr
	#EndIf
	
	
	' 添加一个 Surface 到管理器中
	Declare Function Add(ByVal ResID As Integer,ByVal sf As Surface) As Integer
	' 获取 Surface
	Declare Function Get(ByVal ID As Integer,ByVal tpe As Integer=0) As Surface
	' 获取 SurfaceInfo 结构体指针
	Declare Function GetPtr(ByVal ID As Integer,ByVal tpe As Integer=0) As xge_SurfaceInfo Ptr
	' 选取一个 Surface
	Declare Function Sel(ByVal ID As Integer,ByVal tpe As Integer=0) As Integer
	' 释放一个 Surface 占用的内存
	Declare Sub Free(ByVal ID As Integer,ByVal tpe As Integer=0)
	' 释放所有 Surface 并重启管理器
	Declare Sub FreeAll()
	
	
	' 创建一个新的 Surface
	Declare Function Create(ByVal ResID As Integer,ByVal w As Integer,ByVal h As Integer) As Integer
	' 载入一个 BMP 文件到管理器
	Declare Function LoadFile(ByVal ResID As Integer,ByVal FileName As ZString Ptr) As Integer
	' 载入一个 RAW 文件到管理器 [从xywhPackL中载入]
	#Ifdef xywh_library_xpkl
		Declare Function LoadPack(ByVal ID As Integer,ByVal PassWord As ZString Ptr,ByVal tpe As Integer=0) As Integer
		Declare Sub LoadPackAll(ByVal PassWord As ZString Ptr)
	#EndIf
	
	
	' 构造类
	Declare Constructor()
End Type



Constructor SurfaceManage()
	StructLenght = SizeOf(xge_SurfaceInfo)
	MemoryStep = 50
End Constructor

Function SurfaceManage.Add(ByVal ResID As Integer,ByVal sf As Surface) As Integer
	Dim RetPtr As xge_SurfaceInfo Ptr = AddStruct()
	If RetPtr Then
		RetPtr->ResID = ResID
		RetPtr->sf = sf
		ImageInfo(sf,,,,,RetPtr->BitMap,RetPtr->MemSize)
		Return Count
	EndIf
End Function

Function SurfaceManage.GetPtr(ByVal ID As Integer,ByVal tpe As Integer=0) As xge_SurfaceInfo Ptr
	If tpe Then				' 使用 StuID
		Return GetPoint(ID)
	Else							' 使用 ResID
		Dim i As Integer
		Dim RetPtr As xge_SurfaceInfo Ptr
		For i = 1 To Count
			RetPtr = GetPoint(i)
			If RetPtr Then
				If RetPtr->ResID = ID Then Return RetPtr
			EndIf
		Next
	EndIf
End Function

Function SurfaceManage.Get(ByVal ID As Integer,ByVal tpe As Integer=0) As Surface
	Dim RetPtr As xge_SurfaceInfo Ptr = GetPtr(ID,tpe)
	If RetPtr Then
		Return RetPtr->sf
	EndIf
End Function

Function SurfaceManage.Sel(ByVal ID As Integer,ByVal tpe As Integer=0) As Integer
	Dim RetPtr As xge_SurfaceInfo Ptr = GetPtr(ID,tpe)
	If RetPtr Then
		SelPtr = RetPtr
		SelImg = RetPtr->sf
		Return -1
	EndIf
End Function

Sub SurfaceManage.Free(ByVal ID As Integer,ByVal tpe As Integer=0)
	Dim RetPtr As xge_SurfaceInfo Ptr = GetPtr(ID,tpe)
	If RetPtr Then
		If RetPtr->sf Then
			ImageDestroy(RetPtr->sf)
			RetPtr->sf = NULL
			RetPtr->ResID = 0
			RetPtr->BitMap = 0
			RetPtr->MemSize = 0
		EndIf
	EndIf
End Sub

Sub SurfaceManage.FreeAll()
	Dim i As Integer
	Dim RetPtr As xge_SurfaceInfo Ptr
	For i = 1 To Count
		RetPtr = GetPoint(i)
		If RetPtr Then
			If RetPtr->sf Then
				ImageDestroy(RetPtr->sf)
			EndIf
		EndIf
	Next
	ReInitManage()
End Sub

Function SurfaceManage.Create(ByVal ResID As Integer,ByVal w As Integer,ByVal h As Integer) As Integer
	Dim TempSurface As Surface = ImageCreate(w,h)
	If TempSurface Then
		Dim RetInt As Integer = Add(ResID,TempSurface)
		If RetInt Then
			Return RetInt
		Else
			ImageDestroy(TempSurface)
		EndIf
	EndIf
End Function

Function SurfaceManage.LoadFile(ByVal ResID As Integer,ByVal FileName As ZString Ptr) As Integer
	Dim TempSurface As Surface
	If Right(*FileName,3) = "bmp" Then
		TempSurface = xge.LoadBMP(FileName)
	Else
		TempSurface = xge.LoadGDI(FileName)
	EndIf
	If TempSurface Then
		Dim RetInt As Integer = Add(ResID,TempSurface)
		If RetInt Then
			Return RetInt
		Else
			ImageDestroy(TempSurface)
		EndIf
	EndIf
End Function

#Ifdef xywh_library_xpkl
	Function SurfaceManage.LoadPack(ByVal ID As Integer,ByVal PassWord As ZString Ptr,ByVal tpe As Integer=0) As Integer
		Dim RID As Integer
		Dim TSF As Surface
		If tpe Then				' 使用 StuID
			If Pack->CheckIndex(ID) Then
				RID = Pack->File_GetExtSrt(ID)
				TSF = xge.LoadXPK(Pack,ID,PassWord)
				If TSF Then
					Return Add(RID,TSF)
				EndIf
			EndIf
		Else							' 使用 ResID
			RID = Pack->Find_ExtSrt(ID)
			Pack->Find_Over()
			If RID Then
				TSF = xge.LoadXPK(Pack,RID,PassWord)
				If TSF Then
					Return Add(ID,TSF)
				EndIf
			EndIf
		EndIf
	End Function
	
	Sub SurfaceManage.LoadPackAll(ByVal PassWord As ZString Ptr)
		Dim i As Integer
		For i = 1 To Pack->Count
			Dim ExtByte As Integer = Pack->File_GetExtByte(i)
			If (ExtByte And 12) = 4 Then
				If ExtByte And 1 Then
					LoadPack(i,PassWord,-1)
				EndIf
			EndIf
		Next
	End Sub
#EndIf