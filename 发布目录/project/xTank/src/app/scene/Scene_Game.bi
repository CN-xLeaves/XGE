


Dim Shared GameObject As GameSystem



' Scene function
' ����ֵ��0=�����˳� 1=ͨ�� 2=��Ϸ����
Function GameScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Select Case msg
		Case XGE_MSG_FRAME				' frame Logic processing
			' Player1 ����
			If GameObject.Tank.Player.stk Then
				If MultiKey(SC_W) Then
					GameObject.TankMove(@GameObject.Tank.Player,3)
				ElseIf MultiKey(SC_S) Then
					GameObject.TankMove(@GameObject.Tank.Player,0)
				ElseIf MultiKey(SC_A) Then
					GameObject.TankMove(@GameObject.Tank.Player,1)
				ElseIf MultiKey(SC_D) Then
					GameObject.TankMove(@GameObject.Tank.Player,2)
				EndIf
				If MultiKey(SC_J) Then
					GameObject.TankFire(@GameObject.Tank.Player,1)
				EndIf
			EndIf
			'/'
			' ����AI
			GameObject.RunAll()
			' ����������
			If GameObject.Tank.Player.stk = 0 Then
				xge.Scene.Stop()
			EndIf
			' ���AI
			If GameObject.Map.Info.NumAI <= 0 Then
				If GameObject.Tank.GetCountAI = 0 Then
					' ��ͨ�ؽ���
					/'
					GameObject.Tank.Player.Exp += GameObject.Map.Info.PassExp
					GameObject.Tank.Player.goods(0) = GameObject.Map.Info.AddGoods1
					GameObject.Tank.Player.goods(1) = GameObject.Map.Info.AddGoods2
					GameObject.Tank.Player.goods(2) = GameObject.Map.Info.AddGoods3
					GameObject.Tank.Player.goods(3) = GameObject.Map.Info.AddGoods4
					'/
					Module.CurMapID += 1
					xge.Scene.Stop()
				EndIf
			EndIf
			'/
		Case XGE_MSG_DRAW				' draw
			xge.Clear
			xge.Shape.Rect(480, 0, 640, 452, &HFF444444)
			xge.Shape.Rect(480, 452, 640, 480, &HFF666666)
			' ������Ϣ����
			Dim tr As RECT = (480,452,640,480)
			'DrawStringRect(NULL,tr,"fps : " & xge.FPS,"����",9)
			' ����̹�ˡ���ͼ���ӵ���
			GameObject.DrawAll()
			' ���Ƶ�����Ϣ
			'DrawString(NULL,500,20,"player1 :","����",9)
			'DrawString(NULL,520,40,"�ȼ� : " & GameObject.Tank.Player(0).lv,"����",9)
			'DrawString(NULL,520,60,"װ�� : " & GameObject.Tank.Player(0).hp & "/" & GameObject.Tank.Player(0).hpmax,"����",9)
			'DrawString(NULL,520,80,"���� : " & GameObject.Tank.Player(0).Exp & "/" & GameObject.Tank.Player(0).ExpMax,"����",9)
			'DrawString(NULL,520,100,"���� : " & GameObject.Tank.Player(0).pt,"����",9)
			'DrawString(NULL,520,120,"�ƶ� : " & GameObject.Tank.Player(0).slv,"����",9)
			'DrawString(NULL,520,140,"װ�� : " & GameObject.Tank.Player(0).llv,"����",9)
			'DrawString(NULL,520,160,"���� : " & GameObject.Tank.Player(0).alv,"����",9)
			'DrawString(NULL,520,180,"���� : " & GameObject.Tank.Player(0).dlv,"����",9)
			'DrawString(NULL,500,200,"player2 :","����",9)
			'DrawString(NULL,520,220,"�ȼ� : " & GameObject.Tank.Player(1).lv,"����",9)
			'DrawString(NULL,520,240,"װ�� : " & GameObject.Tank.Player(1).hp & "/" & GameObject.Tank.Player(1).hpmax,"����",9)
			'DrawString(NULL,520,260,"���� : " & GameObject.Tank.Player(1).Exp & "/" & GameObject.Tank.Player(1).ExpMax,"����",9)
			'DrawString(NULL,520,280,"���� : " & GameObject.Tank.Player(1).pt,"����",9)
			'DrawString(NULL,520,300,"�ƶ� : " & GameObject.Tank.Player(1).slv,"����",9)
			'DrawString(NULL,520,320,"װ�� : " & GameObject.Tank.Player(1).llv,"����",9)
			'DrawString(NULL,520,340,"���� : " & GameObject.Tank.Player(1).alv,"����",9)
			'DrawString(NULL,520,360,"���� : " & GameObject.Tank.Player(1).dlv,"����",9)
			'DrawString(NULL,500,380,"AI : ","����",9)
			'DrawString(NULL,520,400,"��Ծ : " & GameObject.Tank.GetCountAI,"����",9)
			'DrawString(NULL,520,420,"ʣ�� : " & GameObject.Map.Info.NumAI,"����",9)
		Case XGE_MSG_KEY_DOWN			' keyboard down
			/'
			If CheatMode Then
				If eve->scancode = SC_F1 Then			' �ؼ� F1 : ���1����
					GameObject.Tank.LevelUP(@GameObject.Tank.Player,-1)
				EndIf
				/'
				If eve->scancode = SC_F2 Then			' �ؼ� F2 : ���2����
					GameObject.Tank.LevelUP(@GameObject.Tank.Player,-1)
				EndIf
				'/
				If eve->scancode = SC_F3 Then			' �ؼ� F3 : ���AI
					GameObject.Tank.NewTankEx(GetRand(0, 3), 10)
				EndIf
				If eve->scancode = SC_F4 Then			' �ؼ� F4 : �����״̬
					GameObject.Tank.Player.hp = GameObject.Tank.Player.hpmax
				EndIf
			EndIf
			If eve->scancode = SC_F5 Then				' ��ʾѪ��
				ViewHP = Not(ViewHP)
			EndIf
			If eve->scancode = SC_F6 Then				' ��ʾ�ȼ�
				ViewLevel = Not(ViewLevel)
			EndIf
			If eve->scancode = SC_F7 Then				' ������Ѫ
				ViewHP_Value = Not(ViewHP_Value)
			EndIf
			If eve->scancode = SC_1 Then				' ʹ��1����Ʒ
				
			EndIf
			If eve->scancode = SC_2 Then				' ʹ��2����Ʒ
				
			EndIf
			If eve->scancode = SC_3 Then				' ʹ��3����Ʒ
				
			EndIf
			If eve->scancode = SC_4 Then				' ʹ��4����Ʒ
				
			EndIf'/
		Case XGE_MSG_LOADRES			' load resources
			' �����ͼ����ʼ����Ϸ����
			If GameObject.Map.Load() Then
				GameObject.Tank.ReInitManage
				' �ж��Ƿ���Ҫ��ʼ���������
				If Module.CurMapID = 1 Then
					GameObject.Tank.InitPlayer()
				Else
					If GameObject.Map.Info.ClearPlayer Then
						GameObject.Tank.InitPlayer()
					EndIf
				EndIf
				' �����������
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
