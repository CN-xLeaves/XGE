Dim Shared GameObject As GameSystem


' 返回值：0=意外退出 1=通关 2=游戏结束
Function GameScreen(ByVal message As Integer,ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Select Case message
		Case xge_msg_frame				' 逻辑处理
			' Player1 控制
			If GameObject.Tank.Player(0).stk Then
				If MultiKey(SC_W) Then
					GameObject.TankMove(@GameObject.Tank.Player(0),3)
				ElseIf MultiKey(SC_S) Then
					GameObject.TankMove(@GameObject.Tank.Player(0),0)
				ElseIf MultiKey(SC_A) Then
					GameObject.TankMove(@GameObject.Tank.Player(0),1)
				ElseIf MultiKey(SC_D) Then
					GameObject.TankMove(@GameObject.Tank.Player(0),2)
				EndIf
				If MultiKey(SC_J) Then
					GameObject.TankFire(@GameObject.Tank.Player(0),1)
				EndIf
			EndIf
			' Player2 控制
			If GameObject.Tank.Player(1).stk Then
				If MultiKey(SC_UP) Then
					GameObject.TankMove(@GameObject.Tank.Player(1),3)
				ElseIf MultiKey(SC_DOWN) Then
					GameObject.TankMove(@GameObject.Tank.Player(1),0)
				ElseIf MultiKey(SC_LEFT) Then
					GameObject.TankMove(@GameObject.Tank.Player(1),1)
				ElseIf MultiKey(SC_RIGHT) Then
					GameObject.TankMove(@GameObject.Tank.Player(1),2)
				EndIf
				If MultiKey(SC_SPACE) Then
					GameObject.TankFire(@GameObject.Tank.Player(1),2)
				EndIf
			EndIf
			' 处理AI
			GameObject.RunAll()
			' 检测玩家死亡
			Dim As Integer i,Stk
			For i = 0 To 3
				Stk = GameObject.Tank.Player(i).stk Or Stk
			Next
			If Stk=0 Then
				xge.Stop(2)
			EndIf
			' 检测AI
			If GameObject.Map.Info.NumAI <= 0 Then
				If GameObject.Tank.GetCountAI = 0 Then
					' 给通关奖励
					GameObject.Tank.Player(0).Exp += GameObject.Map.Info.PassExp
					GameObject.Tank.Player(0).goods(0) = GameObject.Map.Info.AddGoods1
					GameObject.Tank.Player(0).goods(1) = GameObject.Map.Info.AddGoods2
					GameObject.Tank.Player(0).goods(2) = GameObject.Map.Info.AddGoods3
					GameObject.Tank.Player(0).goods(3) = GameObject.Map.Info.AddGoods4
					GameObject.Tank.Player(1).Exp += GameObject.Map.Info.PassExp
					GameObject.Tank.Player(1).goods(0) = GameObject.Map.Info.AddGoods1
					GameObject.Tank.Player(1).goods(1) = GameObject.Map.Info.AddGoods2
					GameObject.Tank.Player(1).goods(2) = GameObject.Map.Info.AddGoods3
					GameObject.Tank.Player(1).goods(3) = GameObject.Map.Info.AddGoods4
					Module.ScreenAddr += 1
					xge.Stop(1)
				EndIf
			EndIf
		Case xge_msg_draw					' 绘图
			xge.Clear
			Line (480,0)-(640,452),&H444444,BF
			Line (480,452)-(640,480),&H666666,BF
			' 绘制信息文字
			Dim tr As RECT = (480,452,640,480)
			DrawStringRect(NULL,tr,"fps : " & xge.FPS,"宋体",9)
			' 绘制坦克、地图、子弹等
			GameObject.DrawAll()
			' 绘制调试信息
			DrawString(NULL,500,20,"player1 :","宋体",9)
			DrawString(NULL,520,40,"等级 : " & GameObject.Tank.Player(0).lv,"宋体",9)
			DrawString(NULL,520,60,"装甲 : " & GameObject.Tank.Player(0).hp & "/" & GameObject.Tank.Player(0).hpmax,"宋体",9)
			DrawString(NULL,520,80,"经验 : " & GameObject.Tank.Player(0).Exp & "/" & GameObject.Tank.Player(0).ExpMax,"宋体",9)
			DrawString(NULL,520,100,"点数 : " & GameObject.Tank.Player(0).pt,"宋体",9)
			DrawString(NULL,520,120,"移动 : " & GameObject.Tank.Player(0).slv,"宋体",9)
			DrawString(NULL,520,140,"装填 : " & GameObject.Tank.Player(0).llv,"宋体",9)
			DrawString(NULL,520,160,"攻击 : " & GameObject.Tank.Player(0).alv,"宋体",9)
			DrawString(NULL,520,180,"防御 : " & GameObject.Tank.Player(0).dlv,"宋体",9)
			DrawString(NULL,500,200,"player2 :","宋体",9)
			DrawString(NULL,520,220,"等级 : " & GameObject.Tank.Player(1).lv,"宋体",9)
			DrawString(NULL,520,240,"装甲 : " & GameObject.Tank.Player(1).hp & "/" & GameObject.Tank.Player(1).hpmax,"宋体",9)
			DrawString(NULL,520,260,"经验 : " & GameObject.Tank.Player(1).Exp & "/" & GameObject.Tank.Player(1).ExpMax,"宋体",9)
			DrawString(NULL,520,280,"点数 : " & GameObject.Tank.Player(1).pt,"宋体",9)
			DrawString(NULL,520,300,"移动 : " & GameObject.Tank.Player(1).slv,"宋体",9)
			DrawString(NULL,520,320,"装填 : " & GameObject.Tank.Player(1).llv,"宋体",9)
			DrawString(NULL,520,340,"攻击 : " & GameObject.Tank.Player(1).alv,"宋体",9)
			DrawString(NULL,520,360,"防御 : " & GameObject.Tank.Player(1).dlv,"宋体",9)
			DrawString(NULL,500,380,"AI : ","宋体",9)
			DrawString(NULL,520,400,"活跃 : " & GameObject.Tank.GetCountAI,"宋体",9)
			DrawString(NULL,520,420,"剩余 : " & GameObject.Map.Info.NumAI,"宋体",9)
		Case xge_msg_key_dowm			' 键盘按下
			If Module.GodMod Then
				If Event->scancode = SC_F1 Then			' 秘籍 F1 : 玩家1升级
					GameObject.Tank.LevelUP(@GameObject.Tank.Player(0),-1)
				EndIf
				If Event->scancode = SC_F2 Then			' 秘籍 F2 : 玩家2升级
					GameObject.Tank.LevelUP(@GameObject.Tank.Player(1),-1)
				EndIf
				If Event->scancode = SC_F3 Then			' 秘籍 F3 : 添加AI
					GameObject.Tank.NewTankEx(xge.GetRnd(0,3),10)
				EndIf
				If Event->scancode = SC_F4 Then			' 秘籍 F4 : 玩家满状态
					Dim i As Integer
					For i = 0 To 3
						GameObject.Tank.Player(i).stk = 1
						GameObject.Tank.Player(i).hp = GameObject.Tank.Player(i).hpmax
					Next
				EndIf
			EndIf
			If Event->scancode = SC_F5 Then				' 显示血条
				Module.ViewHP = Not(Module.ViewHP)
			EndIf
			If Event->scancode = SC_F6 Then				' 显示等级
				Module.ViewLevel = Not(Module.ViewLevel)
			EndIf
			If Event->scancode = SC_F7 Then				' 数字显血
				Module.ViewValueHP = Not(Module.ViewValueHP)
			EndIf
			If Event->scancode = SC_1 Then				' 使用1号物品
				
			EndIf
			If Event->scancode = SC_2 Then				' 使用2号物品
				
			EndIf
			If Event->scancode = SC_3 Then				' 使用3号物品
				
			EndIf
			If Event->scancode = SC_4 Then				' 使用4号物品
				
			EndIf
		Case xge_msg_loadres			' 加载资源
			' 载入地图、初始化游戏数据
			If GameObject.Map.Load() Then
				GameObject.Tank.ReInitManage
				' 判断是否需要初始化玩家数据
				If Module.ScreenAddr = 1 Then
					GameObject.Tank.InitPlayer()
				Else
					If GameObject.Map.Info.ClearPlayer Then
						GameObject.Tank.InitPlayer()
					EndIf
				EndIf
				' 重设玩家数据
				Dim i As Integer
				For i = 0 To 3
					GameObject.Tank.Player(i).stk = 1
					GameObject.Tank.Player(i).hp = GameObject.Tank.Player(i).hpmax
					GameObject.Tank.Player(i).img = sfm.Get(300 + GameObject.Tank.Player(i).tpe)
					GameObject.Tank.Player(i).x = GameObject.Map.Info.Player(i).x
					GameObject.Tank.Player(i).y = GameObject.Map.Info.Player(i).y
					GameObject.Tank.Player(i).dt = GameObject.Map.Info.Player(i).dt
				Next
				' 特殊代码 : 杀死三号和四号玩家 [因为目前没实现三号和四号玩家的代码]
				GameObject.Tank.Player(2).stk = 0
				GameObject.Tank.Player(3).stk = 0
			Else
				xge.Stop()
			EndIf
		Case xge_msg_close				' 窗口关闭
			Return -1
	End Select
End Function