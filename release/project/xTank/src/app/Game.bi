'==================================================================================
	'�� ��Ϸ���̿�����
	'#-------------------------------------------------------------------------------
	'# ���� : ���������Ϸ���̺ͳ����л� , ��Ϸ�ĵ�һ����������������
	'# ˵�� : 
'==================================================================================



' ����ȫ����Դ
Function LoadRes() As Integer
	Res.AddPack(ExePath() & "\res.xpk")
	Res.CreateIndex()
	
	Res.LoadFont(1)
	Res.LoadFont(2)
	
	img_Logo = Res.LoadPicture(100)
	img_BackImage = Res.LoadPicture(101)
	img_PassImage = Res.LoadPicture(102)
	img_EndImage = Res.LoadPicture(103)
	
	img_Tank1 = Res.LoadPicture(200)
	img_Tank2 = Res.LoadPicture(201)
	img_Tank3 = Res.LoadPicture(202)
	img_Tank4 = Res.LoadPicture(203)
	
	img_Boom = Res.LoadPicture(300)
	img_MapTile = Res.LoadPicture(301)
	
	se_Fire = Res.LoadSample(400)
	se_Boom = Res.LoadSample(401)
	
	' ��������
	ViewHP = xIni_GetInt(ExePath & "\setup.ini", "option", "ViewHP")
	ViewLevel = xIni_GetInt(ExePath & "\setup.ini", "option", "ViewLevel")
	ViewHP_Value = xIni_GetInt(ExePath & "\setup.ini", "option", "ViewHP_Value")
	CheatMode = xIni_GetInt(ExePath & "\setup.ini", "option", "CheatMode")
	
	Return -1
End Function



' �ͷ�ȫ����Դ
Sub FreeRes()
	Res.FreeAll()
	xge.Text.RemoveFont(2)
	xge.Text.RemoveFont(1)
End Sub



' ��ʼ��Ӧ��
Function AppInit() As Integer
	' ����Module����
	If InitModuleSystem() = FALSE Then
		MessageBox(0, "��Ϸģ������ʧ�ܣ�", "xTank", MB_ICONERROR)
		Return 0
	EndIf
	' ��ʼ��XGE��Ϸ����
	If xge.InitA(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, @Module.Title) = FALSE Then
		MessageBox(0, "xywh Game Engine ��ʼ��ʧ�ܣ�", "xTank", MB_ICONERROR)
		Return 0
	EndIf
	' ������Ϸ��Դ
	If LoadRes() = FALSE Then
		MessageBox(0, "��Ϸ��Դ����ʧ�ܣ���ȷ����Ϸ�ͻ���������", "xTank", MB_ICONERROR)
		Return 0
	EndIf
	If Command(1) = "-e" Then
		' ��ͼ�༭��ģʽ����
		MapPath = Command(2)
		xge.Scene.Cut(@MapEditScene, 40)
	Else
		' ��Ϸģʽ����
		xge.Scene.Cut(@LogoScene, 40, FALSE, Cast(Integer, img_Logo))
		xge.Scene.Cut(@MenuScene, 40, FALSE, Cast(Integer, img_BackImage))
	EndIf
End Function



' �ͷ�Ӧ����Դ
Sub AppUint()
	FreeRes()
	xge.Unit()
End Sub
