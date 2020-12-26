#Include Once "Windows.bi"
#Include Once "win\commctrl.bi"



#Define xywh_library_xgui



' �������ݶ��岿��
Dim Shared xywh_library_xgui_ram As ZString Ptr



' ListBox / ComboBox �ؼ����岿��
Enum ListChangeFlag
	ChangeText = 1
	ChangeData = 2
End Enum





' Control ��
#Ifdef xywh_library_xgui
	Type xywh_Control
		hWnd As HWND
		TagInt As Integer
		TagPtr As Any Ptr
		Declare Sub Bind(ByVal WinHWND As HANDLE,ByVal WinID As Integer = 0)
		Declare Function Send(ByVal Message As Integer,ByVal wParam As Integer,ByVal lParam As Integer) As Integer
		Declare Function Post(ByVal Message As Integer,ByVal wParam As Integer,ByVal lParam As Integer) As Integer
		Declare Property Style(ByVal NewValue As Integer)					'����:��ʽ
		Declare Property Style As Integer
		Declare Property ExStyle(ByVal NewValue As Integer)				'����:��չ��ʽ
		Declare Property ExStyle As Integer
		Declare Sub AddStyle(ByVal NewStyle As Integer)						'����:�������ʽ
		Declare Sub DelStyle(ByVal StyleID As Integer)						'����:ȥ����ʽ
		Declare Sub AddExStyle(ByVal NewStyle As Integer)					'����:�������ʽ
		Declare Sub DelExStyle(ByVal StyleID As Integer)					'����:ȥ����ʽ
		Declare Sub Refresh()
		Declare Sub SetFocus()
		Declare Sub Move(ByVal X As Integer,ByVal Y As Integer)
		Declare Sub Size(ByVal W As Integer,ByVal H As Integer)
		Declare Sub SetProc(ByVal NewProc As Any Ptr)							'����:����Proc����
		Declare Property Enabled(ByVal NewValue As Integer)				'����:�Ƿ����
		Declare Property Enabled As Integer
		Declare Property Visible(ByVal NewValue As Integer)				'����:�Ƿ�ɼ�
		Declare Property Visible As Integer
		Declare Property Width(ByVal NewValue As Integer)					'����:���
		Declare Property Width As Integer
		Declare Property Height(ByVal NewValue As Integer)				'����:�߶�
		Declare Property Height As Integer
		Declare Property Left(ByVal NewValue As Integer)					'����:X����
		Declare Property Left As Integer
		Declare Property Top(ByVal NewValue As Integer)						'����:Y����
		Declare Property Top As Integer
		Declare Property Caption(ByVal NewValue As ZString Ptr)		'����:����
		Declare Property Caption As ZString Ptr
		Declare Property Parent(ByVal NewValue As HANDLE)					'����:������
		Declare Property Parent As HANDLE
		Declare Function ClassName() As ZString Ptr								'����:����
		Declare Function ScaleWidth() As Integer
		Declare Function ScaleHeight() As Integer
		IsWindowMode As Integer
	End Type
	
	Sub xywh_Control.Bind(ByVal WinHWND As HANDLE,ByVal WinID As Integer = 0)
		If WinID = 0 Then
			hWnd = WinHWND
		Else
			hWnd = GetDlgItem(WinHWND,WinID)
		EndIf
	End Sub
	
	Function xywh_Control.Send(ByVal Message As Integer,ByVal wParam As Integer,ByVal lParam As Integer) As Integer
		Return SendMessage(hWnd,Message,wParam,lParam)
	End Function
	
	Function xywh_Control.Post(ByVal Message As Integer,ByVal wParam As Integer,ByVal lParam As Integer) As Integer
		Return PostMessage(hWnd,Message,wParam,lParam)
	End Function
	
	Property xywh_Control.Style(ByVal NewValue As Integer)
		SetWindowLong(hWnd,GWL_STYLE,NewValue)
	End Property
	
	Property xywh_Control.Style As Integer
		Style = GetWindowLong(hWnd,GWL_STYLE)
	End Property
	
	Property xywh_Control.ExStyle(ByVal NewValue As Integer)
		SetWindowLong(hWnd,GWL_EXSTYLE,NewValue)
	End Property
	
	Property xywh_Control.ExStyle As Integer
		ExStyle = GetWindowLong(hWnd,GWL_EXSTYLE)
	End Property
	
	Sub xywh_Control.AddStyle(ByVal NewStyle As Integer)
		Dim TL As Integer = GetWindowLong(hWnd,GWL_STYLE)
		TL = TL Or NewStyle
		SetWindowLong(hWnd,GWL_STYLE,TL)
	End Sub
	
	Sub xywh_Control.DelStyle(ByVal StyleID As Integer)
		Dim TL As Integer = GetWindowLong(hWnd,GWL_STYLE)
		TL = TL And Not(StyleID)
		SetWindowLong(hWnd,GWL_STYLE,TL)
	End Sub
	
	Sub xywh_Control.AddExStyle(ByVal NewStyle As Integer)
		Dim TL As Integer = GetWindowLong(hWnd,GWL_EXSTYLE)
		TL = TL Or NewStyle
		SetWindowLong(hWnd,GWL_EXSTYLE,TL)
	End Sub
	
	Sub xywh_Control.DelExStyle(ByVal StyleID As Integer)
		Dim TL As Integer = GetWindowLong(hWnd,GWL_EXSTYLE)
		TL = TL And Not(StyleID)
		SetWindowLong(hWnd,GWL_EXSTYLE,TL)
	End Sub
	
	Sub xywh_Control.Refresh()
		InvalidateRect(hWnd,NULL,TRUE)
		UpdateWindow(hWnd)
	End Sub
	
	Sub xywh_Control.SetFocus()
		SendMessage(hWnd,WM_SETFOCUS,0,0)
	End Sub
	
	Property xywh_Control.Enabled(ByVal NewValue As Integer)
		If NewValue Then
			DelStyle(WS_DISABLED)
		Else
			AddStyle(WS_DISABLED)
		EndIf
		Refresh()
	End Property
	
	Property xywh_Control.Enabled As Integer
		If Style And WS_DISABLED = 0 Then Return -1
	End Property
	
	Property xywh_Control.Visible(ByVal NewValue As Integer)
		ShowWindow(hWnd,IIf(NewValue,SW_SHOW,SW_HIDE))
	End Property
	
	Property xywh_Control.Visible As Integer
		Visible = IsWindowVisible(hWnd)
	End Property
	
	Sub xywh_Control.Move(ByVal X As Integer,ByVal Y As Integer)
		SetWindowPos(hWnd,0,X,Y,0,0,SWP_NOACTIVATE Or SWP_NOSIZE Or SWP_NOREPOSITION)
	End Sub
	
	Sub xywh_Control.Size(ByVal W As Integer,ByVal H As Integer)
		SetWindowPos(hWnd,0,0,0,W,H,SWP_NOACTIVATE Or SWP_NOMOVE Or SWP_NOREPOSITION)
	End Sub
	
	Sub xywh_Control.SetProc(ByVal NewProc As Any Ptr)
		SetWindowLong(hWnd,GWL_WNDPROC,Cast(Integer,NewProc))
	End Sub
	
	Property xywh_Control.Width(ByVal NewValue As Integer)
		Size(NewValue,Height)
	End Property
	
	Property xywh_Control.Width As Integer
		Dim TR As RECT
		GetWindowRect(hWnd,@TR)
		Return TR.right - TR.left
	End Property
	
	Function xywh_Control.ScaleWidth() As Integer
		Dim TR As RECT
		GetClientRect(hWnd,@TR)
		Return TR.right
	End Function
	
	Property xywh_Control.Height(ByVal NewValue As Integer)
		Size(Width,NewValue)
	End Property
	
	Property xywh_Control.Height As Integer
		Dim TR As RECT
		GetWindowRect(hWnd,@TR)
		Return TR.bottom - TR.top
	End Property
	
	Function xywh_Control.ScaleHeight() As Integer
		Dim TR As RECT
		GetClientRect(hWnd,@TR)
		Return TR.bottom
	End Function
	
	Property xywh_Control.Left(ByVal NewValue As Integer)
		Move(NewValue,Top)
	End Property
	
	Property xywh_Control.Left As Integer
		Dim ParHWND As HANDLE = GetParent(hWnd)
		Dim TRM As RECT
		GetWindowRect(hWnd,@TRM)
		If ParHWND Then
			Dim TRP As RECT
			GetWindowRect(ParHWND,@TRP)
			Return TRM.left - TRP.left
		Else
			Return TRM.left
		EndIf
	End Property
	
	Property xywh_Control.Top(ByVal NewValue As Integer)
		Move(Left,NewValue)
	End Property
	
	Property xywh_Control.Top As Integer
		Dim ParHWND As HANDLE = GetParent(hWnd)
		Dim TRM As RECT
		GetWindowRect(hWnd,@TRM)
		If ParHWND Then
			Dim TRP As RECT
			GetWindowRect(ParHWND,@TRP)
			Return TRM.top - TRP.top
		Else
			Return TRM.top
		EndIf
	End Property
	
	Property xywh_Control.Caption(ByVal NewValue As ZString Ptr)
		SendMessage(hWnd,WM_SETTEXT,0,Cast(Integer,NewValue))
	End Property
	
	Property xywh_Control.Caption As ZString Ptr
		Dim TL As Integer = SendMessage(hWnd,WM_GETTEXTLENGTH,0,0)
		DeAllocate(xywh_library_xgui_ram)
		xywh_library_xgui_ram = Allocate(TL+1)
		SendMessage(hWnd,WM_GETTEXT,TL+1,Cast(Integer,xywh_library_xgui_ram))
		Caption = xywh_library_xgui_ram
	End Property
	
	Function xywh_Control.ClassName() As ZString Ptr
		DeAllocate(xywh_library_xgui_ram)
		xywh_library_xgui_ram = Allocate(256)
		GetClassName(hWnd,xywh_library_xgui_ram,256)
		ClassName = xywh_library_xgui_ram
	End Function
	
	Property xywh_Control.Parent() As HANDLE
		Return GetParent(hWnd)
	End Property
	
	Property xywh_Control.Parent(ByVal NewValue As HANDLE)
		SetParent(hWnd,NewValue)
	End Property
