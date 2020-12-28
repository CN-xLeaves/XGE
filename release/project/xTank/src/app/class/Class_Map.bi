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
	BasicX As UByte								' 基地X坐标
	BasicY As UByte								' 基地Y坐标
	Tag1 As UShort
	Tag2 As Integer
	Tag3 As Integer
	Tag4 As Integer
	Tag5 As Integer
	Player As Tank_MapPoint		' 玩家出生点
	np(2) As Tank_MapPoint
	PointAI(11) As Tank_MapPoint	' AI出生点
End Type



Type Tank_Map
	tk As UByte Ptr
	Info As MapFileHdr
	
	Declare Function Load() As Integer
	Declare Function LoadToFile(ByVal MapFile As ZString Ptr) As Integer
	Declare Function LoadToPack(ByVal FileID As Integer) As Integer
	
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



Function Tank_Map.LoadToFile(ByVal MapFile As ZString Ptr) As Integer
	xFile.Read(MapFile, @Info, 0, SizeOf(MapFileHdr))
	If Info.FileHead="xtm" Then
		DeAllocate(tk)
		tk = Allocate(Info.MapWidth*Info.MapHeight)
		xFile.Read(MapFile, tk, SizeOf(MapFileHdr), Info.MapWidth*Info.MapHeight)
		Return -1
	Else
		MessageBox(xge.hWnd,"地图载入失败 [格式不正确] ！","Error :",MB_ICONERROR)
	EndIf
End Function

Function Tank_Map.LoadToPack(ByVal FileID As Integer) As Integer
	Return -1
End Function

Function Tank_Map.Load() As Integer
	' INI 模式MOD
	Return LoadToFile(Module.Path & Module.CurMapID & ".map")
End Function

Sub Tank_Map.Save(ByVal MapFile As ZString Ptr)
	' 填写信息
	Info.FileHead = "xtm"
	Info.MapWidth = 30
	Info.MapHeight = 30
	Info.NumAI = 30
	Info.RunAI = 3
	Info.Player.dt = 3
	' 保存地图
	xFile.Write(MapFile, @Info, 0, SizeOf(MapFileHdr))
	xFile.Write(MapFile, tk, SizeOf(MapFileHdr), 900)
End Sub

Sub Tank_Map.Draw(ByVal px As Integer,ByVal py As Integer)
	Dim As Integer x,y
	For y = 0 To 29
		For x = 0 To 29
			img_MapTile->DrawEx_Trans(px+(x*16), py+(y*16), tk[(y*30)+x]*16, 0, 15, 15)
		Next
	Next
End Sub

Function Tank_Map.Test(ByVal x As Integer,ByVal y As Integer) As Integer
	Return TestTK(tk[((y-1)*30)+(x-1)])
End Function

Sub Tank_Map.Die(ByVal x As Integer,ByVal y As Integer)
	tk[((y-1)*30)+(x-1)] = 0
End Sub
