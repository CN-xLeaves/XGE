

' ÿ�����ڼ�������1���˺���ÿ��װ�׼�������2��װ��

' Ѫ�����㹫ʽ bhp + (dlv x 2) + (lv \ 3)
' �ƶ��ٶȹ�ʽ mcd - (slv * 15)
' ��������ʽ kcd - (llv * 30)
' 

Type TankItem
	' ��������
	stk As Integer											' Ŀ��״̬ [0=���� 1=����]
	tpe As Integer											' ̹������ [0=��� 1=�ٶ� 2=���� 3=���� 4=�ۺ�]
	lv As Integer												' �ȼ�
	x As Integer												' ���ں�����
	y As Integer												' ����������
	dt As Integer												' ���� [0=�� 1=�� 2=�� 3=��]
	
	' ��ͼ����
	px As Integer												' ����ƫ��
	py As Integer												' ����ƫ��
	stp As Integer											' ����[0=��һ�� 1=�ڶ���]
	
	' ״̬����
	moving As Integer										' �����ƶ� [CDʱ��]
	atting As Integer										' ������� [CDʱ��]
	
	' ʵʱ����
	hp As Integer												' ��ǰѪ��
	hpmax As Integer										' ���Ѫ��
	Exp As Integer											' ����ֵ
	ExpMax As Integer										' ��������ֵ
	
	' ��������
	mcd As Integer											' �����ƶ����
	kcd As Integer											' ����������
	bhp As Integer											' ����װ��
	BExp As Integer											' ���� Exp
	AExp As Integer											' ���� Exp ���� [�ٷֱ�]
	
	' �������
	pt As Integer												' ʣ�༼�ܵ�
	slv As Integer											' �ƶ����� [������20��]
	alv As Integer											' �������� [������20��]
	dlv As Integer											' װ�׼��� [������20��]
	llv As Integer											' װ������ [������20��]
	apf As Integer											' �´μӵ� [AIʹ��] [0=����ӵ� 1=��Ҫ�ӵ�]
	
	' ��Ʒ
	goods(9) As Integer									' ��Ʒ����
	
	' Surface
	img As Any Ptr											' �ز�ͼָ��
End Type


Type TankManage Extends xywhBSMM
	' ���̹��
	Player(3) As TankItem
	
	TickNewAI As Integer						' ˢ̹��Tick
	AddrPointAI As Integer					' AI̹��ˢ�µ�ID
	
	Declare Constructor()
	
	' ����AI̹��
	Declare Function NewTankEx(ByVal theType As Integer,ByVal Level As Integer) As TankItem Ptr
	Declare Function NewTank() As TankItem Ptr
	' ��ʼ̹������[1��]
	Declare Sub IntData(ByVal TankObj As TankItem Ptr,ByVal theType As Integer)
	' �������̹������
	Declare Sub RndData(ByVal TankObj As TankItem Ptr,ByVal Level As Integer)
	' ̹������
	Declare Sub LevelUP(ByVal TankObj As TankItem Ptr,ByVal IsAI As Integer)
	' ����̹��
	Declare Sub DrawTank(ByVal TankObj As TankItem Ptr)
	Declare Sub DrawAll()
	' ̹���ƶ� [����ǳ����ƶ�]
	Declare Sub TankMove(ByVal TankObj As TankItem Ptr,ByVal x As Integer,ByVal y As Integer)
	' ����AI̹������
	Declare Function GetCountAI() As Integer
	' ����һ�����Ƿ����̹�� [TankTypeΪλ��� 1=��� 2=AI]
	Declare Function TestTank(ByVal x As Integer,ByVal y As Integer,ByVal TankType As Integer) As TankItem Ptr
	' ��ʼ�����̹��
	Declare Sub InitPlayer()
End Type



Constructor TankManage()
	StructLenght = SizeOf(TankItem)
	MemoryStep = 50
End Constructor

Function TankManage.NewTankEx(ByVal theType As Integer,ByVal Level As Integer) As TankItem Ptr
	Dim TankObj As TankItem Ptr = AddStruct()
	If TankObj Then
		IntData(TankObj,theType)
		If Level > 1 Then
			RndData(TankObj,Level)
		EndIf
		Return TankObj
	EndIf
End Function

Function TankManage.NewTank() As TankItem Ptr
	Return NewTankEx(xge.GetRnd(0,3),1)
