'==================================================================================
	'�� ��Ϸ���̿�����
	'#-------------------------------------------------------------------------------
	'# ���� : ���������Ϸ���̺ͳ����л� , ��Ϸ�ĵ�һ����������������
	'# ˵�� : 
'==================================================================================


If AppInit() Then
	' ������Ϸ��Դ
	sfm.LoadPackAll(NULL)
	som.LoadPackAll(NULL,5)
	' ���� Logo ����
	If xge.Start(@LogoScreen,sfm.Get(1)) Then
		' ���� Start ����
		If xge.Start(@PauseScreen,sfm.Get(2)) Then
			' �����л�����
			Do
				Select Case xge.Start(@GameScreen)
					Case 0		' �����˳�
						Exit Do
					Case 1		' ͨ��
						If Module.ScreenAddr >= Module.ScreenCount Then
							xge.Start(@PauseScreen,sfm.Get(3))
						Else
							Module.ScreenAddr += 1
							xge.Start(@GameScreen)
							Exit Do
						EndIf
					Case 2		' ��Ϸ����
						xge.Start(@PauseScreen,sfm.Get(4))
						Exit Do
				End Select
			Loop
		EndIf
	EndIf
	' �ͷ���Ϸ��Դ
	sfm.FreeAll()
EndIf
AppUint()