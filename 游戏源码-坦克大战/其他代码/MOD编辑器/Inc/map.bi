Dim Shared TestTK(9) As Integer



Type Tank_MapPoint Field = 1
	x As UByte
	y As UByte
	dt As UByte
	Tag As UByte
End Type



' 地图文件头 [100字节]
Type MapFileHdr Field = 1
	FileHead As ZString * 4				' xtm
	MapWidth As UByte							' 地图宽度
	MapHeight As UByte						' 地图高度
	NumAI As UByte								' AI坦克总数
	RunAI As UByte								' 屏幕AI数量
	PointNum As UByte							' AI出生点数量
	ClearPlayer As UByte					' 通关后清除玩家信息
	PassExp As UShort							' 通关经验奖励
	AddGoods1 As UByte						' 通关给物品1
	AddGoods2 As UByte						' 通关给物品2
	AddGoods3 As UByte						' 通关给物品3
	AddGoods4 As UByte						' 通关给物品4
	Tag4 As Integer
	Player1 As Tank_MapPoint			' 玩家1出生点
	Player2 As Tank_MapPoint			' 玩家2出生点
	Player3 As Tank_MapPoint			' 玩家3出生点
	Player4 As Tank_MapPoint			' 玩家4出生点
	PointAI(15) As Tank_MapPoint	' AI出生点
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
		MessageBox(Con_MWindow.hWnd,"地图载入失败 [格式不正确] ！","Error :",MB_ICONERROR)
	EndIf
End Function

Sub Tank_Map.Save(ByVal MapFile As ZString Ptr)
	' 保存地图
	PutFile(MapFile,@Info,0,SizeOf(MapFileHdr))
	PutFile(MapFile,tk,SizeOf(MapFileHdr),900)
End Sub
