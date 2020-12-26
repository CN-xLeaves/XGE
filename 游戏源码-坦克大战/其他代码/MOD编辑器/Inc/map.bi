Dim Shared TestTK(9) As Integer



Type Tank_MapPoint Field = 1
	x As UByte
	y As UByte
	dt As UByte
	Tag As UByte
End Type



' ��ͼ�ļ�ͷ [100�ֽ�]
Type MapFileHdr Field = 1
	FileHead As ZString * 4				' xtm
	MapWidth As UByte							' ��ͼ���
	MapHeight As UByte						' ��ͼ�߶�
	NumAI As UByte								' AI̹������
	RunAI As UByte								' ��ĻAI����
	PointNum As UByte							' AI����������
	ClearPlayer As UByte					' ͨ�غ���������Ϣ
	PassExp As UShort							' ͨ�ؾ��齱��
	AddGoods1 As UByte						' ͨ�ظ���Ʒ1
	AddGoods2 As UByte						' ͨ�ظ���Ʒ2
	AddGoods3 As UByte						' ͨ�ظ���Ʒ3
	AddGoods4 As UByte						' ͨ�ظ���Ʒ4
	Tag4 As Integer
	Player1 As Tank_MapPoint			' ���1������
	Player2 As Tank_MapPoint			' ���2������
	Player3 As Tank_MapPoint			' ���3������
	Player4 As Tank_MapPoint			' ���4������
	PointAI(15) As Tank_MapPoint	' AI������
End Type



Type Tank_Map
	tk As UByte Ptr
	Info As MapFileHdr
	
	Declare Function Load(ByVal MapFile As ZString Ptr) As Integer
	Declare Sub Save(ByVal MapFile As ZString Ptr)
	Declare Sub Draw(ByVal px As Integer,ByVal py As Integer)
	Declare Function Test(ByVal x As Integer,ByVal y As Integer) As Integer
	Declare Sub Die(ByVal x As Integer,ByVal y As Integer)
	
	Declare Constructor()
End Type



Constructor Tank_Map()
	TestTK(0) = 0
	TestTK(1) = 1
	TestTK(2) = 16
	TestTK(3) = 0
	TestTK(4) = -1
	TestTK(5) = 1
	TestTK(6) = 1
	TestTK(7) = 1
	TestTK(8) = 1
	TestTK(9) = -1
End Constructor



Function Tank_Map.Load(ByVal MapFile As ZString Ptr) As Integer
	GetFile(MapFile,@Info,0,SizeOf(MapFileHdr))
	If Info.FileHead="xtm" Then
		DeAllocate(tk)
		tk = Allocate(Info.MapWidth*Info.MapHeight)
		GetFile(MapFile,tk,SizeOf(MapFileHdr),Info.MapWidth*Info.MapHeight)
		Return -1
	Else
		MessageBox(Con_MWindow.hWnd,"��ͼ����ʧ�� [��ʽ����ȷ] ��","Error :",MB_ICONERROR)
	EndIf
End Function

Sub Tank_Map.Save(ByVal MapFile As ZString Ptr)
	' �����ͼ
	PutFile(MapFile,@Info,0,SizeOf(MapFileHdr))
	PutFile(MapFile,tk,SizeOf(MapFileHdr),900)
End Sub
