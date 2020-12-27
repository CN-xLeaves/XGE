#Include Once "windows.bi"
#Include Once "win\winuser.bi"
#Include Once "win\commctrl.bi"



#Ifndef XUI_SOURCE_NOLIB
	#Define XUI_SOURCE_NOLIB
	#Inclib "xGui"
#EndIf



#Ifndef XUI_GRID_NOLIB
	' 表格控件声明
	#Inclib "SprSht"
	Extern "Windows"
		Declare Function SprShtInstall(hinst As HANDLE) As Integer
	End Extern
#EndIf





' 控件使用 xFont 处理字体 [建议开启]
'	这个选项可以获得类似VB的字体处理效果，但会使用更多的句柄和内存，如果你自己处理自己部分，则可以注释掉这个编译选项。
#Define XUI_COMPILE_USE_XFONT

' 使用 xFont 指针而不是 xFont 对象 [追求快速开发建议不开启, 追求性能优化建议开启]
'   仅在开启 XUI_COMPILE_USE_XFONT 的情况下生效，将控件字体对象替换为字体对象指针，使多个控件可以共享一个字体对象。
#Define XUI_COMPILE_XFONT_PTR

' 窗口使用 xMenu 处理菜单 [建议开启]
'   这个选项可以方便窗口的菜单操作，菜单直接作为窗口的一部分直接处理，开启后会为每个窗口创建菜单对象，否则使用 HMENU 设置。
#Define XUI_COMPILE_USE_XMENU

' xHandleList 预申请内存步长 [建议根据xHandleList使用容量自行调整]
#Define XUI_RUNTIME_HLIST_STP		32

' 最多保留的临时内存数量 (自动释放内存函数使用次数超过这个值的内存会被自动释放)
#Define XUI_RUNTIME_MEM_COUNT		32





' 字体类定义
#Define XUI_FONT_BOLD			1
#Define XUI_FONT_ITALIC			2
#Define XUI_FONT_UNDERLINE		4
#Define XUI_FONT_STRIKEOUT		8



#Include "xGui_base.bi"
#Include "xGui_CommCtrl.bi"
#Include "xGui_SpreadSheet.bi"
#Include "xGui_SciEdit.bi"
