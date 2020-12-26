'==================================================================================
	'★ Surface Manage 图像管理器
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================

#Include Once "Inc\SDK\File.bi"
#Include Once "Inc\SDK\xywhBSMM.bi"



#Define xywh_library_sfmg



Type xge_SurfaceInfo
	ResID As Integer							' 图像ID
	sf As Surface									' Surface 指针
	BitMap As Any Ptr							' 数据指针
	MemSize As Integer						' 数据尺寸
End Type



Type SurfaceManage Extends xywhBSMM
	' 当前选取的 Surface 和结构体指针
	sf As Surface
	InfoPtr As xge_SurfaceInfo Ptr
	
	
	#Ifdef xywh_library_xpkl
		Pack As xywhPack Ptr
	#EndIf
	
	
	' 添加一个 Surface 到管理器中
	Declare Function Add(ByVal ID As Integer,ByVal Surface As Surface) As xge_SurfaceInfo Ptr
	
	
	' 根据 ResID 获取 StuID
	Declare Function GetSID(ByVal ID As Integer) As Integer
	' 根据 ResID 获取 Surface 结构体指针
	Declare Function GetPtr(ByVal ID As Integer) As xge_SurfaceInfo Ptr
	' 根据 ResID 选取一个 Surface
	Declare Function SelSurface(ByVal ID As Integer) As Integer
	' 根据 ResID 获取 Surface
	Declare Function Get(ByVal ID As Integer) As Surface
	
	
	' 载入一个 BMP 文件到管理器
	Declare Function LoadFile(ByVal ID As Integer,ByVal FileName As ZString Ptr) As Surface
	' 创建一个新的 Surface
	Declare Function Create(ByVal ID As Integer,ByVal w As Integer,ByVal h As Integer) As Surface
	' 载入一个 RAW 文件到管理器 [从xywhPackL中载入]
	#Ifdef xywh_library_xpkl
		Declare Function LoadPack_SID(ByVal SID As Integer,ByVal PassWord As ZString Ptr) As Surface
		Declare Function LoadPack(ByVal Index As Integer,ByVal PassWord As ZString Ptr) As Surface
		Declare Sub LoadPackAll(ByVal PassWord As ZString Ptr)
	#EndIf
	
	
	' 创建一个 Surface 的灰度图像
	Declare Function Gray(ByVal ID As Integer,ByVal NewID As Integer) As Surface
	' 创建一个 Surface 的翻转图像 [Flag : 1=纵向 , 2=横向]
	Declare Function Flip(ByVal ID As Integer,ByVal NewID As Integer,ByVal Flag As Integer) As Surface
	
	
	' 释放一个 Surface 占用的内存
	Declare Sub Free(ByVal ID As Integer)
	' 释放所有 Surface 并重启管理器
	Declare Sub FreeAll()
	
	
	' 构造类
	Declare Constructor()
End Type



Constructor SurfaceManage()
	StructLenght = SizeOf(xge_SurfaceInfo)
	MemoryStep = 100
End Constructor

Function SurfaceManage.GetSID(ByVal ID As Integer) As Integer
	Dim i As Integer
	Dim RetPtr As xge_SurfaceInfo Ptr
	For i = 1 To Count
		RetPtr = GetPoint(i)
		If RetPtr Then
			If RetPtr->ResID = ID Then Return i
		EndIf
	Next
End Function

Function SurfaceManage.GetPtr(ByVal ID As Integer) As xge_SurfaceInfo Ptr
	Dim i As Integer
	Dim RetPtr As xge_SurfaceInfo Ptr
	For i = 1 To Count
		RetPtr = GetPoint(i)
		If RetPtr Then
			If RetPtr->ResID = ID Then Return RetPtr
		EndIf
	Next
End Function

Function SurfaceManage.SelSurface(ByVal ID As Integer) As Integer
	InfoPtr = GetPtr(ID)
	If InfoPtr Then
		sf = InfoPtr->sf
		Return -1
	Else
		sf = NULL
	EndIf
