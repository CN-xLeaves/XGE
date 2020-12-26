'==================================================================================
	'�� Surface Manage ͼ�������
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================

#Include Once "Inc\SDK\File.bi"
#Include Once "Inc\SDK\xywhBSMM.bi"



#Define xywh_library_xsfm



Type xge_SurfaceInfo
	ResID As Integer							' ͼ��ID
	sf As Surface									' Surface ָ��
	BitMap As Any Ptr							' ����ָ��
	MemSize As Integer						' ���ݳߴ�
End Type



Type SurfaceManage Extends xywhBSMM
	' ��ǰѡȡ�� Surface �ͽṹ��ָ��
	SelImg As Surface
	SelPtr As xge_SurfaceInfo Ptr
	
	
	#Ifdef xywh_library_xpkl
		Pack As xywhPack Ptr
	#EndIf
	
	
	' ���һ�� Surface ����������
	Declare Function Add(ByVal ResID As Integer,ByVal sf As Surface) As Integer
	' ��ȡ Surface
	Declare Function Get(ByVal ID As Integer,ByVal tpe As Integer=0) As Surface
	' ��ȡ SurfaceInfo �ṹ��ָ��
	Declare Function GetPtr(ByVal ID As Integer,ByVal tpe As Integer=0) As xge_SurfaceInfo Ptr
	' ѡȡһ�� Surface
	Declare Function Sel(ByVal ID As Integer,ByVal tpe As Integer=0) As Integer
	' �ͷ�һ�� Surface ռ�õ��ڴ�
	Declare Sub Free(ByVal ID As Integer,ByVal tpe As Integer=0)
	' �ͷ����� Surface ������������
	Declare Sub FreeAll()
	
	
	' ����һ���µ� Surface
	Declare Function Create(ByVal ResID As Integer,ByVal w As Integer,ByVal h As Integer) As Integer
	' ����һ�� BMP �ļ���������
	Declare Function LoadFile(ByVal ResID As Integer,ByVal FileName As ZString Ptr) As Integer
	' ����һ�� RAW �ļ��������� [��xywhPackL������]
	#Ifdef xywh_library_xpkl
		Declare Function LoadPack(ByVal ID As Integer,ByVal PassWord As ZString Ptr,ByVal tpe As Integer=0) As Integer
		Declare Sub LoadPackAll(ByVal PassWord As ZString Ptr)
	#EndIf
	
	
	' ������
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
	If tpe Then				' ʹ�� StuID
		Return GetPoint(ID)
	Else							' ʹ�� ResID
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
		If tpe Then				' ʹ�� StuID
			If Pack->CheckIndex(ID) Then
				RID = Pack->File_GetExtSrt(ID)
				TSF = xge.LoadXPK(Pack,ID,PassWord)
				If TSF Then
					Return Add(RID,TSF)
				EndIf
			EndIf
		Else							' ʹ�� ResID
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