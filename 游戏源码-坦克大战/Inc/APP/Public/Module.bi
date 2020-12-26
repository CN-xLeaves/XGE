
Type ModuleInfo
	' Module �������� [�ֶ�:116Byte]
	Title As ZString * 60							' Module ���ڱ���
	Player(3) As Integer							' ���̹������
	PlayerCount As Integer						' ֧������������[1-3]
	PlayerLV As Integer								' ��ҳ�ʼ�ȼ�
	ExpMul As Integer									' ���鱶��
	ViewHP As Integer									' ��ʾѡ��
	ViewLevel As Integer
	ViewValueHP As Integer
	GoodsCount1 As Integer						' ��Ʒ����
	GoodsCount2 As Integer
	GoodsCount3 As Integer
	GoodsCount4 As Integer
	ScreenCount As Integer						' ��ͼ����
	' ����ѡ�� [�ֶ�:12Byte]
	SpeedNewAI As Integer							' AI̹��ˢ���ٶ�
	TimeAddHP As Integer							' ̹��Ѫ���ָ��ٶ�
	GodMod As Integer									' ���׿���
	' ��������
	ModuleType As Integer							' Module���� [0=ini��1=xpk]
	ModulePath As ZString * 260
	' ����ʱ����
	ScreenAddr As Integer							' ��ǰ��ͼ
End Type
Dim Shared Module As ModuleInfo


Sub LoadModule_ToIni()
	' ����Moduleѡ��
	Module.Title = *rtl.IniFile.GetStr(Module.ModulePath & ".ini","xywhsoft","Title")
	Module.Title &= "[����]"
	Module.Player(0) = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","Player1")
	Module.Player(1) = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","Player2")
	Module.Player(2) = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","Player3")
	Module.Player(3) = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","Player4")
	Module.PlayerLV = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","PlayerLV")
	Module.ExpMul = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","ExpMul")
	Module.ViewHP = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","ViewHP")
	Module.ViewLevel = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","ViewLevel")
	Module.ViewValueHP = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","ViewValueHP")
	Module.GoodsCount1 = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","GoodsCount1")
	Module.GoodsCount2 = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","GoodsCount2")
	Module.GoodsCount3 = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","GoodsCount3")
	Module.GoodsCount4 = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","GoodsCount4")
	Module.ScreenCount = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","ScreenCount")
	' ��������ѡ��
	Module.SpeedNewAI = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","SpeedNewAI")
	Module.TimeAddHP = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","TimeAddHP")
	Module.GodMod = rtl.IniFile.GetInt(Module.ModulePath & ".ini","xywhsoft","GodMod")
	If Module.SpeedNewAI = 0 Then Module.SpeedNewAI = 2000
	If Module.TimeAddHP = 0 Then Module.TimeAddHP = 5000
End Sub

Sub LoadModule_ToXPK()
	
End Sub

Sub AutoLoadModule(ByVal ModuleFile As ZString Ptr)
	Module.ModulePath = ExePath & "\Data\Moudle\" & *ModuleFile
	Module.ScreenAddr = 1
	If FileExists(Module.ModulePath & ".xpk") Then
		Module.ModulePath &= ".xpk"
		Module.ModuleType = 1
		LoadModule_ToXPK()
	ElseIf FileExists(Module.ModulePath & ".ini") Then
		Module.ModuleType = 0
		LoadModule_ToIni()
		Module.ModulePath &= "\"
	Else
		MessageBox(xge.hWnd,"Module ����ʧ�ܣ�","Error :",MB_ICONERROR)
	EndIf
End Sub