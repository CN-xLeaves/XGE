
Dim Shared Map As Tank_Map

Dim Shared SelTK As Integer
Dim Shared EditMode As Integer

Dim Shared MapPath As ZString * 260
Dim Shared P1 As Any Ptr
Dim Shared P2 As Any Ptr
Dim Shared AI As Any Ptr



' ���������ִ���
Function MainScreen(ByVal message As Integer,ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Select Case message
		Case xge_msg_frame				' �߼�����
			
		Case xge_msg_draw					' ��ͼ
			xge.Clear
			Line (480,0)-(640,452),&H444444,BF
			Line (480,452)-(640,480),&H666666,BF
			' ������Ϣ����
			Dim tr As RECT = (480,452,640,480)
			DrawStringRect(NULL,tr,"fps : " & xge.FPS,"����",9)
			' ����˵���˵�
			DrawString(NULL,516,20,"�� 0-9 ѡȡ����","����",9)
			Put (500,60),sfm.Get(100),(0,0)-Step(15,15),Trans
			DrawString(NULL,520,62,"0.�հ׵���","����",9)
			Put (500,80),sfm.Get(100),(16,0)-Step(15,15),Trans
			DrawString(NULL,520,82,"1.שǽ [���Ի���]","����",9)
			Put (500,100),sfm.Get(100),(32,0)-Step(15,15),Trans
			DrawString(NULL,520,102,"2.��ǽ [���Ի���]","����",9)
			Put (500,120),sfm.Get(100),(48,0)-Step(15,15),Trans
			DrawString(NULL,520,122,"3.�ݵ� [��������]","����",9)
			Put (500,140),sfm.Get(100),(64,0)-Step(15,15),Trans
			DrawString(NULL,520,142,"4.���� [����ͨ��]","����",9)
			Put (500,160),sfm.Get(100),(80,0)-Step(15,15),Trans
			DrawString(NULL,520,162,"5.���� [����ʧ��]","����",9)
			Put (500,180),sfm.Get(100),(96,0)-Step(15,15),Trans
			DrawString(NULL,520,182,"6.���� [����ʧ��]","����",9)
			Put (500,200),sfm.Get(100),(112,0)-Step(15,15),Trans
			DrawString(NULL,520,202,"7.���� [����ʧ��]","����",9)
			Put (500,220),sfm.Get(100),(128,0)-Step(15,15),Trans
			DrawString(NULL,520,222,"8.���� [����ʧ��]","����",9)
			Put (500,240),sfm.Get(100),(144,0)-Step(15,15),Trans
			DrawString(NULL,520,242,"9.���� [����ͨ��]","����",9)
			DrawString(NULL,505,282,"��ǰѡ����� :","����",9)
			If SelTK < 10 Then
				Put (596,280),sfm.Get(100),(SelTK*16,0)-Step(15,15),Trans
			EndIf
			DrawString(NULL,518,320,"�� F1 ���λ��","����",9)
			DrawString(NULL,518,340,"�� F2 ���λ��","����",9)
			DrawString(NULL,518,360,"�� F3 ѡˢ�µ�","����",9)
			DrawString(NULL,518,380,"�� F4 ��ˢ�µ�","����",9)
			DrawString(NULL,518,400,"�� F8 ����ͼ","����",9)
			DrawString(NULL,518,420,"�� F9 �����ͼ","����",9)
			' ���Ƶ�ͼ
			Map.Draw(0,0)
			' ���Ƴ�����
			Put ((Map.Info.Player1.x-1)*16,(Map.Info.Player1.y-1)*16),P1,Alpha,60
			Put ((Map.Info.Player2.x-1)*16,(Map.Info.Player2.y-1)*16),P2,Alpha,60
			Dim i As Integer
			For i = 1 To Map.Info.PointNum
				Put ((Map.Info.PointAI(i-1).x-1)*16,(Map.Info.PointAI(i-1).y-1)*16),AI,Alpha,60
			Next
		Case xge_msg_mouse_move		' ����ƶ�
			If EditMode Then
				Select Case SelTK
					Case 0 To 9
						Map.tk[((Event->y\16)*30)+(Event->x\16)] = SelTK
					Case 11
						Map.Info.Player1.x = (Event->x\16) + 1
						Map.Info.Player1.y = (Event->y\16) + 1
					Case 12
						Map.Info.Player2.x = (Event->x\16) + 1
						Map.Info.Player2.y = (Event->y\16) + 1
					Case 20 To 31
						Map.Info.PointAI(SelTK - 20).x = (Event->x\16) + 1
						Map.Info.PointAI(SelTK - 20).y = (Event->y\16) + 1
				End Select
			EndIf
		Case xge_msg_mouse_down		' ��갴��
			EditMode = -1
		Case xge_msg_mouse_up
			EditMode = 0
		Case xge_msg_key_dowm			' ���̰���
			Select Case Event->scancode
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
				Case SC_F2
					SelTK = 12
				Case SC_F3
					If SelTK >= 19 + Map.Info.PointNum Then
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
					Dim NewNum As ZString Ptr = InputBox(xge.hWnd,"������Ҫ���õ�ˢ�µ����� [1 - 12]","�����޺�Ȥζ̹�˵�ͼ�༭��",Str(Map.Info.PointNum),0,0,0,0)
					If NewNum Then
						Dim tl As Integer = CInt(*NewNum)
						If tl > 0 Then
							If tl < 13 Then
								Map.Info.PointNum = tl
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
		Case xge_msg_loadres			' ������Դ
			xpk_Bind(xge.hWnd)
			sfm.Pack = @xpk
			sfm.Pack->Open(ExePath & "\Data\Game.xpk",-1)
			sfm.LoadPack(100,NULL)
			Dim tr As RECT = (1,1,32,32)
			P1 = ImageCreate(32,32)
			Line P1,(0,0)-Step(32,32),&HFF,BF
			DrawStringRect(P1,tr,"P1","����",9)
			P2 = ImageCreate(32,32)
			Line P2,(0,0)-Step(32,32),&HFF,BF
			DrawStringRect(P2,tr,"P2","����",9)
			AI = ImageCreate(32,32)
			Line AI,(0,0)-Step(32,32),&HFF,BF
			DrawStringRect(AI,tr,"AI","����",9)
			
			If FileExists(@MapPath)=0 Then
				rtl.Res.ToFile(200,@MapPath)
			EndIf
			Map.Load(@MapPath)
		Case xge_msg_freeres			' ж����Դ
			sfm.FreeAll()
		Case xge_msg_close				' ���ڹر�
			If MessageBox(xge.hWnd,"�˳����ᱣ�����༭�õĵ�ͼ��ȷʵҪ�˳���","Title :",MB_YESNO Or MB_ICONWARNING)=IDYES Then
				Return -1
			EndIf
	End Select
End Function