


' ͨ�ó�ʼ������
Sub xge_test_init()
	
End Sub



' һ������
Function MainScreen(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static pic1 As xge.Surface Ptr
	Static ui As xui.Element Ptr
	Static As xui.ScrollBar Ptr vs, hs
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
			'xge.Text.LoadFont("..\����Ŀ¼\res\font\xrf\simsun_16px_ucs2.xrf", 0)
			'xge.Text.LoadFont("..\����Ŀ¼\res\font\xrf\simsun_12px_ucs2.xrf", 0)
			'xge.Text.LoadFont("F:\����\˼Դ��������.ttf", 0)
			xge.Text.LoadFont("D:\Git\XGE\release\res\font\ttf\Roboto-Light.ttf", 0)
			xge.Text.LoadFont("F:\����\��������������2.0��ǿ��.ttf", 0)
			xge.Text.SetFontSize(2, 12)
			'xge.Text.LoadFont("C:\windows\fonts\simsun.ttc", 0)
			
			pic1 = New xge.Surface("D:\Git\XGE\release\res\back.xgi", 0)
			
			vs = xui.CreateVScrollBar(, 100, 50, 18, 500)
			hs = xui.CreateHScrollBar(, 50, 20, 500, 18)
			
			ui->Childs.AddElement(vs)
			ui->Childs.AddElement(hs)
			xui.LayoutApply()
			
			'pic1->Create(800, 600)
			/'
			xge.Text.Draw(pic1, 0, 100, A2W("Draw  ��Ⱦ ANSI �ַ��� [UNICODE->ANSI]"), &HFF00)
			xge.Text.DrawA(pic1, 0, 140, "DrawA ��Ⱦ ANSI �ַ��� [ANSI->ANSI]", &HFF00)
			xge.Text.Draw(pic1, 0, 180, A2W("Draw  ��Ⱦ GB2312 �ַ��� [UNICODE->GB2312]"), &HFF00, 2)
			xge.Text.DrawA(pic1, 0, 220, "DrawA ��Ⱦ GB2312 �ַ��� [GB2312->GB2312]", &HFF00, 2)
			xge.Text.Draw(pic1, 0, 260, A2W("Draw  ��Ⱦ UCS2 �ַ��� [UNICODE->UNICODE]"), &HFF00, 3)
			xge.Text.DrawA(pic1, 0, 300, "DrawA ��Ⱦ UCS2 �ַ��� [ANSI->UNICODE]", &HFF00, 3)
			xge.Text.Draw(pic1, 0, 0, A2W("stb_ttf �������ȾЧ��"), &HFF00, 1)
			xge.Text.DrawA(pic1, 0, 100, "stb_ttf �������ȾЧ��", &HFF00, 1, 5)
			xge.Text.DrawRect(pic1, 0, 200, 400, 300, A2W(!"����ص���ȥ\n��Ĭ�Ż�ϲ\n���֮���ڿ���\nԽ��ԽԶ����"), &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, 0, 0)
			xge.Shape.Rect(0, 200, 400, 500, &HFF00FF00, pic1)
			pic1->Draw_Alpha(200, 0)
			'/
			'xge.Text.DrawA(pic1, 0, 140, "x x��x", &HFF00, 1)
			'xge.Text.DrawRectA(pic1, 0, 200, 400, 300, !"����ص���ȥ\n��Ĭ�Ż�ϲ\n���֮���ڿ���\nԽ��ԽԶ����", &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, 0, 0)
			'pic1->Draw_Alpha(NULL, 200, 0)
		Case XGE_MSG_FREERES			' ж����Դ
			
		Case XGE_MSG_CLOSE				' ���ڹر�
			Return -1
	End Select
End Function



' OOP ����Ժ���
Sub xge_test_oop()
	xge.Init(800, 600, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE���� - �հ׳���")
	xge.Scene.Start(@MainScreen, 40)
End Sub



' API ����Ժ���
Sub xge_test_sdk()
	
End Sub



' ͨ��ж�غ���
Sub xge_test_unit()
	
End Sub
