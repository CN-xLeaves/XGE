'==================================================================================
	'�� xywh Game Engine ��Ⱦ����ģ��
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================


			
			
			/' -------------------------- ��Ⱦ������� -------------------------- '/
			Type RenderBaseObject Extends Object
				x As Integer
				y As Integer
				Priority As Integer
				Enabled As Integer
				Visible As Integer
				
				Declare Abstract Sub Disp()
				Declare Abstract Sub Draw(px As Integer, py As Integer)
			End Type
			
			
			/' -------------------------- ��Ⱦ������ -------------------------- '/
			Type RenderObject Extends RenderBaseObject
				img As xge.Surface Ptr
				Parent As xge.Surface Ptr
				cut As Integer
				cx As Integer
				cy As Integer
				cw As Integer
				ch As Integer
				AutoFree As Integer
				
				' �չ���
				Declare Constructor()
				
				' ������ Surface ����
				Declare Constructor(sf As xge.Surface Ptr, px As Integer = 0, py As Integer = 0, pl As Integer = 0, p As xge.Surface Ptr = NULL)
				
				' �Զ��������ͷ� Surface
				Declare Constructor(addr As ZString Ptr, size As UInteger, px As Integer = 0, py As Integer = 0, pl As Integer = 0, p As xge.Surface Ptr = NULL)
				
				' ����
				Declare Destructor()
				
				' �ü�
				Declare Sub SetCut(iscut As Integer, cut_x As Integer = 0, cut_y As Integer = 0, cut_w As Integer = 0, cut_h As Integer = 0)
				
				' ��Ⱦ
				Declare Sub Draw(px As Integer, py As Integer)
			End Type

Extern XGE_EXTERNCLASS
	'#Ifdef XGE_BUILD_USEOOP
		Namespace xge
	'#EndIf
	
	
	
	' �չ���
	Constructor RenderObject() XGE_EXPORT_OBJ
	
	End Constructor
	
	' ������ Surface ����
	Constructor RenderObject(sf As xge.Surface Ptr, px As Integer = 0, py As Integer = 0, pl As Integer = 0, p As xge.Surface Ptr = NULL) XGE_EXPORT_OBJ
		img = sf
		AutoFree = FALSE
		Visible = TRUE
		x = px
		y = py
		Priority = pl
		Parent = p
	End Constructor
	
	' �Զ��������ͷ� Surface
	Constructor RenderObject(addr As ZString Ptr, size As UInteger, px As Integer = 0, py As Integer = 0, pl As Integer = 0, p As xge.Surface Ptr = NULL) XGE_EXPORT_OBJ
		img = New xge.Surface(addr, size)
		AutoFree = TRUE
		Visible = TRUE
		x = px
		y = py
		Priority = pl
		Parent = p
	End Constructor
	
	' ����
	Destructor RenderObject() XGE_EXPORT_OBJ
		If AutoFree Then
			Delete img
		EndIf
	End Destructor
	
	' �ü�
	Sub RenderObject.SetCut(iscut As Integer, cut_x As Integer = 0, cut_y As Integer = 0, cut_w As Integer = 0, cut_h As Integer = 0) XGE_EXPORT_OBJ
		cut = iscut
		cx = cut_x
		cy = cut_y
		cw = cut_w
		ch = cut_h
	End Sub
	
	' ��Ⱦ
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