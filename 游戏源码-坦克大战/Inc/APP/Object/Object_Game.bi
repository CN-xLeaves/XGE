
Type GameSystem
	Map As Tank_Map
	Ammo As Tank_AmmoManage
	Tank As TankManage
	
	TickNewAI As Integer						' 刷坦克Tick
	AddrPointAI As Integer					' AI坦克刷新点ID
	TimeAddHP As Integer
	
	' 坦克操作封装与挂接
	Declare Sub TankMove(ByVal TankObj As TankItem Ptr,ByVal dt As Integer)
	Declare Sub TankFire(ByVal TankObj As TankItem Ptr,ByVal IsAI As Integer)
	
	' 通行测试 [返回-1不可通行]
	Declare Function TestWalk(ByVal x As Integer,ByVal y As Integer,ByVal dt As Integer) As Integer
	
	' 执行AI
	Declare Sub RunTank(ByVal TankObj As TankItem Ptr)
	Declare Sub RunAI()
	
	' 运行游戏
	Declare Sub RunAll()
	
	' 全部画出
	Declare Sub DrawAll()
End Type



Function GameSystem.TestWalk(ByVal x As Integer,ByVal y As Integer,ByVal dt As Integer) As Integer
	' 获取要测试的坐标
	Dim As Point p1,p2
	Select Case dt
		Case 1			' 左
			p1.x = x-1
			p1.y = y
			p2.x = x-1
			p2.y = y+1
		Case 2			' 右
			p1.x = x+2
			p1.y = y
			p2.x = x+2
			p2.y = y+1
		Case 3			' 上
			p1.x = x
			p1.y = y-1
			p2.x = x+1
			p2.y = y-1
		Case Else		' 下
			p1.x = x
			p1.y = y+2
			p2.x = x+1
			p2.y = y+2
	End Select
	' 测试地图
	If Map.Test(p1.x,p1.y) Then
		Return -1
	EndIf
	If Map.Test(p2.x,p2.y) Then
		Return -1
	EndIf
	' 测试活动坦克
	If Tank.TestTank(p1.x,p1.y,3) Then
		Return -1
	EndIf
	If Tank.TestTank(p2.x,p2.y,3) Then
		Return -1
	EndIf
End Function

Sub GameSystem.TankMove(ByVal TankObj As TankItem Ptr,ByVal dt As Integer)
	Dim IsMove As Integer
	If TankObj Then
		If TankObj->moving=0 Then
			' 转向
			TankObj->dt = dt
			' 通行检查
			If TestWalk(TankObj->x,TankObj->y,dt)=0 Then
				' 地图越界检查
				Select Case dt
					Case 1			' 左
						If TankObj->x > 1 Then IsMove = -1
					Case 2			' 右
						If TankObj->x < (Map.Info.MapWidth-1) Then IsMove = -1
					Case 3			' 上
						If TankObj->y > 1 Then IsMove = -1
					Case Else		' 下
						If TankObj->y < (Map.Info.MapHeight-1) Then IsMove = -1
				End Select
			EndIf
			If IsMove Then
				Select Case dt
					Case 1
						TankObj->x -= 1
					Case 2
						TankObj->x += 1
					Case 3
						TankObj->y -= 1
					Case Else
						TankObj->y += 1
				End Select
				TankObj->moving = xge.Tick()
			EndIf
		EndIf
	EndIf
End Sub

Sub GameSystem.TankFire(ByVal TankObj As TankItem Ptr,ByVal IsAI As Integer)
	If TankObj->atting=0 Then
		TankObj->atting = xge.Tick()
		Ammo.AddAmmo(TankObj->x,TankObj->y,TankObj->dt,TankObj->alv + 1,IsAI)
		som.Play(400)
	Else
		If (xge.Tick - TankObj->atting) > (TankObj->kcd - (TankObj->llv * 30)) Then
			TankObj->atting = 0
		EndIf
	EndIf
End Sub

