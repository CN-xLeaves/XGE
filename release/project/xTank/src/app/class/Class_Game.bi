
Type GameSystem
	Map As Tank_Map
	Ammo As Tank_AmmoManage
	Tank As TankManage
	
	TickNewAI As Integer						' ˢ̹��Tick
	AddrPointAI As Integer					' AI̹��ˢ�µ�ID
	TimeAddHP As Integer
	
	' ̹�˲�����װ��ҽ�
	Declare Sub TankMove(ByVal TankObj As TankItem Ptr,ByVal dt As Integer)
	Declare Sub TankFire(ByVal TankObj As TankItem Ptr,ByVal IsAI As Integer)
	
	' ͨ�в��� [����-1����ͨ��]
	Declare Function TestWalk(ByVal x As Integer,ByVal y As Integer,ByVal dt As Integer) As Integer
	
	' ִ��AI
	Declare Sub RunTank(ByVal TankObj As TankItem Ptr)
	Declare Sub RunAI()
	
	' ������Ϸ
	Declare Sub RunAll()
	
	' ȫ������
	Declare Sub DrawAll()
End Type



Function GameSystem.TestWalk(ByVal x As Integer,ByVal y As Integer,ByVal dt As Integer) As Integer
	' ��ȡҪ���Ե�����
	Dim As Point p1,p2
	Select Case dt
		Case 1			' ��
			p1.x = x-1
			p1.y = y
			p2.x = x-1
			p2.y = y+1
		Case 2			' ��
			p1.x = x+2
			p1.y = y
			p2.x = x+2
			p2.y = y+1
		Case 3			' ��
			p1.x = x
			p1.y = y-1
			p2.x = x+1
			p2.y = y-1
		Case Else		' ��
			p1.x = x
			p1.y = y+2
			p2.x = x+1
			p2.y = y+2
	End Select
	' ���Ե�ͼ
	If Map.Test(p1.x,p1.y) Then
		Return -1
	EndIf
	If Map.Test(p2.x,p2.y) Then
		Return -1
	EndIf
	' ���Ի̹��
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
			' ת��
			TankObj->dt = dt
			' ͨ�м��
			If TestWalk(TankObj->x,TankObj->y,dt)=0 Then
				' ��ͼԽ����
				Select Case dt
					Case 1			' ��
						If TankObj->x > 1 Then IsMove = -1
					Case 2			' ��
						If TankObj->x < (Map.HeadInfo.MapWidth-1) Then IsMove = -1
					Case 3			' ��
						If TankObj->y > 1 Then IsMove = -1
					Case Else		' ��
						If TankObj->y < (Map.HeadInfo.MapHeight-1) Then IsMove = -1
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
				TankObj->moving = GetTickCount()
			EndIf
		EndIf
	EndIf
End Sub

Sub GameSystem.TankFire(ByVal TankObj As TankItem Ptr,ByVal IsAI As Integer)
	If TankObj->atting=0 Then
		TankObj->atting = GetTickCount()
		Ammo.AddAmmo(TankObj->x,TankObj->y,TankObj->dt,TankObj->alv + 1,IsAI)
		se_Fire->Play()
	Else
		If (GetTickCount - TankObj->atting) > (TankObj->kcd - (TankObj->llv * 30)) Then
			TankObj->atting = 0
		EndIf
	EndIf
End Sub

Sub GameSystem.RunTank(ByVal TankObj As TankItem Ptr)
	If TankObj Then
		If TankObj->stk Then
			If TankObj->moving=0 Then
				Select Case TankObj->dt
					Case 1			' �� [80%�������� , 10%���� , 10%����]
						If RandTest(8000) Then
							TankMove(TankObj,1)
						Else
							If RandTest(5000) Then
								TankMove(TankObj,0)
							Else
								TankMove(TankObj,3)
							EndIf
						EndIf
					Case 2			' �� [80%�������� , 10%���� , 10%����]
						If RandTest(8000) Then
							TankMove(TankObj,2)
						Else
							If RandTest(5000) Then
								TankMove(TankObj,0)
							Else
								TankMove(TankObj,3)
							EndIf
						EndIf
					Case 3			' �� [80%�������� , 10%���� , 10%����]
						If RandTest(8000) Then
							TankMove(TankObj,3)
						Else
							If RandTest(5000) Then
								TankMove(TankObj,1)
							Else
								TankMove(TankObj,2)
							EndIf
						EndIf
					Case Else		' �� [80%�������� , 10%���� , 10%����]
						If RandTest(8000) Then
							TankMove(TankObj,0)
						Else
							If RandTest(5000) Then
								TankMove(TankObj,1)
							Else
								TankMove(TankObj,2)
							EndIf
						EndIf
				End Select
			EndIf
			' ��ͣ�����
			TankFire(TankObj,0)
		EndIf
	EndIf
End Sub

Sub GameSystem.RunAI()
	Dim i As Integer
	' ����ȫ���з�AI
	Dim TankObj As TankItem Ptr
	For i = 1 To Tank.StructCount
		TankObj = Tank.GetPtrStruct(i)
		If TankObj Then
			RunTank(TankObj)
		EndIf
	Next
End Sub

