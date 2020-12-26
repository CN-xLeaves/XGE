Dim Shared GameObject As GameSystem


' ����ֵ��0=�����˳� 1=ͨ�� 2=��Ϸ����
Function GameScreen(ByVal message As Integer,ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Select Case message
		Case xge_msg_frame				' �߼�����
			' Player1 ����
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
			' Player2 ����
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
			' ����AI
			GameObject.RunAll()
			' ����������
			Dim As Integer i,Stk
			For i = 0 To 3
				Stk = GameObject.Tank.Player(i).stk Or Stk
			Next
			If Stk=0 Then
				xge.Stop(2)
			EndIf
			' ���AI
			If GameObject.Map.Info.NumAI <= 0 Then
				If GameObject.Tank.GetCountAI = 0 Then
					' ��ͨ�ؽ���
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
		Case xge_msg_draw					' ��ͼ
			xge.Clear
			Line (480,0)-(640,452),&H444444,BF
			Line (480,452)-(640,480),&H666666,BF
			' ������Ϣ����
			Dim tr As RECT = (480,452,640,480)
			DrawStringRect(NULL,tr,"fps : " & xge.FPS,"����",9)
			' ����̹�ˡ���ͼ���ӵ���
			GameObject.DrawAll()
			' ���Ƶ�����Ϣ
			DrawString(NULL,500,20,"player1 :","����",9)
			DrawString(NULL,520,40,"�ȼ� : " & GameObject.Tank.Player(0).lv,"����",9)
			DrawString(NULL,520,60,"װ�� : " & GameObject.Tank.Player(0).hp & "/" & GameObject.Tank.Player(0).hpmax,"����",9)
			DrawString(NULL,520,80,"���� : " & GameObject.Tank.Player(0).Exp & "/" & GameObject.Tank.Player(0).ExpMax,"����",9)
			DrawString(NULL,520,100,"���� : " & GameObject.Tank.Player(0).pt,"����",9)
			DrawString(NULL,520,120,"�ƶ� : " & GameObject.Tank.Player(0).slv,"����",9)
			DrawString(NULL,520,140,"װ�� : " & GameObject.Tank.Player(0).llv,"����",9)
			DrawString(NULL,520,160,"���� : " & GameObject.Tank.Player(0).alv,"����",9)
			DrawString(NULL,520,180,"���� : " & GameObject.Tank.Player(0).dlv,"����",9)
			DrawString(NULL,500,200,"player2 :","����",9)
			DrawString(NULL,520,220,"�ȼ� : " & GameObject.Tank.Player(1).lv,"����",9)
			DrawString(NULL,520,240,"װ�� : " & GameObject.Tank.Player(1).hp & "/" & GameObject.Tank.Player(1).hpmax,"����",9)
			DrawString(NULL,520,260,"���� : " & GameObject.Tank.Player(1).Exp & "/" & GameObject.Tank.Player(1).ExpMax,"����",9)
			DrawString(NULL,520,280,"���� : " & GameObject.Tank.Player(1).pt,"����",9)
			DrawString(NULL,520,300,"�ƶ� : " & GameObject.Tank.Player(1).slv,"����",9)
			DrawString(NULL,520,320,"װ�� : " & GameObject.Tank.Player(1).llv,"����",9)
			DrawString(NULL,520,340,"���� : " & GameObject.Tank.Player(1).alv,"����",9)
			DrawString(NULL,520,360,"���� : " & GameObject.Tank.Player(1).dlv,"����",9)
			DrawString(NULL,500,380,"AI : ","����",9)
			DrawString(NULL,520,400,"��Ծ : " & GameObject.Tank.GetCountAI,"����",9)
			DrawString(NULL,520,420,"ʣ�� : " & GameObject.Map.Info.NumAI,"����",9)
		Case xge_msg_key_dowm			' ���̰���
			If Module.GodMod Then
				If Event->scancode = SC_F1 Then			' �ؼ� F1 : ���1����
					GameObject.Tank.LevelUP(@GameObject.Tank.Player(0),-1)
				EndIf
				If Event->scancode = SC_F2 Then			' �ؼ� F2 : ���2����
					GameObject.Tank.LevelUP(@GameObject.Tank.Player(1),-1)
				EndIf
				If Event->scancode = SC_F3 Then			' �ؼ� F3 : ���AI
					GameObject.Tank.NewTankEx(xge.GetRnd(0,3),10)
				EndIf
				If Event->scancode = SC_F4 Then			' �ؼ� F4 : �����״̬
					Dim i As Integer
					For i = 0 To 3
						GameObject.Tank.Player(i).stk = 1
						GameObject.Tank.Player(i).hp = GameObject.Tank.Player(i).hpmax
					Next
				EndIf
			EndIf
			If Event->scancode = SC_F5 Then				' ��ʾѪ��
				Module.ViewHP = Not(Module.ViewHP)
			EndIf
			If Event->scancode = SC_F6 Then				' ��ʾ�ȼ�
				Module.ViewLevel = Not(Module.ViewLevel)
			EndIf
			If Event->scancode = SC_F7 Then				' ������Ѫ
				Module.ViewValueHP = Not(Module.ViewValueHP)
			EndIf
			If Event->scancode = SC_1 Then				' ʹ��1����Ʒ
				
			EndIf
			If Event->scancode = SC_2 Then				' ʹ��2����Ʒ
				
			EndIf
			If Event->scancode = SC_3 Then				' ʹ��3����Ʒ
				
			EndIf
			If Event->scancode = SC_4 Then				' ʹ��4����Ʒ
				
			EndIf
		Case xge_msg_loadres			' ������Դ
			' �����ͼ����ʼ����Ϸ����
			If GameObject.Map.Load() Then
				GameObject.Tank.ReInitManage
				' �ж��Ƿ���Ҫ��ʼ���������
				If Module.ScreenAddr = 1 Then
					GameObject.Tank.InitPlayer()
				Else
					If GameObject.Map.Info.ClearPlayer Then
						GameObject.Tank.InitPlayer()
					EndIf
				EndIf
				' �����������
				Dim i As Integer
				For i = 0 To 3
					GameObject.Tank.Player(i).stk = 1
					GameObject.Tank.Player(i).hp = GameObject.Tank.Player(i).hpmax
					GameObject.Tank.Player(i).img = sfm.Get(300 + GameObject.Tank.Player(i).tpe)
					GameObject.Tank.Player(i).x = GameObject.Map.Info.Player(i).x
					GameObject.Tank.Player(i).y = GameObject.Map.Info.Player(i).y
					GameObject.Tank.Player(i).dt = GameObject.Map.Info.Player(i).dt
				Next
				' ������� : ɱ�����ź��ĺ���� [��ΪĿǰûʵ�����ź��ĺ���ҵĴ���]
				GameObject.Tank.Player(2).stk = 0
				GameObject.Tank.Player(3).stk = 0
			Else
				xge.Stop()
			EndIf
		Case xge_msg_close				' ���ڹر�
			Return -1
	End Select
End Function