Sub GameSystem.RunTank(ByVal TankObj As TankItem Ptr)
	If TankObj Then
		If TankObj->stk Then
			If TankObj->moving=0 Then
				Select Case TankObj->dt
					Case 1			' 左 [80%继续向左 , 10%向上 , 10%向下]
						If xge.RndOK(8000) Then
							TankMove(TankObj,1)
						Else
							If xge.RndOK(5000) Then
								TankMove(TankObj,0)
							Else
								TankMove(TankObj,3)
							EndIf
						EndIf
					Case 2			' 右 [80%继续向右 , 10%向上 , 10%向下]
						If xge.RndOK(8000) Then
							TankMove(TankObj,2)
						Else
							If xge.RndOK(5000) Then
								TankMove(TankObj,0)
							Else
								TankMove(TankObj,3)
							EndIf
						EndIf
					Case 3			' 上 [80%继续向上 , 10%向左 , 10%向右]
						If xge.RndOK(8000) Then
							TankMove(TankObj,3)
						Else
							If xge.RndOK(5000) Then
								TankMove(TankObj,1)
							Else
								TankMove(TankObj,2)
							EndIf
						EndIf
					Case Else		' 下 [80%继续向下 , 10%向左 , 10%向右]
						If xge.RndOK(8000) Then
							TankMove(TankObj,0)
						Else
							If xge.RndOK(5000) Then
								TankMove(TankObj,1)
							Else
								TankMove(TankObj,2)
							EndIf
						EndIf
				End Select
			EndIf
			' 不停的射击
			TankFire(TankObj,0)
		EndIf
	EndIf
End Sub

Sub GameSystem.RunAI()
	Dim i As Integer
	' 运行全部敌方AI
	Dim TankObj As TankItem Ptr
	For i = 1 To Tank.Count
		TankObj = Tank.GetPoint(i)
		If TankObj Then
			RunTank(TankObj)
		EndIf
	Next
End Sub

