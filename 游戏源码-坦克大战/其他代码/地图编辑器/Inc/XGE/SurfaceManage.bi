'==================================================================================
	'�� Surface Manage ͼ�������
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================

#Include Once "Inc\SDK\File.bi"
#Include Once "Inc\SDK\xywhBSMM.bi"



#Define xywh_library_sfmg



Type xge_SurfaceInfo
	ResID As Integer							' ͼ��ID
	sf As Surface									' Surface ָ��
	BitMap As Any Ptr							' ����ָ��
	MemSize As Integer						' ���ݳߴ�
End Type



Type SurfaceManage Extends xywhBSMM
	' ��ǰѡȡ�� Surface �ͽṹ��ָ��
	sf As Surface
	InfoPtr As xge_SurfaceInfo Ptr
	
	
	#Ifdef xywh_library_xpkl
		Pack As xywhPack Ptr
	#EndIf
	
	
	' ���һ�� Surface ����������
	Declare Function Add(ByVal ID As Integer,ByVal Surface As Surface) As xge_SurfaceInfo Ptr
	
	
	' ���� ResID ��ȡ StuID
	Declare Function GetSID(ByVal ID As Integer) As Integer
	' ���� ResID ��ȡ Surface �ṹ��ָ��
	Declare Function GetPtr(ByVal ID As Integer) As xge_SurfaceInfo Ptr
	' ���� ResID ѡȡһ�� Surface
	Declare Function SelSurface(ByVal ID As Integer) As Integer
	' ���� ResID ��ȡ Surface
	Declare Function Get(ByVal ID As Integer) As Surface
	
	
	' ����һ�� BMP �ļ���������
	Declare Function LoadFile(ByVal ID As Integer,ByVal FileName As ZString Ptr) As Surface
	' ����һ���µ� Surface
	Declare Function Create(ByVal ID As Integer,ByVal w As Integer,ByVal h As Integer) As Surface
	' ����һ�� RAW �ļ��������� [��xywhPackL������]
	#Ifdef xywh_library_xpkl
		Declare Function LoadPack_SID(ByVal SID As Integer,ByVal PassWord As ZString Ptr) As Surface
		Declare Function LoadPack(ByVal Index As Integer,ByVal PassWord As ZString Ptr) As Surface
		Declare Sub LoadPackAll(ByVal PassWord As ZString Ptr)
	#EndIf
	
	
	' ����һ�� Surface �ĻҶ�ͼ��
	Declare Function Gray(ByVal ID As Integer,ByVal NewID As Integer) As Surface
	' ����һ�� Surface �ķ�תͼ�� [Flag : 1=���� , 2=����]
	Declare Function Flip(ByVal ID As Integer,ByVal NewID As Integer,ByVal Flag As Integer) As Surface
	
	
	' �ͷ�һ�� Surface ռ�õ��ڴ�
	Declare Sub Free(ByVal ID As Integer)
	' �ͷ����� Surface ������������
	Declare Sub FreeAll()
	
	
	' ������
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
			Dim As Integer bpp,w,h,id,TempInt						' ��ȡ����
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
