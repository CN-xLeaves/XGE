'==================================================================================
	'�� ��Ϸ��ʼ��ģ��
	'#-------------------------------------------------------------------------------
	'# ���� : ��Ϸ�����￪ʼִ�� , �����ʼ���Ȳ��� , ��Ϸж��Ҳ���������
	'# ˵�� : 
'==================================================================================

Function AppInit() As Integer
	' �ļ�����ʼ��
	If xpk.Open(ExePath & "\Data\Game.xpk",-1) Then
		sfm.Pack = @xpk
		som.Pack = @xpk
		' ����Module����
		AutoLoadModule(rtl.IniFile.GetStr(ExePath & "\Data\setup.ini","Tank","LoadModule"))
		' ��Ϸ�����ʼ��
		Return xge.Init(16,640,480,xge_window,40,0,@Module.Title)
	EndIf
End Function

Sub AppUint()
	xge.Unit()
End Sub
