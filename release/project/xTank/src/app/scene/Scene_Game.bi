


Dim Shared GameObject As GameSystem



' Scene function
' 返回值：0=意外退出 1=通关 2=游戏结束
Function GameScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Select Case msg
		Case XGE_MSG_FRAME				' frame Logic processing
			' Player1 控制
			If GameObject.Tank.Player.stk Then
				If xInput.KeyStatus(SC_W) Then
					GameObject.TankMove(@GameObject.Tank.Player,3)
				ElseIf xInput.KeyStatus(SC_S) Then
					GameObject.TankMove(@GameObject.Tank.Player,0)
				ElseIf xInput.KeyStatus(SC_A) Then
					GameObject.TankMove(@GameObject.Tank.Player,1)
				ElseIf xInput.KeyStatus(SC_D) Then
					GameObject.TankMove(@GameObject.Tank.Player,2)
				EndIf
				If xInput.KeyStatus(SC_J) Then
					GameObject.TankFire(@GameObject.Tank.Player,1)
				EndIf
			EndIf
			' 处理AI
			GameObject.RunAll()
			' 检测玩家死亡
			If GameObject.Tank.Player.stk = 0 Then
				xge.Scene.Stop()
			EndIf
			' 检测AI
			If GameObject.Map.Info.NumAI <= 0 Then
				If GameObject.Tank.GetCountAI = 0 Then
					' 给通关奖励
					GameObject.Tank.Player.Exp += GameObject.Map.Info.PassExp
					Module.CurMapID += 1
					xge.Scene.Stop()
				EndIf
			EndIf
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			xge.Shape.RectFull(480, 0, 640, 452, &HFF444444)
			xge.Shape.RectFull(480, 452, 640, 480, &HFF666666)
			' 绘制信息文字
			xge.Text.DrawRectA(NULL, 480, 452, 160, 28, "fps : " & xge.Scene.FPS, &HFFFFFFFF)
			' 绘制坦克、地图、子弹等
			GameObject.DrawAll()
			' 绘制调试信息
			xge.Text.DrawA(NULL, 500,  20, "player1 :", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524,  40, "等级 : " & GameObject.Tank.Player.lv, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524,  60, "装甲 : " & GameObject.Tank.Player.hp & "/" & GameObject.Tank.Player.hpmax, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524,  80, "经验 : " & GameObject.Tank.Player.Exp & "/" & GameObject.Tank.Player.ExpMax, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 100, "点数 : " & GameObject.Tank.Player.pt, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 120, "移动 : " & GameObject.Tank.Player.slv, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 140, "装填 : " & GameObject.Tank.Player.llv, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 160, "攻击 : " & GameObject.Tank.Player.alv, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 180, "防御 : " & GameObject.Tank.Player.dlv, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 500, 380, "AI : ", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 400, "活跃 : " & GameObject.Tank.GetCountAI, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 420, "剩余 : " & GameObject.Map.Info.NumAI, &HFFFFFFFF)
		Case XGE_MSG_KEY_DOWN			' keyboard down
			/'
			If CheatMode Then
				If eve->scancode = SC_F1 Then			' 秘籍 F1 : 玩家1升级
					GameObject.Tank.LevelUP(@GameObject.Tank.Player,-1)
				EndIf
				/'
				If eve->scancode = SC_F2 Then			' 秘籍 F2 : 玩家2升级
					GameObject.Tank.LevelUP(@GameObject.Tank.Player,-1)
				EndIf
				'/
				If eve->scancode = SC_F3 Then			' 秘籍 F3 : 添加AI
					GameObject.Tank.NewTankEx(GetRand(0, 3), 10)
				EndIf
				If eve->scancode = SC_F4 Then			' 秘籍 F4 : 玩家满状态
					GameObject.Tank.Player.hp = GameObject.Tank.Player.hpmax
				EndIf
			EndIf
			'/
			If eve->scancode = SC_F5 Then				' 显示血条
				ViewHP = Not(ViewHP)
			EndIf
			If eve->scancode = SC_F6 Then				' 显示等级
				ViewLevel = Not(ViewLevel)
			EndIf
			If eve->scancode = SC_F7 Then				' 数字显血
				ViewHP_Value = Not(ViewHP_Value)
			EndIf
		Case XGE_MSG_LOADRES			' load resources
			' 载入地图、初始化游戏数据
			If GameObject.Map.Load() Then
				GameObject.Tank.ReInitManage
				' 判断是否需要初始化玩家数据
				If Module.CurMapID = 1 Then
					GameObject.Tank.InitPlayer()
				Else
					If GameObject.Map.Info.ClearPlayer Then
						GameObject.Tank.InitPlayer()
					EndIf
				EndIf
				' 重设玩家数据
				GameObject.Tank.Player.stk = 1
				GameObject.Tank.Player.hp = GameObject.Tank.Player.hpmax
				Select Case GameObject.Tank.Player.tpe
					Case 2
						GameObject.Tank.Player.img = img_Tank2
					Case 3
						GameObject.Tank.Player.img = img_Tank3
					Case 4
						GameObject.Tank.Player.img = img_Tank4
					Case Else
						GameObject.Tank.Player.img = img_Tank1
				End Select
				GameObject.Tank.Player.x = GameObject.Map.Info.Player.x
				GameObject.Tank.Player.y = GameObject.Map.Info.Player.y
				GameObject.Tank.Player.dt = GameObject.Map.Info.Player.dt
			Else
				xge.Scene.Stop()
			EndIf
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function
