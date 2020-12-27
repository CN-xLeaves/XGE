'==================================================================================
	'★ xywh Game Engine 渲染对象模块
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================


			
			
			/' -------------------------- 渲染对象基类 -------------------------- '/
			Type RenderBaseObject Extends Object
				x As Integer
				y As Integer
				Priority As Integer
				Enabled As Integer
				Visible As Integer
				
				Declare Abstract Sub Disp()
				Declare Abstract Sub Draw(px As Integer, py As Integer)
			End Type
			
			
			/' -------------------------- 渲染对象类 -------------------------- '/
			Type RenderObject Extends RenderBaseObject
				img As xge.Surface Ptr
				Parent As xge.Surface Ptr
				cut As Integer
				cx As Integer
				cy As Integer
				cw As Integer
				ch As Integer
				AutoFree As Integer
				
				' 空构造
				Declare Constructor()
				
				' 从现有 Surface 创建
				Declare Constructor(sf As xge.Surface Ptr, px As Integer = 0, py As Integer = 0, pl As Integer = 0, p As xge.Surface Ptr = NULL)
				
				' 自动创建和释放 Surface
				Declare Constructor(addr As ZString Ptr, size As UInteger, px As Integer = 0, py As Integer = 0, pl As Integer = 0, p As xge.Surface Ptr = NULL)
				
				' 析构
				Declare Destructor()
				
				' 裁剪
				Declare Sub SetCut(iscut As Integer, cut_x As Integer = 0, cut_y As Integer = 0, cut_w As Integer = 0, cut_h As Integer = 0)
				
				' 渲染
				Declare Sub Draw(px As Integer, py As Integer)
			End Type

Extern XGE_EXTERNCLASS
	'#Ifdef XGE_BUILD_USEOOP
		Namespace xge
	'#EndIf
	
	
	
	' 空构造
	Constructor RenderObject() XGE_EXPORT_OBJ
	
	End Constructor
	
	' 从现有 Surface 创建
	Constructor RenderObject(sf As xge.Surface Ptr, px As Integer = 0, py As Integer = 0, pl As Integer = 0, p As xge.Surface Ptr = NULL) XGE_EXPORT_OBJ
		img = sf
		AutoFree = FALSE
		Visible = TRUE
		x = px
		y = py
		Priority = pl
		Parent = p
	End Constructor
	
	' 自动创建和释放 Surface
	Constructor RenderObject(addr As ZString Ptr, size As UInteger, px As Integer = 0, py As Integer = 0, pl As Integer = 0, p As xge.Surface Ptr = NULL) XGE_EXPORT_OBJ
		img = New xge.Surface(addr, size)
		AutoFree = TRUE
		Visible = TRUE
		x = px
		y = py
		Priority = pl
		Parent = p
	End Constructor
	
	' 析构
	Destructor RenderObject() XGE_EXPORT_OBJ
		If AutoFree Then
			Delete img
		EndIf
	End Destructor
	
	' 裁剪
	Sub RenderObject.SetCut(iscut As Integer, cut_x As Integer = 0, cut_y As Integer = 0, cut_w As Integer = 0, cut_h As Integer = 0) XGE_EXPORT_OBJ
		cut = iscut
		cx = cut_x
		cy = cut_y
		cw = cut_w
		ch = cut_h
	End Sub
	
	' 渲染
	Sub RenderObject.Draw(px As Integer, py As Integer) XGE_EXPORT_OBJ
		If cut Then
			img->DrawEx(px + x, py + y, cx, cy, cw, ch, Parent)
		Else
			img->Draw(px + x, py + y, Parent)
		EndIf
	End Sub
	
	
	'#Ifdef XGE_BUILD_USEOOP
		End Namespace
	'#EndIf
End Extern