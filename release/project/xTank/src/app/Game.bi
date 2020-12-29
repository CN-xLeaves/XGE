'==================================================================================
	'�� ��Ϸ���̿�����
	'#-------------------------------------------------------------------------------
	'# ���� : ���������Ϸ���̺ͳ����л� , ��Ϸ�ĵ�һ����������������
	'# ˵�� : 
'==================================================================================



' ����ȫ����Դ
Function LoadRes() As Integer
	ResPath = ExePath() & "\Res\"
	img_Logo = New xge.Surface(ResPath & "Logo.bmp", 0)
	img_MapTile = New xge.Surface(ResPath & "map.bmp", 0)
	img_Boom = New xge.Surface(ResPath & "boom.bmp", 0)
	img_Tank1 = New xge.Surface(ResPath & "tank01.bmp", 0)
	img_Tank2 = New xge.Surface(ResPath & "tank02.bmp", 0)
	img_Tank3 = New xge.Surface(ResPath & "tank03.bmp", 0)
	img_Tank4 = New xge.Surface(ResPath & "tank04.bmp", 0)
	img_BackImage = New xge.Surface(ResPath & Module.BackImage, 0)
	img_PassImage = New xge.Surface(ResPath & "Pass.bmp", 0)
	img_EndImage = New xge.Surface(ResPath & "End.bmp", 0)
	
	se_Boom = New xge.Sound(XGE_SOUND_SAMPLE, 0, ResPath & "boom.ogg", 0)
	se_Fire = New xge.Sound(XGE_SOUND_SAMPLE, 0, ResPath & "fire.ogg", 0)
	
	xge.Text.LoadFont(ResPath & "simsun_12px_gb2312.xrf", 0)
	xge.Text.LoadFont(ResPath & "simsun_16px_gb2312.xrf", 0)
	
	' ��������
	ViewHP = xIni.GetInt(ExePath & "\setup.ini", "option", "ViewHP")
	ViewLevel = xIni.GetInt(ExePath & "\setup.ini", "option", "ViewLevel")
	ViewHP_Value = xIni.GetInt(ExePath & "\setup.ini", "option", "ViewHP_Value")
	CheatMode = xIni.GetInt(ExePath & "\setup.ini", "option", "CheatMode")
	
	Return -1
End Function



' �ͷ�ȫ����Դ
Sub FreeRes()
	Delete img_Logo
	Delete img_MapTile
	Delete img_Boom
	Delete img_Tank1
	Delete img_Tank2
	Delete img_Tank3
	Delete img_Tank4
	Delete img_BackImage
	Delete img_PassImage
	Delete img_EndImage
	
	Delete se_Boom
	Delete se_Fire
	
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
	If xge.Init(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, @Module.Title) = FALSE Then
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