End Function

Sub TankManage.IntData(ByVal TankObj As TankItem Ptr,ByVal theType As Integer)
	' ��������
	Clear(*TankObj,0,SizeOf(TankItem))
	' ��д������Ϣ
	TankObj->stk = 1
	TankObj->lv = 1
	TankObj->BExp = 10
	TankObj->AExp = 30
	TankObj->dt = 0
	' ���û��ָ�����ͣ������ѡ��һ��
	If theType=0 Then theType = xge.GetRnd(1,4)
	' ���ݲ�ͬ��̹�˸���ͬ������
	Select Case theType
		Case 2		' ������
			TankObj->tpe = 2
			TankObj->img = sfm.Get(302)
			TankObj->mcd = 450
			TankObj->kcd = 660
			TankObj->bhp = 3
			TankObj->slv = 0
			TankObj->alv = 1
			TankObj->dlv = 0
			TankObj->llv = 0
		Case 3		' ������
			TankObj->tpe = 3
			TankObj->img = sfm.Get(303)
			TankObj->mcd = 500
			TankObj->kcd = 800
			TankObj->bhp = 5
			TankObj->slv = 0
			TankObj->alv = 0
			TankObj->dlv = 1
			TankObj->llv = 0
		Case 4		' �ۺ���
			TankObj->tpe = 4
			TankObj->img = sfm.Get(304)
			TankObj->mcd = 400
			TankObj->kcd = 700
			TankObj->bhp = 4
			TankObj->slv = 0
			TankObj->alv = 0
			TankObj->dlv = 0
			TankObj->llv = 1
		Case Else	' �ٶ���
			TankObj->tpe = 1
			TankObj->img = sfm.Get(301)
			TankObj->mcd = 360
			TankObj->kcd = 750
			TankObj->bhp = 2
			TankObj->slv = 1
			TankObj->alv = 0
			TankObj->dlv = 0
			TankObj->llv = 0
	End Select
	' ��дʵʱ��Ϣ
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
		' �Ӽ�
		TankObj->lv += 1
		' ������tank�����Ѫ
		If TankObj->tpe = 3 Then
			TankObj->bhp += 1
		EndIf
		' �Զ��ӵ�
		If AutoPoint Then
			Select Case TankObj->tpe
				Case 2			' ������̹�� [50%�ӹ��� , ʣ���������� , 50%���ʼ�װ�� , 25%���ʼ��ƶ� , 25%���ʼӷ���]
					If TankObj->apf Then
						TankObj->alv += 1
					Else
						If xge.RndOK(5000) Then
							TankObj->llv += 1
						Else
							If xge.RndOK(5000) Then
								TankObj->slv += 1
							Else
								TankObj->dlv += 1
							EndIf
						EndIf
					EndIf
				Case 3			' ������̹�� [50%�ӷ��� , ʣ���������� , 50%���ʼ��ƶ� , 25%���ʼӹ��� , 25%���ʼ�װ��]
					If TankObj->apf Then
						TankObj->dlv += 1
					Else
						If xge.RndOK(5000) Then
							TankObj->slv += 1
						Else
							If xge.RndOK(5000) Then
								TankObj->alv += 1
							Else
								TankObj->llv += 1
							EndIf
						EndIf
					EndIf
				Case 4			' �ۺ���̹�� [ȫ25%��������ӵ� , ��25%�ļ���4��ȫ��]
					Dim RndNum As Integer = xge.GetRnd(1,5)
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
				Case Else		' �ٶ���̹�� [50%���ƶ� , ʣ���������� , 50%���ʼ�װ�� , 25%���ʼӹ��� , 25%���ʼӷ���]
					If TankObj->apf Then
						TankObj->slv += 1
					Else
						If xge.RndOK(5000) Then
							TankObj->llv += 1
						Else
							If xge.RndOK(5000) Then
								TankObj->alv += 1
							Else
								TankObj->dlv += 1
							EndIf
						EndIf
					EndIf
			End Select
			' �����´μӵ�Ŀ��
			If TankObj->apf Then
				TankObj->apf = 0
			Else
				TankObj->apf = 1
			EndIf
		Else
			' ���Զ��ӵ�����õ�������1
			TankObj->pt += 1
		EndIf
		' ���¼���ʵʱ����
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
			' ����̹������
			If TankObj->moving Then
				' һ���ƶ�ָ��ִ�����
				If (xge.Tick - TankObj->moving) > (TankObj->mcd - (TankObj->slv * 15)) Then
					TankObj->moving = 0
					TankObj->px = 0
					TankObj->py = 0
				Else
					' �ƶ�ָ�������
					Dim MoveAddr As Integer = (xge.Tick - TankObj->moving) / (TankObj->mcd - (TankObj->slv * 15)) * 16
					If MoveAddr > 16 Then MoveAddr = 16
					If MoveAddr < 0 Then MoveAddr = 0
					Select Case TankObj->dt
						Case 1			' ��
							TankObj->py = 0
							TankObj->px = -MoveAddr+16
						Case 2			' ��
							TankObj->py = 0
							TankObj->px = MoveAddr-16
						Case 3			' ��
							TankObj->px = 0
							TankObj->py = -MoveAddr+16
						Case Else		' ��
							TankObj->px = 0
							TankObj->py = MoveAddr-16
					End Select
					' ������
					If TankObj->stp Then
						TankObj->stp = 0
					Else
						TankObj->stp = 1
					EndIf
				EndIf
			EndIf
			' ��̹��
			Put (((TankObj->x-1)*16)+TankObj->px,((TankObj->y-1)*16)+TankObj->py),TankObj->img,(TankObj->stp*32,TankObj->dt*32)-Step(31,31),Trans
			' ���ȼ�
			Dim tr As RECT
			tr.left = ((TankObj->x-1)*16)+TankObj->px
			tr.top = ((TankObj->y-1)*16)+TankObj->py
			tr.right = tr.left + 32
			tr.bottom = tr.top + 12
			If Module.ViewLevel Then
				DrawStringRect(NULL,tr,"Lv." & TankObj->lv,"����",9)
			EndIf
			' ��Ѫ��
			If Module.ViewHP Then
				Line (((TankObj->x-1)*16)+TankObj->px,((TankObj->y-1)*16)+TankObj->py+13)-Step(32,4),&HFF0000,BF
				Line (((TankObj->x-1)*16)+TankObj->px+1,((TankObj->y-1)*16)+TankObj->py+14)-Step((TankObj->hp * 30) \ TankObj->hpmax,2),&HFF00,BF
			EndIf
			' ��Ѫ��
			tr.top = tr.bottom+5
			tr.bottom = tr.top + 12
			If Module.ViewValueHP Then
				DrawStringRect(NULL,tr,TankObj->hp & "/" & TankObj->hpmax,"����",9)
			EndIf
		EndIf
	EndIf
