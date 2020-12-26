Type Tank_AmmoItem
	stk As Integer							' 子弹状态 [0=废弃]
	x As Integer								' 子弹当前横坐标
	y As Integer								' 子弹当前纵坐标
	dt As Integer								' 子弹发射方向
	Atk As Integer							' 子弹威力
	IsAI As Integer							' 子弹阵营 [0=AI 1=玩家1 2=玩家2 3=玩家3 4=玩家4]
	boom As Integer							' 爆炸
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
	' 先检查有没有子弹空位
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
	' 没有空位就申请一个新的位置
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
			Case 1			' 左
				Line ((AmmoObj->x-1)*16,(AmmoObj->y-1)*16+15)-Step(2,2),&HFF0000,BF
				Line ((AmmoObj->x-1)*16+2,(AmmoObj->y-1)*16+15)-Step(4,2),&HFF5555,BF
				Line ((AmmoObj->x-1)*16+6,(AmmoObj->y-1)*16+15)-Step(5,2),&HFFAAAA,BF
				Line ((AmmoObj->x-1)*16+11,(AmmoObj->y-1)*16+15)-Step(5,2),&HFFFFFF,BF
			Case 2			' 右
				Line ((AmmoObj->x-1)*16+31,(AmmoObj->y-1)*16+15)-Step(-2,2),&HFF0000,BF
				Line ((AmmoObj->x-1)*16+29,(AmmoObj->y-1)*16+15)-Step(-4,2),&HFF5555,BF
				Line ((AmmoObj->x-1)*16+24,(AmmoObj->y-1)*16+15)-Step(-5,2),&HFFAAAA,BF
				Line ((AmmoObj->x-1)*16+19,(AmmoObj->y-1)*16+15)-Step(-5,2),&HFFFFFF,BF
			Case 3			' 上
				Line ((AmmoObj->x-1)*16+15,(AmmoObj->y-1)*16)-Step(2,2),&HFF0000,BF
				Line ((AmmoObj->x-1)*16+15,(AmmoObj->y-1)*16+2)-Step(2,4),&HFF5555,BF
				Line ((AmmoObj->x-1)*16+15,(AmmoObj->y-1)*16+6)-Step(2,5),&HFFAAAA,BF
				Line ((AmmoObj->x-1)*16+15,(AmmoObj->y-1)*16+11)-Step(2,5),&HFFFFFF,BF
			Case Else		' 下
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
