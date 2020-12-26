Type Tank_AmmoItem
	stk As Integer							' �ӵ�״̬ [0=����]
	x As Integer								' �ӵ���ǰ������
	y As Integer								' �ӵ���ǰ������
	dt As Integer								' �ӵ����䷽��
	Atk As Integer							' �ӵ�����
	IsAI As Integer							' �ӵ���Ӫ [0=AI 1=���1 2=���2 3=���3 4=���4]
	boom As Integer							' ��ը
End Type



Type Tank_AmmoManage Extends xywhBSMM
	Declare Function AddAmmo(ByVal x As Integer,ByVal y As Integer,ByVal dt As Integer,ByVal Atk As Integer,ByVal IsAI As Integer) As Tank_AmmoItem Ptr
	Declare Sub Boom(ByVal AmmoObj As Tank_AmmoItem Ptr)
	
	Declare Sub DrawAmmo(ByVal AmmoObj As Tank_AmmoItem Ptr)
	Declare Sub DrawAll()
	
	Declare Constructor()
End Type



Constructor Tank_AmmoManage()
	StructLenght = SizeOf(Tank_AmmoItem)
	MemoryStep = 10
End Constructor



Function Tank_AmmoManage.AddAmmo(ByVal x As Integer,ByVal y As Integer,ByVal dt As Integer,ByVal Atk As Integer,ByVal IsAI As Integer) As Tank_AmmoItem Ptr
	' �ȼ����û���ӵ���λ
	Dim i As Integer
	Dim AmmoObj As Tank_AmmoItem Ptr
	For i = 1 To Count
		AmmoObj = GetPoint(i)
		If AmmoObj Then
			If AmmoObj->stk=0 Then
				If AmmoObj->boom = 0 Then
					AmmoObj->stk = -1
					AmmoObj->x = x
					AmmoObj->y = y
					AmmoObj->dt = dt
					AmmoObj->Atk = Atk
					AmmoObj->IsAI = IsAI
					Return AmmoObj
				EndIf
			EndIf
		EndIf
	Next
	' û�п�λ������һ���µ�λ��
	AmmoObj = AddStruct()
	If AmmoObj Then
		AmmoObj->stk = -1
		AmmoObj->x = x
		AmmoObj->y = y
		AmmoObj->dt = dt
		AmmoObj->Atk = Atk
		AmmoObj->IsAI = IsAI
		Return AmmoObj
	EndIf
End Function

Sub Tank_AmmoManage.Boom(ByVal AmmoObj As Tank_AmmoItem Ptr)
	AmmoObj->stk = 0
	AmmoObj->boom = 8
End Sub

Sub Tank_AmmoManage.DrawAmmo(ByVal AmmoObj As Tank_AmmoItem Ptr)
	If AmmoObj->stk Then
		Select Case AmmoObj->dt
			Case 1			' ��
				Line ((AmmoObj->x-1)*16,(AmmoObj->y-1)*16+15)-Step(2,2),&HFF0000,BF
				Line ((AmmoObj->x-1)*16+2,(AmmoObj->y-1)*16+15)-Step(4,2),&HFF5555,BF
				Line ((AmmoObj->x-1)*16+6,(AmmoObj->y-1)*16+15)-Step(5,2),&HFFAAAA,BF
				Line ((AmmoObj->x-1)*16+11,(AmmoObj->y-1)*16+15)-Step(5,2),&HFFFFFF,BF
			Case 2			' ��
				Line ((AmmoObj->x-1)*16+31,(AmmoObj->y-1)*16+15)-Step(-2,2),&HFF0000,BF
				Line ((AmmoObj->x-1)*16+29,(AmmoObj->y-1)*16+15)-Step(-4,2),&HFF5555,BF
				Line ((AmmoObj->x-1)*16+24,(AmmoObj->y-1)*16+15)-Step(-5,2),&HFFAAAA,BF
				Line ((AmmoObj->x-1)*16+19,(AmmoObj->y-1)*16+15)-Step(-5,2),&HFFFFFF,BF
			Case 3			' ��
				Line ((AmmoObj->x-1)*16+15,(AmmoObj->y-1)*16)-Step(2,2),&HFF0000,BF
				Line ((AmmoObj->x-1)*16+15,(AmmoObj->y-1)*16+2)-Step(2,4),&HFF5555,BF
				Line ((AmmoObj->x-1)*16+15,(AmmoObj->y-1)*16+6)-Step(2,5),&HFFAAAA,BF
				Line ((AmmoObj->x-1)*16+15,(AmmoObj->y-1)*16+11)-Step(2,5),&HFFFFFF,BF
			Case Else		' ��
				Line ((AmmoObj->x-1)*16+15,(AmmoObj->y-1)*16+31)-Step(2,2),&HFF0000,BF
				Line ((AmmoObj->x-1)*16+15,(AmmoObj->y-1)*16+29)-Step(2,4),&HFF5555,BF
				Line ((AmmoObj->x-1)*16+15,(AmmoObj->y-1)*16+24)-Step(2,5),&HFFAAAA,BF
				Line ((AmmoObj->x-1)*16+15,(AmmoObj->y-1)*16+19)-Step(2,5),&HFFFFFF,BF
		End Select
	Else
		If AmmoObj->boom Then
			Put ((AmmoObj->x-1)*16,(AmmoObj->y-1)*16),sfm.get(200),((AmmoObj->boom-1)*32,0)-Step(31,31),Trans
			AmmoObj->boom -= 1
		EndIf
	EndIf
End Sub

Sub Tank_AmmoManage.DrawAll()
	Dim i As Integer
	Dim AmmoObj As Tank_AmmoItem Ptr
	For i = 1 To Count
		AmmoObj = GetPoint(i)
		If AmmoObj Then
			DrawAmmo(AmmoObj)
		EndIf
	Next
End Sub
