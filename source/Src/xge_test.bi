


' 通用初始化函数
Sub xge_test_init()
	
End Sub



' 一个场景
Function MainScreen(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static pic1 As xge.Surface Ptr
	Static ui As xui.Element Ptr
	Static As xui.ScrollBar Ptr vs, hs
	Select Case msg
		Case XGE_MSG_FRAME				' 逻辑处理
			
		Case XGE_MSG_DRAW				' 绘图
			xge.Clear()
			ui->Draw()
		Case XGE_MSG_MOUSE_MOVE			' 鼠标移动
			
		Case XGE_MSG_MOUSE_DOWN			' 鼠标按下
			
		Case XGE_MSG_MOUSE_UP			' 鼠标弹起
			
		Case XGE_MSG_MOUSE_CLICK		' 鼠标单击
			
		Case XGE_MSG_MOUSE_DCLICK		' 鼠标双击
			
		Case XGE_MSG_MOUSE_WHELL		' 鼠标滚轮滚动
			
		Case XGE_MSG_KEY_DOWN			' 键盘按下
			
		Case XGE_MSG_KEY_UP				' 键盘弹起
			
		Case XGE_MSG_KEY_REPEAT			' 按键重复按下
			
		Case XGE_MSG_GOTFOCUS			' 拥有焦点
			
		Case XGE_MSG_LOSTFOCUS			' 失去焦点
			
		Case XGE_MSG_MOUSE_ENTER		' 鼠标移入
			
		Case XGE_MSG_MOUSE_EXIT			' 鼠标移出
			
		Case XGE_MSG_LOADRES			' 加载资源
			ui = xui.GetRootElement()
			'xge.Text.LoadFont("..\发布目录\res\font\xrf\simsun_16px_ucs2.xrf", 0)
			'xge.Text.LoadFont("..\发布目录\res\font\xrf\simsun_12px_ucs2.xrf", 0)
			'xge.Text.LoadFont("F:\字体\思源屏显臻宋.ttf", 0)
			xge.Text.LoadFont("D:\Git\XGE\release\res\font\ttf\Roboto-Light.ttf", 0)
			xge.Text.LoadFont("F:\字体\庞门正道标题体2.0增强版.ttf", 0)
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
			xge.Text.Draw(pic1, 0, 100, A2W("Draw  渲染 ANSI 字符串 [UNICODE->ANSI]"), &HFF00)
			xge.Text.DrawA(pic1, 0, 140, "DrawA 渲染 ANSI 字符串 [ANSI->ANSI]", &HFF00)
			xge.Text.Draw(pic1, 0, 180, A2W("Draw  渲染 GB2312 字符串 [UNICODE->GB2312]"), &HFF00, 2)
			xge.Text.DrawA(pic1, 0, 220, "DrawA 渲染 GB2312 字符串 [GB2312->GB2312]", &HFF00, 2)
			xge.Text.Draw(pic1, 0, 260, A2W("Draw  渲染 UCS2 字符串 [UNICODE->UNICODE]"), &HFF00, 3)
			xge.Text.DrawA(pic1, 0, 300, "DrawA 渲染 UCS2 字符串 [ANSI->UNICODE]", &HFF00, 3)
			xge.Text.Draw(pic1, 0, 0, A2W("stb_ttf 字体的渲染效果"), &HFF00, 1)
			xge.Text.DrawA(pic1, 0, 100, "stb_ttf 字体的渲染效果", &HFF00, 1, 5)
			xge.Text.DrawRect(pic1, 0, 200, 400, 300, A2W(!"我想回到过去\n沉默着欢喜\n天空之城在哭泣\n越来越远的你"), &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, 0, 0)
			xge.Shape.Rect(0, 200, 400, 500, &HFF00FF00, pic1)
			pic1->Draw_Alpha(200, 0)
			'/
			'xge.Text.DrawA(pic1, 0, 140, "x x我x", &HFF00, 1)
			'xge.Text.DrawRectA(pic1, 0, 200, 400, 300, !"我想回到过去\n沉默着欢喜\n天空之城在哭泣\n越来越远的你", &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, 0, 0)
			'pic1->Draw_Alpha(NULL, 200, 0)
		Case XGE_MSG_FREERES			' 卸载资源
			
		Case XGE_MSG_CLOSE				' 窗口关闭
			Return -1
	End Select
End Function



' OOP 版测试函数
Sub xge_test_oop()
	xge.Init(800, 600, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE范例 - 空白场景")
	xge.Scene.Start(@MainScreen, 40)
End Sub



' API 版测试函数
Sub xge_test_sdk()
	
End Sub



' 通用卸载函数
Sub xge_test_unit()
	
End Sub
