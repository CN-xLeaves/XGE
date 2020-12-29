
Dim Shared Map As Tank_Map

Dim Shared SelTK As Integer
Dim Shared EditMode As Integer



' 场景处理部分代码
Function MapEditScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xge.Surface Ptr P1, AI
	Select Case msg
		Case XGE_MSG_DRAW					' 绘图
			xge.Clear
			xge.Shape.RectFull(NULL, 480, 0, 640, 452, &HFF444444)
			xge.Shape.RectFull(NULL, 480, 452, 640, 480, &HFF666666)
			' 绘制信息文字
			xge.Text.DrawRectA(NULL, 480, 452, 160, 28, "fps : " & xge.Scene.FPS, &HFFFFFFFF)
			' 绘制说明菜单
			xge.Text.DrawA(NULL, 516,  20, "按 0-9 选取地形", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 60, 0, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  62, "0.空白地形", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 80, 16, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  82, "1.砖墙 [可以击碎]", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 100, 32, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  102, "2.铁墙 [难以击碎]", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 120, 48, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  122, "3.草地 [可以隐身]", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 140, 64, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  142, "4.河流 [坐船通行]", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 160, 80, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  162, "5.基地 [击中失败]", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 180, 96, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  182, "6.基地 [击中失败]", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 200, 112, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  202, "7.基地 [击中失败]", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 220, 128, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  222, "8.基地 [击中失败]", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 240, 144, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  242, "9.熔岩 [不可通行]", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 505,  282, "当前选择地形 :", &HFFFFFFFF)
			If SelTK < 10 Then
				img_MapTile->DrawEx_Trans(NULL, 596, 280, SelTK*16, 0, 15, 15)
			EndIf
			xge.Text.DrawA(NULL, 518,  320, "按 F1 玩家位置", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 518,  340, "按 F3 选刷新点", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 518,  360, "按 F4 设刷新点", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 518,  380, "按 F8 填充地图", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 518,  400, "按 F9 保存地图", &HFFFFFFFF)
			' 绘制地图
			Map.Draw(0,0)
			' 绘制出生点
			P1->Draw_Alpha2(NULL, (Map.HeadInfo.Player.x-1)*16, (Map.HeadInfo.Player.y-1)*16, 60)
			Dim i As Integer
			For i = 1 To Map.HeadInfo.PointNum
				AI->Draw_Alpha2(NULL, (Map.HeadInfo.PointAI(i-1).x-1)*16, (Map.HeadInfo.PointAI(i-1).y-1)*16, 60)
			Next
		Case XGE_MSG_MOUSE_MOVE		' 鼠标移动
			If EditMode Then
				Select Case SelTK
					Case 0 To 9
						Map.tk[((eve->y\16)*30)+(eve->x\16)] = SelTK
					Case 11
						Map.HeadInfo.Player.x = (eve->x\16) + 1
						Map.HeadInfo.Player.y = (eve->y\16) + 1
					Case 20 To 31
						Map.HeadInfo.PointAI(SelTK - 20).x = (eve->x\16) + 1
						Map.HeadInfo.PointAI(SelTK - 20).y = (eve->y\16) + 1
				End Select
			EndIf
		Case XGE_MSG_MOUSE_DOWN		' 鼠标按下
			EditMode = -1
		Case XGE_MSG_MOUSE_UP
			EditMode = 0
		Case XGE_MSG_KEY_DOWN			' 键盘按下
			Select Case eve->scancode
				Case SC_0
					SelTK = 0
				Case SC_1
					SelTK = 1
				Case SC_2
					SelTK = 2
				Case SC_3
					SelTK = 3
				Case SC_4
					SelTK = 4
				Case SC_5
					SelTK = 5
				Case SC_6
					SelTK = 6
				Case SC_7
					SelTK = 7
				Case SC_8
					SelTK = 8
				Case SC_9
					SelTK = 9
				Case SC_F1
					SelTK = 11
				Case SC_F3
					If SelTK >= 19 + Map.HeadInfo.PointNum Then
						SelTK = 20
					Else
						If SelTK < 20 Then
							SelTK = 20
						Else
							SelTK += 1
						EndIf
					EndIf
					WindowTitle("星月无痕趣味坦克地图编辑器 - [" & Str(SelTK-20) & "]")
				Case SC_F4
					Dim NewNum As ZString Ptr = InputBox(xge.hWnd,"请输入要设置的刷新点数量 [1 - 12]","星月无痕趣味坦克地图编辑器",Str(Map.HeadInfo.PointNum),0,0,0,0)
					If NewNum Then
						Dim tl As Integer = CInt(*NewNum)
						If tl > 0 Then
							If tl < 13 Then
								Map.HeadInfo.PointNum = tl
							EndIf
						EndIf
					EndIf
				Case SC_F8
					If SelTK > 9 Then
						MessageBox(xge.hWnd,"请先选择一个地图图块！","Title :",MB_OK Or MB_ICONINFORMATION)
					Else
						If MessageBox(xge.hWnd,"本次操作不可逆，确认填充图块吗？","Title :",MB_YESNO Or MB_ICONWARNING)=IDYES Then
							memset(Map.tk,SelTK,900)
						EndIf
					EndIf
				Case SC_F9
					Map.Save(@MapPath)
					MessageBox(xge.hWnd,"地图保存成功 [" & MapPath & "] ！","Title :",MB_ICONINFORMATION)
			End Select
		Case XGE_MSG_LOADRES			' 加载资源
			P1 = New xge.Surface(32, 32)
			AI = New xge.Surface(32, 32)
			xge.Shape.RectFull(P1, 0, 0, 32, 32, &HFF0000FF)
			xge.Shape.RectFull(AI, 0, 0, 32, 32, &HFF0000FF)
			xge.Text.DrawRectA(P1, 0, 0, 32, 32, "P1", &HFFFFFFFF)
			xge.Text.DrawRectA(AI, 0, 0, 32, 32, "AI", &HFFFFFFFF)
			If xFile.Exists(@MapPath) = FALSE Then
				ResToFile(200, @MapPath)
			EndIf
			Map.Load(@MapPath)
		Case XGE_MSG_FREERES			' 卸载资源
			Delete P1
			Delete AI
		Case XGE_MSG_CLOSE				' 窗口关闭
			If MessageBox(xge.hWnd,"退出不会保存您编辑好的地图，确实要退出吗？","Title :",MB_YESNO Or MB_ICONWARNING)=IDYES Then
				Return -1
			EndIf
	End Select
End Function
