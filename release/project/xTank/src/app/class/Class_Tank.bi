

' 每级火炮级别提升1点伤害，每级装甲级别提升2点装甲

' 血量计算公式 bhp + (dlv x 2) + (lv \ 3)
' 移动速度公式 mcd - (slv * 15)
' 开火间隔公式 kcd - (llv * 30)
' 

Type TankItem
	' 基本数据
	stk As Integer											' 目标状态 [0=死亡 1=正常]
	tpe As Integer											' 坦克类型 [0=随机 1=速度 2=攻击 3=防御 4=综合]
	lv As Integer												' 等级
	x As Integer												' 所在横坐标
	y As Integer												' 所在纵坐标
	dt As Integer												' 朝向 [0=下 1=左 2=右 3=上]
	
	' 绘图数据
	px As Integer												' 绘制偏移
	py As Integer												' 绘制偏移
	stp As Integer											' 步伐[0=第一步 1=第二步]
	
	' 状态数据
	moving As Integer										' 正在移动 [CD时间]
	atting As Integer										' 正在射击 [CD时间]
	
	' 实时数据
	hp As Integer												' 当前血量
	hpmax As Integer										' 最高血量
	Exp As Integer											' 经验值
	ExpMax As Integer										' 升级经验值
	
	' 基础属性
	mcd As Integer											' 基础移动间隔
	kcd As Integer											' 基础开火间隔
	bhp As Integer											' 基础装甲
	BExp As Integer											' 基础 Exp
	AExp As Integer											' 升级 Exp 增量 [百分比]
	
	' 技能相关
	pt As Integer												' 剩余技能点
	slv As Integer											' 移动级别 [玩家最高20级]
	alv As Integer											' 攻击级别 [玩家最高20级]
	dlv As Integer											' 装甲级别 [玩家最高20级]
	llv As Integer											' 装弹级别 [玩家最高20级]
	apf As Integer											' 下次加点 [AI使用] [0=随机加点 1=主要加点]
	
	' 物品
	goods(9) As Integer									' 物品数量
	
	' Surface
	img As xge.Surface Ptr											' 素材图指针
End Type


Type TankManage Extends xBsmm
	' 玩家坦克
	Player As TankItem
	
	TickNewAI As Integer						' 刷坦克Tick
	AddrPointAI As Integer					' AI坦克刷新点ID
	
	Declare Constructor()
	
	' 创建AI坦克
	Declare Function NewTankEx(ByVal theType As Integer,ByVal Level As Integer) As TankItem Ptr
	Declare Function NewTank() As TankItem Ptr
	' 初始坦克数据[1级]
	Declare Sub IntData(ByVal TankObj As TankItem Ptr,ByVal theType As Integer)
	' 随机设置坦克数据
	Declare Sub RndData(ByVal TankObj As TankItem Ptr,ByVal Level As Integer)
	' 坦克升级
	Declare Sub LevelUP(ByVal TankObj As TankItem Ptr,ByVal IsAI As Integer)
	' 画出坦克
	Declare Sub DrawTank(ByVal TankObj As TankItem Ptr)
	Declare Sub DrawAll()
	' 坦克移动 [这个是超级移动]
	Declare Sub TankMove(ByVal TankObj As TankItem Ptr,ByVal x As Integer,ByVal y As Integer)
	' 返回AI坦克数量
	Declare Function GetCountAI() As Integer
	' 测试一个点是否存在坦克 [TankType为位标记 1=玩家 2=AI]
	Declare Function TestTank(ByVal x As Integer,ByVal y As Integer,ByVal TankType As Integer) As TankItem Ptr
	' 初始化玩家坦克
	Declare Sub InitPlayer()
End Type



Constructor TankManage()
	StructLenght = SizeOf(TankItem)
	AllocStep = 50
End Constructor

Function TankManage.NewTankEx(ByVal theType As Integer,ByVal Level As Integer) As TankItem Ptr
	Dim idx As Integer = AppendStruct()
	Dim TankObj As TankItem Ptr = GetPtrStruct(idx)
	If TankObj Then
		IntData(TankObj, theType)
		If Level > 1 Then
			RndData(TankObj, Level)
		EndIf
		Return TankObj
	EndIf
End Function

Function TankManage.NewTank() As TankItem Ptr
	Return NewTankEx(GetRand(0, 3), 1)
End Function