End Sub

Sub TankManage.DrawAll()
	Dim i As Integer
	' �����̹��
	For i = 0 To 3
		DrawTank(@Player(i))
	Next
	' ��AI
	Dim TankObj As TankItem Ptr
	For i = 1 To Count
		TankObj = GetPoint(i)
		If TankObj Then
			DrawTank(TankObj)
		EndIf
	Next
End Sub

Sub TankManage.TankMove(ByVal TankObj As TankItem Ptr,ByVal x As Integer,ByVal y As Integer)
	TankObj->x = x
	TankObj->y = y
	TankObj->moving = 0			' �����ƶ����ƶ��������ȴ�����
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
	' �����Ƿ�����Ҳ�����ײ
	If TankType And 1 Then
		For i = 0 To 3
			If Player(i).stk Then
				If TestPointTank(x,y,Player(i).x,Player(i).y) Then
					Return @Player(i)
				EndIf
			EndIf
		Next
	EndIf
	' �����Ƿ���AI������ײ
	If TankType And 2 Then
		Dim TankObj As TankItem Ptr
		For i = 1 To Count
			TankObj = GetPoint(i)
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
	For i = 1 To Count
		TankObj = GetPoint(i)
		If TankObj Then
			If TankObj->stk Then
				NumAI += 1
			EndIf
		EndIf
	Next
	Return NumAI
End Function

Sub TankManage.InitPlayer()
	Dim i As Integer
	For i = 0 To 3
		IntData(@Player(i),Module.Player(i))
		' Ϊ���̹������һ��������
		Player(i).mcd -= 30
		Player(i).kcd -= 30
		Player(i).bhp += 5
		If Module.PlayerLV > 1 Then
			RndData(@Player(i),Module.PlayerLV)
		EndIf
	Next
End Sub