#EndIf





' Window ��
#Ifndef xywh_library_xgui_del_window
	Type xywh_Window Extends xywh_Control
		Declare Constructor()
		Declare Sub Show(St As Integer = SW_SHOW)
		Declare Sub Hide()
	End Type
	
	Constructor xywh_Window()
		IsWindowMode = -1
	End Constructor
	
	Sub xywh_Window.Show(St As Integer = SW_SHOW)
		ShowWindow(hWnd,St)
	End Sub
	
	Sub xywh_Window.Hide()
		ShowWindow(hWnd,SW_HIDE)
	End Sub
#EndIf





' Button ��
#Ifndef xywh_library_xgui_del_button
	Type xywh_Button Extends xywh_Control
		Declare Sub Click()
		Declare Property Value(ByVal NewValue As Integer)					'����:״̬
		Declare Property Value As Integer
	End Type
	
	Sub xywh_Button.Click()
		SendMessage(hWnd,BM_CLICK,0,0)
	End Sub
	
	Property xywh_Button.Value(ByVal NewValue As Integer)
		SendMessage(hWnd,BM_SETCHECK,NewValue,0)
	End Property
	
	Property xywh_Button.Value As Integer
		Value = SendMessage(hWnd,BM_GETCHECK,0,0)
	End Property
#EndIf





' CheckBox ��
#Ifndef xywh_library_xgui_del_checkbox
	Type xywh_CheckBox As xywh_Button
#EndIf





' RadioBox ��
#Ifndef xywh_library_xgui_del_radiobox
	Type xywh_RadioBox As xywh_Button
#EndIf





' TextBox ��
#Ifndef xywh_library_xgui_del_textbox
	Type xywh_TextBox Extends xywh_Control
		Declare Property Text(ByVal NewValue As ZString Ptr)			'����:�ı�
		Declare Property Text As ZString Ptr
		Declare Property Locked(ByVal NewValue As Integer)				'����:����
		Declare Property Locked As Integer
		Declare Function Lenght() As Integer
		Declare Function IsChange() As Integer
		Declare Sub ClearChange()
		Declare Sub Copy()
		Declare Sub Cut()
		Declare Sub Paste()
		Declare Sub Del()
		Declare Sub SelectAll()
		Declare Sub Undo()
	End Type
	
	Property xywh_TextBox.Text(ByVal NewValue As ZString Ptr)
		Caption = NewValue
	End Property
	
	Property xywh_TextBox.Text As ZString Ptr
		Text = Caption
	End Property
	
	Property xywh_TextBox.Locked(ByVal NewValue As Integer)
		SendMessage(hWnd,EM_SETREADONLY,NewValue,0)
	End Property
	
	Property xywh_TextBox.Locked As Integer
		If Style And ES_READONLY Then Return -1
	End Property
	
	Function xywh_TextBox.Lenght() As Integer
		Lenght = SendMessage(hWnd,WM_GETTEXTLENGTH,0,0)
	End Function
	
	Function xywh_TextBox.IsChange() As Integer
		IsChange = SendMessage(hWnd,EM_CANUNDO,0,0)
	End Function
	
	Sub xywh_TextBox.ClearChange()
		SendMessage(hWnd,EM_EMPTYUNDOBUFFER,0,0)
	End Sub
	
	Sub xywh_TextBox.Copy()
		SendMessage(hWnd,WM_COPY,0,0)
	End Sub
	
	Sub xywh_TextBox.Cut()
		SendMessage(hWnd,WM_CUT,0,0)
	End Sub
	
	Sub xywh_TextBox.Paste()
		SendMessage(hWnd,WM_PASTE,0,0)
	End Sub
	
	Sub xywh_TextBox.Del()
		SendMessage(hWnd,WM_CLEAR,0,0)
	End Sub
	
	Sub xywh_TextBox.SelectAll()
		PostMessage(hWnd,EM_SETSEL,0,-1)
	End Sub
	
	Sub xywh_TextBox.Undo()
		SendMessage(hWnd,EM_UNDO,0,0)
	End Sub
#EndIf





' ListBox ��
#Ifndef xywh_library_xgui_del_listbox
	Type xywh_ListBox Extends xywh_Control
		Declare Function AddItemEx(ByVal ItemStr As ZString Ptr,ByVal ItemData As Integer) As Integer
		Declare Function AddItem(ByVal ItemStr As ZString Ptr) As Integer							'����:�����
		Declare Sub ChangeItemEx(ByVal nIndex As Integer,ByVal ItemStr As ZString Ptr,ByVal ItemData As Integer,ByVal Flag As ListChangeFlag)
		Declare Sub ChangeItem(ByVal nIndex As Integer,ByVal ItemStr As ZString Ptr)	'����:������
		Declare Sub RemoveItem(ByVal nIndex As Integer)																'����:�Ƴ���
		Declare Sub Clear()
		Declare Sub CheckItem(ByVal nIndex As Integer,ByVal CheckStk As Integer)			'����:ѡ����
		Declare Function List(ByVal nIndex As Integer) As ZString Ptr									'����:ȡ���ı�
		Declare Function ListData(ByVal nIndex As Integer) As Integer									'����:ȡ������
		Declare Function IsCheck(ByVal nIndex As Integer) As Integer									'����:��ȡѡ��״̬
		Declare Property Index(ByVal nIndex As Integer)																'����:ѡ����ID
		Declare Property Index As Integer
		Declare Property ListCount As Integer																					'����:�б�����Ŀ
		Declare Property Text(ByVal NewValue As ZString Ptr)													'����:ѡ��������
		Declare Property Text As ZString Ptr
	End Type
	
	Function xywh_ListBox.AddItemEx(ByVal ItemStr As ZString Ptr,ByVal ItemData As Integer) As Integer
		Dim TL As Integer
		TL = SendMessage(hWnd,LB_ADDSTRING,0,Cast(Integer,ItemStr))
		SendMessage(hWnd,LB_SETITEMDATA,tl,ItemData)
		AddItemEx = TL
	End Function
	
	Function xywh_ListBox.AddItem(ByVal ItemStr As ZString Ptr) As Integer
		AddItem = AddItemEx(ItemStr,0)
	End Function
	
	Sub xywh_ListBox.ChangeItemEx(ByVal nIndex As Integer,ByVal ItemStr As ZString Ptr,ByVal ItemData As Integer,ByVal Flag As ListChangeFlag)
		If nIndex>-1 Then
			Dim TL As Integer,OldValue As Integer
			If (Flag And ChangeData) Xor ChangeData Then			' ����Data����
				OldValue = SendMessage(hWnd,LB_GETITEMDATA,nIndex,0)
			EndIf
			If Flag And ChangeText Then												' �����б����
				SendMessage(hWnd,LB_DELETESTRING,nIndex,0)
				TL = SendMessage(hWnd,LB_INSERTSTRING,nIndex,Cast(LPARAM,ItemStr))
			Else
				TL = nIndex
			EndIf
			If Flag And ChangeData Then												' ��ԭData����
				SendMessage(hWnd,LB_SETITEMDATA,TL,ItemData)
			Else
				SendMessage(hWnd,LB_SETITEMDATA,TL,OldValue)
			EndIf
			SendMessage(hWnd,LB_SETCURSEL,nIndex,0)
		EndIf
	End Sub
	
	Sub xywh_ListBox.ChangeItem(ByVal nIndex As Integer,ByVal ItemStr As ZString Ptr)
		ChangeItemEx(nIndex,ItemStr,0,ChangeText)
	End Sub
	
	Sub xywh_ListBox.RemoveItem(ByVal nIndex As Integer)
		SendMessage(hWnd,LB_DELETESTRING,nIndex,0)
	End Sub
	
	Sub xywh_ListBox.Clear()
		SendMessage(hWnd,LB_RESETCONTENT,0,0)
	End Sub
	
	Sub xywh_ListBox.CheckItem(ByVal nIndex As Integer,ByVal Value As Integer)
		SendMessage(hWnd,LB_SETSEL,Value,nIndex)
	End Sub
	
	Function xywh_ListBox.List(ByVal nIndex As Integer) As ZString Ptr
		DeAllocate(xywh_library_xgui_ram)
		If nIndex>-1 Then
			Dim TL As Integer
			TL = SendMessage(hWnd,LB_GETTEXTLEN,nIndex,0)
			xywh_library_xgui_ram = Allocate(TL+1)
			SendMessage(hWnd,LB_GETTEXT,nIndex,Cast(Integer,xywh_library_xgui_ram))
		Else
			xywh_library_xgui_ram = Allocate(1)
		EndIf
		List = xywh_library_xgui_ram
	End Function
	
	Function xywh_ListBox.ListData(ByVal nIndex As Integer) As Integer
		If nIndex>-1 Then
			ListData = SendMessage(hWnd,LB_GETITEMDATA,nIndex,0)
		Else
			ListData = 0
		EndIf
	End Function
	
	Function xywh_ListBox.IsCheck(ByVal nIndex As Integer) As Integer
		If SendMessage(hWnd,LB_GETSEL,nIndex,0) > 0 Then
			Return -1
		EndIf
	End Function
	
	Property xywh_ListBox.Index(ByVal nIndex As Integer)
		SendMessage(hWnd,LB_SETCURSEL,nIndex,0)
	End Property
	
	Property xywh_ListBox.Index As Integer
		Index = SendMessage(hWnd,LB_GETCURSEL,0,0)
	End Property
	
	Property xywh_ListBox.ListCount As Integer
		ListCount = SendMessage(hWnd,LB_GETCOUNT,0,0)
	End Property
	
	Property xywh_ListBox.Text(ByVal NewValue As ZString Ptr)
		If Not(Index) Then
			ChangeItemEx(Index,NewValue,0,ChangeText)
		EndIf
	End Property
	
	Property xywh_ListBox.Text As ZString Ptr
		Text = List(Index)
	End Property
