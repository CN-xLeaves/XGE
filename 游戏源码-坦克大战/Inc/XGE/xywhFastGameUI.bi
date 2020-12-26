'==================================================================================
	'�� xywh Fast GUI ͼ�ν���ϵͳ [FxGUI]
	'#-------------------------------------------------------------------------------
	'# ���� : δ��� , �ݲ�����
	'# ˵�� : 
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

#Define xywh_library_fxgui_max 256			' �ؼ��������
#Define xywh_library_fxgui_smax 64			' һ��������������Ŀؼ�����



' ������Ϣ
#Define MSG_NULL							&H0					' ����Ϣ[��Ӧ���]
#Define MSG_CONINIT						&H1					' �ؼ���ʼ��
#Define MSG_CONUNIT						&H2					' �ؼ�ж��
#Define MSG_DRAW							&H3					' ����
#Define MSG_MOUSEMOVE					&H4					' ����ƶ�
#Define MSG_MOUSEDOWN					&H5					' ��갴��
#Define MSG_MOUSEUP						&H6					' ��굯��
#Define MSG_MOUSEDCLICK				&H7					' ���˫��
#Define MSG_MOUSEWHELL				&H8					' ���ֹ���
#Define MSG_KEYDOWN						&H9					' ���̰���
#Define MSG_KEYUP							&HA					' ���̵���
#Define MSG_KEYREPEAT					&HB					' �����ظ�����
#Define MSG_IMECHAR						&HC					' ��������
' ��װ�ַ���Ϣ
#Define MSG_MOUSEENTER				&H100				' ������
#Define MSG_MOUSEEXIT					&H101				' ����뿪
' �ؼ���Ϣ
#Define MSG_CLICK							&H1000			' ����� [Button��CheckBox]
#Define MSG_REDCACHE					&H1001			' �ؽ����� [LineEdit]