Sub GameSystem.RunAll()
	Dim i As Integer
	' ˢ��
	If GetTickCount() - TickNewAI > Module.SpawnTime Then
		TickNewAI = GetTickCount()
		If Map.HeadInfo.NumAI > 0 Then
			If Tank.GetCountAI < Map.HeadInfo.RunAI Then
				Dim TankObj As TankItem Ptr = Tank.NewTankEx(GetRand(0,3), Tank.Player.lv)
				If TankObj Then
					TankObj->x = Map.HeadInfo.PointAI(AddrPointAI).x
					TankObj->y = Map.HeadInfo.PointAI(AddrPointAI).y
					TankObj->dt = Map.HeadInfo.PointAI(AddrPointAI).dt
					
					AddrPointAI += 1
					If AddrPointAI = Map.HeadInfo.PointNum Then
						AddrPointAI = 0
					EndIf
					Map.HeadInfo.NumAI -= 1
				EndIf
			EndIf
		EndIf
		' ��AI�;���
		Dim TankObj As TankItem Ptr
		For i = 1 To Tank.StructCount
			TankObj = Tank.GetPtrStruct(i)
			If TankObj->stk Then
				TankObj->Exp += GetRand(0,4) * ((TankObj->ExpMax \ 30) + 1)
				If TankObj->Exp >= TankObj->ExpMax Then
					Tank.LevelUP(TankObj,-1)
				EndIf
			EndIf
		Next
	EndIf
	' �����ӵ�
	Dim AmmoObj As Tank_AmmoItem Ptr
	For i = 1 To Ammo.StructCount
		AmmoObj = Ammo.GetPtrStruct(i)
		If AmmoObj Then
			If AmmoObj->stk Then
				Dim As Point p1,p2
				' �ӵ��ƶ���Խ���顢ȡ��ײ����
				Select Case AmmoObj->dt
					Case 1			' ��
						AmmoObj->x -= 1
						If AmmoObj->x <= 0 Then AmmoObj->stk = 0
						p1.x = AmmoObj->x
						p1.y = AmmoObj->y
						p2.x = AmmoObj->x
						p2.y = AmmoObj->y + 1
					Case 2			' ��
						AmmoObj->x += 1
						If AmmoObj->x >= Map.HeadInfo.MapWidth Then AmmoObj->stk = 0
						p1.x = AmmoObj->x
						p1.y = AmmoObj->y
						p2.x = AmmoObj->x
						p2.y = AmmoObj->y + 1
					Case 3			' ��
						AmmoObj->y -= 1
						If AmmoObj->y <= 0 Then AmmoObj->stk = 0
						p1.x = AmmoObj->x
						p1.y = AmmoObj->y
						p2.x = AmmoObj->x + 1
						p2.y = AmmoObj->y
					Case Else		' ��
						AmmoObj->y += 1
						If AmmoObj->y >= Map.HeadInfo.MapHeight Then AmmoObj->stk = 0
						p1.x = AmmoObj->x
						p1.y = AmmoObj->y
						p2.x = AmmoObj->x + 1
						p2.y = AmmoObj->y
				End Select
				' �ӵ���ײ��� [ǽ]
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
				' �ӵ���ײ��� [̹��]
				If AmmoObj->stk Then
					Dim tk1 As TankItem Ptr = Tank.TestTank(p1.x,p1.y,IIf(AmmoObj->IsAI,2,1))
					Dim tk2 As TankItem Ptr = Tank.TestTank(p2.x,p2.y,IIf(AmmoObj->IsAI,2,1))
					If tk1 = tk2 Then
						tk2 = NULL
					EndIf
					If tk1 Then
						Ammo.Boom(AmmoObj)
						tk1->hp -= AmmoObj->Atk
						' ��һ�������� [�൱��̹�˵ȼ�]
						If tk1->hp <= 0 Then
							tk1->stk = 0
							Tank.Player.Exp += tk1->lv * Module.ExpMul
							se_Boom->Play()
						EndIf
					EndIf
					If tk2 Then
						Ammo.Boom(AmmoObj)
						tk2->hp -= AmmoObj->Atk
						' ��һ�������� [�൱��̹�˵ȼ�]
						If tk2->hp <= 0 Then
							tk2->stk = 0
							Tank.Player.Exp += tk2->lv * Module.ExpMul
							se_Boom->Play()
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	Next
	' ������Ѫ��\�Ƿ�����
	If Tank.Player.hp <= 0 Then
		Tank.Player.stk = 0
		se_Boom->Play()
	EndIf
	If Tank.Player.Exp >= Tank.Player.ExpMax Then
		Tank.LevelUP(@Tank.Player, -1)
	EndIf
	' �Զ�Ϊ��Ҽ�Ѫ
	If GetTickCount() - TimeAddHP > Module.AddHPTime Then
		TimeAddHP = GetTickCount()
		If Tank.Player.stk Then
			If Tank.Player.hp < Tank.Player.hpmax Then
				Tank.Player.hp += 1
			EndIf
		EndIf
	EndIf
	' ����AI
	RunAI
End Sub

Sub GameSystem.DrawAll()
	Map.Draw(0,0)
	Tank.DrawAll()
	Ammo.DrawAll()
End Sub