Sub TankManage.IntData(ByVal TankObj As TankItem Ptr,ByVal theType As Integer)
	' 数据清理
	Clear(*TankObj,0,SizeOf(TankItem))
	' 填写基本信息
	TankObj->stk = 1
	TankObj->lv = 1
	TankObj->BExp = 10
	TankObj->AExp = 30
	TankObj->dt = 0
	' 如果没有指定类型，就随机选择一种
	If theType=0 Then theType = GetRand(1, 4)
	' 根据不同的坦克给不同的能力
	Select Case theType
		Case 2		' 进攻型
			TankObj->tpe = 2
			TankObj->img = img_Tank2
			TankObj->mcd = 450
			TankObj->kcd = 660
			TankObj->bhp = 3
			TankObj->slv = 0
			TankObj->alv = 1
			TankObj->dlv = 0
			TankObj->llv = 0
		Case 3		' 防御型
			TankObj->tpe = 3
			TankObj->img = img_Tank3
			TankObj->mcd = 500
			TankObj->kcd = 800
			TankObj->bhp = 5
			TankObj->slv = 0
			TankObj->alv = 0
			TankObj->dlv = 1
			TankObj->llv = 0
		Case 4		' 综合型
			TankObj->tpe = 4
			TankObj->img = img_Tank4
			TankObj->mcd = 400
			TankObj->kcd = 700
			TankObj->bhp = 4
			TankObj->slv = 0
			TankObj->alv = 0
			TankObj->dlv = 0
			TankObj->llv = 1
		Case Else	' 速度型
			TankObj->tpe = 1
			TankObj->img = img_Tank1
			TankObj->mcd = 360
			TankObj->kcd = 750
			TankObj->bhp = 2
			TankObj->slv = 1
			TankObj->alv = 0
			TankObj->dlv = 0
			TankObj->llv = 0
	End Select
	' 填写实时信息
	TankObj->ExpMax = TankObj->BExp
	TankObj->hpmax = TankObj->bhp
	TankObj->hp = TankObj->hpmax
End Sub

Sub TankManage.RndData(ByVal TankObj As TankItem Ptr,ByVal Level As Integer)
	Dim i As Integer
	For i = TankObj->lv To Level-1
		LevelUP(TankObj,-1)
	Next
End Sub

Sub TankManage.LevelUP(ByVal TankObj As TankItem Ptr,ByVal AutoPoint As Integer)
	If TankObj->lv < 40 Then
		' 加级
		TankObj->lv += 1
		' 防御型tank额外给血
		If TankObj->tpe = 3 Then
			TankObj->bhp += 1
		EndIf
		' 自动加点
		If AutoPoint Then
			Select Case TankObj->tpe
				Case 2			' 攻击型坦克 [50%加攻击 , 剩余点数随机加 , 50%几率加装填 , 25%几率加移动 , 25%几率加防御]
					If TankObj->apf Then
						TankObj->alv += 1
					Else
						If RandTest(5000) Then
							TankObj->llv += 1
						Else
							If RandTest(5000) Then
								TankObj->slv += 1
							Else
								TankObj->dlv += 1
							EndIf
						EndIf
					EndIf
				Case 3			' 防御型坦克 [50%加防御 , 剩余点数随机加 , 50%几率加移动 , 25%几率加攻击 , 25%几率加装填]
					If TankObj->apf Then
						TankObj->dlv += 1
					Else
						If RandTest(5000) Then
							TankObj->slv += 1
						Else
							If RandTest(5000) Then
								TankObj->alv += 1
							Else
								TankObj->llv += 1
							EndIf
						EndIf
					EndIf
				Case 4			' 综合型坦克 [全25%几率随机加点 , 有25%的几率4点全加]
					Dim RndNum As Integer = GetRand(1,5)
					Select Case RndNum
						Case 1
							TankObj->alv += 1
						Case 2
							TankObj->dlv += 1
						Case 3
							TankObj->slv += 1
						Case 4
							TankObj->llv += 1
						Case Else
							TankObj->llv += 1
							TankObj->slv += 1
							TankObj->dlv += 1
							TankObj->alv += 1
					End Select
				Case Else		' 速度型坦克 [50%加移动 , 剩余点数随机加 , 50%几率加装填 , 25%几率加攻击 , 25%几率加防御]
					If TankObj->apf Then
						TankObj->slv += 1
					Else
						If RandTest(5000) Then
							TankObj->llv += 1
						Else
							If RandTest(5000) Then
								TankObj->alv += 1
							Else
								TankObj->dlv += 1
							EndIf
						EndIf
					EndIf
			End Select
			' 设置下次加点目标
			If TankObj->apf Then
				TankObj->apf = 0
			Else
				TankObj->apf = 1
			EndIf
		Else
			' 不自动加点则可用点数增加1
			TankObj->pt += 1
		EndIf
		' 重新计算实时数据
		TankObj->hpmax = TankObj->bhp + (TankObj->dlv * 2) + (TankObj->lv \ 3)
		TankObj->hp = TankObj->hpmax
		TankObj->ExpMax += (TankObj->ExpMax * TankObj->AExp) \ 100
		TankObj->Exp -= TankObj->ExpMax
		If TankObj->Exp<0 Then
			TankObj->Exp = 0
		EndIf
	EndIf
End Sub

