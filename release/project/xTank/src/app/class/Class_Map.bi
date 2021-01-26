Dim Shared TestTK(9) As Integer = {0, 1, 16, 0, -1, 1, 1, 1, 1, -1}



Type Tank_MapPoint Field = 1
	x As UByte
	y As UByte
	dt As UByte
	Tag As UByte
End Type



' ��ͼ�ļ�ͷ [100�ֽ�]
Type MapFileHdr_Old Field = 1
	FileHead As ZString * 4				' xtm
	MapWidth As UByte							' ��ͼ���
	MapHeight As UByte						' ��ͼ�߶�
	NumAI As UByte								' AI̹������
	RunAI As UByte								' ��ĻAI����
	PointNum As UByte							' AI����������
	ClearPlayer As UByte					' ͨ�غ���������Ϣ
	PassExp As UShort					' ͨ�ؾ��齱��
	AddGoods1 As UByte						' ͨ�ظ���Ʒ1
	AddGoods2 As UByte						' ͨ�ظ���Ʒ2
	AddGoods3 As UByte						' ͨ�ظ���Ʒ3
	AddGoods4 As UByte						' ͨ�ظ���Ʒ4
	BasicX As UByte								' ����X����
	BasicY As UByte								' ����Y����
	Tag1 As UShort
	Tag2 As Integer
	Tag3 As Integer
	Tag4 As Integer
	Tag5 As Integer
	Player As Tank_MapPoint		' ��ҳ�����
	np(2) As Tank_MapPoint
	PointAI(11) As Tank_MapPoint	' AI������
End Type

Type xTank_MapHeadInfo Field = 1
	FileHead As ZString * 4				' xtm
	MapWidth As UByte					' ��ͼ���
	MapHeight As UByte					' ��ͼ�߶�
	NumAI As UByte						' AI̹������
	RunAI As UByte						' ͬ��AI����
	PointNum As UByte					' AI����������
	ClearPlayer As UByte				' ͨ�غ���������Ϣ
	PassExp As UShort					' ͨ�ؾ��齱��
	Player As Tank_MapPoint				' ��ҳ�����
	PointAI(8) As Tank_MapPoint			' AI������
	Tag As Integer
End Type



Type Tank_Map
	tk As UByte Ptr
	HeadInfo As MapFileHdr_Old
	
	Declare Function Load(ByVal MapFile As ZString Ptr) As Integer
	
	Declare Sub Save(ByVal MapFile As ZString Ptr)
	Declare Sub Draw(ByVal px As Integer,ByVal py As Integer)
	Declare Function Test(ByVal x As Integer,ByVal y As Integer) As Integer
	Declare Sub Die(ByVal x As Integer,ByVal y As Integer)
	
End Type



Function Tank_Map.Load(MapFile As ZString Ptr) As Integer
	xFile_Read(MapFile, @HeadInfo, 0, SizeOf(MapFileHdr_Old))
	If HeadInfo.FileHead = "xtm" Then
		If tk Then
			DeAllocate(tk)
		EndIf
		tk = Allocate(HeadInfo.MapWidth * HeadInfo.MapHeight)
		xFile_Read(MapFile, tk, SizeOf(MapFileHdr_Old), HeadInfo.MapWidth * HeadInfo.MapHeight)
		Return -1
	Else
		MessageBox(xge.hWnd,"��ͼ����ʧ�� [��ʽ����ȷ] ��","Error :",MB_ICONERROR)
	EndIf
End Function

Sub Tank_Map.Save(ByVal MapFile As ZString Ptr)
	' ��д��Ϣ
	HeadInfo.FileHead = "xtm"
	HeadInfo.MapWidth = 30
	HeadInfo.MapHeight = 30
	HeadInfo.NumAI = 30
	HeadInfo.RunAI = 3
	HeadInfo.Player.dt = 3
	' �����ͼ
	xFile_Write(MapFile, @HeadInfo, 0, SizeOf(MapFileHdr_Old))
	xFile_Write(MapFile, tk, SizeOf(MapFileHdr_Old), 900)
End Sub

Sub Tank_Map.Draw(ByVal px As Integer,ByVal py As Integer)
	Dim As Integer x,y
	For y = 0 To 29
		For x = 0 To 29
			img_MapTile->DrawEx_Trans(NULL, px+(x*16), py+(y*16), tk[(y*30)+x]*16, 0, 15, 15)
		Next
	Next
End Sub

Function Tank_Map.Test(ByVal x As Integer,ByVal y As Integer) As Integer
	Return TestTK(tk[((y-1)*30)+(x-1)])
End Function

Sub Tank_Map.Die(ByVal x As Integer,ByVal y As Integer)
	tk[((y-1)*30)+(x-1)] = 0
End Sub
