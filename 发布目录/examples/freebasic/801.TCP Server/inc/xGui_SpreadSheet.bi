


#Ifndef xywh_library_xui_grid
	#Define xywh_library_xui_grid
	
	
	
	' SpreadSheet 控件定义部分[消息]
	Const SPRM_SPLITTHOR		= WM_USER+100			' 在当前行创建水平分割窗口 [wParam=0,lParam=0]
	Const SPRM_SPLITTVER		= WM_USER+101			' 在当前行创建垂直分割窗口 [wParam=0,lParam=0]
	Const SPRM_SPLITTCLOSE		= WM_USER+102			' 关闭当前行的分割窗口 [wParam=0,lParam=0]
	Const SPRM_SPLITTSYNC		= WM_USER+103			' [?]同步一个分割窗口的父 [wParam=0,lParam=TRUE/FALSE]
	Const SPRM_GETSPLITTSTATE	= WM_USER+104			' [?]取得分割状态 [wParam=nWin(0-7),if nWin=-1 active split window,lParam=0]
	Const SPRM_GETCELLRECT		= WM_USER+105			' 取得当前单元格矩形在活动分割 [wParam=0,lParam=pointer to RECT struct. Returns handle of active splitt window.]
	Const SPRM_GETLOCKCOL		= WM_USER+106			' 获取锁定列在活动分割窗口 [wParam=0,lParam=0]
	Const SPRM_SETLOCKCOL		= WM_USER+107			' 锁定列在活动分割窗口 [wParam=0,lParam=cols]
	Const SPRM_GETLOCKROW		= WM_USER+108			' 获取锁定行在活动分割窗口 [wParam=0,lParam=0]
	Const SPRM_SETLOCKROW		= WM_USER+109			' 锁定行在活动分割窗口 [wParam=0,lParam=rows]
	Const SPRM_DELETECOL		= WM_USER+110			' 删除列 [wParam=col,lParam=0]
	Const SPRM_INSERTCOL		= WM_USER+111			' 插入列 [wParam=col,lParam=0]
	Const SPRM_DELETEROW		= WM_USER+112			' 删除行 [wParam=row,lParam=0]
	Const SPRM_INSERTROW		= WM_USER+113			' 插入行 [wParam=row,lParam=0]
	Const SPRM_GETCOLCOUNT		= WM_USER+114			' 获取列数 [wParam=0,lParam=0]
	Const SPRM_SETCOLCOUNT		= WM_USER+115			' 设置列数 [wParam=nCols,lParam=0]
	Const SPRM_GETROWCOUNT		= WM_USER+116			' 获取行数 [wParam=0,lParam=0]
	Const SPRM_SETROWCOUNT		= WM_USER+117			' 设置行数 [wParam=nRows,lParam=0]
	Const SPRM_RECALC			= WM_USER+118			' 重新计算表 [wParam=0,lParam=0]
	Const SPRM_BLANKCELL		= WM_USER+119			' 清空单元格数据 [wParam=col,lParam=row]
	Const SPRM_GETCURRENTWIN	= WM_USER+120			' 取得活动的分割窗口 [wParam=0,lParam=0]
	Const SPRM_SETCURRENTWIN	= WM_USER+121			' 设置活动的分割窗口 [wParam=0, lParam=nWin (0-7)]
	Const SPRM_GETCURRENTCELL	= WM_USER+122			' 取得当前行/列在活动分割窗口 [wParam=0,lParam=0. Returns Hiword=row, Loword=col]
	Const SPRM_SETCURRENTCELL	= WM_USER+123			' 设置当前行/列在活动分割窗口 [wParam=col,lParam=row]
	Const SPRM_GETCELLSTRING	= WM_USER+124			' 取得当前单元格内容 [wParam=0,lParam=0. Returns a pointer to a null terminated string.]
	Const SPRM_SETCELLSTRING	= WM_USER+125			' 设置当前单元格内容 [wParam=type,lParam=pointer to string.]
	Const SPRM_GETCOLWIDT		= WM_USER+126			' 获取列的宽度 [wParam=col,lParam=0. Returns column width.]
	Const SPRM_SETCOLWIDT		= WM_USER+127			' 设置列的宽度 [wParam=col,lParam=width.]
	Const SPRM_GETROWHEIGHT		= WM_USER+128			' 取得行的高度 [wParam=row,lParam=0. Returns row height.]
	Const SPRM_SETROWHEIGHT	 	= WM_USER+129			' 设置行的高度 [wParam=row, lParam=height.]
	Const SPRM_GETCELLDATA		= WM_USER+130			' 获取单元格数据 [wParam=0, lParam=Pointer to SPR_ITEM struct]
	Const SPRM_SETCELLDATA		= WM_USER+131			' 设置单元格数据 [wParam=0, lParam=Pointer to SPR_ITEM struct]
	Const SPRM_GETMULTISEL		= WM_USER+132			' 获取多选 [wParam=0, lParam=pointer to a RECT struct. Returns handle of active split window]
	Const SPRM_SETMULTISEL		= WM_USER+133			' 设置多选 [wParam=0, lParam=pointer to a RECT struct. Returns handle of active split window]
	Const SPRM_GETFONT			= WM_USER+134			' 获取字体 [wParam=index(0-15), lParam=pointer to FONT struct. Returns font handle]
	Const SPRM_SETFONT			= WM_USER+135			' 设置字体 [wParam=index(0-15), lParam=pointer to FONT struct. Returns font handle]
	Const SPRM_GETGLOBAL		= WM_USER+136			' 获取全局变量 [wParam=0, lParam=pointer to GLOBAL struct.]
	Const SPRM_SETGLOBAL		= WM_USER+137			' 设置全局变量 [wParam=0, lParam=pointer to GLOBAL struct.]
	Const SPRM_IMPORTLINE		= WM_USER+138			' 导入一行数据 [wParam=SepChar, lParam=pointer to data line.]
	Const SPRM_LOADFILE			= WM_USER+139			' 载入文件 [wParam=0, lParam=pointer to filename]
	Const SPRM_SAVEFILE			= WM_USER+140			' 保存文件 [wParam=0, lParam=pointer to filename]
	Const SPRM_NEWSHEET			= WM_USER+141			' 清除表格 [wParam=0, lParam=0]
	Const SPRM_EXPANDCELL		= WM_USER+142			' 合并单元格 [wParam=0, lParam=pointer to RECT struct]
	Const SPRM_GETCELLTYPE		= WM_USER+143			' 取得单元格数据类型 [wParam=col, lParam=row. Returns cell type.]
	Const SPRM_ADJUSTCELLREF	= WM_USER+144			' 调整单元格引用公式 [wParam=pointer to cell, lParam=pointer to RECT.]
	Const SPRM_CREATECOMBO		= WM_USER+145			' 创建一个下拉组合框 [wPatam=0, lParam=0]
	Const SPRM_SCROLLCELL		= WM_USER+146			' 滚动视图到当前单元格 [wPatam=0, lParam=0]
	Const SPRM_DELETECELL		= WM_USER+147			' 删除一个单元格 [wParam=col, lParam=row]
	Const SPRM_GETDATEFORMAT	= WM_USER+148			' 返回格式化后的日期 [wParam=0, lParam=0]
	Const SPRM_SETDATEFORMAT	= WM_USER+149			' 设置格式化文本的日期数据 [wParam=0, lParam=lpDateFormat (yyyy-MM-dd)]
	
	' SpreadSheet 控件定义部分[风格]
	Const SPS_VSCROLL			= &h0001				' 垂直滚动条
	Const SPS_HSCROLL			= &h0002				' 水平滚动条
	Const SPS_STATUS			= &h0004				' 显示状态窗口
	Const SPS_GRIDLINES			= &h0008				' 显示表格线条
	Const SPS_ROWSELECT			= &h0010				' 整行选择
	Const SPS_CELLEDIT			= &h0020				' 单元格编辑
	Const SPS_GRIDMODE			= &h0040				' 表格模式 [允许自行 插入/删除 行和列]
	Const SPS_COLSIZE			= &h0080				' 允许使用鼠标调整列宽
	Const SPS_ROWSIZE		    = &h0100				' 允许使用鼠标调整行高
	Const SPS_WINSIZE			= &h0200				' 允许使用鼠标调整分割窗口大小
	Const SPS_MULTISELECT		= &h0400				' 允许多行选择
	
	' SpreadSheet 控件定义部分 [单元格数据类型]
	Const TPE_EMPTY				= &h000					' 单元格只包含格式化数据[默认自动数据类型]
	Const TPE_COLHDR			= &h001					' 列标题
	Const TPE_ROWHDR			= &h002					' 行标题
	Const TPE_WINHDR			= &h003					' 分割窗口句柄
	Const TPE_TEXT				= &h004					' 文本
	Const TPE_TEXTMULTILINE		= &h005					' 多行文本
	Const TPE_INTEGER			= &h006					' Integer
	Const TPE_FLOAT				= &h007					' 80位浮点数
	Const TPE_FORMULA			= &h008					' 公式
	Const TPE_GRAP				= &h009					' 图形
	Const TPE_HYPERLINK			= &h00A					' 超链接
	Const TPE_CHECKBOX			= &h00B					' 复选框
	Const TPE_COMBOBOX			= &h00C					' 组合下拉框
	Const TPE_OWNERDRAWBLOB		= &h00D					' Owner drawn blob, first word is lenght of blob
	Const TPE_OWNERDRAWINTEGER	= &h00E					' Owner drawn integer
	Const TPE_EXPANDED			= &h00F					' 部分扩展单元 [内部使用]
	Const TPE_BUTTON			= &h010					' 小按钮 [在行尾]
	Const TPE_WIDEBUTTON		= &h020					' 大按钮 [占满行]
	Const TPE_DATE				= &h030					' 日期
	Const TPE_FORCETYPE			= &h040					' 强制类型
	Const TPE_FIXEDSIZE			= &h080					' 固定大小的 复选框/下拉组合框/按钮/图形
	
	' SpreadSheet 控件定义部分[格式/对齐/小数]
	Const FMTA_AUTO				= &h000					' 自动 [文本左中对齐，数字右中对齐]
	Const FMTA_LEFT				= &h010					' 左侧对齐
	Const FMTA_CENTER			= &h020					' 居中对齐
	Const FMTA_RIGHT			= &h030					' 右侧对齐
	Const FMTA_TOP				= &h000					' 顶端对齐
	Const FMTA_MIDDLE			= &h040					' 纵向居中对齐
	Const FMTA_BOTTOM			= &h080					' 底端对齐
	Const FMTA_GLOBAL			= &h0F0
	Const FMTA_MASK				= &h0F0					' 对齐掩码
	Const FMTA_XMASK			= &h030					' 横向对齐掩码
	Const FMTA_YMASK			= &h0C0					' 纵向对齐掩码
	Const FMTD_0				= &h00
	Const FMTD_1				= &h01
	Const FMTD_2				= &h02
	Const FMTD_3				= &h03
	Const FMTD_4				= &h04
	Const FMTD_5				= &h05
	Const FMTD_6				= &h06
	Const FMTD_7				= &h07
	Const FMTD_8				= &h08
	Const FMTD_9				= &h09
	Const FMTD_10				= &h0A
	Const FMTD_11				= &h0B
	Const FMTD_12				= &h0C
	Const FMTD_ALL				= &h0D
	Const FMTD_SCI				= &h0E
	Const FMTD_GLOBAL			= &h0F
	Const FMTD_MASK				= &h0F
	
	' 单元格格式结构体
	Type FORMAT
		bckcol		As Integer							' 背景颜色
		txtcol		As Integer							' 文本颜色
		txtal		As Byte								' 文本对齐/小数
		imgal		As Byte								' 图像调整和 imagelist 控件图像ID
		fnt			As Byte								' 字体ID[0-15]
		tpe			As Byte								' 单元格类型
	End Type
	
	' 全局设置结构体
	Type SPS_GLOBAL
		colhdrbtn	As Integer
		rowhdrbtn	As Integer
		winhdrbtn	As Integer
		lockcol		As Integer							' 锁定单元格的背景色
		hdrgrdcol	As Integer							' 表头的颜色
		grdcol		As Integer							' 单元格颜色
		bcknfcol	As Integer							' 活动单元格的背景颜色[失去焦点时]
		txtnfcol	As Integer							' 活动单元格的文本颜色[失去焦点时]
		bckfocol	As Integer							' 活动单元格的背景颜色[获取焦点时]
		txtfocol	As Integer							' 活动单元格的文本颜色[获取焦点时]
		ncols		As Integer
		nrows		As Integer
		ghdrwt		As Integer
		ghdrht		As Integer
		gcellwt		As Integer
		gcellht		As Integer
		colhdr		As FORMAT							' 列标题格式
		rowhdr		As FORMAT 							' 行标题格式
		winhdr		As FORMAT							' 分割窗口标题格式
		cell		As FORMAT							' 单元格格式
	End Type
	
	' 字体结构体
	Type SPS_FONT
		hfont		As HANDLE							' 字体句柄
		face		As ZString * LF_FACESIZE			' 字体名
		fsize		As Integer							' 字体大小
		ht			As Integer							' 高度
		bold		As Byte								' 加粗
		italic		As Byte								' 倾斜
		underline	As Byte								' 下划线
		strikeout	As Byte								' 删除线
	End Type
	
	' 单元格状态定义
	Const STATE_LOCKED		= &h001						' 单元格锁定 [不能编辑]
	Const STATE_HIDDEN		= &h002						' 单元格内容隐藏 [不显示]
	Const STATE_REDRAW		= &h008
	Const STATE_ERROR		= &h010
	Const STATE_DIV0		= &h020
	Const STATE_UNDERFLOW	= &h030
	Const STATE_OVERFLOW	= &h040
	Const STATE_RECALC		= &h080
	Const STATE_ERRMASK		= &h0F0
	
	' 单元格获取、修改 控制位标记
	Const SPRIF_BACKCOLOR	= &h00000001				' 背景颜色有效
	Const SPRIF_TEXTCOLOR	= &h00000002				' 文本颜色有效
	Const SPRIF_TEXTALIGN	= &h00000004				' 单元格格式有效
	Const SPRIF_IMAGEALIGN	= &h00000008				' 图像有效
	Const SPRIF_FONT		= &h00000010				' 字体有效
	Const SPRIF_STATE		= &h00000020				' 状态有效
	Const SPRIF_TYPE		= &h00000040				' 类型有效
	Const SPRIF_WIDTH		= &h00000080				' 宽度有效
	Const SPRIF_HEIGHT		= &h00000100				' 高度有效
	Const SPRIF_DATA		= &h00000200				' 附加数据有效
	Const SPRIF_DOUBLE		= &h00000400				' 从 Double 转换
	Const SPRIF_SINGLE		= &h00000800				' 从 Single 转换
	Const SPRIF_COMPILE		= &h80000000				' 编译公式
	#Define SPRIF_ALL		SPRIF_BACKCOLOR Or SPRIF_TEXTCOLOR Or SPRIF_TEXTALIGN Or SPRIF_IMAGEALIGN Or SPRIF_FONT Or SPRIF_STATE Or SPRIF_TYPE Or SPRIF_WIDTH Or SPRIF_HEIGHT Or SPRIF_DATA
	
	' 单元格结构体
	Type SPR_ITEM
		flag	As Integer
		col		As Integer
		row		As Integer
		expx	As Byte									' 扩展列 (cols)
		expy	As Byte									' 扩展行 (rows)
		state	As Byte									' 状态
		fmt		As FORMAT								' 单元格格式
		wt		As Integer
		ht		As Integer
		lpdta	As ZString ptr							' 标题、数据
	End Type
	
	' SpreadSheet 控件定义部分[WM_NOTIFY消息通知]
	Const SPRN_SELCHANGE		= 1						' 选择的行/列被改变[分割窗口]
	Const SPRN_BEFOREEDIT		= 2						' 进入到编辑框模式
	Const SPRN_AFTEREDIT		= 3						' 编辑框模式完毕
	Const SPRN_BEFOREUPDATE		= 4						' 单元格更新开始
	Const SPRN_AFTERUPDATE		= 5						' 单元格更新完毕
	Const SPRN_HYPERLINKENTER	= 6						' 超链接鼠标进入
	Const SPRN_HYPERLINKLEAVE	= 7						' 超链接鼠标离开
	Const SPRN_HYPERLINKCLICK	= 8						' 超链接被点击
	Const SPRN_BUTTONCLICK		= 9						' 按钮被点击
	
	' SpreadSheet 控件定义部分[消息结构体定义]
	Type SPR_SELCHANGE
		hdr				As NMHDR
		nwin			As Integer
		col				As Integer
		row				As Integer
		fcancel		As Integer
	End Type
	Type SPR_EDIT
		hdr				As NMHDR
		lpspri		As SPR_ITEM ptr
		fcancel		As Integer
	End Type
	Type SPR_HYPERLINK
		hdr				As NMHDR
		lpspri		As SPR_ITEM ptr
	End Type
	Type SPR_BUTTON
		hdr				As NMHDR
		lpspri		As SPR_ITEM ptr
	End Type
	
	
	
	Namespace xGui
		
		
		
		' 电子表格类
		Type xGrid Extends xControl
			
			' 列数
			Declare Property ColCount(nVal As Integer)
			Declare Property ColCount() As Integer
			
			' 行数
			Declare Property RowCount(nVal As Integer)
			Declare Property RowCount() As Integer
			
			' 插入行
			Declare Sub InsertRow(row As Integer = -1)
			
			' 删除行
			Declare Sub DeleteRow(row As Integer)
			
			' 插入列
			Declare Sub InsertCol(col As Integer = -1)
			
			' 删除列
			Declare Sub DeleteCol(col As Integer)
			
			' 列宽度
			Declare Property ColWidth(nIndex As UInteger, nVal As UInteger)
			Declare Property ColWidth(nIndex As UInteger) As Integer
			
			' 行高度
			Declare Property RowHeight(nIndex As UInteger, nVal As UInteger)
			Declare Property RowHeight(nIndex As UInteger) As Integer
			
			' 编写修改单元格函数
			Declare Sub SetCell(row As Integer, col As Integer, sText As ZString Ptr, iAlgin As Integer = -1, iFont As Integer = -1, bColor As Integer = -1, tColor As Integer = -1, iType As Integer = -1, iLock As Integer = 0)
			
			' 单元格数据 [完整结构体]
			Declare Sub Cell(row As Integer, col As Integer, nVal As SPR_ITEM Ptr)
			Declare Function Cell(row As Integer, col As Integer, flag As Integer = SPRIF_ALL) As SPR_ITEM Ptr
			
			' 单元格数据类型
			Declare Sub CellType(row As Integer, col As Integer, nVal As Integer)
			Declare Function CellType(row As Integer, col As Integer) As Integer
			
			' 单元格数据 [文本]
			Declare Sub CellText(row As Integer, col As Integer, nVal As ZString Ptr)
			Declare Function CellText(row As Integer, col As Integer) As ZString Ptr
			
			' 单元格背景颜色
			Declare Sub CellBackColor(row As Integer, col As Integer, nVal As Integer)
			Declare Function CellBackColor(row As Integer, col As Integer) As Integer
			
			' 单元格文字颜色
			Declare Sub CellTextColor(row As Integer, col As Integer, nVal As Integer)
			Declare Function CellTextColor(row As Integer, col As Integer) As Integer
			
			' 单元格文字对齐方式
			Declare Sub CellTextAlign(row As Integer, col As Integer, nVal As Integer)
			Declare Function CellTextAlign(row As Integer, col As Integer) As Integer
			
			' 单元格图片对齐方式
			Declare Sub CellImageAlign(row As Integer, col As Integer, nVal As Integer)
			Declare Function CellImageAlign(row As Integer, col As Integer) As Integer
			
			' 单元格字体编号
			Declare Sub CellFont(row As Integer, col As Integer, nVal As Integer)
			Declare Function CellFont(row As Integer, col As Integer) As Integer
			
			' 单元格锁定编辑状态
			Declare Sub CellLock(row As Integer, col As Integer, nVal As Integer)
			Declare Function CellLock(row As Integer, col As Integer) As Integer
			
			' 单元格隐藏内容状态
			Declare Sub CellHide(row As Integer, col As Integer, nVal As Integer)
			Declare Function CellHide(row As Integer, col As Integer) As Integer
			
			' 获取所选单元格内容
			Declare Property CurCellText(nVal As ZString Ptr)
			Declare Property CurCellText() As ZString Ptr
			
			' 清空单元格数据
			Declare Sub ClearCell(row As Integer, col As Integer)
			
			' 删除单元格
			Declare Sub DeleteCell(row As Integer, col As Integer)
			
			' 合并单元格
			Declare Sub ExpandCell(pRect As RECT Ptr)
			Declare Sub ExpandCell(sRow As Integer, eRow As Integer, sCol As Integer, eCol As Integer)
			
			' 选择行
			Declare Property CurRow(nVal As Integer)
			Declare Property CurRow() As Integer
			
			' 选择列
			Declare Property CurCol(nVal As Integer)
			Declare Property CurCol() As Integer
			
			' 选择单元格
			Declare Sub GetCurCell(row As Integer Ptr, col As Integer Ptr)
			Declare Sub SetCurCell(row As Integer, col As Integer)
			
			' 选择范围
			Declare Property SelectRect(nVal As RECT Ptr)
			Declare Property SelectRect() As RECT Ptr
			
			' 滚动视图到当前单元格
			Declare Sub ScrollCell()
			
			' 字体
			Declare Property Fonts(nIndex As UInteger, nVal As SPS_FONT Ptr)
			Declare Property Fonts(nIndex As UInteger) As SPS_FONT Ptr
			
			' 全局选项
			Declare Property GlobalOption(nVal As SPS_GLOBAL Ptr)
			Declare Property GlobalOption() As SPS_GLOBAL Ptr
			
			' 保存到文件
			Declare Sub SaveFile(sPath As ZString Ptr)
			
			' 从文件载入
			Declare Sub LoadFile(sPath As ZString Ptr)
			
			' 清空表格
			Declare Sub Clear()
			
			' 重新计算公式
			Declare Sub ReCalc()
		End Type
		
		' 电子表格别名
		Type xSpreadSheet As xGrid
	End Namespace
#EndIf
