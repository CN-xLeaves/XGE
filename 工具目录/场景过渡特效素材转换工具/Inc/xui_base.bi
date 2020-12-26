


#Ifndef xywh_library_xui_base
	#Define xywh_library_xui_base
	
	
	
	Namespace xui
		
		' ��ʼ��
		Declare Function Init(WindowExtDataSize As Integer=12,ClassExtDataSize As Integer=0) As Integer
		
		' ����
		Declare Function Start() As Integer
		
		' ֹͣ
		Declare Function Stop() As Integer
		
		' ����ͼƬ
		Declare Function LoadPicture(sFile As ZString Ptr, iSize As Integer, iColor As Integer, x As Integer, y As Integer) As HBITMAP
		
		' ����ͼ��
		'Declare Function LoadIcon() As HICON
		
		' ��������
		Declare Function CreatWindow(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sText As ZString Ptr, WndProc As Any Ptr, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr=0) As HWND
		
		' �����ؼ�
		Declare Function CraetControl(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sClass As ZString Ptr, sText As ZString Ptr, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HWND
		
		' ������ʱ�ڴ�
		Declare Function TempMemory(size As UInteger) As Any Ptr
		
		
		
		' ����б�
		Type xHandleList
			
			' ����
			Declare Destructor()
			
			' ����
			Declare Function Init() As Integer
			
			' ���
			Declare Function Add(NewValue As HANDLE) As Integer
			
			' ɾ��
			Declare Function Del(iPos As Integer) As Integer
			
			' ��ȡλ��
			Declare Function Pos(Value As HANDLE) As Integer
			
			' ����
			Declare Function Count() As Integer
			
			' ���ʾ��
			Declare Property List(nIndex As Integer) As HANDLE
			Declare Property List(nIndex As Integer, NewValue As HANDLE)
			
			' ˽�б���
			Private:
				p_Hdr As HANDLE Ptr
				c_Hdr As Integer
				c_Mem As Integer
		End Type
		
		
		
		
		
		' ������
		Type xFont
			Dim AutoMake As Integer
			
			' ����
			Declare Constructor()
			Declare Constructor(sName As ZString Ptr, iSize As Integer, iStyle As Integer, iChar As Integer = GB2312_CHARSET)
			
			' ����
			Declare Destructor()
			
			' ��
			Declare Function Bind(hWin As HANDLE, idx As Integer = 0) As Integer
			Declare Function UnBind(hWin As HANDLE) As Integer
			
			' ���б�
			Declare Property BindList As xui.xHandleList Ptr
			Declare Property BindList(NewValue As xui.xHandleList Ptr)
			
			' �����µ��������
			Declare Function Make() As HANDLE
			
			' ������
			Declare Property Name As ZString Ptr
			Declare Property Name(NewValue As ZString Ptr)
			
			' �ֺ�
			Declare Property Size As Integer
			Declare Property Size(NewValue As Integer)
			
			' ����
			Declare Property Bold As Integer
			Declare Property Bold(NewValue As Integer)
			
			' б��
			Declare Property Italic As Integer
			Declare Property Italic(NewValue As Integer)
			
			' �»���
			Declare Property Underline As Integer
			Declare Property Underline(NewValue As Integer)
			
			' ɾ����
			Declare Property Strikethrough As Integer
			Declare Property Strikethrough(NewValue As Integer)
			
			' �ַ���
			Declare Property Charset As Integer
			Declare Property Charset(NewValue As Integer)
			
			' ����
			Declare Property Weight As Integer
			Declare Property Weight(NewValue As Integer)
			
			' ��ȡ������
			Declare Property Font As HANDLE
			
			' ˽�б���
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
		
		
		
		
		
		' �˵���
		Type xMenu
			' ����
			Declare Property Caption As ZString Ptr
			Declare Property Caption(NewValue As ZString Ptr)
			
			' ����
			Declare Property Checked As Integer
			Declare Property Checked(NewValue As Integer)
			
			' ����
			Declare Property Enabled As Integer
			Declare Property Enabled(NewValue As Integer)
			
			' �ɼ�
			Declare Property Visible As Integer
			Declare Property Visible(NewValue As Integer)
			
			' �ɼ�
			Declare Property HelpContextID As Integer
			Declare Property HelpContextID(NewValue As Integer)
			
			' Index
			Declare Property Index As Integer
			Declare Property Index(NewValue As Integer)
			
			' ���˵�
			Declare Property Parent As HMENU
			Declare Property Parent(NewValue As HMENU)
			
			' ��������
			Declare Property Tag As Integer
			Declare Property Tag(NewValue As Integer)
			
			' ˽�б���
			Private:
				Dim h_Menu As HMENU
		End Type
		
		
		
		
		
		' �ؼ�����
		Type xControl
			Dim hWnd As HANDLE
			
			' ����
			Declare Destructor()
			
			' ��
			Declare Function Bind(hWin As HANDLE, idx As Integer = 0) As HANDLE
			
			' ����
			Declare Function Create(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sClass As ZString Ptr, sText As ZString Ptr, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' ����
			Declare Function Destroy() As Integer
			
			' ����Ϣ
			Declare Function Send(msg As Integer, wParam As Integer = 0, lParam As Integer = 0) As Integer
			Declare Function Post(msg As Integer, wParam As Integer = 0, lParam As Integer = 0) As Integer
			
			' LONG
			Declare Function GetLong(idx as Integer) as Integer
			Declare Function SetLong(idx as Integer, value as Integer) As Integer
			
			' Index
			Declare Property Index As Integer
			Declare Property Index(NewValue As Integer)
			
			' ��ʽ
			Declare Property Style As Integer
			Declare Property Style(NewValue As Integer)
			Declare Function AddStyle(NewStyle As Integer) As Integer
			Declare Function DelStyle(StyleID As Integer) As Integer
			
			' ��չ��ʽ
			Declare Property ExStyle As Integer
			Declare Property ExStyle(NewValue As Integer)
			Declare Function AddExStyle(NewStyle As Integer) As Integer
			Declare Function DelExStyle(StyleID As Integer) As Integer
			
			' ˢ��
			Declare Function Refresh(lpRect As RECT Ptr = NULL) As Integer
			
			' ����
			Declare Function SetFocus() As HANDLE
			
			' �ƶ�/��С
			Declare Function Move(x As Integer, y As Integer) As Integer
			Declare Function Size(w As Integer, h As Integer) As Integer
			
			' ����
			Declare Property Enabled As Integer
			Declare Property Enabled(NewValue As Integer)
			
			' �ɼ�
			Declare Property Visible As Integer
			Declare Property Visible(NewValue As Integer)
			
			' ���
			Declare Property Width As Integer
			Declare Property Width(NewValue As Integer)
			
			' �߶�
			Declare Property Height As Integer
			Declare Property Height(NewValue As Integer)
			
			' ���ÿ��/�߶�
			Declare Function ScaleWidth() As Integer
			Declare Function ScaleHeight() As Integer
			
			' ������
			Declare Property Left As Integer
			Declare Property Left(NewValue As Integer)
			
			' ������
			Declare Property Top As Integer
			Declare Property Top(NewValue As Integer)
			
			' ����
			Declare Property Caption As ZString Ptr
			Declare Property Caption(NewValue As ZString Ptr)
			
			' ������
			Declare Property Parent As HANDLE
			Declare Property Parent(NewValue As HANDLE)
			
			' ��������
			Declare Property Tag As Integer
			Declare Property Tag(NewValue As Integer)
			
			' ����
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
			
			' ����
			Declare Function ClassName() As ZString Ptr
			
			' Z��
			Declare Function ZOrder(iPos As Integer = 0) As Integer
			
			' ˽�б���
			Private:
				Dim h_dc As HANDLE
		End Type
		
		
		
		
		
		' ������
		Type xWindow Extends xControl
			' ����
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sText As ZString Ptr, WndProc As Any Ptr, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' ��ʾ����
			Declare Function Show(St As Integer = SW_SHOW) As Integer
			Declare Function Hide() As Integer
			
			' �ɼ�״̬
			Declare Property WindowState As Integer
			Declare Property WindowState(NewValue As Integer)
			
			' ͼ��
			Declare Property Icon As HICON
			Declare Property Icon(NewValue As HICON)
			
			' ϵͳ�˵�
			Declare Property ControlBox As Integer
			Declare Property ControlBox(NewValue As Integer)
			
			' ��󻯰�ť
			Declare Property MaxButton As Integer
			Declare Property MaxButton(NewValue As Integer)
			
			' ��С����ť
			Declare Property MinButton As Integer
			Declare Property MinButton(NewValue As Integer)
			
			' �߿���
			Declare Property BorderStyle As Integer
			Declare Property BorderStyle(NewValue As Integer)
			
			' �Ƿ�ɵ��߿��С
			Declare Property SizeBorder As Integer
			Declare Property SizeBorder(NewValue As Integer)
			
			' �˵�
			#Ifdef XUI_COMPILE_USE_XMENU
				Dim Menu As xMenu
			#Else
				Declare Property Menu As HMENU
				Declare Property Menu(NewValue As HMENU)
			#EndIf
		End Type
		
		
		
		
		
		' ʱ��
		Type xTimer
			Dim Index As Integer
			Dim Tag As Integer
			
			' ����
			Declare Function Create(hParent As HANDLE, idx As Integer, iInterval As Integer) As Integer
			
			' ����
			Declare Function Destroy() As Integer
			
			' ʱ����
			Declare Property Interval As Integer
			Declare Property Interval(NewValue As Integer)
			
			' ������
			Declare Property Parent As HANDLE
			
			' ˽�б���
			Private:
				Dim t_Interval As Integer
				Dim h_Parent As HANDLE
				Dim p_ParentProc As Any Ptr
		End Type
		
		
		
		
		
		' ��ǩ
		Type xLabel Extends xControl
			' ����
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sText As ZString Ptr, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' & ���ſ�ݷ���
			Declare Property UseMnemonic As Integer
			Declare Property UseMnemonic(NewValue As Integer)
			
			' �Զ�����
			Declare Property WordWrap As Integer
			Declare Property WordWrap(NewValue As Integer)
		End Type
		
		
		
		
		
		' ͼ��
		Type xImageBox Extends xControl
			' ����
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' ͼ��
			Declare Property Picture As HANDLE
			Declare Property Picture(NewValue As HANDLE)
			
			' ����
			Declare Property ImageType As Integer
			Declare Property ImageType(NewValue As Integer)
			
			' �Զ�������С
			Declare Property Stretch As Integer
			Declare Property Stretch(NewValue As Integer)
		End Type
		
		
		
		
		
		' ��ť��
		Type xButtom Extends xControl
			' ����
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sText As ZString Ptr, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' ���
			Declare Function Click() As Integer
			
			' ѡ��
			Declare Property Value As Integer
			Declare Property Value(NewValue As Integer)
			
			' Ĭ��
			Declare Property Default As Integer
			Declare Property Default(NewValue As Integer)
		End Type
		
		' ��ѡ����
		Type xCheckBox Extends xButtom
			' ����
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sText As ZString Ptr, iVal As Integer, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
		End Type
		
		' ��ѡ����
		Type xRadioBox Extends xButtom
			' ����
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sText As ZString Ptr, iVal As Integer, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
		End Type
		
		
		
		
		
		' �������
		Type xTextBox Extends xControl
			' ����
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sText As ZString Ptr, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' �ı�
			Declare Property Text As ZString Ptr
			Declare Property Text(NewValue As ZString Ptr)
			
			' ����
			Declare Property Locked As Integer
			Declare Property Locked(NewValue As Integer)
			
			' ���� [����ȡ(������Ҳ������Ч)]
			Declare Property MultiLine As Integer
			
			' ���� [����ȡ(������Ҳ������Ч)]
			Declare Property PassWord As Integer
			
			' ����
			Declare Function Length() As Integer
			
			' �Ƿ��޸�
			Declare Property IsChange As Integer
			Declare Property IsChange(NewValue As Integer)
			
			' �������
			Declare Function Copy() As Integer
			Declare Function Cut() As Integer
			Declare Function Paste() As Integer
			Declare Function Del() As Integer
			Declare Function SelectAll() As Integer
			Declare Function Undo() As Integer
			Declare Function CanUndo() As Integer
			
			' ѡ��
			Declare Property SelLength As Integer
			Declare Property SelLength(NewValue As Integer)
			Declare Property SelStart As Integer
			Declare Property SelStart(NewValue As Integer)
			Declare Property SelEnd As Integer
			Declare Property SelEnd(NewValue As Integer)
			Declare Property SelText As ZString Ptr
			Declare Property SelText(NewValue As ZString Ptr)
		End Type
		
		
		
		
		
		' �б����
		Type xListBox Extends xControl
			' ����
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' �б���
			Declare Property List(nIndex As Integer) As ZString Ptr
			Declare Property List(nIndex As Integer, NewValue As ZString Ptr)
			
			' �б��������
			Declare Property ItemData(nIndex As Integer) As Integer
			Declare Property ItemData(nIndex As Integer, NewValue As Integer)
			
			' ��ѡ [����ȡ(������Ҳ������Ч)]
			Declare Property MultiSelect As Integer
			
			' ���� [����ȡ(������Ҳ������Ч)]
			Declare Property Sorted As Integer
			
			' ����б���
			Declare Function AddItem(sText As ZString Ptr, nIndex As Integer = -1) As Integer
			Declare Function AddItemEx(sText As ZString Ptr, iData As Integer, idx As Integer = -1) As Integer
			Declare Function InsItem(sText As ZString Ptr, nIndex As Integer) As Integer
			
			' �Ƴ��б���
			Declare Function RemoveItem(nIndex As Integer) As Integer
			Declare Function Clear() As Integer
			
			' ѡ���б���
			Declare Property Selected(nIndex As Integer) As Integer
			Declare Property Selected(nIndex As Integer, NewValue As Integer)
			
			' ѡ��������
			Declare Function SelCount() As Integer
			
			' �������ѡ��
			Declare Function SelClear() As Integer
			
			' �б�������
			Declare Property ListCount As Integer
			
			' ��ǰ�б���
			Declare Property ListIndex As Integer
			Declare Property ListIndex(ByVal nIndex As Integer)
			
			' ��ǰ�б������
			Declare Property Text As ZString Ptr
			Declare Property Text(NewValue As ZString Ptr)
		End Type
		
		
		
		
		
		' ��Ͽ���
		Type xComboBox Extends xControl
			' ����
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' �б���
			Declare Property List(nIndex As Integer) As ZString Ptr
			Declare Property List(nIndex As Integer, NewValue As ZString Ptr)
			
			' �б��������
			Declare Property ItemData(nIndex As Integer) As Integer
			Declare Property ItemData(nIndex As Integer, NewValue As Integer)
			
			' ���� [����ȡ(������Ҳ������Ч)]
			Declare Property Sorted As Integer
			
			' ����б���
			Declare Function AddItem(sText As ZString Ptr, nIndex As Integer = -1) As Integer
			Declare Function AddItemEx(sText As ZString Ptr, iData As Integer, idx As Integer = -1) As Integer
			Declare Function InsItem(sText As ZString Ptr, nIndex As Integer) As Integer
			
			' �Ƴ��б���
			Declare Function RemoveItem(nIndex As Integer) As Integer
			Declare Function Clear() As Integer
			
			' �б�������
			Declare Property ListCount As Integer
			
			' ��ǰ�б���
			Declare Property ListIndex As Integer
			Declare Property ListIndex(ByVal nIndex As Integer)
			
			' ��ǰ�б������
			Declare Property Text As ZString Ptr
			Declare Property Text(NewValue As ZString Ptr)
			
			' ģʽ
			Declare Property Mode As Integer
			Declare Property Mode(NewValue As Integer)
		End Type
		
		
		
		
		
		' �������
		Type xFrame Extends xControl
			' ����
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, sText As ZString Ptr, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
		End Type
		
		
		
		
		
		' ������
		Type xScroll Extends xControl
			' ����
			Declare Function Create OverLoad(hParent As HANDLE, x As Integer, y As Integer, w As Integer, h As Integer, iTpe As Integer, idx As Integer=0, iStyle As Integer=0, iExStyle As Integer=0, lpData As Any Ptr) As HANDLE
			
			' ��Сֵ
			Declare Property MinValue As Integer
			Declare Property MinValue(NewValue As Integer)
			
			' ���ֵ
			Declare Property MaxValue As Integer
			Declare Property MaxValue(NewValue As Integer)
			
			' ��ǰֵ
			Declare Property Value As Integer
			Declare Property Value(NewValue As Integer)
			
			' ����[ˮƽ��ֱ]
			Declare Property ScrollType As Integer
			Declare Property ScrollType(NewValue As Integer)
		End Type
	End Namespace
#EndIf
