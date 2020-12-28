Type Tank_AmmoItem
	stk As Integer							' �ӵ�״̬ [0=����]
	x As Integer								' �ӵ���ǰ������
	y As Integer								' �ӵ���ǰ������
	dt As Integer								' �ӵ����䷽��
	Atk As Integer							' �ӵ�����
	IsAI As Integer							' �ӵ���Ӫ [0=AI 1=���]
	boom As Integer							' ��ը
End Type



Type Tank_AmmoManage Extends xBsmm
	Declare Function AddAmmo(ByVal x As Integer,ByVal y As Integer,ByVal dt As Integer,ByVal Atk As Integer,ByVal IsAI As Integer) As Tank_AmmoItem Ptr
	Declare Sub Boom(ByVal AmmoObj As Tank_AmmoItem Ptr)
	
	Declare Sub DrawAmmo(ByVal AmmoObj As Tank_AmmoItem Ptr)
	Declare Sub DrawAll()
	
	Declare Constructor()
End Type



Constructor Tank_AmmoManage()
	StructLenght = SizeOf(Tank_AmmoItem)
	AllocStep = 10
End Constructor



Function Tank_AmmoManage.AddAmmo(ByVal x As Integer,ByVal y As Integer,ByVal dt As Integer,ByVal Atk As Integer,ByVal IsAI As Integer) As Tank_AmmoItem Ptr
	' �ȼ����û���ӵ���λ
	Dim i As Integer
	Dim AmmoObj As Tank_AmmoItem Ptr
	For i = 1 To StructCount
		AmmoObj = GetPtrStruct(i)
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
	i = AppendStruct()
	AmmoObj = GetPtrStruct(i)
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
				xge.Shape.RectFull((AmmoObj->x-1)*16, (AmmoObj->y-1)*16+15, (AmmoObj->x-1)*16 + 2, (AmmoObj->y-1)*16+15 + 2, &HFFFF0000)
				xge.Shape.RectFull((AmmoObj->x-1)*16+2, (AmmoObj->y-1)*16+15, (AmmoObj->x-1)*16+2 + 2, (AmmoObj->y-1)*16+15 + 2, &HFFFF5555)
				xge.Shape.RectFull((AmmoObj->x-1)*16+6, (AmmoObj->y-1)*16+15, (AmmoObj->x-1)*16+6 + 2, (AmmoObj->y-1)*16+15 + 2, &HFFFFAAAA)
				xge.Shape.RectFull((AmmoObj->x-1)*16+11, (AmmoObj->y-1)*16+15, (AmmoObj->x-1)*16+11 + 2, (AmmoObj->y-1)*16+15 + 2, &HFFFFFFFF)
			Case 2			' ��
				xge.Shape.RectFull((AmmoObj->x-1)*16+31, (AmmoObj->y-1)*16+15, (AmmoObj->x-1)*16+31 - 2, (AmmoObj->y-1)*16+15 + 2, &HFFFF0000)
				xge.Shape.RectFull((AmmoObj->x-1)*16+29, (AmmoObj->y-1)*16+15, (AmmoObj->x-1)*16+29 - 4, (AmmoObj->y-1)*16+15 + 2, &HFFFF5555)
				xge.Shape.RectFull((AmmoObj->x-1)*16+24, (AmmoObj->y-1)*16+15, (AmmoObj->x-1)*16+24 - 5, (AmmoObj->y-1)*16+15 + 2, &HFFFFAAAA)
				xge.Shape.RectFull((AmmoObj->x-1)*16+19, (AmmoObj->y-1)*16+15, (AmmoObj->x-1)*16+19 - 5, (AmmoObj->y-1)*16+15 + 2, &HFFFFFFFF)
			Case 3			' ��
				xge.Shape.RectFull((AmmoObj->x-1)*16+15, (AmmoObj->y-1)*16, (AmmoObj->x-1)*16+15 + 2, (AmmoObj->y-1)*16 + 2, &HFFFF0000)
				xge.Shape.RectFull((AmmoObj->x-1)*16+15, (AmmoObj->y-1)*16+2, (AmmoObj->x-1)*16+15 + 2, (AmmoObj->y-1)*16+2 + 4, &HFFFF5555)
				xge.Shape.RectFull((AmmoObj->x-1)*16+15, (AmmoObj->y-1)*16+6, (AmmoObj->x-1)*16+15 + 2, (AmmoObj->y-1)*16+6 + 5, &HFFFFAAAA)
				xge.Shape.RectFull((AmmoObj->x-1)*16+15, (AmmoObj->y-1)*16+11, (AmmoObj->x-1)*16+15 + 2, (AmmoObj->y-1)*16+11 + 5, &HFFFFFFFF)
			Case Else		' ��
				xge.Shape.RectFull((AmmoObj->x-1)*16+15, (AmmoObj->y-1)*16+31, (AmmoObj->x-1)*16+15 + 2, (AmmoObj->y-1)*16+31 + 2, &HFFFF0000)
				xge.Shape.RectFull((AmmoObj->x-1)*16+15, (AmmoObj->y-1)*16+29, (AmmoObj->x-1)*16+15 + 2, (AmmoObj->y-1)*16+29 + 4, &HFFFF5555)
				xge.Shape.RectFull((AmmoObj->x-1)*16+15, (AmmoObj->y-1)*16+24, (AmmoObj->x-1)*16+15 + 2, (AmmoObj->y-1)*16+24 + 5, &HFFFFAAAA)
				xge.Shape.RectFull((AmmoObj->x-1)*16+15, (AmmoObj->y-1)*16+19, (AmmoObj->x-1)*16+15 + 2, (AmmoObj->y-1)*16+19 + 5, &HFFFFFFFF)
		End Select
	Else
		If AmmoObj->boom Then
			img_Boom->DrawEx_Trans((AmmoObj->x - 1) * 16, (AmmoObj->y - 1) * 16, (AmmoObj->boom - 1) * 32, 0, 31, 31)
			AmmoObj->boom -= 1
		EndIf
	EndIf
End Sub

Sub Tank_AmmoManage.DrawAll()
	Dim i As Integer
	Dim AmmoObj As Tank_AmmoItem Ptr
	For i = 1 To StructCount
		AmmoObj = GetPtrStruct(i)
		If AmmoObj Then
			DrawAmmo(AmmoObj)
		EndIf
	Next
End Sub
