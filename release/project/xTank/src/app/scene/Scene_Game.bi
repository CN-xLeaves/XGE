


Dim Shared GameObject As GameSystem



' Scene function
' ����ֵ��0=�����˳� 1=ͨ�� 2=��Ϸ����
Function GameScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Select Case msg
		Case XGE_MSG_FRAME				' frame Logic processing
			' Player1 ����
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
			' ����AI
			GameObject.RunAll()
			' ����������
			If GameObject.Tank.Player.stk = 0 Then
				xge.Scene.Cut(@PauseScene, 40, FALSE, Cast(Integer, img_EndImage))
			EndIf
			' ���AI
			If GameObject.Map.HeadInfo.NumAI <= 0 Then
				If GameObject.Tank.GetCountAI = 0 Then
					' ��ͨ�ؽ���
					GameObject.Tank.Player.Exp += GameObject.Map.HeadInfo.PassExp
					Module.CurMapID += 1
					If Module.CurMapID > Module.MapCount Then
						xge.Scene.Cut(@PauseScene, 40, FALSE, Cast(Integer, img_PassImage))
					Else
						xge.Scene.Cut(@GameScene, 40)
					EndIf
				EndIf
			EndIf
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			xge.Shape.RectFull(NULL, 480, 0, 640, 452, &HFF444444)
			xge.Shape.RectFull(NULL, 480, 452, 640, 480, &HFF666666)
			' ������Ϣ����
			xge.Text.DrawRectA(NULL, 480, 452, 160, 28, "fps : " & xge.Scene.FPS, &HFFFFFFFF)
			' ����̹�ˡ���ͼ���ӵ���
			GameObject.DrawAll()
			' ���Ƶ�����Ϣ
			xge.Text.DrawA(NULL, 500,  20, "player1 :", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524,  40, "�ȼ� : " & GameObject.Tank.Player.lv, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524,  60, "װ�� : " & GameObject.Tank.Player.hp & "/" & GameObject.Tank.Player.hpmax, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524,  80, "���� : " & GameObject.Tank.Player.Exp & "/" & GameObject.Tank.Player.ExpMax, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 100, "���� : " & GameObject.Tank.Player.pt, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 120, "�ƶ� : " & GameObject.Tank.Player.slv, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 140, "װ�� : " & GameObject.Tank.Player.llv, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 160, "���� : " & GameObject.Tank.Player.alv, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 180, "���� : " & GameObject.Tank.Player.dlv, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 500, 380, "AI : ", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 400, "��Ծ : " & GameObject.Tank.GetCountAI, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 420, "ʣ�� : " & GameObject.Map.HeadInfo.NumAI, &HFFFFFFFF)
			xge.Text.DrawA(NULL, 500, 220, "���� :", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 240, "F2 ��ʾѪ��", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 260, "F3 ��ʾ�ȼ�", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 524, 280, "F4 ��ʾѪ��", &HFFFFFFFF)
			If CheatMode Then
				xge.Text.DrawA(NULL, 524, 300, "F5 �������", &HFFFFFFFF)
				xge.Text.DrawA(NULL, 524, 320, "F6 ��ӵ���", &HFFFFFFFF)
				xge.Text.DrawA(NULL, 524, 340, "F7 �ָ�Ѫ��", &HFFFFFFFF)
			EndIf
		Case XGE_MSG_KEY_DOWN			' keyboard down
			If eve->scancode = SC_F2 Then				' ��ʾѪ��
				ViewHP = IIf(ViewHP, FALSE, TRUE)
			EndIf
			If eve->scancode = SC_F3 Then				' ��ʾ�ȼ�
				ViewLevel = IIf(ViewLevel, FALSE, TRUE)
			EndIf
			If eve->scancode = SC_F4 Then				' ������Ѫ
				ViewHP_Value = IIf(ViewHP_Value, FALSE, TRUE)
			EndIf
			If CheatMode Then
				If eve->scancode = SC_F5 Then			' �ؼ� F1 : ���1����
					GameObject.Tank.LevelUP(@GameObject.Tank.Player,-1)
				EndIf
				If eve->scancode = SC_F6 Then			' �ؼ� F3 : ���AI
					Dim TankObj As TankItem Ptr = GameObject.Tank.NewTankEx(GetRand(0,3), GameObject.Tank.Player.lv)
					If TankObj Then
						TankObj->x = GameObject.Map.HeadInfo.PointAI(GameObject.AddrPointAI).x
						TankObj->y = GameObject.Map.HeadInfo.PointAI(GameObject.AddrPointAI).y
						TankObj->dt = GameObject.Map.HeadInfo.PointAI(GameObject.AddrPointAI).dt
						GameObject.AddrPointAI += 1
						If GameObject.AddrPointAI = GameObject.Map.HeadInfo.PointNum Then
							GameObject.AddrPointAI = 0
						EndIf
					EndIf
				EndIf
				If eve->scancode = SC_F7 Then			' �ؼ� F4 : �����״̬
					GameObject.Tank.Player.hp = GameObject.Tank.Player.hpmax
				EndIf
			EndIf
		Case XGE_MSG_LOADRES			' load resources
			' �����ͼ����ʼ����Ϸ����
			If GameObject.Map.Load(Module.Path & Module.CurMapID & ".map") Then
				GameObject.Tank.ReInitManage
				' �ж��Ƿ���Ҫ��ʼ���������
				If Module.CurMapID = 1 Then
					GameObject.Tank.InitPlayer()
				Else
					If GameObject.Map.HeadInfo.ClearPlayer Then
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
				GameObject.Tank.Player.x = GameObject.Map.HeadInfo.Player.x
				GameObject.Tank.Player.y = GameObject.Map.HeadInfo.Player.y
				GameObject.Tank.Player.dt = GameObject.Map.HeadInfo.Player.dt
			Else
				xge.Scene.StopAll()
			EndIf
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function
