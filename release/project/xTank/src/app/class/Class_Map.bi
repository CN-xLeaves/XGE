Dim Shared TestTK(9) As Integer = {0, 1, 16, 0, -1, 1, 1, 1, 1, -1}



Type Tank_MapPoint Field = 1
	x As UByte
	y As UByte
	dt As UByte
	Tag As UByte
End Type



' 地图文件头 [100字节]
Type MapFileHdr_Old Field = 1
	FileHead As ZString * 4				' xtm
	MapWidth As UByte							' 地图宽度
	MapHeight As UByte						' 地图高度
	NumAI As UByte								' AI坦克总数
	RunAI As UByte								' 屏幕AI数量
	PointNum As UByte							' AI出生点数量
	ClearPlayer As UByte					' 通关后清除玩家信息
	PassExp As UShort					' 通关经验奖励
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

Type xTank_MapHeadInfo Field = 1
	FileHead As ZString * 4				' xtm
	MapWidth As UByte					' 地图宽度
	MapHeight As UByte					' 地图高度
	NumAI As UByte						' AI坦克总数
	RunAI As UByte						' 同屏AI数量
	PointNum As UByte					' AI出生点数量
	ClearPlayer As UByte				' 通关后清除玩家信息
	PassExp As UShort					' 通关经验奖励
	Player As Tank_MapPoint				' 玩家出生点
	PointAI(8) As Tank_MapPoint			' AI出生点
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
		MessageBox(xge.hWnd,"地图载入失败 [格式不正确] ！","Error :",MB_ICONERROR)
	EndIf
End Function

Sub Tank_Map.Save(ByVal MapFile As ZString Ptr)
	' 填写信息
	HeadInfo.FileHead = "xtm"
	HeadInfo.MapWidth = 30
	HeadInfo.MapHeight = 30
	HeadInfo.NumAI = 30
	HeadInfo.RunAI = 3
	HeadInfo.Player.dt = 3
	' 保存地图
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
