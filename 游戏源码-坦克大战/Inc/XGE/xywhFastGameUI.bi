'==================================================================================
	'★ xywh Fast GUI 图形界面系统 [FxGUI]
	'#-------------------------------------------------------------------------------
	'# 功能 : 未完成 , 暂不可用
	'# 说明 : 
'==================================================================================
/'
#Include Once "Win\Imm.bi"
#Include Once "Inc\SDK\File.bi"

		If xywh_library_2dge_IsInit=0 Then
			#Ifdef XGE_USE_GUI
				xywh_library_2dge_oldproc = Cast(Any Ptr,GetWindowLong(hWnd,GWL_WNDPROC))
				SetWindowLong(hWnd,GWL_WNDPROC,Cast(Integer,@xywh_library_2dge_proc))
				xywh_library_2dge_IsInit = -1
				fxgui.Init()
			#EndIf
		EndIf

#Define xywh_library_fxgui_max 256			' 控件最大数量
#Define xywh_library_fxgui_smax 64			' 一个框架中最多允许的控件数量



' 基础消息
#Define MSG_NULL							&H0					' 空消息[响应检测]
#Define MSG_CONINIT						&H1					' 控件初始化
#Define MSG_CONUNIT						&H2					' 控件卸载
#Define MSG_DRAW							&H3					' 画出
#Define MSG_MOUSEMOVE					&H4					' 鼠标移动
#Define MSG_MOUSEDOWN					&H5					' 鼠标按下
#Define MSG_MOUSEUP						&H6					' 鼠标弹起
#Define MSG_MOUSEDCLICK				&H7					' 鼠标双击
#Define MSG_MOUSEWHELL				&H8					' 滚轮滚动
#Define MSG_KEYDOWN						&H9					' 键盘按下
#Define MSG_KEYUP							&HA					' 键盘弹起
#Define MSG_KEYREPEAT					&HB					' 键盘重复按下
#Define MSG_IMECHAR						&HC					' 汉字输入
' 封装分发消息
#Define MSG_MOUSEENTER				&H100				' 鼠标进入
#Define MSG_MOUSEEXIT					&H101				' 鼠标离开
' 控件消息
#Define MSG_CLICK							&H1000			' 鼠标点击 [Button、CheckBox]
#Define MSG_REDCACHE					&H1001			' 重建缓存 [LineEdit]



