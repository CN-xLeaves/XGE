
Dim Shared Map As Tank_Map

Dim Shared SelTK As Integer
Dim Shared EditMode As Integer



' ���������ִ���
Function MapEditScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xge.Surface Ptr P1, AI
	Select Case msg
		Case XGE_MSG_DRAW					' ��ͼ
			xge.Clear
			xge.Shape.RectFull(NULL, 480, 0, 640, 452, &HFF444444)
			xge.Shape.RectFull(NULL, 480, 452, 640, 480, &HFF666666)
			' ������Ϣ����
			xge.Text.DrawRectA(NULL, 480, 452, 160, 28, "fps : " & xge.Scene.FPS, &HFFFFFFFF)
			' ����˵���˵�
			xge.Text.DrawA(NULL, 516,  20, "�� 0-9 ѡȡ����", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 60, 0, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  62, "0.�հ׵���", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 80, 16, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  82, "1.שǽ [���Ի���]", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 100, 32, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  102, "2.��ǽ [���Ի���]", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 120, 48, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  122, "3.�ݵ� [��������]", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 140, 64, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  142, "4.���� [����ͨ��]", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 160, 80, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  162, "5.���� [����ʧ��]", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 180, 96, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  182, "6.���� [����ʧ��]", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 200, 112, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  202, "7.���� [����ʧ��]", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 220, 128, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  222, "8.���� [����ʧ��]", &HFFFFFFFF)
			img_MapTile->DrawEx_Trans(NULL, 500, 240, 144, 0, 15, 15)
			xge.Text.DrawA(NULL, 520,  242, "9.���� [����ͨ��]", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 505,  282, "��ǰѡ����� :", &HFFFFFFFF)
			If SelTK < 10 Then
				img_MapTile->DrawEx_Trans(NULL, 596, 280, SelTK*16, 0, 15, 15)
			EndIf
			xge.Text.DrawA(NULL, 518,  320, "�� F1 ���λ��", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 518,  340, "�� F3 ѡˢ�µ�", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 518,  360, "�� F4 ��ˢ�µ�", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 518,  380, "�� F8 ����ͼ", &HFFFFFFFF)
			xge.Text.DrawA(NULL, 518,  400, "�� F9 �����ͼ", &HFFFFFFFF)
			' ���Ƶ�ͼ
			Map.Draw(0,0)
			' ���Ƴ�����
			P1->Draw_Alpha2(NULL, (Map.HeadInfo.Player.x-1)*16, (Map.HeadInfo.Player.y-1)*16, 60)
			Dim i As Integer
			For i = 1 To Map.HeadInfo.PointNum
				AI->Draw_Alpha2(NULL, (Map.HeadInfo.PointAI(i-1).x-1)*16, (Map.HeadInfo.PointAI(i-1).y-1)*16, 60)
			Next
		Case XGE_MSG_MOUSE_MOVE		' ����ƶ�
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
		Case XGE_MSG_MOUSE_DOWN		' ��갴��
			EditMode = -1
		Case XGE_MSG_MOUSE_UP
			EditMode = 0
		Case XGE_MSG_KEY_DOWN			' ���̰���
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
					WindowTitle("�����޺�Ȥζ̹�˵�ͼ�༭�� - [" & Str(SelTK-20) & "]")
				Case SC_F4
					Dim NewNum As ZString Ptr = InputBox(xge.hWnd,"������Ҫ���õ�ˢ�µ����� [1 - 12]","�����޺�Ȥζ̹�˵�ͼ�༭��",Str(Map.HeadInfo.PointNum),0,0,0,0)
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
						MessageBox(xge.hWnd,"����ѡ��һ����ͼͼ�飡","Title :",MB_OK Or MB_ICONINFORMATION)
					Else
						If MessageBox(xge.hWnd,"���β��������棬ȷ�����ͼ����","Title :",MB_YESNO Or MB_ICONWARNING)=IDYES Then
							memset(Map.tk,SelTK,900)
						EndIf
					EndIf
				Case SC_F9
					Map.Save(@MapPath)
					MessageBox(xge.hWnd,"��ͼ����ɹ� [" & MapPath & "] ��","Title :",MB_ICONINFORMATION)
			End Select
		Case XGE_MSG_LOADRES			' ������Դ
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
		Case XGE_MSG_FREERES			' ж����Դ
			Delete P1
			Delete AI
		Case XGE_MSG_CLOSE				' ���ڹر�
			If MessageBox(xge.hWnd,"�˳����ᱣ�����༭�õĵ�ͼ��ȷʵҪ�˳���","Title :",MB_YESNO Or MB_ICONWARNING)=IDYES Then
				Return -1
			EndIf
	End Select
End Function
