#Include Once "windows.bi"
#Include Once "win\winuser.bi"
#Include Once "win\commctrl.bi"



#Ifndef XUI_SOURCE_NOLIB
	#Define XUI_SOURCE_NOLIB
	#Inclib "xGui"
#EndIf



#Ifndef XUI_GRID_NOLIB
	' ���ؼ�����
	#Inclib "SprSht"
	Extern "Windows"
		Declare Function SprShtInstall(hinst As HANDLE) As Integer
	End Extern
#EndIf





' �ؼ�ʹ�� xFont �������� [���鿪��]
'	���ѡ����Ի������VB�����崦��Ч��������ʹ�ø���ľ�����ڴ棬������Լ������Լ����֣������ע�͵��������ѡ�
#Define XUI_COMPILE_USE_XFONT

' ʹ�� xFont ָ������� xFont ���� [׷����ٿ������鲻����, ׷�������Ż����鿪��]
'   ���ڿ��� XUI_COMPILE_USE_XFONT ���������Ч�����ؼ���������滻Ϊ�������ָ�룬ʹ����ؼ����Թ���һ���������
#Define XUI_COMPILE_XFONT_PTR

' ����ʹ�� xMenu ����˵� [���鿪��]
'   ���ѡ����Է��㴰�ڵĲ˵��������˵�ֱ����Ϊ���ڵ�һ����ֱ�Ӵ����������Ϊÿ�����ڴ����˵����󣬷���ʹ�� HMENU ���á�
#Define XUI_COMPILE_USE_XMENU

' xHandleList Ԥ�����ڴ沽�� [�������xHandleListʹ���������е���]
#Define XUI_RUNTIME_HLIST_STP		32

' ��ౣ������ʱ�ڴ����� (�Զ��ͷ��ڴ溯��ʹ�ô����������ֵ���ڴ�ᱻ�Զ��ͷ�)
#Define XUI_RUNTIME_MEM_COUNT		32





' �����ඨ��
#Define XUI_FONT_BOLD			1
#Define XUI_FONT_ITALIC			2
#Define XUI_FONT_UNDERLINE		4
#Define XUI_FONT_STRIKEOUT		8



#Include "xGui_base.bi"
#Include "xGui_CommCtrl.bi"
#Include "xGui_SpreadSheet.bi"
#Include "xGui_SciEdit.bi"