#EndIf





' ComboBox ��
#Ifndef xywh_library_xgui_del_combobox
	Type xywh_ComboBox Extends xywh_ListBox
		Declare Function AddItemEx(ByVal ItemStr As ZString Ptr,ByVal ItemData As Integer) As Integer
		Declare Function AddItem(ByVal ItemStr As ZString Ptr) As Integer							'����:�����
		Declare Sub ChangeItemEx(ByVal nIndex As Integer,ByVal ItemStr As ZString Ptr,ByVal ItemData As Integer,ByVal Flag As ListChangeFlag)
		Declare Sub ChangeItem(ByVal nIndex As Integer,ByVal ItemStr As ZString Ptr)	'����:������
		Declare Sub RemoveItem(ByVal nIndex As Integer)																'����:�Ƴ���
		Declare Sub Clear()
		Declare Function List(ByVal nIndex As Integer) As ZString Ptr									'����:ȡ���ı�
		Declare Function ListData(ByVal nIndex As Integer) As Integer									'����:ȡ������
		Declare Property Index(ByVal nIndex As Integer)																'����:ѡ����ID
		Declare Property Index As Integer
		Declare Property ListCount As Integer																					'����:�б�����Ŀ
		Declare Property Text(ByVal NewValue As ZString Ptr)													'����:ѡ��������
		Declare Property Text As ZString Ptr
	End Type
	
	Function xywh_ComboBox.AddItemEx(ByVal ItemStr As ZString Ptr,ByVal ItemData As Integer) As Integer
		Dim TL As Integer
		TL = SendMessage(hWnd,CB_ADDSTRING,0,Cast(Integer,ItemStr))
		SendMessage(hWnd,CB_SETITEMDATA,tl,ItemData)
		AddItemEx = TL
	End Function
	
	Function xywh_ComboBox.AddItem(ByVal ItemStr As ZString Ptr) As Integer
		AddItem = AddItemEx(ItemStr,0)
	End Function
	
	Sub xywh_ComboBox.ChangeItemEx(ByVal nIndex As Integer,ByVal ItemStr As ZString Ptr,ByVal ItemData As Integer,ByVal Flag As ListChangeFlag)
		If nIndex>-1 Then
			Dim TL As Integer,OldValue As Integer
			If (Flag And ChangeData) Xor ChangeData Then			' ����Data����
				OldValue = SendMessage(hWnd,CB_GETITEMDATA,nIndex,0)
			EndIf
			If Flag And ChangeText Then												' �����б����
				SendMessage(hWnd,CB_DELETESTRING,nIndex,0)
				TL = SendMessage(hWnd,CB_INSERTSTRING,nIndex,Cast(LPARAM,ItemStr))
			Else
				TL = nIndex
			EndIf
			If Flag And ChangeData Then												' ��ԭData����
				SendMessage(hWnd,CB_SETITEMDATA,TL,ItemData)
			Else
				SendMessage(hWnd,CB_SETITEMDATA,TL,OldValue)
			EndIf
			SendMessage(hWnd,CB_SETCURSEL,nIndex,0)
		EndIf
	End Sub
	
	Sub xywh_ComboBox.ChangeItem(ByVal nIndex As Integer,ByVal ItemStr As ZString Ptr)
		ChangeItemEx(nIndex,ItemStr,0,ChangeText)
	End Sub
	
	Sub xywh_ComboBox.RemoveItem(ByVal nIndex As Integer)
		SendMessage(hWnd,CB_DELETESTRING,nIndex,0)
	End Sub
	
	Sub xywh_ComboBox.Clear()
		SendMessage(hWnd,CB_RESETCONTENT,0,0)
	End Sub
	
	Function xywh_ComboBox.List(ByVal nIndex As Integer) As ZString Ptr
		DeAllocate(xywh_library_xgui_ram)
		If nIndex>-1 Then
			Dim TL As Integer
			TL = SendMessage(hWnd,CB_GETLBTEXTLEN,nIndex,0)
			xywh_library_xgui_ram = Allocate(TL+1)
			SendMessage(hWnd,CB_GETLBTEXT,nIndex,Cast(Integer,xywh_library_xgui_ram))
		Else
			xywh_library_xgui_ram = Allocate(1)
		EndIf
		List = xywh_library_xgui_ram
	End Function
	
	Function xywh_ComboBox.ListData(ByVal nIndex As Integer) As Integer
		If nIndex>-1 Then
			ListData = SendMessage(hWnd,CB_GETITEMDATA,nIndex,0)
		Else
			ListData = 0
		EndIf
	End Function
	
	Property xywh_ComboBox.Index(ByVal nIndex As Integer)
		SendMessage(hWnd,CB_SETCURSEL,nIndex,0)
	End Property
	
	Property xywh_ComboBox.Index As Integer
		Index = SendMessage(hWnd,CB_GETCURSEL,0,0)
	End Property
	
	Property xywh_ComboBox.ListCount As Integer
		ListCount = SendMessage(hWnd,CB_GETCOUNT,0,0)
	End Property
	
	Property xywh_ComboBox.Text(ByVal NewValue As ZString Ptr)
		Dim TL As Integer
		TL = GetWindowLong(hWnd,GWL_STYLE)
		If (TL And CBS_DROPDOWNLIST)=CBS_DROPDOWNLIST Then
			If Not(Index) Then
				ChangeItemEx(Index,NewValue,0,ChangeText)
			EndIf
		Else
			SetWindowText(hWnd,NewValue)
		EndIf
	End Property
	
	Property xywh_ComboBox.Text As ZString Ptr
		Dim TL As Integer
		TL = GetWindowLong(hWnd,GWL_STYLE)
		If (TL And CBS_DROPDOWNLIST)=CBS_DROPDOWNLIST Then
			Text = List(Index)
		Else
			Text = Caption
		EndIf
	End Property
#EndIf