End Function

Function SurfaceManage.Add(ByVal ID As Integer,ByVal Surface As Surface) As xge_SurfaceInfo Ptr
	Dim RetPtr As xge_SurfaceInfo Ptr = AddStruct()
	If RetPtr Then
		RetPtr->ResID = ID
		RetPtr->sf = Surface
		ImageInfo(Surface,,,,,RetPtr->BitMap,RetPtr->MemSize)
		Return RetPtr
	EndIf
End Function

Function SurfaceManage.Get(ByVal ID As Integer) As Surface
	Dim RetPtr As xge_SurfaceInfo Ptr = GetPtr(ID)
	If RetPtr Then
		Return RetPtr->sf
	EndIf
End Function

Sub SurfaceManage.Free(ByVal ID As Integer)
	Dim StuID As Integer = GetSID(ID)
	Dim RetPtr As xge_SurfaceInfo Ptr = GetPoint(StuID)
	If RetPtr Then
		If RetPtr->sf Then
			ImageDestroy(RetPtr->sf)
		EndIf
		DelStruct(StuID)
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

Function SurfaceManage.LoadFile(ByVal ID As Integer,ByVal FileName As ZString Ptr) As Surface
	Dim TempSurface As Surface
	If Right(*FileName,3) = "bmp" Then
		TempSurface = xge.LoadBMP(FileName)
	Else
		TempSurface = xge.LoadGDI(FileName)
	EndIf
	If Add(ID,TempSurface) Then
		Return TempSurface
	Else
		ImageDestroy(TempSurface)
	EndIf
End Function

Function SurfaceManage.Create(ByVal ID As Integer,ByVal w As Integer,ByVal h As Integer) As Surface
	Dim TempSurface As Surface = ImageCreate(w,h)
	If TempSurface Then
		If Add(ID,TempSurface) Then
			Return TempSurface
		Else
			ImageDestroy(TempSurface)
		EndIf
	EndIf
End Function

#Ifdef xywh_library_xpkl
	Function SurfaceManage.LoadPack_SID(ByVal SID As Integer,ByVal PassWord As ZString Ptr) As Surface
		If Pack->CheckIndex(SID) Then
			Dim As Integer bpp,w,h,id,TempInt						' 获取属性
			TempInt = Pack->File_GetExtInt(SID)
			w = HiWord(TempInt)
			h = LoWord(TempInt)
			id = Pack->File_GetExtSrt(SID)
			TempInt = Pack->File_GetExtByte(SID)
			If TempInt And 16 Then
				bpp = 32
			Else
				bpp = 16
			EndIf
			Dim TempSurface As Surface = ImageCreate(w,h,,bpp)
			If TempSurface Then
				Dim si As xge_SurfaceInfo Ptr = Add(id,TempSurface)
				If si Then
					Pack->GetFileData(SID,0,si->MemSize,si->BitMap,PassWord,0)
					Return TempSurface
				Else
					ImageDestroy(TempSurface)
				EndIf
			EndIf
		EndIf
	End Function
	
	Function SurfaceManage.LoadPack(ByVal Index As Integer,ByVal PassWord As ZString Ptr) As Surface
		Dim SID As Integer = Pack->Find_ExtSrt(Index)
		Pack->Find_Over()
		If SID Then
			Return LoadPack_SID(SID,PassWord)
		EndIf
	End Function
	
	Sub SurfaceManage.LoadPackAll(ByVal PassWord As ZString Ptr)
		Dim i As Integer
		For i = 1 To Pack->Count
			Dim ExtByte As Integer = Pack->File_GetExtByte(i)
			If (ExtByte And 12) = 4 Then
				If ExtByte And 1 Then
					LoadPack_SID(i,PassWord)
				EndIf
			EndIf
		Next
	End Sub
#EndIf