Type fxgui_Control Extends Object						' 基本控件
	Index As UInteger					' 控件ID
	x As Integer							' 控件坐标
	y As Integer							' 控件坐标
	w As Integer							' 控件宽度
	h As Integer							' 控件高度
	Visible As Integer				' 是否显示
	Parent As Integer					' 父控件ID
	tpe As Integer						' 控件类别
	Font As xywhPointFont Ptr	' 控件字体
	IsFrame As Integer				' 是否为框架控件
	TagInt As Integer					' 附加数据[Int]
	TagPtr As Any Ptr					' 附加数据[Ptr]
	' 控件消息回调
	MessageBackCall As Function (ByVal Msg As Integer,ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	' 类回调
	Declare Virtual Function ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
End Type

Type fxgui_Frame Extends fxgui_Control				' 基本控件[容器]
	Controls(1 To xywh_library_fxgui_smax) As fxgui_Control Ptr
	' 类回调
	Declare Function ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	' 消息分发器 [返回0代表消息被穿透，否则消息被GUI系统吃掉]
	Declare Function MessageDispatch(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	' 添加控件到 Frame
	Declare Function GetSpace() As Integer
	Declare Function AddControl(ByVal Control As fxgui_Control Ptr) As Integer
End Type

Type fxgui_Button Extends fxgui_Control				' 按钮
	Caption As ZString * 64			' 按钮标题
	Img_Default As Surface			' 按钮图片[默认]
	Img_Hot As Surface					' 按钮图片[移入]
	Img_Down As Surface					' 按钮图片[按下]
	stk As Integer							' 状态[1=鼠标是否在按钮内，2=鼠标是否按下]
	Declare Function ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
End Type

Type fxgui_CheckBox Extends fxgui_Control			' 复选框
	Value As Integer
	Caption As ZString * 64			' 按钮标题
	Img_Default As Surface			' 按钮图片[默认]
	Img_Hot As Surface					' 按钮图片[移入]
	Img_Down As Surface					' 按钮图片[按下]
	Img_Chk As Surface					' 选中图片
	stk As Integer							' 状态[1=鼠标是否在按钮内，2=鼠标是否按下]
	Declare Function ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
End Type

Type fxgui_ProgBar Extends fxgui_Control			' 进度条
	Min As Integer
	Max As Integer
	Value As Integer
	Img_Back As Surface					' 图片[背景]
	Img_Val As Surface					' 图片[进度]
	Declare Function ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
End Type

Type fxgui_LineEdit Extends fxgui_Control			' 当行编辑框
	Text As ZString Ptr
	SelStart As Integer
	SelLength As Integer
	ViewAddr As Integer
	tpe As Integer
	MaxLength As Integer
	BackColor As Integer
	ForeColor As Integer
	Img_Cache As Surface
	flash As UInteger
	Declare Function ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
End Type





Function HitTest(ByVal x As Integer,ByVal y As Integer,ByVal w As Integer,ByVal h As Integer,ByVal px As Integer,ByVal py As Integer) As Integer
	If px >= x Then
		If py >= y Then
			If px <= x+w Then
				If py <= y+h Then
					Return -1
				EndIf
			EndIf
		EndIf
	EndIf
End Function



Function fxgui_Control.ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Return 0
End Function



Function fxgui_Frame.ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Return 0
End Function

Function fxgui_Frame.GetSpace() As Integer
	Dim i As Integer
	For i = 1 To xywh_library_fxgui_smax
		If Controls(i)=NULL Then Return i
	Next
End Function

Function fxgui_Frame.AddControl(ByVal Control As fxgui_Control Ptr) As Integer
	Dim i As Integer
	i = GetSpace()
	If i Then
		Controls(i) = Control
		Return -1
	EndIf
End Function

Function fxgui_Frame.MessageDispatch(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Dim msg As Integer = LoWord(Param)
	Dim i As Integer
	Select Case msg
		Case MSG_MOUSEMOVE
			For i = 1 To xywh_library_fxgui_smax
				If Controls(i) Then
					If HitTest(Controls(i)->x,Controls(i)->y,Controls(i)->w,Controls(i)->h,Event->x,Event->y) Then
						Dim te As NewEvent
						te.Param1 = Event->x - Controls(i)->x
						te.Param2 = Event->y - Controls(i)->y
						Controls(i)->ClassBackCall(MAKELONG(MSG_MOUSEMOVE,0),@te)
						Return Cast(Integer,Controls(i))
					EndIf
				EndIf
			Next
	End Select
	Return 0
End Function



Function fxgui_Button.ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Dim msg As Integer = LoWord(Param)
	Select Case msg
		Case MSG_DRAW
			If stk=0 Then
				Put (x,y),Img_Default,Trans
			Else
				If stk And 2 Then
					Put (x,y),Img_Down,Trans
				Else
					If stk And 1 Then
						Put (x,y),Img_Hot,Trans
					EndIf
				EndIf
			EndIf
		Case MSG_MOUSEENTER
			stk = stk Or 1
		Case MSG_MOUSEEXIT
			stk = stk And Not(1)
		Case MSG_MOUSEDOWN
			stk = stk Or 2
			Return -1						' 启用鼠标停靠锁
		Case MSG_MOUSEUP
			stk = stk And Not(2)
			Dim As Integer px,py
			GetMouse(px,py)
			If HitTest(x,y,w,h,px,py) Then
				MessageBackCall(xge_msg_xgui,MAKELONG(MSG_CLICK,Index),NULL)
			EndIf
		Case MSG_CONINIT
			' 创建图像缓存
			Img_Default = ImageCreate(w+1,h+1)
			Img_Hot = ImageCreate(w+1,h+1)
			Img_Down = ImageCreate(w+1,h+1)
			' 按钮标题矩形
			Dim TempRect As RECT
			TempRect.left = 2
			TempRect.top = 2
			TempRect.right = w-2
			TempRect.bottom = h-2
			' 默认状态图像缓存
			Line Img_Default,(0,0)-(w,h),RGB(49,77,99),BF
			Line Img_Default,(2,2)-(w-2,h-2),RGB(132,190,132),BF
			PReset Img_Default,(0,0)
			PReset Img_Default,(w,0)
			PReset Img_Default,(0,h)
			PReset Img_Default,(w,h)
			PSet Img_Default,(2,2),RGB(49,77,99)
			PSet Img_Default,(w-2,2),RGB(49,77,99)
			PSet Img_Default,(2,h-2),RGB(49,77,99)
			PSet Img_Default,(w-2,h-2),RGB(49,77,99)
			Font->PSetTextRect(Img_Default,@Caption,0,0,TempRect,Hori_Center Or Vert_Center,RGB(43,43,43))
			' 指向/弹起状态图像缓存
			Line Img_Hot,(0,0)-(w,h),RGB(28,44,57),BF
			Line Img_Hot,(2,2)-(w-2,h-2),RGB(190,220,190),BF
			PReset Img_Hot,(0,0)
			PReset Img_Hot,(w,0)
			PReset Img_Hot,(0,h)
			PReset Img_Hot,(w,h)
			PSet Img_Hot,(2,2),RGB(28,44,57)
			PSet Img_Hot,(w-2,2),RGB(28,44,57)
			PSet Img_Hot,(2,h-2),RGB(28,44,57)
			PSet Img_Hot,(w-2,h-2),RGB(28,44,57)
			Font->PSetTextRect(Img_Hot,@Caption,0,0,TempRect,Hori_Center Or Vert_Center,RGB(28,44,57))
			' 按下状态图像缓存
			Line Img_Down,(0,0)-(w,h),RGB(49,77,99),BF
			Line Img_Down,(2,2)-(w-2,h-2),RGB(28,44,57),BF
			PReset Img_Down,(0,0)
			PReset Img_Down,(w,0)
			PReset Img_Down,(0,h)
			PReset Img_Down,(w,h)
			PSet Img_Down,(2,2),RGB(49,77,99)
			PSet Img_Down,(w-2,2),RGB(49,77,99)
			PSet Img_Down,(2,h-2),RGB(49,77,99)
			PSet Img_Down,(w-2,h-2),RGB(49,77,99)
			Font->PSetTextRect(Img_Down,@Caption,0,0,TempRect,Hori_Center Or Vert_Center,RGB(255,255,255))
		Case MSG_CONUNIT
			ImageDestroy(Img_Default)
			ImageDestroy(Img_Hot)
			ImageDestroy(Img_Down)
		Case Else
			Return FALSE
	End Select
	Return -1
End Function



Function fxgui_CheckBox.ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Dim msg As Integer = LoWord(Param)
	Select Case msg
		Case MSG_DRAW
			If stk=0 Then
				Put (x,y),Img_Default,Trans
			Else
				If stk And 2 Then
					Put (x,y),Img_Down,Trans
				Else
					If stk And 1 Then
						Put (x,y),Img_Hot,Trans
					EndIf
				EndIf
			EndIf
			If Value Then
				Put (x+4,y+4),Img_Chk,Trans
			EndIf
		Case MSG_MOUSEENTER
			stk = stk Or 1
		Case MSG_MOUSEEXIT
			stk = stk And Not(1)
		Case MSG_MOUSEDOWN
			stk = stk Or 2
			Return -1						' 启用鼠标停靠锁
		Case MSG_MOUSEUP
			stk = stk And Not(2)
			Dim As Integer px,py
			GetMouse(px,py)
			If HitTest(x,y,w,h,px,py) Then
				Value = IIf(Value,0,-1)
				MessageBackCall(xge_msg_xgui,MAKELONG(MSG_CLICK,Index),NULL)
			EndIf
		Case MSG_CONINIT
			' 创建图像缓存
			Img_Default = ImageCreate(w+1,h+1)
			Img_Hot = ImageCreate(w+1,h+1)
			Img_Down = ImageCreate(w+1,h+1)
			Img_Chk = ImageCreate(8,8)
			' 默认状态图像缓存
			Line Img_Default,(0,0)-(15,15),RGB(49,77,99),BF
			Line Img_Default,(2,2)-(13,13),RGB(132,190,132),BF
			PReset Img_Default,(0,0)
			PReset Img_Default,(15,0)
			PReset Img_Default,(0,15)
			PReset Img_Default,(15,15)
			Font->PSetText(Img_Default,@Caption,20,3,RGB(255,255,255))
			' 指向/弹起状态图像缓存
			Line Img_Hot,(0,0)-(15,15),RGB(28,44,57),BF
			Line Img_Hot,(2,2)-(13,13),RGB(190,220,190),BF
			PReset Img_Hot,(0,0)
			PReset Img_Hot,(15,0)
			PReset Img_Hot,(0,15)
			PReset Img_Hot,(15,15)
			Font->PSetText(Img_Hot,@Caption,20,3,RGB(28,44,57))
			' 按下状态图像缓存
			Line Img_Down,(0,0)-(15,15),RGB(49,77,99),BF
			Line Img_Down,(2,2)-(13,13),RGB(28,44,57),BF
			PReset Img_Down,(0,0)
			PReset Img_Down,(15,0)
			PReset Img_Down,(0,15)
			PReset Img_Down,(15,15)
			Font->PSetText(Img_Down,@Caption,20,3,RGB(28,44,57))
			' 选中图片缓存
			Line Img_Chk,(0,0)-(7,7),RGB(28,44,57),BF
			PSet Img_Chk,(0,0),RGB(255,0,255)
			PSet Img_Chk,(7,0),RGB(255,0,255)
			PSet Img_Chk,(0,7),RGB(255,0,255)
			PSet Img_Chk,(7,7),RGB(255,0,255)
		Case MSG_CONUNIT
			ImageDestroy(Img_Default)
			ImageDestroy(Img_Hot)
			ImageDestroy(Img_Down)
			ImageDestroy(Img_Chk)
		Case Else
			Return FALSE
	End Select
	Return -1
End Function



Function fxgui_ProgBar.ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Dim msg As Integer = LoWord(Param)
	Select Case msg
		Case MSG_DRAW
				Put (x,y),Img_Back,Trans
				Line (x+4,y+4)-Step((w-8)*Value/(Max-Min),h-8),RGB(28,44,57),BF
		Case MSG_CONINIT
			' 创建图像缓存
			Img_Back = ImageCreate(w+1,h+1)
			' 默认背景图像缓存
			Line Img_Back,(0,0)-(w,h),RGB(49,77,99),BF
			Line Img_Back,(2,2)-(w-2,h-2),RGB(132,190,132),BF
			PReset Img_Back,(0,0)
			PReset Img_Back,(w,0)
			PReset Img_Back,(0,h)
			PReset Img_Back,(w,h)
		Case MSG_CONUNIT
			ImageDestroy(Img_Back)
		Case Else
			Return FALSE
	End Select
	Return -1
End Function



Function fxgui_LineEdit.ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Dim msg As Integer = LoWord(Param)
	Select Case msg
		Case MSG_DRAW
			Put (x,y),Img_Cache,Trans
			If ((GetTickCount() \ 600) Mod 2) = 0 Then
				Line (x+2,y+2)-(x+2,y+h-2),ForeColor,B
			EndIf
		Case MSG_MOUSEENTER
			
		Case MSG_MOUSEEXIT
			
		Case MSG_MOUSEMOVE
			
		Case MSG_MOUSEDOWN
			
			Return -1						' 启用鼠标停靠锁
		Case MSG_MOUSEUP
			
		Case MSG_REDCACHE
			Line Img_Cache,(0,0)-(w,h),&HAAAAAA,B
			Line Img_Cache,(1,1)-(w-1,h-1),BackColor,BF
			Dim tr As RECT
			tr.left = 3
			tr.right = w
			tr.bottom = h
			Font->PSetTextRect(Img_Cache,Text,0,0,tr,Hori_Left Or Vert_Center,ForeColor)
		Case MSG_CONINIT
			Img_Cache = ImageCreate(w+1,h+1)
			ClassBackCall(MSG_REDCACHE,NULL)
		Case MSG_CONUNIT
			ImageDestroy(Img_Cache)
		Case Else
			Return FALSE
	End Select
	Return -1
End Function





Dim Shared xywh_library_fxgui_cons(1 To xywh_library_fxgui_max) As fxgui_Control Ptr		' 控件表
Dim Shared xywh_library_fxgui_frame As fxgui_Frame Ptr																	' 主框架 [所有控件都在此框架之下]
Dim Shared xywh_library_fxgui_bcall As Any Ptr																					' 默认回调地址 [创建控件时如果不指定，则回调地址使用次地址]

Dim Shared xywh_library_fxgui_mcon As fxgui_Control Ptr																	' 鼠标停靠的控件
Dim Shared xywh_library_fxgui_lock As Integer																						' 鼠标停靠锁
Dim Shared xywh_library_fxgui_fcon As fxgui_Control Ptr																	' 有焦点的控件
Dim Shared xywh_Library_fxgui_icon As fxgui_Control Ptr																	' 键盘输入焦点





Namespace fxgui
	' 初始化 xgui 引擎
	Function Init() As Integer
		xywh_library_fxgui_frame = New fxgui_Frame
		Return -1
	End Function
	' 卸载 xgui 引擎
	Sub Unit()
		Dim i As Integer
		For i = 1 To xywh_library_fxgui_max
			If xywh_library_fxgui_cons(i) Then
				xywh_library_fxgui_cons(i)->ClassBackCall(MSG_CONUNIT,NULL)
				Delete xywh_library_fxgui_cons(i)
			EndIf
		Next
		Delete xywh_library_fxgui_frame
	End Sub
	
	Sub Draw(ByVal Surface As Surface)
		Dim i As Integer
		For i = 1 To xywh_library_fxgui_max
			If xywh_library_fxgui_cons(i) Then
				xywh_library_fxgui_cons(i)->ClassBackCall(MSG_DRAW,NULL)
			EndIf
		Next
	End Sub
	
	Sub SetInput(ByVal Con As fxgui_Control Ptr)
		xywh_Library_fxgui_icon = Con
	End Sub
	
	Function MessageDispatch(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Dim msg As Integer = LoWord(Param)
	Select Case msg
		Case MSG_MOUSEMOVE
			' MouseMove 消息涉及 mcon[鼠标停靠控件] 的更改，消息分发器会传递消息到最终控件，并由消息分发器层层返回最终的控件句柄
			' 返回的控件句柄会被设置为 mcon ，如果 mcon 被改变，则会发送 MSG_MOUSEENTER[鼠标进入] 消息到控件
			' 当 mcon 存在时，鼠标移动会判断是否离开控件矩形，如果离开，则会发送 MSG_MOUSEEXIT[鼠标离开] 消息到控件，并清空 mcon 值
			If xywh_library_fxgui_lock=0 Then
				If xywh_library_fxgui_mcon Then
					If HitTest(xywh_library_fxgui_mcon->x,xywh_library_fxgui_mcon->y,xywh_library_fxgui_mcon->w,xywh_library_fxgui_mcon->h,Event->x,Event->y)=0 Then
						xywh_library_fxgui_mcon->ClassBackCall(MSG_MOUSEEXIT,NULL)
						xywh_library_fxgui_mcon = NULL
					EndIf
				EndIf
				Dim RetObj As fxgui_Control Ptr = Cast(Any Ptr,xywh_library_fxgui_frame->MessageDispatch(Param,Event))
				If RetObj Then				' 消息被吃掉则更改 GUI 系统的 MouseControl
					If xywh_library_fxgui_mcon <> RetObj Then
						xywh_library_fxgui_mcon = RetObj
						xywh_library_fxgui_mcon->ClassBackCall(MSG_MOUSEENTER,NULL)
					EndIf
				EndIf
			EndIf
		Case MSG_MOUSEDOWN
			' MouseDown 消息会直接发送给 mcon ，当 mcon 为空时，消息会穿透给XGE，一旦控件接受了 MouseDown 消息并返回TRUE
			' 则 lock[鼠标停靠锁] 会开启， lock 开启后，MouseMove将不会被处理，直到 lock 关闭为止。
			If xywh_library_fxgui_mcon Then
				If xywh_library_fxgui_mcon->ClassBackCall(MSG_MOUSEDOWN,NULL) Then
					xywh_library_fxgui_lock = -1
				EndIf
			Else
				Return 0
			EndIf
		Case MSG_MOUSEUP
			' MouseUp 消息会直接发送给 mcon ，当 mcon 为空时，消息会穿透给XGE， MouseUp 消息会自动关闭 lock
			If xywh_library_fxgui_mcon Then
				xywh_library_fxgui_mcon->ClassBackCall(MSG_MOUSEUP,NULL)
				xywh_library_fxgui_lock = 0
			Else
				Return 0
			EndIf
		Case MSG_MOUSEDCLICK
			' MouseDoubleClick 消息会直接发送给 mcon ，当 mcon 为空时，消息会穿透给XGE
			If xywh_library_fxgui_mcon Then
				xywh_library_fxgui_mcon->ClassBackCall(MSG_MOUSEDCLICK,NULL)
			Else
				Return 0
			EndIf
		Case MSG_MOUSEWHELL
			' MouseWhell 消息会直接发送给 mcon ，当 mcon 为空时，消息会穿透给XGE
			If xywh_library_fxgui_mcon Then
				xywh_library_fxgui_mcon->ClassBackCall(MSG_MOUSEWHELL,NULL)
			Else
				Return 0
			EndIf
			/'
		Case MSG_KEYDOWN
			
		Case MSG_KEYUP
			
		Case MSG_KEYREPEAT
			
		Case MSG_IMECHAR
			'/
		Case Else
			xywh_library_fxgui_frame->MessageDispatch(Param,Event)
	End Select
	Return 0
End Function
	
	' 在控件索引中查找一个空位
	Function GetSpace() As Integer
		Dim i As Integer
		For i = 1 To xywh_library_fxgui_max
			If xywh_library_fxgui_cons(i)=NULL Then Return i
		Next
	End Function
	
	' 添加控件到 xgui 引擎 [Parent:父控件ID,必选参数、Control:控件结构指针、Index:控件ID]
	Function AddControl(ByVal Parent As Integer,ByVal Index As Integer,ByVal IsFrame As Integer,ByVal Control As fxgui_Control Ptr) As Integer
		Dim i As Integer
		If Parent Then
			For i = 1 To xywh_library_fxgui_max														' 查找父控件
				If xywh_library_fxgui_cons(i) Then
					If xywh_library_fxgui_cons(i)->IsFrame Then								' 父控件必须为框架
						If xywh_library_fxgui_cons(i)->Index = Parent Then				' 找到父控件
							If Cast(fxgui_Frame Ptr,xywh_library_fxgui_cons(i))->AddControl(Control) Then
								i = GetSpace()																			' 添加控件到索引表中
								If i Then
									xywh_library_fxgui_cons(i) = Control
									Control->Parent = Parent
									Control->Index = Index
									Control->IsFrame = IsFrame
									Return -1
								EndIf
							EndIf
							Exit For
						EndIf
					EndIf
				EndIf
			Next
		Else
			If xywh_library_fxgui_frame->AddControl(Control) Then
				i = GetSpace()
				If i Then
					xywh_library_fxgui_cons(i) = Control
					Control->Index = Index
					Control->IsFrame = IsFrame
					Return -1
				EndIf
			EndIf
		EndIf
	End Function
	
	' 创建控件到 xgui 引擎
	Function CreateControl(ByVal Parent As Integer,ByVal Index As Integer,ByVal x As Integer,ByVal y As Integer,ByVal w As Integer,ByVal h As Integer,ByVal Font As xywhPointFont Ptr,ByVal bk As Any Ptr) As fxgui_Control Ptr
		Dim TmpCon As fxgui_Control Ptr = New fxgui_Control
		If AddControl(Parent,Index,0,TmpCon) Then
			TmpCon->x = x
			TmpCon->y = y
			TmpCon->w = w
			TmpCon->h = h
			TmpCon->Font = Font
			If bk Then
				TmpCon->MessageBackCall = bk
			Else
				TmpCon->MessageBackCall = xywh_library_fxgui_bcall
			EndIf
			TmpCon->ClassBackCall(MSG_CONINIT,NULL)
			Return TmpCon
		Else
			Delete TmpCon
		EndIf
	End Function
	
	Function CreateButton(ByVal Parent As Integer,ByVal Index As Integer,ByVal x As Integer,ByVal y As Integer,ByVal w As Integer,ByVal h As Integer,ByVal Caption As ZString Ptr,ByVal Font As xywhPointFont Ptr,ByVal bk As Any Ptr=NULL) As fxgui_Button Ptr
		Dim TmpCon As fxgui_Button Ptr = New fxgui_Button
		If AddControl(Parent,Index,0,TmpCon) Then
			TmpCon->x = x
			TmpCon->y = y
			TmpCon->w = w
			TmpCon->h = h
			TmpCon->Font = Font
			TmpCon->Caption = *Caption
			If bk Then
				TmpCon->MessageBackCall = bk
			Else
				TmpCon->MessageBackCall = xywh_library_fxgui_bcall
			EndIf
			TmpCon->ClassBackCall(MSG_CONINIT,NULL)
			Return TmpCon
		Else
			Delete TmpCon
		EndIf
	End Function
	
	Function CreateCheckBox(ByVal Parent As Integer,ByVal Index As Integer,ByVal x As Integer,ByVal y As Integer,ByVal w As Integer,ByVal h As Integer,ByVal Caption As ZString Ptr,ByVal Font As xywhPointFont Ptr,ByVal bk As Any Ptr=NULL) As fxgui_CheckBox Ptr
		Dim TmpCon As fxgui_CheckBox Ptr = New fxgui_CheckBox
		If AddControl(Parent,Index,0,TmpCon) Then
			TmpCon->x = x
			TmpCon->y = y
			TmpCon->w = w
			TmpCon->h = h
			TmpCon->Font = Font
			TmpCon->Caption = *Caption
			If bk Then
				TmpCon->MessageBackCall = bk
			Else
				TmpCon->MessageBackCall = xywh_library_fxgui_bcall
			EndIf
			TmpCon->ClassBackCall(MSG_CONINIT,NULL)
			Return TmpCon
		Else
			Delete TmpCon
		EndIf
	End Function
	
	Function CreateProgBar(ByVal Parent As Integer,ByVal Index As Integer,ByVal x As Integer,ByVal y As Integer,ByVal w As Integer,ByVal h As Integer,ByVal min As Integer,ByVal max As Integer,ByVal Value As Integer,ByVal bk As Any Ptr=NULL) As fxgui_ProgBar Ptr
		Dim TmpCon As fxgui_ProgBar Ptr = New fxgui_ProgBar
		If AddControl(Parent,Index,0,TmpCon) Then
			TmpCon->x = x
			TmpCon->y = y
			TmpCon->w = w
			TmpCon->h = h
			TmpCon->Min = min
			TmpCon->Max = max
			TmpCon->Value = Value
			If bk Then
				TmpCon->MessageBackCall = bk
			Else
				TmpCon->MessageBackCall = xywh_library_fxgui_bcall
			EndIf
			TmpCon->ClassBackCall(MSG_CONINIT,NULL)
			Return TmpCon
		Else
			Delete TmpCon
		EndIf
	End Function
	
	Function CreateLineEdit(ByVal Parent As Integer,ByVal Index As Integer,ByVal x As Integer,ByVal y As Integer,ByVal w As Integer,ByVal h As Integer,ByVal Text As ZString Ptr,ByVal Font As xywhPointFont Ptr,ByVal MaxLen As Integer=260,ByVal bk As Any Ptr=NULL) As fxgui_LineEdit Ptr
		Dim TmpCon As fxgui_LineEdit Ptr = New fxgui_LineEdit
		If AddControl(Parent,Index,0,TmpCon) Then
			TmpCon->x = x
			TmpCon->y = y
			TmpCon->w = w
			TmpCon->h = h
			TmpCon->Text = Allocate(MaxLen+1)
			*TmpCon->Text = *Text
			TmpCon->MaxLength = MaxLen
			TmpCon->Font = Font
			TmpCon->BackColor = &H0
			TmpCon->ForeColor = &HFFFFFF
			If bk Then
				TmpCon->MessageBackCall = bk
			Else
				TmpCon->MessageBackCall = xywh_library_fxgui_bcall
			EndIf
			TmpCon->ClassBackCall(MSG_CONINIT,NULL)
			Return TmpCon
		Else
			Delete TmpCon
		EndIf
	End Function
End Namespace


#Ifdef XGE_USE_GUI
	Function xywh_library_2dge_proc(ByVal hWin As HWND, ByVal uMsg As UINT, ByVal wParam As WPARAM, ByVal lParam As LPARAM) As Integer
		Select Case uMsg
			Case WM_IME_COMPOSITION
				If lParam And GCS_RESULTSTR Then
					Dim hinst As HIMC = ImmGetContext(hWin)
					If hinst Then
						Dim sCharLen As Integer = ImmGetCompositionString(hinst,GCS_RESULTSTR,NULL,NULL)
						Dim bufferChar As ZString Ptr = Allocate(sCharLen+1)
						ImmGetCompositionString(hinst,GCS_RESULTSTR,bufferChar,sCharLen)
						bufferChar[sCharLen] = 0
						ImmReleaseContext(hWin,hinst)
						Dim te As NewEvent
						te.Param1 = sCharLen
						te.Param2 = Cast(Integer,bufferChar)
						xywh_library_fxgui_frame->MessageDispatch(MSG_IMECHAR,@te)
						DeAllocate(bufferChar)
					End If
				End If
			Case Else
				Return xywh_library_2dge_oldproc(hWin,uMsg,wParam,lParam)
		End Select
	End Function
#EndIf
'/