' ϵͳ��չ�ؼ�
#Ifdef xywh_library_xgui_use_commctrl
	' �� ImageList �Ļ�����
	Type xywh_CommCtrl Extends xywh_Control
		ImageList As HIMAGELIST
		IconSize As Integer
		Declare Function AddImage_Res(ByVal ResID As Integer) As Integer
		Declare Function AddImage_File(ByVal FileName As ZString Ptr) As Integer
		Declare Function AddIcon_Res(ByVal ResID As Integer) As Integer
		Declare Function AddIcon_File(ByVal FileName As ZString Ptr) As Integer
	End Type
	
	Function xywh_CommCtrl.AddImage_Res(ByVal ResID As Integer) As Integer
		SendMessage(hWnd,TB_SETIMAGELIST,0,Cast(LPARAM,ImageList))
		Return ImageList_AddIcon(ImageList,LoadImage(GetModuleHandle(NULL),MAKEINTRESOURCE(ResID),IMAGE_BITMAP,IconSize,IconSize,LR_SHARED))
	End Function
	
	Function xywh_CommCtrl.AddImage_File(ByVal FileName As ZString Ptr) As Integer
		SendMessage(hWnd,TB_SETIMAGELIST,0,Cast(LPARAM,ImageList))
		Return ImageList_AddIcon(ImageList,LoadImage(NULL,FileName,IMAGE_BITMAP,IconSize,IconSize,LR_SHARED))
	End Function
	
	Function xywh_CommCtrl.AddIcon_Res(ByVal ResID As Integer) As Integer
		SendMessage(hWnd,TB_SETIMAGELIST,0,Cast(LPARAM,ImageList))
		Return ImageList_AddIcon(ImageList,LoadImage(GetModuleHandle(NULL),MAKEINTRESOURCE(ResID),IMAGE_ICON,IconSize,IconSize,LR_SHARED))
	End Function
	
	Function xywh_CommCtrl.AddIcon_File(ByVal FileName As ZString Ptr) As Integer
		SendMessage(hWnd,TB_SETIMAGELIST,0,Cast(LPARAM,ImageList))
		Return ImageList_AddIcon(ImageList,LoadImage(NULL,FileName,IMAGE_ICON,IconSize,IconSize,LR_SHARED))
	End Function
	
	
	
	' ProgBar ��
	#Ifndef xywh_library_xgui_del_progbar
		Type xywh_ProgBar Extends xywh_Control
			Declare Property MinNum(ByVal NewValue As Integer)				'����:������Сֵ
			Declare Property MinNum As Integer
			Declare Property MaxNum(ByVal NewValue As Integer)				'����:�������ֵ
			Declare Property MaxNum As Integer
			Declare Property Value(ByVal NewValue As Integer)					'����:���ȵ�ǰֵ
			Declare Property Value As Integer
		End Type
		
		Property xywh_ProgBar.MinNum(ByVal NewValue As Integer)
			Dim TL As PBRANGE
			SendMessage(hWnd,PBM_GETRANGE,0,Cast(LPARAM,@TL))
			SendMessage(hWnd,PBM_SETRANGE,0,MAKELPARAM(TL.iHigh,200))
		End Property
		
		Property xywh_ProgBar.MinNum As Integer
			Dim TL As PBRANGE
			SendMessage(hWnd,PBM_GETRANGE,0,Cast(LPARAM,@TL))
			MinNum = TL.iLow
		End Property
		
		Property xywh_ProgBar.MaxNum(ByVal NewValue As Integer)
			Dim TL As PBRANGE
			SendMessage(hWnd,PBM_GETRANGE,0,Cast(LPARAM,@TL))
			SendMessage(hWnd,PBM_SETRANGE,0,MAKELPARAM(TL.iLow,NewValue))
		End Property
		
		Property xywh_ProgBar.MaxNum As Integer
			Dim TL As PBRANGE
			SendMessage(hWnd,PBM_GETRANGE,0,Cast(LPARAM,@TL))
			MaxNum = TL.iHigh
		End Property
		
		Property xywh_ProgBar.Value(ByVal NewValue As Integer)
			SendMessage(hWnd,PBM_SETPOS,NewValue,0)
		End Property
		
		Property xywh_ProgBar.Value As Integer
			Value = SendMessage(hWnd,PBM_GETPOS,0,0)
		End Property
	#EndIf
	
	
	
	' TabStrip ��
	#Ifndef xywh_library_xgui_del_tabstrip
		Type xywh_TabStrip Extends xywh_Control
			Declare Function AddTabEx(ByVal Index As Integer,ByVal TitleStr As ZString Ptr,ByVal nParam As Integer,ByVal nImage As Integer) As Integer
			Declare Function AddTab(ByVal TitleStr As ZString Ptr) As Integer		'����:���ѡ�
			Declare Function Remove(ByVal nIndex As Integer) As Integer					'����:�Ƴ�ѡ�
			Declare Property Caption(ByVal nIndex As Integer,ByVal NewValue As ZString Ptr)
			Declare Property Caption(ByVal nIndex As Integer) As ZString Ptr		'����:����
			Declare Property Param(ByVal nIndex As Integer,ByVal NewValue As Integer)
			Declare Property Param(ByVal nIndex As Integer) As Integer					'����:��������
			Declare Property Index(ByVal nIndex As Integer)											'����:ѡ����ID
			Declare Property Index As Integer
			Declare Property Count As Integer																		'����:ѡ�����
		End Type
		
		Function xywh_TabStrip.AddTabEx(ByVal nIndex As Integer,ByVal TitleStr As ZString Ptr,ByVal nParam As Integer,ByVal nImage As Integer) As Integer
			Dim tc As TCITEM
			Dim tl As Integer
			tc.mask = TCIF_TEXT Or TCIF_PARAM Or TCIF_IMAGE
			tc.pszText = TitleStr
			tc.lParam = nParam
			tc.iImage = nImage
			tl = SendMessage(hWnd,TCM_INSERTITEM,nIndex,Cast(Integer,@tc))
			SendMessage(hWnd,TCM_SETCURSEL,tl,0)
			AddTabEx = tl
		End Function
		
		Function xywh_TabStrip.AddTab(ByVal TitleStr As ZString Ptr) As Integer
			Dim tc As TCITEM
			Dim tl As Integer
			tc.mask = TCIF_TEXT
			tc.pszText = TitleStr
			tl = SendMessage(hWnd,TCM_INSERTITEM,SendMessage(hWnd,TCM_GETITEMCOUNT,0,0),Cast(Integer,@tc))
			SendMessage(hWnd,TCM_SETCURSEL,tl,0)
			AddTab = tl
		End Function
		
		Function xywh_TabStrip.Remove(ByVal nIndex As Integer) As Integer
			SendMessage(hWnd,TCM_DELETEITEM,nIndex,0)
			If nIndex < Count Then
				Index = nIndex
			Else
				Index = Count-1
			EndIf
			Remove = Index
		End Function
		
		Property xywh_TabStrip.Index(ByVal nIndex As Integer)
			SendMessage(hWnd,TCM_SETCURSEL,nIndex,0)
		End Property
		
		Property xywh_TabStrip.Index As Integer
			Index = SendMessage(hWnd,TCM_GETCURSEL,0,0)
		End Property
		
		Property xywh_TabStrip.Count As Integer
			Count = SendMessage(hWnd,TCM_GETITEMCOUNT,0,0)
		End Property
		
		Property xywh_TabStrip.Caption(ByVal nIndex As Integer,ByVal NewValue As ZString Ptr)
			Dim tc As TCITEM
			tc.mask = TCIF_TEXT
			tc.pszText = NewValue
			SendMessage(hWnd,TCM_SETITEM,nIndex,Cast(Integer,@tc))
		End Property
		
		Property xywh_TabStrip.Caption(ByVal nIndex As Integer) As ZString Ptr
			Dim tc As TCITEM
			tc.mask = TCIF_TEXT
			DeAllocate(xywh_library_xgui_ram)
			xywh_library_xgui_ram = Allocate(4096)
			tc.pszText = xywh_library_xgui_ram
			tc.cchTextMax = 4096
			SendMessage(hWnd,TCM_GETITEM,nIndex,Cast(Integer,@tc))
			Return tc.pszText
		End Property
		
		Property xywh_TabStrip.Param(ByVal nIndex As Integer,ByVal NewValue As Integer)
			Dim tc As TCITEM
			tc.mask = TCIF_PARAM
			tc.lParam = NewValue
			SendMessage(hWnd,TCM_SETITEM,nIndex,Cast(Integer,@tc))
		End Property
		
		Property xywh_TabStrip.Param(ByVal nIndex As Integer) As Integer
			Dim tc As TCITEM
			tc.mask = TCIF_PARAM
			SendMessage(hWnd,TCM_GETITEM,nIndex,Cast(Integer,@tc))
			Return tc.lParam
		End Property
	#EndIf
	
	
	
	' ToolBox ��
	#Ifndef xywh_library_xgui_del_toolbox
		Type xywh_ToolBox Extends xywh_CommCtrl
			Declare Constructor(ByVal IcnSize As Integer)
			Declare Function AddButton(ByVal Caption As ZString Ptr,ByVal ImageID As Integer,ByVal CmdID As Integer) As Integer
			Declare Function AddSplit() As Integer
		End Type
		
		Constructor xywh_ToolBox(ByVal IcnSize As Integer)
			IconSize = IcnSize
			ImageList = ImageList_Create(IcnSize,IcnSize,ILC_MASK Or ILC_COLOR32,0,0)
		End Constructor
		
		Function xywh_ToolBox.AddButton(ByVal Caption As ZString Ptr,ByVal ImageID As Integer,ByVal CmdID As Integer) As Integer
			Dim tbb as TBBUTTON
			tbb.iBitmap = ImageID
			tbb.fsState	= TBSTATE_ENABLED
			tbb.fsStyle	= TBSTYLE_BUTTON
			tbb.idCommand = CmdID
			tbb.iString = Cast(Integer,Caption)
			Return SendMessage(hWnd,TB_ADDBUTTONS,1,cint(@tbb))
		End Function
		
		Function xywh_ToolBox.AddSplit() As Integer
			Dim tbb as TBBUTTON
			tbb.fsState	= TBSTATE_ENABLED
			tbb.fsStyle	= TBSTYLE_SEP
			Return SendMessage(hWnd,TB_ADDBUTTONS,1,cint(@tbb))
		End Function
	#EndIf
	
	
	
	' TreeList ��
	#Ifndef xywh_library_xgui_del_treelist
		Type xywh_TreeList Extends xywh_CommCtrl
			Declare Constructor(ByVal IcnSize As Integer)
			Declare Function NodeCount(ByVal NodePtr As HTREEITEM) As Integer
			Declare Function NodeAppend(ByVal Parent As HTREEITEM,ByVal Caption As ZString Ptr,ByVal Param As Integer=0,ByVal ImageID As Integer=0,ByVal SelImageID As Integer=0) As HTREEITEM
			Declare Function NodeInsert() As HTREEITEM
			Declare Function NodeClear() As Integer
			Declare Function NodeRemove(ByVal NodePtr As HTREEITEM) As Integer
			Declare Function NodeData(ByVal NodePtr As HTREEITEM) As TV_ITEM
			Declare Function NodeChange(ByVal TI As TV_ITEM Ptr) As Integer
			Declare Function NodeExpand(ByVal NodePtr As HTREEITEM,ByVal IsExpand As Integer) As HTREEITEM
			Declare Function NodeLevel(ByVal NodePtr As HTREEITEM) As Integer
			Declare Function NodeNext(ByVal NodePtr As HTREEITEM) As HTREEITEM
			Declare Function HitTestEx(ByVal PointX As Integer,ByVal PointY As Integer,ByVal Flag As Integer) As HTREEITEM
			Declare Function HitTest(ByVal Flag As Integer) As HTREEITEM
			Declare Property NodeIndex(ByVal NewValue As HTREEITEM)
			Declare Property NodeIndex As HTREEITEM
		End Type
		
		Constructor xywh_TreeList(ByVal IcnSize As Integer)
			IconSize = IcnSize
			ImageList = ImageList_Create(IcnSize,IcnSize,ILC_MASK Or ILC_COLOR32,0,0)
		End Constructor
		
		Function xywh_TreeList.NodeCount(ByVal NodePtr As HTREEITEM) As Integer
			Dim Count As Integer
			Dim Child As HANDLE = Cast(HANDLE,TreeView_GetNextItem(hWnd,NodePtr,TVGN_CHILD))
			While Child
				Count += 1
				Child = Cast(HANDLE,TreeView_GetNextItem(hWnd,Child,TVGN_NEXT))
			Wend
			Return Count
		End Function
		
		Function xywh_TreeList.NodeAppend(ByVal Parent As HTREEITEM,ByVal Caption As ZString Ptr,ByVal Param As Integer=0,ByVal ImageID As Integer=0,ByVal SelImageID As Integer=0) As HTREEITEM
			Dim TI As TV_INSERTSTRUCT
			TI.hInsertAfter = TVI_LAST
			TI.item.mask = TVIF_TEXT Or TVIF_IMAGE Or TVIF_SELECTEDIMAGE Or TVIF_PARAM
			TI.hParent = Parent
			TI.item.pszText = Caption
			TI.item.iImage = ImageID
			TI.item.iSelectedImage = SelImageID
			TI.item.lParam = Param
			Return Cast(HTREEITEM,SendMessage(hWnd,TVM_INSERTITEM,0,Cast(LPARAM,@TI)))
		End Function
		
		Function NodeInsert() As HTREEITEM
			Return NULL
		End Function
		
		Function xywh_TreeList.NodeClear() As Integer
			Return SendMessage(hWnd,TVM_DELETEITEM,0,Cast(LPARAM,TVI_ROOT))
		End Function
		
		Function xywh_TreeList.NodeRemove(ByVal NodePtr As HTREEITEM) As Integer
			Return SendMessage(hWnd,TVM_DELETEITEM,0,Cast(LPARAM,NodePtr))
		End Function
		
		Function xywh_TreeList.NodeData(ByVal NodePtr As HTREEITEM) As TV_ITEM
			Dim TI As TV_ITEM
			TI.hItem = NodePtr
			TI.mask  = TVIF_TEXT Or TVIF_IMAGE Or TVIF_PARAM Or TVIF_STATE Or TVIF_HANDLE Or TVIF_SELECTEDIMAGE Or TVIF_CHILDREN
			TreeView_GetItem(hWnd,@TI)
			Return TI
		End Function
		
		Function xywh_TreeList.NodeChange(ByVal TI As TV_ITEM Ptr) As Integer
			Return TreeView_SetItem(hWnd,TI)
		End Function
		
		Function xywh_TreeList.NodeExpand(ByVal NodePtr As HTREEITEM,ByVal IsExpand As Integer) As HTREEITEM
			Return Cast(HTREEITEM,TreeView_Expand(hWnd,NodePtr,IIf(IsExpand,TVE_EXPAND,TVE_COLLAPSE)))
		End Function
		
		Function xywh_TreeList.NodeLevel(ByVal NodePtr As HTREEITEM) As Integer
			Dim As Integer Root,Level
			Root = Cast(Integer,TreeView_GetRoot(hWnd))
			While ((NodePtr <> Root) And (NodePtr <> 0))
				Level += 1
				NodePtr = TreeView_GetNextItem(hWnd,NodePtr,TVGN_PARENT)
			Wend
			Return Level
		End Function
		
		Function xywh_TreeList.NodeNext(ByVal NodePtr As HTREEITEM) As HTREEITEM
			Dim As HTREEITEM ParentID,Result
			Result = TreeView_GetChild(hWnd,NodePtr)
			If Result = NULL Then
				Result = TreeView_GetNextSibling(hWnd,NodePtr)
			EndIf
			ParentID = NodePtr
			While ((Result = NULL) And (ParentID <> NULL))
				ParentID = TreeView_GetParent(hWnd,ParentID)
				Result = TreeView_GetNextSibling(hWnd,ParentID)
			Wend
			Return Result
		End Function
		
		Function xywh_TreeList.HitTestEx(ByVal PointX As Integer,ByVal PointY As Integer,ByVal Flag As Integer) As HTREEITEM
			Dim ht As TVHITTESTINFO
			ht.pt.x = PointX
			ht.pt.y = PointY
			ht.flags = Flag
			Return TreeView_HitTest(hWnd,Cast(Any Ptr,@ht))
		End Function
		
		Function xywh_TreeList.HitTest(ByVal Flag As Integer) As HTREEITEM
			Dim pt As Point
			GetCursorPos(@pt)
			ScreenToClient(hWnd,@pt)
			Return HitTestEx(pt.x,pt.y,Flag)
		End Function
		
		Property xywh_TreeList.NodeIndex(ByVal NewValue As HTREEITEM)
			TreeView_SelectItem(hWnd,NewValue)
		End Property
		
		Property xywh_TreeList.NodeIndex As HTREEITEM
			Return TreeView_GetSelection(hWnd)
		End Property
	#EndIf
