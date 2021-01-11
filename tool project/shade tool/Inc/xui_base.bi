


#Ifndef xywh_library_xui_base
	#Define xywh_library_xui_base
	
	
	
	Namespace xui
		
		' 初始化
		Declare Function Init(WindowExtDataSize As Integer=12,ClassExtDataSize As Integer=0) As Integer
		
		' 启动
		Declare Function Start() As Integer
		
		' 停止
		Declare Function Stop() As Integer
		
		' 载入图片
		Declare Function LoadPicture(sFile As ZString Ptr, iSize As Integer, iColor As Integer, x As Integer, y As Integer) As HBITMAP
		
		' 载入图标
		'Declare Function LoadIcon() As HICON
		
		' 创建窗口
		Declare Function CreatWindow(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sText As ZString Ptr, WndProc As Any Ptr, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr=0) As HWND
		
		' 创建控件
		Declare Function CraetControl(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sClass As ZString Ptr, sText As ZString Ptr, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HWND
		
		' 申请临时内存
		Declare Function TempMemory(size As UInteger) As Any Ptr
		
		
		
		' 句柄列表
		Type xHandleList
			
			' 析构
			Declare Destructor()
			
			' 重置
			Declare Function Init() As Integer
			
			' 添加
			Declare Function Add(NewValue As HANDLE) As Integer
			
			' 删除
			Declare Function Del(iPos As Integer) As Integer
			
			' 获取位置
			Declare Function Pos(Value As HANDLE) As Integer
			
			' 数量
			Declare Function Count() As Integer
			
			' 访问句柄
			Declare Property List(nIndex As Integer) As HANDLE
			Declare Property List(nIndex As Integer, NewValue As HANDLE)
			
			' 私有变量
			Private:
				p_Hdr As HANDLE Ptr
				c_Hdr As Integer
				c_Mem As Integer
		End Type
		
		
		
		
		
		' 字体类
		Type xFont
			Dim AutoMake As Integer
			
			' 构造
			Declare Constructor()
			Declare Constructor(sName As ZString Ptr, iSize As Integer, iStyle As Integer, iChar As Integer = GB2312_CHARSET)
			
			' 析构
			Declare Destructor()
			
			' 绑定
			Declare Function Bind(hWin As HANDLE, idx As Integer = 0) As Integer
			Declare Function UnBind(hWin As HANDLE) As Integer
			
			' 绑定列表
			Declare Property BindList As xui.xHandleList Ptr
			Declare Property BindList(NewValue As xui.xHandleList Ptr)
			
			' 生成新的字体对象
			Declare Function Make() As HANDLE
			
			' 字体名
			Declare Property Name As ZString Ptr
			Declare Property Name(NewValue As ZString Ptr)
			
			' 字号
			Declare Property Size As Integer
			Declare Property Size(NewValue As Integer)
			
			' 粗体
			Declare Property Bold As Integer
			Declare Property Bold(NewValue As Integer)
			
			' 斜体
			Declare Property Italic As Integer
			Declare Property Italic(NewValue As Integer)
			
			' 下划线
			Declare Property Underline As Integer
			Declare Property Underline(NewValue As Integer)
			
			' 删除线
			Declare Property Strikethrough As Integer
			Declare Property Strikethrough(NewValue As Integer)
			
			' 字符集
			Declare Property Charset As Integer
			Declare Property Charset(NewValue As Integer)
			
			' 磅数
			Declare Property Weight As Integer
			Declare Property Weight(NewValue As Integer)
			
			' 获取字体句柄
			Declare Property Font As HANDLE
			
			' 私有变量
			Private:
				Dim s_Font As LOGFONT
				Dim h_Font As HANDLE
				Dim p_List As xui.xHandleList Ptr
				Dim b_list As Integer
		End Type
		#Ifdef XUI_COMPILE_USE_XFONT
			#Ifdef XUI_COMPILE_XFONT_PTR
				Dim Font As xFont
			#EndIf
		#EndIf
		
		
		
		
		
		' 菜单类
		Type xMenu
			' 标题
			Declare Property Caption As ZString Ptr
			Declare Property Caption(NewValue As ZString Ptr)
			
			' 标题
			Declare Property Checked As Integer
			Declare Property Checked(NewValue As Integer)
			
			' 可用
			Declare Property Enabled As Integer
			Declare Property Enabled(NewValue As Integer)
			
			' 可见
			Declare Property Visible As Integer
			Declare Property Visible(NewValue As Integer)
			
			' 可见
			Declare Property HelpContextID As Integer
			Declare Property HelpContextID(NewValue As Integer)
			
			' Index
			Declare Property Index As Integer
			Declare Property Index(NewValue As Integer)
			
			' 父菜单
			Declare Property Parent As HMENU
			Declare Property Parent(NewValue As HMENU)
			
			' 附加数据
			Declare Property Tag As Integer
			Declare Property Tag(NewValue As Integer)
			
			' 私有变量
			Private:
				Dim h_Menu As HMENU
		End Type
		
		
		
		
		
		' 控件基类
		Type xControl
			Dim hWnd As HANDLE
			
			' 析构
			Declare Destructor()
			
			' 绑定
			Declare Function Bind(hWin As HANDLE, idx As Integer = 0) As HANDLE
			
			' 创建
			Declare Function Create(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sClass As ZString Ptr, sText As ZString Ptr, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' 销毁
			Declare Function Destroy() As Integer
			
			' 发消息
			Declare Function Send(msg As Integer, wParam As Integer = 0, lParam As Integer = 0) As Integer
			Declare Function Post(msg As Integer, wParam As Integer = 0, lParam As Integer = 0) As Integer
			
			' LONG
			Declare Function GetLong(idx as Integer) as Integer
			Declare Function SetLong(idx as Integer, value as Integer) As Integer
			
			' Index
			Declare Property Index As Integer
			Declare Property Index(NewValue As Integer)
			
			' 样式
			Declare Property Style As Integer
			Declare Property Style(NewValue As Integer)
			Declare Function AddStyle(NewStyle As Integer) As Integer
			Declare Function DelStyle(StyleID As Integer) As Integer
			
			' 扩展样式
			Declare Property ExStyle As Integer
			Declare Property ExStyle(NewValue As Integer)
			Declare Function AddExStyle(NewStyle As Integer) As Integer
			Declare Function DelExStyle(StyleID As Integer) As Integer
			
			' 刷新
			Declare Function Refresh(lpRect As RECT Ptr = NULL) As Integer
			
			' 焦点
			Declare Function SetFocus() As HANDLE
			
			' 移动/大小
			Declare Function Move(x As Integer, y As Integer) As Integer
			Declare Function Size(w As Integer, h As Integer) As Integer
			
			' 可用
			Declare Property Enabled As Integer
			Declare Property Enabled(NewValue As Integer)
			
			' 可见
			Declare Property Visible As Integer
			Declare Property Visible(NewValue As Integer)
			
			' 宽度
			Declare Property Width As Integer
			Declare Property Width(NewValue As Integer)
			
			' 高度
			Declare Property Height As Integer
			Declare Property Height(NewValue As Integer)
			
			' 可用宽度/高度
			Declare Function ScaleWidth() As Integer
			Declare Function ScaleHeight() As Integer
			
			' 横坐标
			Declare Property Left As Integer
			Declare Property Left(NewValue As Integer)
			
			' 纵坐标
			Declare Property Top As Integer
			Declare Property Top(NewValue As Integer)
			
			' 标题
			Declare Property Caption As ZString Ptr
			Declare Property Caption(NewValue As ZString Ptr)
			
			' 父窗口
			Declare Property Parent As HANDLE
			Declare Property Parent(NewValue As HANDLE)
			
			' 附加数据
			Declare Property Tag As Integer
			Declare Property Tag(NewValue As Integer)
			
			' 字体
			#Ifdef XUI_COMPILE_USE_XFONT
				#Ifdef XUI_COMPILE_XFONT_PTR
					Dim Font As xFont Ptr
				#Else
					Dim Font As xFont
				#EndIf
			#Else
				Declare Property Font As HFONT
				Declare Property Font(NewValue As HFONT)
			#EndIf
			
			' DC
			Declare Property hDC As HANDLE
			
			' 类名
			Declare Function ClassName() As ZString Ptr
			
			' Z序
			Declare Function ZOrder(iPos As Integer = 0) As Integer
			
			' 私有变量
			Private:
				Dim h_dc As HANDLE
		End Type
		
		
		
		
		
		' 窗体类
		Type xWindow Extends xControl
			' 创建
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sText As ZString Ptr, WndProc As Any Ptr, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' 显示隐藏
			Declare Function Show(St As Integer = SW_SHOW) As Integer
			Declare Function Hide() As Integer
			
			' 可见状态
			Declare Property WindowState As Integer
			Declare Property WindowState(NewValue As Integer)
			
			' 图标
			Declare Property Icon As HICON
			Declare Property Icon(NewValue As HICON)
			
			' 系统菜单
			Declare Property ControlBox As Integer
			Declare Property ControlBox(NewValue As Integer)
			
			' 最大化按钮
			Declare Property MaxButton As Integer
			Declare Property MaxButton(NewValue As Integer)
			
			' 最小化按钮
			Declare Property MinButton As Integer
			Declare Property MinButton(NewValue As Integer)
			
			' 边框风格
			Declare Property BorderStyle As Integer
			Declare Property BorderStyle(NewValue As Integer)
			
			' 是否可调边框大小
			Declare Property SizeBorder As Integer
			Declare Property SizeBorder(NewValue As Integer)
			
			' 菜单
			#Ifdef XUI_COMPILE_USE_XMENU
				Dim Menu As xMenu
			#Else
				Declare Property Menu As HMENU
				Declare Property Menu(NewValue As HMENU)
			#EndIf
		End Type
		
		
		
		
		
		' 时钟
		Type xTimer
			Dim Index As Integer
			Dim Tag As Integer
			
			' 创建
			Declare Function Create(hParent As HANDLE, idx As Integer, iInterval As Integer) As Integer
			
			' 销毁
			Declare Function Destroy() As Integer
			
			' 时间间隔
			Declare Property Interval As Integer
			Declare Property Interval(NewValue As Integer)
			
			' 父窗口
			Declare Property Parent As HANDLE
			
			' 私有变量
			Private:
				Dim t_Interval As Integer
				Dim h_Parent As HANDLE
				Dim p_ParentProc As Any Ptr
		End Type
		
		
		
		
		
		' 标签
		Type xLabel Extends xControl
			' 创建
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sText As ZString Ptr, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' & 符号快捷访问
			Declare Property UseMnemonic As Integer
			Declare Property UseMnemonic(NewValue As Integer)
			
			' 自动换行
			Declare Property WordWrap As Integer
			Declare Property WordWrap(NewValue As Integer)
		End Type
		
		
		
		
		
		' 图像
		Type xImageBox Extends xControl
			' 创建
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' 图像
			Declare Property Picture As HANDLE
			Declare Property Picture(NewValue As HANDLE)
			
			' 类型
			Declare Property ImageType As Integer
			Declare Property ImageType(NewValue As Integer)
			
			' 自动调整大小
			Declare Property Stretch As Integer
			Declare Property Stretch(NewValue As Integer)
		End Type
		
		
		
		
		
		' 按钮类
		Type xButtom Extends xControl
			' 创建
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sText As ZString Ptr, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' 点击
			Declare Function Click() As Integer
			
			' 选项
			Declare Property Value As Integer
			Declare Property Value(NewValue As Integer)
			
			' 默认
			Declare Property Default As Integer
			Declare Property Default(NewValue As Integer)
		End Type
		
		' 多选框类
		Type xCheckBox Extends xButtom
			' 创建
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sText As ZString Ptr, iVal As Integer, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
		End Type
		
		' 单选框类
		Type xRadioBox Extends xButtom
			' 创建
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sText As ZString Ptr, iVal As Integer, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
		End Type
		
		
		
		
		
		' 输入框类
		Type xTextBox Extends xControl
			' 创建
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sText As ZString Ptr, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' 文本
			Declare Property Text As ZString Ptr
			Declare Property Text(NewValue As ZString Ptr)
			
			' 锁定
			Declare Property Locked As Integer
			Declare Property Locked(NewValue As Integer)
			
			' 多行 [仅获取(风格加上也不会生效)]
			Declare Property MultiLine As Integer
			
			' 密码 [仅获取(风格加上也不会生效)]
			Declare Property PassWord As Integer
			
			' 长度
			Declare Function Length() As Integer
			
			' 是否修改
			Declare Property IsChange As Integer
			Declare Property IsChange(NewValue As Integer)
			
			' 常规操作
			Declare Function Copy() As Integer
			Declare Function Cut() As Integer
			Declare Function Paste() As Integer
			Declare Function Del() As Integer
			Declare Function SelectAll() As Integer
			Declare Function Undo() As Integer
			Declare Function CanUndo() As Integer
			
			' 选择
			Declare Property SelLength As Integer
			Declare Property SelLength(NewValue As Integer)
			Declare Property SelStart As Integer
			Declare Property SelStart(NewValue As Integer)
			Declare Property SelEnd As Integer
			Declare Property SelEnd(NewValue As Integer)
			Declare Property SelText As ZString Ptr
			Declare Property SelText(NewValue As ZString Ptr)
		End Type
		
		
		
		
		
		' 列表框类
		Type xListBox Extends xControl
			' 创建
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' 列表项
			Declare Property List(nIndex As Integer) As ZString Ptr
			Declare Property List(nIndex As Integer, NewValue As ZString Ptr)
			
			' 列表项附加数据
			Declare Property ItemData(nIndex As Integer) As Integer
			Declare Property ItemData(nIndex As Integer, NewValue As Integer)
			
			' 多选 [仅获取(风格加上也不会生效)]
			Declare Property MultiSelect As Integer
			
			' 排序 [仅获取(风格加上也不会生效)]
			Declare Property Sorted As Integer
			
			' 添加列表项
			Declare Function AddItem(sText As ZString Ptr, nIndex As Integer = -1) As Integer
			Declare Function AddItemEx(sText As ZString Ptr, iData As Integer, idx As Integer = -1) As Integer
			Declare Function InsItem(sText As ZString Ptr, nIndex As Integer) As Integer
			
			' 移除列表项
			Declare Function RemoveItem(nIndex As Integer) As Integer
			Declare Function Clear() As Integer
			
			' 选中列表项
			Declare Property Selected(nIndex As Integer) As Integer
			Declare Property Selected(nIndex As Integer, NewValue As Integer)
			
			' 选中项数量
			Declare Function SelCount() As Integer
			
			' 清除所有选中
			Declare Function SelClear() As Integer
			
			' 列表项数量
			Declare Property ListCount As Integer
			
			' 当前列表项
			Declare Property ListIndex As Integer
			Declare Property ListIndex(ByVal nIndex As Integer)
			
			' 当前列表项标题
			Declare Property Text As ZString Ptr
			Declare Property Text(NewValue As ZString Ptr)
		End Type
		
		
		
		
		
		' 组合框类
		Type xComboBox Extends xControl
			' 创建
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' 列表项
			Declare Property List(nIndex As Integer) As ZString Ptr
			Declare Property List(nIndex As Integer, NewValue As ZString Ptr)
			
			' 列表项附加数据
			Declare Property ItemData(nIndex As Integer) As Integer
			Declare Property ItemData(nIndex As Integer, NewValue As Integer)
			
			' 排序 [仅获取(风格加上也不会生效)]
			Declare Property Sorted As Integer
			
			' 添加列表项
			Declare Function AddItem(sText As ZString Ptr, nIndex As Integer = -1) As Integer
			Declare Function AddItemEx(sText As ZString Ptr, iData As Integer, idx As Integer = -1) As Integer
			Declare Function InsItem(sText As ZString Ptr, nIndex As Integer) As Integer
			
			' 移除列表项
			Declare Function RemoveItem(nIndex As Integer) As Integer
			Declare Function Clear() As Integer
			
			' 列表项数量
			Declare Property ListCount As Integer
			
			' 当前列表项
			Declare Property ListIndex As Integer
			Declare Property ListIndex(ByVal nIndex As Integer)
			
			' 当前列表项标题
			Declare Property Text As ZString Ptr
			Declare Property Text(NewValue As ZString Ptr)
			
			' 模式
			Declare Property Mode As Integer
			Declare Property Mode(NewValue As Integer)
		End Type
		
		
		
		
		
		' 容器框架
		Type xFrame Extends xControl
			' 创建
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sText As ZString Ptr, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
		End Type
		
		
		
		
		
		' 滚动条
		Type xScroll Extends xControl
			' 创建
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, iTpe As Integer, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' 最小值
			Declare Property MinValue As Integer
			Declare Property MinValue(NewValue As Integer)
			
			' 最大值
			Declare Property MaxValue As Integer
			Declare Property MaxValue(NewValue As Integer)
			
			' 当前值
			Declare Property Value As Integer
			Declare Property Value(NewValue As Integer)
			
			' 类型[水平或垂直]
			Declare Property ScrollType As Integer
			Declare Property ScrollType(NewValue As Integer)
		End Type
	End Namespace
#EndIf