Sub TankManage.DrawTank(ByVal TankObj As TankItem Ptr)
	If TankObj Then
		If TankObj->stk Then
			' 处理坦克数据
			If TankObj->moving Then
				' 一条移动指令执行完毕
				If (GetTickCount() - TankObj->moving) > (TankObj->mcd - (TankObj->slv * 15)) Then
					TankObj->moving = 0
					TankObj->px = 0
					TankObj->py = 0
				Else
					' 移动指令进行中
					Dim MoveAddr As Integer = (GetTickCount() - TankObj->moving) / (TankObj->mcd - (TankObj->slv * 15)) * 16
					If MoveAddr > 16 Then MoveAddr = 16
					If MoveAddr < 0 Then MoveAddr = 0
					Select Case TankObj->dt
						Case 1			' 左
							TankObj->py = 0
							TankObj->px = -MoveAddr+16
						Case 2			' 右
							TankObj->py = 0
							TankObj->px = MoveAddr-16
						Case 3			' 上
							TankObj->px = 0
							TankObj->py = -MoveAddr+16
						Case Else		' 下
							TankObj->px = 0
							TankObj->py = MoveAddr-16
					End Select
					' 处理步伐
					If TankObj->stp Then
						TankObj->stp = 0
					Else
						TankObj->stp = 1
					EndIf
				EndIf
			EndIf
			' 画坦克
			TankObj->img->DrawEx_Trans(NULL, ((TankObj->x-1)*16)+TankObj->px, ((TankObj->y-1)*16)+TankObj->py, TankObj->stp*32, TankObj->dt*32, 31, 31)
			' 画等级
			Dim tr As RECT
			tr.left = ((TankObj->x-1)*16)+TankObj->px
			tr.top = ((TankObj->y-1)*16)+TankObj->py
			tr.right = tr.left + 32
			tr.bottom = tr.top + 12
			If ViewLevel Then
				xge.Text.DrawRectA(NULL, tr.left, tr.top, 32, 12, "Lv." & TankObj->lv, &HFFFFFFFF)
			EndIf
			' 画血条
			If ViewHP Then
				xge.Shape.RectFull(NULL, ((TankObj->x-1)*16)+TankObj->px, ((TankObj->y-1)*16)+TankObj->py+13, ((TankObj->x-1)*16)+TankObj->px + 32, ((TankObj->y-1)*16)+TankObj->py+13 + 4, &HFFFF0000)
				xge.Shape.RectFull(NULL, ((TankObj->x-1)*16)+TankObj->px+1, ((TankObj->y-1)*16)+TankObj->py+14, ((TankObj->x-1)*16)+TankObj->px+1 + ((TankObj->hp * 30) \ TankObj->hpmax), ((TankObj->y-1)*16)+TankObj->py+14 + 2, &HFF00FF00)
			EndIf
			' 画血量
			tr.top = tr.bottom+5
			tr.bottom = tr.top + 12
			If ViewHP_Value Then
				xge.Text.DrawRectA(NULL, tr.left, tr.top, 32, 12, TankObj->hp & "/" & TankObj->hpmax, &HFFFFFFFF)
			EndIf
		EndIf
	EndIf
End Sub

Sub TankManage.DrawAll()
	Dim i As Integer
	' 画玩家坦克
	DrawTank(@Player)
	' 画AI
	Dim TankObj As TankItem Ptr
	For i = 1 To StructCount
		TankObj = GetPtrStruct(i)
		If TankObj Then
			DrawTank(TankObj)
		EndIf
	Next
End Sub

Sub TankManage.TankMove(ByVal TankObj As TankItem Ptr,ByVal x As Integer,ByVal y As Integer)
	TankObj->x = x
	TankObj->y = y
	TankObj->moving = 0			' 超级移动后移动和射击冷却都完成
	TankObj->atting = 0
End Sub

Function TestPointTank(ByVal x As Integer,ByVal y As Integer,ByVal tx As Integer,ByVal ty As Integer) As Integer
	If (x >= tx) And (x <= (tx+1)) Then
		If (y >= ty) And (y <= (ty+1)) Then
			Return -1
		EndIf
	EndIf
End Function
Function TankManage.TestTank(ByVal x As Integer,ByVal y As Integer,ByVal TankType As Integer) As TankItem Ptr
	Dim i As Integer
	' 测试是否与玩家产生碰撞
	If TankType And 1 Then
		If Player.stk Then
			If TestPointTank(x, y, Player.x, Player.y) Then
				Return @Player
			EndIf
		EndIf
	EndIf
	' 测试是否与AI产生碰撞
	If TankType And 2 Then
		Dim TankObj As TankItem Ptr
		For i = 1 To StructCount
			TankObj = GetPtrStruct(i)
			If TankObj Then
				If TankObj->stk Then
					If TestPointTank(x,y,TankObj->x,TankObj->y) Then
						Return TankObj
					EndIf
				EndIf
			EndIf
		Next
	EndIf
End Function

Function TankManage.GetCountAI() As Integer
	Dim i As Integer
	Dim NumAI As Integer
	Dim TankObj As TankItem Ptr
	For i = 1 To StructCount
		TankObj = GetPtrStruct(i)
		If TankObj Then
			If TankObj->stk Then
				NumAI += 1
			EndIf
		EndIf
	Next
	Return NumAI
End Function

Sub TankManage.InitPlayer()
	IntData(@Player, Module.TankModel)
	' 为玩家坦克提升一定的能力
	Player.mcd -= 30
	Player.kcd -= 30
	Player.bhp += 5
	If Module.StartLevel > 1 Then
		RndData(@Player, Module.StartLevel)
	EndIf
End Sub