#EndIf





' WebBrowser �ؼ�
#Ifdef xywh_library_xgui_use_webbrowser
	#Inclib "FBEWeb"
	Declare Function CreateClass(ByVal hModule As HMODULE,ByVal fGlobal As Boolean) As Integer
	Dim Shared xywh_library_xgui_regweb As Integer
	#Define WBM_NAVIGATE	WM_USER+1
	#Define WBM_GOBACK		WM_USER+2
	#Define WBM_GOFORWARD	WM_USER+3
	
	Type xywh_WebBrowser Extends xywh_Control
		Declare Constructor()
		Declare Sub Navigate(ByVal URL As ZString Ptr)
		Declare Sub GoBack()
		Declare Sub GoForware()
	End Type
	
	Constructor xywh_WebBrowser()
		If xywh_library_xgui_regweb=0 Then
			CreateClass(GetModuleHandle(NULL),FALSE)
			xywh_library_xgui_regweb = -1
		EndIf
	End Constructor
	
	Sub xywh_WebBrowser.Navigate(ByVal URL As ZString Ptr)
		SendMessage(hWnd,WBM_NAVIGATE,0,Cast(Integer,URL))
	End Sub
	
	Sub xywh_WebBrowser.GoBack()
		SendMessage(hWnd,WBM_GOBACK,0,0)
	End Sub
	
	Sub xywh_WebBrowser.GoForware()
		SendMessage(hWnd,WBM_GOFORWARD,0,0)
	End Sub
