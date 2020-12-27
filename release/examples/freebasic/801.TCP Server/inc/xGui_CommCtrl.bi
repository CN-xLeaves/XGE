


#Ifndef xywh_library_xui_cctl
	#Define xywh_library_xui_cctl
	
	
	
	Namespace xGui
		
		
		
		' 图像列表类
		Type xImageList
			' 空构造
			Declare Constructor()
			
			' 构造
			Declare Constructor(w As Integer, h As Integer, flag As Integer = ILC_COLOR32 Or ILC_MASK, cInit As Integer = 0)
			
			' 析构
			Declare Destructor()
			
			' 创建
			Declare Function Create(w As Integer, h As Integer, flag As Integer = ILC_COLOR32 Or ILC_MASK, cInit As Integer = 0) As HANDLE
			
			' 销毁
			Declare Sub Destroy()
			
			' 数量
			Declare Property Count() As UInteger
			Declare Property Count(nval As UInteger)
			
			' 图像列表句柄
			Declare Property hImageList() As HANDLE
			Declare Property hImageList(nval As HANDLE)
			
			' 背景色
			Declare Property BackColor() As Integer
			Declare Property BackColor(nval As Integer)
			
			' 宽度
			Declare Property ImageWidth() As Integer
			Declare Property ImageWidth(nval As Integer)
			
			' 高度
			Declare Property ImageHeight() As Integer
			Declare Property ImageHeight(nval As Integer)
			
			' 大小
			Declare Function GetSize(w As Integer Ptr, h As Integer Ptr) As Integer
			Declare Sub SetSize(w As Integer, h As Integer)
			
			' 添加图标
			Declare Function AddIcon(hico As HICON) As Integer
			Declare Function AddIcon(ires As Integer, hInst As HINSTANCE = NULL) As Integer
			Declare Function AddIcon(file As ZString Ptr) As Integer
			
			' 添加图片
			Declare Function AddImage(hbmp As HBITMAP, cMask As Integer) As Integer
			Declare Function AddImage(ires As Integer, cMask As Integer, hInst As HINSTANCE = NULL) As Integer
			Declare Function AddImage(file As ZString Ptr, cMask As Integer) As Integer
			
			' 替换
			Declare Function Replace(idx As Integer, hico As HICON) As Integer
			Declare Function Replace(idx As Integer, ImgBmp As HBITMAP, MaskBmp As HBITMAP) As Integer
			
			' 删除
			Declare Function Remove(idx As Integer) As Integer
			
			' 绘制
			Declare Function Draw(idx As Integer, dst As HDC, x As Integer, y As Integer, stl As Integer = ILD_TRANSPARENT) As Integer
			Declare Function DrawEx(idx As Integer, dst As HDC, x As Integer, y As Integer, dx As Integer, dy As Integer, stl As Integer = ILD_TRANSPARENT) As Integer
			
			' 获取图标
			Declare Function GetIcon(idx As Integer) As HICON
			
			' 获取图像信息
			Declare Function GetInfo(idx As Integer) As ImageInfo
			
			' 绑定
			Declare Function Bind(hWin As HANDLE, idx As Integer = 0) As Integer
			Declare Function UnBind(hWin As HANDLE) As Integer
			
			' 绑定列表
			Declare Property BindList As xGui.xHandleList Ptr
			Declare Property BindList(NewValue As xGui.xHandleList Ptr)
			
			' 重新设置到绑定的控件中 [修改后需要使用]
			Declare Sub ReSetup()
			
			' 私有变量
			Private:
				Dim h_ImgList As HANDLE
				Dim i_Width As Integer
				Dim i_Height As Integer
				Dim p_List As xGui.xHandleList Ptr
				Dim b_list As Integer
		End Type
		
		
		
		' 进度条类
		Type xProgressBar Extends xControl
			' 范围
			Declare Function GetRange(pMin As Integer Ptr, pMax As Integer Ptr) As Integer
			Declare Function SetRange(iMin As Integer, iMax As Integer) As Integer
			
			' 最大值
			Declare Property MaxValue() As Integer
			Declare Property MaxValue(ival As Integer)
			
			' 最小值
			Declare Property MinValue() As Integer
			Declare Property MinValue(ival As Integer)
			
			' 当前值
			Declare Property Value() As Integer
			Declare Property Value(ival As Integer)
			
			' 增量滚动
			Declare Sub SetStep(ival As Integer)
			Declare Sub IncStep()
			Declare Sub IncValue(ival As Integer)
			
			' 方向 [垂直、水平]
			Declare Property Orientation() As Integer
			Declare Property Orientation(nval As Integer)
			
			' 滚动块风格
			Declare Property Smooth() As Integer
			Declare Property Smooth(nval As Integer)
			
			' 循环滚动
			Declare Property Marquee() As Integer
			Declare Property Marquee(nval As Integer)
			
			' 开始循环滚动
			Declare Function SetMarquee(isopen As Integer, ms As Integer) As Integer
		End Type
		
		
		
		' 滑块类
		Type xTrackBar Extends xControl
			' 最大值
			Declare Property MaxValue() As Integer
			Declare Property MaxValue(ival As Integer)
			
			' 最小值
			Declare Property MinValue() As Integer
			Declare Property MinValue(ival As Integer)
			
			' 当前值
			Declare Property Value() As Integer
			Declare Property Value(ival As Integer)
			
			' 刻度间隔
			Declare Property TickFreuqency(ival As UInteger)
			
			' 小段移动长度
			Declare Property SmallChange() As Integer
			Declare Property SmallChange(ival As Integer)
			
			' 大段移动长度
			Declare Property LargeChange() As Integer
			Declare Property LargeChange(ival As Integer)
			
			' 是否区域选择
			Declare Property SelectRange() As Integer
			Declare Property SelectRange(ival As Integer)
			
			' 选区范围
			Declare Sub GetSelRange(pMin As Integer Ptr, pMax As Integer Ptr)
			Declare Sub SetSelRange(iMin As Integer, iMax As Integer)
			
			' 清除选区
			Declare Sub ClearSel()
			
			' 选区开始
			Declare Property SelStart() As Integer
			Declare Property SelStart(ival As Integer)
			
			' 选区结束
			Declare Property SelEnd() As Integer
			Declare Property SelEnd(ival As Integer)
			
			' 选区长度
			Declare Property SelLength() As Integer
			Declare Property SelLength(ival As Integer)
			
			' 方向 [垂直、水平]
			Declare Property Orientation() As Integer
			Declare Property Orientation(nval As Integer)
		End Type
		
		
		
		' 选项卡类
		Type xTabStrip Extends xControl
			' 图像列表
			ImageList As xGui.xImageList Ptr
			
			' 添加选项卡
			Declare Function Insert(sTitle As ZString Ptr, nIndex As Integer = -1, nImage As UInteger = 0, nParam As Integer = 0) As Integer
			
			' 移除选项卡
			Declare Function Remove(nIndex As Integer) As Integer
			Declare Sub Clear()
			
			' 标题属性
			Declare Property Caption(nIndex As Integer, nVal As ZString Ptr)
			Declare Property Caption(nIndex As Integer) As ZString Ptr
			
			' 附加数据属性
			Declare Property Param(nIndex As Integer, nVal As Integer)
			Declare Property Param(nIndex As Integer) As Integer
			
			' 图像属性
			Declare Property Image(nIndex As Integer, nVal As Integer)
			Declare Property Image(nIndex As Integer) As Integer
			
			' 选中项
			Declare Property TabIndex(nVal As UInteger)
			Declare Property TabIndex() As Integer
			
			' 焦点项
			Declare Property TabFocus(nVal As UInteger)
			Declare Property TabFocus() As Integer
			
			' 选项卡数量
			Declare Property TabCount() As Integer
			
			' 客户区范围
			Declare Property ClientLeft() As Integer
			Declare Property ClientTop() As Integer
			Declare Property ClientRight() As Integer
			Declare Property ClientBottom() As Integer
			Declare Property ClientHeight() As Integer
			Declare Property ClientWidth() As Integer
			Declare Property ClientRect() As RECT Ptr
			
			' 选项卡固定宽度、高度
			Declare Function TabFixedSize(w As Integer, h As Integer) As Integer
			Declare Property TabMinWidth(nVal As UInteger)
			Declare Property TabHeight(nIndex As Integer) As UInteger
			Declare Property TabWidth(nIndex As Integer) As UInteger
			Declare Sub SetPadding(w As Integer, h As Integer)
			
			' 是否允许多行
			Declare Property MultiRow(nVal As Integer)
			Declare Property MultiRow() As Integer
			
			' 是否固定宽度
			Declare Property TabFixed(nVal As Integer)
			Declare Property TabFixed() As Integer
			
			' 选项卡按钮风格
			Declare Property TabStyle(nVal As Integer)
			Declare Property TabStyle() As Integer
			
			' 选项卡填充对齐属性
			Declare Property TabFull(nVal As Integer)
			Declare Property TabFull() As Integer
			
			' 选项卡行数 [仅多行时有效]
			Declare Property RowCount() As Integer
			
			' 高亮某项
			Declare Sub TabHighLight(nIndex As Integer, hl As Integer)
		End Type
	End Namespace
#EndIf
