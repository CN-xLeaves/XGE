


' ͨ�ó�ʼ������
Sub xge_test_init()
	
End Sub



' һ������
Function MainScreen(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static pic1 As xge.Surface Ptr
	Static ui As xui.Element Ptr
	Static win As xui.Window Ptr
	Select Case msg
		Case XGE_MSG_FRAME				' �߼�����
			
		Case XGE_MSG_DRAW				' ��ͼ
			xge.Clear()
			ui->Draw()
		Case XGE_MSG_MOUSE_MOVE			' ����ƶ�
			
		Case XGE_MSG_MOUSE_DOWN			' ��갴��
			
		Case XGE_MSG_MOUSE_UP			' ��굯��
			
		Case XGE_MSG_MOUSE_CLICK		' ��굥��
			
		Case XGE_MSG_MOUSE_DCLICK		' ���˫��
			
		Case XGE_MSG_MOUSE_WHELL		' �����ֹ���
			
		Case XGE_MSG_KEY_DOWN			' ���̰���
			
		Case XGE_MSG_KEY_UP				' ���̵���
			
		Case XGE_MSG_KEY_REPEAT			' �����ظ�����
			
		Case XGE_MSG_GOTFOCUS			' ӵ�н���
			
		Case XGE_MSG_LOSTFOCUS			' ʧȥ����
			
		Case XGE_MSG_MOUSE_ENTER		' �������
			
		Case XGE_MSG_MOUSE_EXIT			' ����Ƴ�
			
		Case XGE_MSG_LOADRES			' ������Դ
			ui = xui.GetRootElement()
			'xge.Text.LoadFont("..\release\res\font\xrf\simsun_16px_ucs2.xrf", 0)
			xge.Text.LoadFontA("..\release\res\font\xrf\simsun_12px_ucs2.xrf", 0)
			'xge.Text.LoadFont("F:\����\˼Դ��������.ttf", 0)
			'xge.Text.LoadFont("D:\Git\XGE\release\res\font\ttf\Roboto-Light.ttf", 0)
			'xge.Text.LoadFont("F:\����\��������������2.0��ǿ��.ttf", 0)
			xge.Text.SetFontSize(2, 12)
			'xge.Text.LoadFont("C:\windows\fonts\simsun.ttc", 0)
			
			pic1 = New xge.Surface("D:\Git\XGE\release\res\back.xgi", 0)
			
			win = xui.CreateBaseWindow(10, 10, 320, 240, , "About xywh Game Engine")
			
			ui->Childs.AddElement(win)
			xui.LayoutApply()
			
		Case XGE_MSG_FREERES			' ж����Դ
			
		Case XGE_MSG_CLOSE				' ���ڹر�
			Return -1
	End Select
End Function



' OOP ����Ժ���
Sub xge_test_oop()
	xge.InitA(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, "XGE���� - �հ׳���")
	xge.Scene.Start(@MainScreen, 40)
End Sub



' API ����Ժ���
Sub xge_test_sdk()
	
End Sub



' ͨ��ж�غ���
Sub xge_test_unit()
	
End Sub