Sub GameSystem.RunAll()
	Dim i As Integer
	' 刷怪
	If xge.Tick - TickNewAI > Module.SpeedNewAI Then
		TickNewAI = xge.Tick
		If Map.Info.NumAI > 0 Then
			If Tank.GetCountAI < Map.Info.RunAI Then
				Dim TankObj As TankItem Ptr = Tank.NewTankEx(xge.GetRnd(0,3),(Tank.Player(0).lv + Tank.Player(1).lv + Tank.Player(2).lv + Tank.Player(3).lv) \ 4)
				If TankObj Then
					TankObj->x = Map.Info.PointAI(AddrPointAI).x
					TankObj->y = Map.Info.PointAI(AddrPointAI).y
					TankObj->dt = Map.Info.PointAI(AddrPointAI).dt
					
					AddrPointAI += 1
					If AddrPointAI = Map.Info.PointNum Then
						AddrPointAI = 0
					EndIf
					Map.Info.NumAI -= 1
				EndIf
			EndIf
		EndIf
		' 给AI送经验
		Dim TankObj As TankItem Ptr
		For i = 1 To Tank.Count
			TankObj = Tank.GetPoint(i)
			If TankObj->stk Then
				TankObj->Exp += xge.GetRnd(0,4) * ((TankObj->ExpMax \ 30) + 1)
				If TankObj->Exp >= TankObj->ExpMax Then
					Tank.LevelUP(TankObj,-1)
				EndIf
			EndIf
		Next
	EndIf
	' 运行子弹
	Dim AmmoObj As Tank_AmmoItem Ptr
	For i = 1 To Ammo.Count
		AmmoObj = Ammo.GetPoint(i)
		If AmmoObj Then
			If AmmoObj->stk Then
				Dim As Point p1,p2
				' 子弹移动、越界检查、取碰撞检测点
				Select Case AmmoObj->dt
					Case 1			' 左
						AmmoObj->x -= 1
						If AmmoObj->x <= 0 Then AmmoObj->stk = 0
						p1.x = AmmoObj->x
						p1.y = AmmoObj->y
						p2.x = AmmoObj->x
						p2.y = AmmoObj->y + 1
					Case 2			' 右
						AmmoObj->x += 1
						If AmmoObj->x >= Map.Info.MapWidth Then AmmoObj->stk = 0
						p1.x = AmmoObj->x
						p1.y = AmmoObj->y
						p2.x = AmmoObj->x
						p2.y = AmmoObj->y + 1
					Case 3			' 上
						AmmoObj->y -= 1
						If AmmoObj->y <= 0 Then AmmoObj->stk = 0
						p1.x = AmmoObj->x
						p1.y = AmmoObj->y
						p2.x = AmmoObj->x + 1
						p2.y = AmmoObj->y
					Case Else		' 下
						AmmoObj->y += 1
						If AmmoObj->y >= Map.Info.MapHeight Then AmmoObj->stk = 0
						p1.x = AmmoObj->x
						p1.y = AmmoObj->y
						p2.x = AmmoObj->x + 1
						p2.y = AmmoObj->y
				End Select
				' 子弹碰撞检测 [墙]
				If AmmoObj->stk Then
					Dim hp1 As Integer = Map.Test(p1.x,p1.y)
					Dim hp2 As Integer = Map.Test(p2.x,p2.y)
					If hp1>0 Then
						Ammo.Boom(AmmoObj)
						If AmmoObj->Atk >= hp1 Then
							Map.Die(p1.x,p1.y)
						EndIf
					EndIf
					If hp2>0 Then
						Ammo.Boom(AmmoObj)
						If AmmoObj->Atk >= hp2 Then
							Map.Die(p2.x,p2.y)
						EndIf
					EndIf
				EndIf
				' 子弹碰撞检测 [坦克]
				If AmmoObj->stk Then
					Dim tk1 As TankItem Ptr = Tank.TestTank(p1.x,p1.y,IIf(AmmoObj->IsAI,2,1))
					Dim tk2 As TankItem Ptr = Tank.TestTank(p2.x,p2.y,IIf(AmmoObj->IsAI,2,1))
					If tk1 = tk2 Then
						tk2 = NULL
					EndIf
					If tk1 Then
						Ammo.Boom(AmmoObj)
						tk1->hp -= AmmoObj->Atk
						' 玩家击碎给经验 [相当于坦克等级]
						If tk1->hp <= 0 Then
							tk1->stk = 0
							Tank.Player(AmmoObj->IsAI-1).Exp += tk1->lv * Module.ExpMul
							som.Play(401)
						EndIf
					EndIf
					If tk2 Then
						Ammo.Boom(AmmoObj)
						tk2->hp -= AmmoObj->Atk
						' 玩家击碎给经验 [相当于坦克等级]
						If tk2->hp <= 0 Then
							tk2->stk = 0
							Tank.Player(AmmoObj->IsAI-1).Exp += tk2->lv * Module.ExpMul
							som.Play(401)
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	Next
	' 检查玩家血量\是否升级
	For i = 0 To 3
		If Tank.Player(i).hp <= 0 Then
			Tank.Player(i).stk = 0
			som.Play(401)
		EndIf
		If Tank.Player(i).Exp >= Tank.Player(i).ExpMax Then
			Tank.LevelUP(@Tank.Player(i),-1)
		EndIf
	Next
	' 自动为玩家加血
	If xge.Tick - TimeAddHP > Module.TimeAddHP Then
		TimeAddHP = xge.Tick
		For i = 0 To 3
			If Tank.Player(i).stk Then
				If Tank.Player(i).hp < Tank.Player(i).hpmax Then
					Tank.Player(i).hp += 1
				EndIf
			EndIf
		Next
	EndIf
	' 运行AI
	RunAI
End Sub

Sub GameSystem.DrawAll()
	Map.Draw(0,0)
	Tank.DrawAll()
	Ammo.DrawAll()
End Sub