Type fxgui_Control Extends Object						' �����ؼ�
	Index As UInteger					' �ؼ�ID
	x As Integer							' �ؼ�����
	y As Integer							' �ؼ�����
	w As Integer							' �ؼ����
	h As Integer							' �ؼ��߶�
	Visible As Integer				' �Ƿ���ʾ
	Parent As Integer					' ���ؼ�ID
	tpe As Integer						' �ؼ����
	Font As xywhPointFont Ptr	' �ؼ�����
	IsFrame As Integer				' �Ƿ�Ϊ��ܿؼ�
	TagInt As Integer					' ��������[Int]
	TagPtr As Any Ptr					' ��������[Ptr]
	' �ؼ���Ϣ�ص�
	MessageBackCall As Function (ByVal Msg As Integer,ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	' ��ص�
	Declare Virtual Function ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
End Type

Type fxgui_Frame Extends fxgui_Control				' �����ؼ�[����]
	Controls(1 To xywh_library_fxgui_smax) As fxgui_Control Ptr
	' ��ص�
	Declare Function ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	' ��Ϣ�ַ��� [����0������Ϣ����͸��������Ϣ��GUIϵͳ�Ե�]
	Declare Function MessageDispatch(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	' ��ӿؼ��� Frame
	Declare Function GetSpace() As Integer
	Declare Function AddControl(ByVal Control As fxgui_Control Ptr) As Integer
End Type

Type fxgui_Button Extends fxgui_Control				' ��ť
	Caption As ZString * 64			' ��ť����
	Img_Default As Surface			' ��ťͼƬ[Ĭ��]
	Img_Hot As Surface					' ��ťͼƬ[����]
	Img_Down As Surface					' ��ťͼƬ[����]
	stk As Integer							' ״̬[1=����Ƿ��ڰ�ť�ڣ�2=����Ƿ���]
	Declare Function ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
End Type

Type fxgui_CheckBox Extends fxgui_Control			' ��ѡ��
	Value As Integer
	Caption As ZString * 64			' ��ť����
	Img_Default As Surface			' ��ťͼƬ[Ĭ��]
	Img_Hot As Surface					' ��ťͼƬ[����]
	Img_Down As Surface					' ��ťͼƬ[����]
	Img_Chk As Surface					' ѡ��ͼƬ
	stk As Integer							' ״̬[1=����Ƿ��ڰ�ť�ڣ�2=����Ƿ���]
	Declare Function ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
End Type

Type fxgui_ProgBar Extends fxgui_Control			' ������
	Min As Integer
	Max As Integer
	Value As Integer
	Img_Back As Surface					' ͼƬ[����]
	Img_Val As Surface					' ͼƬ[����]
	Declare Function ClassBackCall(ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
End Type

Type fxgui_LineEdit Extends fxgui_Control			' ���б༭��
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
			Return -1						' �������ͣ����
		Case MSG_MOUSEUP
			stk = stk And Not(2)
			Dim As Integer px,py
			GetMouse(px,py)
			If HitTest(x,y,w,h,px,py) Then
				MessageBackCall(xge_msg_xgui,MAKELONG(MSG_CLICK,Index),NULL)
			EndIf
		Case MSG_CONINIT
			' ����ͼ�񻺴�
			Img_Default = ImageCreate(w+1,h+1)
			Img_Hot = ImageCreate(w+1,h+1)
			Img_Down = ImageCreate(w+1,h+1)
			' ��ť�������
			Dim TempRect As RECT
			TempRect.left = 2
			TempRect.top = 2
			TempRect.right = w-2
			TempRect.bottom = h-2
			' Ĭ��״̬ͼ�񻺴�
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
			' ָ��/����״̬ͼ�񻺴�
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
			' ����״̬ͼ�񻺴�
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
			Return -1						' �������ͣ����
		Case MSG_MOUSEUP
			stk = stk And Not(2)
			Dim As Integer px,py
			GetMouse(px,py)
			If HitTest(x,y,w,h,px,py) Then
				Value = IIf(Value,0,-1)
				MessageBackCall(xge_msg_xgui,MAKELONG(MSG_CLICK,Index),NULL)
			EndIf
		Case MSG_CONINIT
			' ����ͼ�񻺴�
			Img_Default = ImageCreate(w+1,h+1)
			Img_Hot = ImageCreate(w+1,h+1)
			Img_Down = ImageCreate(w+1,h+1)
			Img_Chk = ImageCreate(8,8)
			' Ĭ��״̬ͼ�񻺴�
			Line Img_Default,(0,0)-(15,15),RGB(49,77,99),BF
			Line Img_Default,(2,2)-(13,13),RGB(132,190,132),BF
			PReset Img_Default,(0,0)
			PReset Img_Default,(15,0)
			PReset Img_Default,(0,15)
			PReset Img_Default,(15,15)
			Font->PSetText(Img_Default,@Caption,20,3,RGB(255,255,255))
			' ָ��/����״̬ͼ�񻺴�
			Line Img_Hot,(0,0)-(15,15),RGB(28,44,57),BF
			Line Img_Hot,(2,2)-(13,13),RGB(190,220,190),BF
			PReset Img_Hot,(0,0)
			PReset Img_Hot,(15,0)
			PReset Img_Hot,(0,15)
			PReset Img_Hot,(15,15)
			Font->PSetText(Img_Hot,@Caption,20,3,RGB(28,44,57))
			' ����״̬ͼ�񻺴�
			Line Img_Down,(0,0)-(15,15),RGB(49,77,99),BF
			Line Img_Down,(2,2)-(13,13),RGB(28,44,57),BF
			PReset Img_Down,(0,0)
			PReset Img_Down,(15,0)
			PReset Img_Down,(0,15)
			PReset Img_Down,(15,15)
			Font->PSetText(Img_Down,@Caption,20,3,RGB(28,44,57))
			' ѡ��ͼƬ����
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
			' ����ͼ�񻺴�
			Img_Back = ImageCreate(w+1,h+1)
			' Ĭ�ϱ���ͼ�񻺴�
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
			
			Return -1						' �������ͣ����
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





Dim Shared xywh_library_fxgui_cons(1 To xywh_library_fxgui_max) As fxgui_Control Ptr		' �ؼ���
Dim Shared xywh_library_fxgui_frame As fxgui_Frame Ptr																	' ����� [���пؼ����ڴ˿��֮��]
Dim Shared xywh_library_fxgui_bcall As Any Ptr																					' Ĭ�ϻص���ַ [�����ؼ�ʱ�����ָ������ص���ַʹ�ôε�ַ]

Dim Shared xywh_library_fxgui_mcon As fxgui_Control Ptr																	' ���ͣ���Ŀؼ�
Dim Shared xywh_library_fxgui_lock As Integer																						' ���ͣ����
Dim Shared xywh_library_fxgui_fcon As fxgui_Control Ptr																	' �н���Ŀؼ�
Dim Shared xywh_Library_fxgui_icon As fxgui_Control Ptr																	' �������뽹��





Namespace fxgui
	' ��ʼ�� xgui ����
	Function Init() As Integer
		xywh_library_fxgui_frame = New fxgui_Frame
		Return -1
	End Function
	' ж�� xgui ����
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
			' MouseMove ��Ϣ�漰 mcon[���ͣ���ؼ�] �ĸ��ģ���Ϣ�ַ����ᴫ����Ϣ�����տؼ���������Ϣ�ַ�����㷵�����յĿؼ����
			' ���صĿؼ�����ᱻ����Ϊ mcon ����� mcon ���ı䣬��ᷢ�� MSG_MOUSEENTER[������] ��Ϣ���ؼ�
			' �� mcon ����ʱ������ƶ����ж��Ƿ��뿪�ؼ����Σ�����뿪����ᷢ�� MSG_MOUSEEXIT[����뿪] ��Ϣ���ؼ�������� mcon ֵ
			If xywh_library_fxgui_lock=0 Then
				If xywh_library_fxgui_mcon Then
					If HitTest(xywh_library_fxgui_mcon->x,xywh_library_fxgui_mcon->y,xywh_library_fxgui_mcon->w,xywh_library_fxgui_mcon->h,Event->x,Event->y)=0 Then
						xywh_library_fxgui_mcon->ClassBackCall(MSG_MOUSEEXIT,NULL)
						xywh_library_fxgui_mcon = NULL
					EndIf
				EndIf
				Dim RetObj As fxgui_Control Ptr = Cast(Any Ptr,xywh_library_fxgui_frame->MessageDispatch(Param,Event))
				If RetObj Then				' ��Ϣ���Ե������ GUI ϵͳ�� MouseControl
					If xywh_library_fxgui_mcon <> RetObj Then
						xywh_library_fxgui_mcon = RetObj
						xywh_library_fxgui_mcon->ClassBackCall(MSG_MOUSEENTER,NULL)
					EndIf
				EndIf
			EndIf
		Case MSG_MOUSEDOWN
			' MouseDown ��Ϣ��ֱ�ӷ��͸� mcon ���� mcon Ϊ��ʱ����Ϣ�ᴩ͸��XGE��һ���ؼ������� MouseDown ��Ϣ������TRUE
			' �� lock[���ͣ����] �Ὺ���� lock ������MouseMove�����ᱻ����ֱ�� lock �ر�Ϊֹ��
			If xywh_library_fxgui_mcon Then
				If xywh_library_fxgui_mcon->ClassBackCall(MSG_MOUSEDOWN,NULL) Then
					xywh_library_fxgui_lock = -1
				EndIf
			Else
				Return 0
			EndIf
		Case MSG_MOUSEUP
			' MouseUp ��Ϣ��ֱ�ӷ��͸� mcon ���� mcon Ϊ��ʱ����Ϣ�ᴩ͸��XGE�� MouseUp ��Ϣ���Զ��ر� lock
			If xywh_library_fxgui_mcon Then
				xywh_library_fxgui_mcon->ClassBackCall(MSG_MOUSEUP,NULL)
				xywh_library_fxgui_lock = 0
			Else
				Return 0
			EndIf
		Case MSG_MOUSEDCLICK
			' MouseDoubleClick ��Ϣ��ֱ�ӷ��͸� mcon ���� mcon Ϊ��ʱ����Ϣ�ᴩ͸��XGE
			If xywh_library_fxgui_mcon Then
				xywh_library_fxgui_mcon->ClassBackCall(MSG_MOUSEDCLICK,NULL)
			Else
				Return 0
			EndIf
		Case MSG_MOUSEWHELL
			' MouseWhell ��Ϣ��ֱ�ӷ��͸� mcon ���� mcon Ϊ��ʱ����Ϣ�ᴩ͸��XGE
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
	
	' �ڿؼ������в���һ����λ
	Function GetSpace() As Integer
		Dim i As Integer
		For i = 1 To xywh_library_fxgui_max
			If xywh_library_fxgui_cons(i)=NULL Then Return i
		Next
	End Function
	
	' ��ӿؼ��� xgui ���� [Parent:���ؼ�ID,��ѡ������Control:�ؼ��ṹָ�롢Index:�ؼ�ID]
	Function AddControl(ByVal Parent As Integer,ByVal Index As Integer,ByVal IsFrame As Integer,ByVal Control As fxgui_Control Ptr) As Integer
		Dim i As Integer
		If Parent Then
			For i = 1 To xywh_library_fxgui_max														' ���Ҹ��ؼ�
				If xywh_library_fxgui_cons(i) Then
					If xywh_library_fxgui_cons(i)->IsFrame Then								' ���ؼ�����Ϊ���
						If xywh_library_fxgui_cons(i)->Index = Parent Then				' �ҵ����ؼ�
							If Cast(fxgui_Frame Ptr,xywh_library_fxgui_cons(i))->AddControl(Control) Then
								i = GetSpace()																			' ��ӿؼ�����������
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
	
	' �����ؼ��� xgui ����
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