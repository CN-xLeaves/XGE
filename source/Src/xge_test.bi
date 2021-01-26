


' 通用初始化函数
Sub xge_test_init()
	
End Sub



' 一个场景
Function MainScreen(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static pic1 As xge.Surface Ptr
	Static ui As xui.Element Ptr
	Static win As xui.Window Ptr
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
			'xge.Text.LoadFont("..\release\res\font\xrf\simsun_16px_ucs2.xrf", 0)
			xge.Text.LoadFontA("..\release\res\font\xrf\simsun_12px_ucs2.xrf", 0)
			'xge.Text.LoadFont("F:\字体\思源屏显臻宋.ttf", 0)
			'xge.Text.LoadFont("D:\Git\XGE\release\res\font\ttf\Roboto-Light.ttf", 0)
			'xge.Text.LoadFont("F:\字体\庞门正道标题体2.0增强版.ttf", 0)
			xge.Text.SetFontSize(2, 12)
			'xge.Text.LoadFont("C:\windows\fonts\simsun.ttc", 0)
			
			pic1 = New xge.Surface("D:\Git\XGE\release\res\back.xgi", 0)
			
			win = xui.CreateBaseWindow(10, 10, 320, 240, , "About xywh Game Engine")
			
			ui->Childs.AddElement(win)
			xui.LayoutApply()
			
		Case XGE_MSG_FREERES			' 卸载资源
			
		Case XGE_MSG_CLOSE				' 窗口关闭
			Return -1
	End Select
End Function



' OOP 版测试函数
Sub xge_test_oop()
	xge.InitA(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, "XGE范例 - 空白场景")
	xge.Scene.Start(@MainScreen, 40)
End Sub



' API 版测试函数
Sub xge_test_sdk()
	
End Sub



' 通用卸载函数
Sub xge_test_unit()
	
End Sub
