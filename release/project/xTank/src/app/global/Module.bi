
Namespace Module
	Dim Path As ZString * MAX_PATH					' Module ·��
	Dim File As ZString * MAX_PATH					' Module �����ļ�
	Dim Title As ZString * 60						' ���ڱ���
	Dim BackImage As ZString * MAX_PATH				' ����ͼƬ (������ʹ��Ĭ�ϵı���ͼ)
	Dim MapCount As Integer							' ��ͼ����
	Dim ExpMul As Integer							' ���鱶�� [100Ϊ1��]
	Dim StartLevel As Integer						' ��ʼ�ȼ�
	Dim TankModel As Integer						' ���̹������
	Dim SpawnTime As Integer						' AI̹��ˢ���ٶ�
	Dim AddHPTime As Integer						' Ѫ���ָ��ٶ�
	
	' ����ʱ����
	Dim CurMapID As Integer							' ��ǰ��ͼ���
End Namespace



Function InitModuleSystem() As Integer
	Module.Path = ExePath() & "\Moudle\" & *xIni.GetStr(ExePath & "\setup.ini", "option", "Module") & "\"
	Module.File = Module.Path & "moudle.ini"
	If xFile.Exists(@Module.File) Then
		Module.Title = *xIni.GetStr(@Module.File, "option", "Title")
		Module.BackImage = *xIni.GetStr(@Module.File, "option", "BackImage")
		Module.MapCount = xIni.GetInt(@Module.File, "option", "MapCount")
		Module.ExpMul = xIni.GetInt(@Module.File, "option", "ExpMul")
		Module.StartLevel = xIni.GetInt(@Module.File, "option", "StartLevel")
		Module.TankModel = xIni.GetInt(@Module.File, "option", "TankModel")
		Module.SpawnTime = xIni.GetInt(@Module.File, "option", "SpawnTime")
		Module.AddHPTime = xIni.GetInt(@Module.File, "option", "AddHPTime")
		If Module.BackImage = "" Then
			Module.BackImage = "back.bmp"
		EndIf
		If Module.SpawnTime < 2000 Then
			Module.SpawnTime = 2000
		EndIf
		If Module.AddHPTime < 5000 Then
			Module.AddHPTime = 5000
		EndIf
	Else
		Return FALSE
	EndIf
	Return TRUE
End Function