#EndIf





' SpreadSheet �ؼ�
#Ifdef xywh_library_xgui_use_spreadsheet
	' SpreadSheet �ؼ����岿��[��Ϣ]
	Const SPRM_SPLITTHOR				= WM_USER+100		'�ڵ�ǰ�д���ˮƽ�ָ�� [wParam=0,lParam=0]
	Const SPRM_SPLITTVER				= WM_USER+101		'�ڵ�ǰ�д�����ֱ�ָ�� [wParam=0,lParam=0]
	Const SPRM_SPLITTCLOSE			= WM_USER+102		'�رյ�ǰ�еķָ�� [wParam=0,lParam=0]
	Const SPRM_SPLITTSYNC				= WM_USER+103		'[?]ͬ��һ���ָ�ڵĸ� [wParam=0,lParam=TRUE/FALSE]
	Const SPRM_GETSPLITTSTATE		= WM_USER+104		'[?]ȡ�÷ָ�״̬ [wParam=nWin(0-7),if nWin=-1 active split window,lParam=0]
	Const SPRM_GETCELLRECT			= WM_USER+105		'ȡ�õ�ǰ��Ԫ������ڻ�ָ� [wParam=0,lParam=pointer to RECT struct. Returns handle of active splitt window.]
	Const SPRM_GETLOCKCOL				= WM_USER+106		'��ȡ�������ڻ�ָ�� [wParam=0,lParam=0]
	Const SPRM_SETLOCKCOL				= WM_USER+107		'�������ڻ�ָ�� [wParam=0,lParam=cols]
	Const SPRM_GETLOCKROW				= WM_USER+108		'��ȡ�������ڻ�ָ�� [wParam=0,lParam=0]
	Const SPRM_SETLOCKROW				= WM_USER+109		'�������ڻ�ָ�� [wParam=0,lParam=rows]
	Const SPRM_DELETECOL				= WM_USER+110		'ɾ���� [wParam=col,lParam=0]
	Const SPRM_INSERTCOL				= WM_USER+111		'������ [wParam=col,lParam=0]
	Const SPRM_DELETEROW				= WM_USER+112		'ɾ���� [wParam=row,lParam=0]
	Const SPRM_INSERTROW				= WM_USER+113		'������ [wParam=row,lParam=0]
	Const SPRM_GETCOLCOUNT			= WM_USER+114		'��ȡ���� [wParam=0,lParam=0]
	Const SPRM_SETCOLCOUNT			= WM_USER+115		'�������� [wParam=nCols,lParam=0]
	Const SPRM_GETROWCOUNT			= WM_USER+116		'��ȡ���� [wParam=0,lParam=0]
	Const SPRM_SETROWCOUNT			= WM_USER+117		'�������� [wParam=nRows,lParam=0]
	Const SPRM_RECALC						= WM_USER+118		'���¼���� [wParam=0,lParam=0]
	Const SPRM_BLANKCELL				= WM_USER+119		'��յ�Ԫ������ [wParam=col,lParam=row]
	Const SPRM_GETCURRENTWIN		= WM_USER+120		'ȡ�û�ķָ�� [wParam=0,lParam=0]
	Const SPRM_SETCURRENTWIN		= WM_USER+121		'���û�ķָ�� [wParam=0, lParam=nWin (0-7)]
	Const SPRM_GETCURRENTCELL		= WM_USER+122		'ȡ�õ�ǰ��/���ڻ�ָ�� [wParam=0,lParam=0. Returns Hiword=row, Loword=col]
	Const SPRM_SETCURRENTCELL		= WM_USER+123		'���õ�ǰ��/���ڻ�ָ�� [wParam=col,lParam=row]
	Const SPRM_GETCELLSTRING		= WM_USER+124		'ȡ�õ�ǰ��Ԫ������ [wParam=0,lParam=0. Returns a pointer to a null terminated string.]
	Const SPRM_SETCELLSTRING		= WM_USER+125		'���õ�ǰ��Ԫ������ [wParam=type,lParam=pointer to string.]
	Const SPRM_GETCOLWIDT		  	= WM_USER+126		'��ȡ�еĿ�� [wParam=col,lParam=0. Returns column width.]
	Const SPRM_SETCOLWIDT		  	= WM_USER+127		'�����еĿ�� [wParam=col,lParam=width.]
	Const SPRM_GETROWHEIGHT		 	= WM_USER+128		'ȡ���еĸ߶� [wParam=row,lParam=0. Returns row height.]
	Const SPRM_SETROWHEIGHT		 	= WM_USER+129		'�����еĸ߶� [wParam=row, lParam=height.]
	Const SPRM_GETCELLDATA			= WM_USER+130		'��ȡ��Ԫ������ [wParam=0, lParam=Pointer to SPR_ITEM struct]
	Const SPRM_SETCELLDATA			= WM_USER+131		'���õ�Ԫ������ [wParam=0, lParam=Pointer to SPR_ITEM struct]
	Const SPRM_GETMULTISEL			= WM_USER+132		'��ȡ��ѡ [wParam=0, lParam=pointer to a RECT struct. Returns handle of active split window]
	Const SPRM_SETMULTISEL			= WM_USER+133		'���ö�ѡ [wParam=0, lParam=pointer to a RECT struct. Returns handle of active split window]
	Const SPRM_GETFONT					= WM_USER+134		'��ȡ���� [wParam=index(0-15), lParam=pointer to FONT struct. Returns font handle]
	Const SPRM_SETFONT					= WM_USER+135		'�������� [wParam=index(0-15), lParam=pointer to FONT struct. Returns font handle]
	Const SPRM_GETGLOBAL				= WM_USER+136		'��ȡȫ�ֱ��� [wParam=0, lParam=pointer to GLOBAL struct.]
	Const SPRM_SETGLOBAL				= WM_USER+137		'����ȫ�ֱ��� [wParam=0, lParam=pointer to GLOBAL struct.]
	Const SPRM_IMPORTLINE				= WM_USER+138		'����һ������ [wParam=SepChar, lParam=pointer to data line.]
	Const SPRM_LOADFILE					= WM_USER+139		'�����ļ� [wParam=0, lParam=pointer to filename]
	Const SPRM_SAVEFILE					= WM_USER+140		'�����ļ� [wParam=0, lParam=pointer to filename]
	Const SPRM_NEWSHEET			  	= WM_USER+141		'������ [wParam=0, lParam=0]
	Const SPRM_EXPANDCELL				= WM_USER+142		'�ϲ���Ԫ�� [wParam=0, lParam=pointer to RECT struct]
	Const SPRM_GETCELLTYPE			= WM_USER+143		'ȡ�õ�Ԫ���������� [wParam=col, lParam=row. Returns cell type.]
	Const SPRM_ADJUSTCELLREF		= WM_USER+144		'������Ԫ�����ù�ʽ [wParam=pointer to cell, lParam=pointer to RECT.]
	Const SPRM_CREATECOMBO			= WM_USER+145		'����һ��������Ͽ� [wPatam=0, lParam=0]
	Const SPRM_SCROLLCELL				= WM_USER+146		'������ͼ����ǰ��Ԫ�� [wPatam=0, lParam=0]
	Const SPRM_DELETECELL				= WM_USER+147		'ɾ��һ����Ԫ�� [wParam=col, lParam=row]
	Const SPRM_GETDATEFORMAT		= WM_USER+148		'���ظ�ʽ��������� [wParam=0, lParam=0]
	Const SPRM_SETDATEFORMAT		= WM_USER+149		'���ø�ʽ���ı����������� [wParam=0, lParam=lpDateFormat (yyyy-MM-dd)]
	' SpreadSheet �ؼ����岿��[���]
	Const SPS_VSCROLL			  		= &h0001				'��ֱ������
	Const SPS_HSCROLL			  		= &h0002				'ˮƽ������
	Const SPS_STATUS			  		= &h0004				'��ʾ״̬����
	Const SPS_GRIDLINES			  	= &h0008				'��ʾ�������
	Const SPS_ROWSELECT			  	= &h0010				'����ѡ��
	Const SPS_CELLEDIT			  	= &h0020				'��Ԫ��༭
	Const SPS_GRIDMODE			  	= &h0040				'���ģʽ[�������� ����/ɾ�� �к���]
	Const SPS_COLSIZE			  		= &h0080				'����ʹ���������п�
	Const SPS_ROWSIZE		      	= &h0100				'����ʹ���������и�
	Const SPS_WINSIZE			  		= &h0200				'����ʹ���������ָ�ڴ�С
	Const SPS_MULTISELECT		  	= &h0400				'�������ѡ��
	' SpreadSheet �ؼ����岿��[��Ԫ����������]
	Const TPE_EMPTY							= &h000					'��Ԫ��ֻ������ʽ������[Ĭ���Զ���������]
	Const TPE_COLHDR						= &h001					'�б���
	Const TPE_ROWHDR						= &h002					'�б���
	Const TPE_WINHDR						= &h003					'�ָ�ھ��
	Const TPE_TEXT							= &h004					'�ı�
	Const TPE_TEXTMULTILINE			= &h005					'�����ı�
	Const TPE_INTEGER						= &h006					'Integer
	Const TPE_FLOAT							= &h007					'80λ������
	Const TPE_FORMULA						= &h008					'��ʽ
	Const TPE_GRAP							= &h009					'ͼ��
	Const TPE_HYPERLINK					= &h00A					'������
	Const TPE_CHECKBOX					= &h00B					'��ѡ��
	Const TPE_COMBOBOX					= &h00C					'���������
	Const TPE_OWNERDRAWBLOB			= &h00D					'Owner drawn blob, first word is lenght of blob
	Const TPE_OWNERDRAWINTEGER	= &h00E					'Owner drawn integer
	Const TPE_EXPANDED					= &h00F					'������չ��Ԫ[�ڲ�ʹ��]
	Const TPE_BUTTON						= &h010					'С��ť[����β]
	Const TPE_WIDEBUTTON				= &h020					'��ť[ռ����]
	Const TPE_DATE							= &h030					'����
	Const TPE_FORCETYPE					= &h040					'ǿ������
	Const TPE_FIXEDSIZE					= &h080					'�̶���С�� ��ѡ��/������Ͽ�/��ť/ͼ��
	' SpreadSheet �ؼ����岿��[��ʽ/����/С��]
	Const FMTA_AUTO							= &h000					'Text left middle, numbers right middle
	Const FMTA_LEFT							= &h010
	Const FMTA_CENTER						= &h020
	Const FMTA_RIGHT						= &h030
	Const FMTA_TOP							= &h000
	Const FMTA_MIDDLE						= &h040
	Const FMTA_BOTTOM						= &h080
	Const FMTA_GLOBAL						= &h0F0
	Const FMTA_MASK							= &h0F0					'Alignment mask
	Const FMTA_XMASK						= &h030					'Alignment x-mask
	Const FMTA_YMASK						= &h0C0					'Alignment y-mask
	Const FMTD_0								= &h00
	Const FMTD_1								= &h01
	Const FMTD_2								= &h02
	Const FMTD_3								= &h03
	Const FMTD_4								= &h04
	Const FMTD_5								= &h05
	Const FMTD_6								= &h06
	Const FMTD_7								= &h07
	Const FMTD_8								= &h08
	Const FMTD_9								= &h09
	Const FMTD_10								= &h0A
	Const FMTD_11								= &h0B
	Const FMTD_12								= &h0C
	Const FMTD_ALL							= &h0D
	Const FMTD_SCI							= &h0E
	Const FMTD_GLOBAL						= &h0F
	Const FMTD_MASK							= &h0F
	Type FORMAT
		bckcol			As Integer										'������ɫ
		txtcol			As Integer										'�ı���ɫ
		txtal				As Byte												'�ı�����/С��
		imgal				As Byte												'ͼ������� imagelist �ؼ�ͼ��ID
		fnt					As Byte												'����ID[0-15]
		tpe					As Byte												'��Ԫ��
	End Type
	Type GLOBAL
		colhdrbtn		As Integer
		rowhdrbtn		As Integer
		winhdrbtn		As Integer
		lockcol			As Integer										'������Ԫ��ı���ɫ
		hdrgrdcol		As Integer										'��ͷ����ɫ
		grdcol			As Integer										'��Ԫ����ɫ
		bcknfcol		As Integer										'���Ԫ��ı�����ɫ[ʧȥ����ʱ]
		txtnfcol		As Integer										'���Ԫ����ı���ɫ[ʧȥ����ʱ]
		bckfocol		As Integer										'���Ԫ��ı�����ɫ[��ȡ����ʱ]
		txtfocol		As Integer										'���Ԫ����ı���ɫ[��ȡ����ʱ]
		ncols				As Integer
		nrows				As Integer
		ghdrwt			As Integer
		ghdrht			As Integer
		gcellwt			As Integer
		gcellht			As Integer
		colhdr			As FORMAT											'�б����ʽ
		rowhdr			As FORMAT 										'�б����ʽ
		winhdr			As FORMAT											'�ָ�ڱ����ʽ
		cell				As FORMAT											'��Ԫ���ʽ
	End Type
	Type FONT
		hfont				As Integer										'������
		face				As ZString*LF_FACESIZE				'Face name
		fsize				As Integer										'Point size
		ht					As Integer										'�߶�
		bold				As Byte												'�Ӵ�
		italic			As Byte												'��б
		underline		As Byte												'�»���
		strikeout		As Byte												'ɾ����
	End Type
	Const STATE_LOCKED				= &h001						'Cell is locked for editing
	Const STATE_HIDDEN				= &h002						'Cell content is not displayed
	Const STATE_REDRAW				= &h008
	Const STATE_ERROR					= &h010
	Const STATE_DIV0					= &h020
	Const STATE_UNDERFLOW			= &h030
	Const STATE_OVERFLOW			= &h040
	Const STATE_RECALC				= &h080
	Const STATE_ERRMASK				= &h0F0
	Const SPRIF_BACKCOLOR			= &h00000001			'������ɫ��Ч
	Const SPRIF_TEXTCOLOR			= &h00000002			'�ı���ɫ��Ч
	Const SPRIF_TEXTALIGN			= &h00000004
	Const SPRIF_IMAGEALIGN		= &h00000008
	Const SPRIF_FONT					= &h00000010
	Const SPRIF_STATE					= &h00000020
	Const SPRIF_TYPE					= &h00000040
	Const SPRIF_WIDTH					= &h00000080
	Const SPRIF_HEIGHT				= &h00000100
	Const SPRIF_DATA					= &h00000200
	Const SPRIF_DOUBLE				= &h00000400			'Converts to / from double
	Const SPRIF_SINGLE				= &h00000800			'Converts to / from single
	Const SPRIF_COMPILE				= &h80000000			'Compile the formula
	Type SPR_ITEM
		flag				As Integer
		col					As Integer
		row					As Integer
		expx				As Byte												'Expanded columns
		expy				As Byte												'Expanded rows
		state				As Byte
		fmt					As FORMAT
		wt					As Integer
		ht					As Integer
		lpdta				As Any ptr
	End Type
	' SpreadSheet �ؼ����岿��[WM_NOTIFY��Ϣ֪ͨ]
	Const SPRN_SELCHANGE				= 1							'ѡ�����/�б��ı�[�ָ��]
	Const SPRN_BEFOREEDIT				= 2							'���뵽�༭��ģʽ
	Const SPRN_AFTEREDIT				= 3							'�༭��ģʽ���
	Const SPRN_BEFOREUPDATE			= 4							'��Ԫ����¿�ʼ
	Const SPRN_AFTERUPDATE			= 5							'��Ԫ��������
	Const SPRN_HYPERLINKENTER		= 6							'Hyperlink entered
	Const SPRN_HYPERLINKLEAVE		= 7							'Hyperlink leaved
	Const SPRN_HYPERLINKCLICK		= 8							'�����ӱ����
	Const SPRN_BUTTONCLICK			= 9							'��ť�����
	' SpreadSheet �ؼ����岿��[�ṹ�嶨��]
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
	
	Type xywh_Grid Extends xywh_Control
		BackColor As Integer
		TextColor As Integer
		TextAlign As Integer
		TextFont As Integer
		Declare Constructor()
		Declare Property ColCount(ByVal NewValue As Integer)
		Declare Property ColCount As Integer
		Declare Property RowCount(ByVal NewValue As Integer)
		Declare Property RowCount As Integer
		Declare Function SetCellEx(ByVal Col As Integer,ByVal Row As Integer,ByVal Text As ZString Ptr,ByVal FontID As Integer,ByVal Tpe As Integer,ByVal TextAlign As Integer,ByVal BackColor As Integer,ByVal TextColor As Integer) As Integer
		Declare Function SetCell(ByVal Col As Integer,ByVal Row As Integer,ByVal Text As ZString Ptr) As Integer
		Declare Function GetCellEx(ByVal Col As Integer,ByVal Row As Integer,ByVal Flag As Integer) As SPR_ITEM Ptr
		Declare Function GetCell(ByVal Col As Integer,ByVal Row As Integer) As ZString Ptr
		Declare Sub SetCellLock(ByVal Col As Integer,ByVal Row As Integer)
		Declare Sub SetCellType(ByVal Col As Integer,ByVal Row As Integer,ByVal NewValue As Byte)
		Declare Function AppendColEx(ByVal Text As ZString Ptr,ByVal ColWidth As Integer,ByVal FontID As Integer,ByVal Align As Integer,ByVal TxtColor As Integer) As Integer
		Declare Function AppendCol(ByVal Text As ZString Ptr) As Integer
		Declare Function InsertColEx(ByVal Text As ZString Ptr) As Integer
		Declare Function InsertCol(ByVal Text As ZString Ptr) As Integer
		Declare Function AppendRowEx(ByVal Text As ZString Ptr) As Integer
		Declare Function AppendRow(ByVal Text As ZString Ptr) As Integer
		Declare Function InsertRowEx(ByVal Text As ZString Ptr) As Integer
		Declare Function InsertRow(ByVal Text As ZString Ptr) As Integer
		Declare Function SetFont(ByVal FontID As Integer,Byval FontName as ZString Ptr,Byval FontSize as Integer,Byval Bold As Integer,ByVal Italic As Integer) As Integer
		Declare Property CurCol(ByVal NewValue As Integer)				'����:��ǰѡ����
		Declare Property CurCol As Integer
		Declare Property CurRow(ByVal NewValue As Integer)				'����:��ǰѡ����
		Declare Property CurRow As Integer
		Declare Function DeleteRow(ByVal Row As Integer) As Integer
	End Type
	
	Constructor xywh_Grid()
		BackColor = &HFFFFFF
		TextColor = &H000000
		TextAlign = FMTA_CENTER Or FMTA_MIDDLE
		SetFont(0,"����",9,0,0)
	End Constructor
	
	Property xywh_Grid.ColCount(ByVal NewValue As Integer)
		SendMessage(hWnd,SPRM_SETCOLCOUNT,NewValue,0)
	End Property
	
	Property xywh_Grid.ColCount As Integer
		Return SendMessage(hWnd,SPRM_GETCOLCOUNT,0,0)
	End Property
	
	Property xywh_Grid.RowCount(ByVal NewValue As Integer)
		SendMessage(hWnd,SPRM_SETROWCOUNT,NewValue,0)
	End Property
	
	Property xywh_Grid.RowCount As Integer
		Return SendMessage(hWnd,SPRM_GETROWCOUNT,0,0)
	End Property
	
	Function xywh_Grid.SetCellEx(ByVal Col As Integer,ByVal Row As Integer,ByVal Text As ZString Ptr,ByVal FontID As Integer,ByVal Tpe As Integer,ByVal Align As Integer,ByVal BkColor As Integer,ByVal TxtColor As Integer) As Integer
		Dim Item As SPR_ITEM
		Item.col = Col
		Item.row = Row
		Item.fmt.bckcol = BkColor
		Item.fmt.txtcol = TxtColor
		Item.fmt.txtal = Align
		Item.fmt.fnt = FontID
		Item.fmt.tpe = Tpe
		Item.lpdta = Text
		Item.flag = SPRIF_DATA Or SPRIF_TEXTALIGN Or SPRIF_FONT Or SPRIF_TEXTCOLOR Or SPRIF_BACKCOLOR Or SPRIF_TYPE
		Return SendMessage(hWnd,SPRM_SETCELLDATA,0,Cast(LPARAM,@Item))
	End Function
	
	Function xywh_Grid.SetCell(ByVal Col As Integer,ByVal Row As Integer,ByVal Text As ZString Ptr) As Integer
		Return SetCellEx(Col,Row,Text,TextFont,TPE_TEXT,TextAlign,BackColor,TextColor)
	End Function
	
	Function xywh_Grid.GetCellEx(ByVal Col As Integer,ByVal Row As Integer,ByVal Flag As Integer) As SPR_ITEM Ptr
		Dim Item As SPR_ITEM
		Item.col = Col
		Item.row = Row
		Item.flag = Flag
		SendMessage(hWnd,SPRM_GETCELLDATA,0,Cast(LPARAM,@Item))
		Return @Item
	End Function
	
	Function xywh_Grid.GetCell(ByVal Col As Integer,ByVal Row As Integer) As ZString Ptr
		Dim Item As SPR_ITEM
		Item.col = Col
		Item.row = Row
		Item.flag = SPRIF_DATA
		SendMessage(hWnd,SPRM_GETCELLDATA,0,Cast(LPARAM,@Item))
		Return Item.lpdta
	End Function
	
	Sub xywh_Grid.SetCellLock(ByVal Col As Integer,ByVal Row As Integer)
		Dim Item As SPR_ITEM
		Item.col = Col
		Item.row = Row
		Item.flag = SPRIF_STATE
		SendMessage(hWnd,SPRM_GETCELLDATA,0,Cast(LPARAM,@Item))
		Item.state = Item.state Or STATE_LOCKED
		SendMessage(hWnd,SPRM_SETCELLDATA,0,Cast(LPARAM,@Item))
	End Sub
	
	Sub xywh_Grid.SetCellType(ByVal Col As Integer,ByVal Row As Integer,ByVal NewValue As Byte)
		Dim Item As SPR_ITEM
		Item.col = Col
		Item.row = Row
		Item.fmt.tpe = NewValue
		Item.flag = SPRIF_TYPE
		SendMessage(hWnd,SPRM_SETCELLDATA,0,Cast(LPARAM,@Item))
	End Sub
	
	Function xywh_Grid.AppendColEx(ByVal Text As ZString Ptr,ByVal ColWidth As Integer,ByVal FontID As Integer,ByVal Align As Integer,ByVal TxtColor As Integer) As Integer
		ColCount = ColCount + 1
		Dim Item As SPR_ITEM
		Item.col = ColCount
		Item.row = 0
		Item.fmt.txtcol = TxtColor
		Item.fmt.txtal = Align
		Item.fmt.fnt = FontID
		Item.lpdta = Text
		Item.wt = ColWidth
		Item.flag = SPRIF_DATA Or SPRIF_TEXTALIGN Or SPRIF_FONT Or SPRIF_TEXTCOLOR Or SPRIF_WIDTH
		Return SendMessage(hWnd,SPRM_SETCELLDATA,0,Cast(LPARAM,@Item))
	End Function
	
	Function xywh_Grid.AppendCol(ByVal Text As ZString Ptr) As Integer
		ColCount = ColCount + 1
		Return SetCell(ColCount,0,Text)
	End Function
	
	Function xywh_Grid.AppendRowEx(ByVal Text As ZString Ptr) As Integer
		Return -1
	End Function
	
	Function xywh_Grid.AppendRow(ByVal Text As ZString Ptr) As Integer
		Return -1
	End Function
	
	Function xywh_Grid.SetFont(ByVal FontID As Integer,Byval FontName as ZString Ptr,Byval FontSize as Integer,Byval Bold As Integer,ByVal Italic As Integer) As Integer
		Dim Fnt As FONT
		Fnt.face = *FontName
		Fnt.ht = MulDiv(FontSize,GetDeviceCaps(GetDC(NULL),LOGPIXELSY),72)
		Fnt.bold = Bold
		Fnt.italic = Italic
		Return SendMessage(hWnd,SPRM_SETFONT,FontID,Cast(Integer,@Fnt))
	End Function
	
	Property xywh_Grid.CurCol(ByVal NewValue As Integer)
		SendMessage(hWnd,SPRM_SETCURRENTCELL,NewValue,CurRow)
	End Property
	
	Property xywh_Grid.CurCol As Integer
		Return LoWord(SendMessage(hWnd,SPRM_GETCURRENTCELL,0,0))
	End Property
	
	Property xywh_Grid.CurRow(ByVal NewValue As Integer)
		SendMessage(hWnd,SPRM_SETCURRENTCELL,CurCol,NewValue)
	End Property
	
	Property xywh_Grid.CurRow As Integer
		Return HiWord(SendMessage(hWnd,SPRM_GETCURRENTCELL,0,0))
	End Property
	
	Function xywh_Grid.DeleteRow(ByVal Row As Integer) As Integer
		Return SendMessage(hWnd,SPRM_DELETEROW,Row,0)
	End Function
#EndIf