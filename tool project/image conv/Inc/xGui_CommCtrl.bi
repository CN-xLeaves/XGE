


#Ifndef xywh_library_xui_cctl
	#Define xywh_library_xui_cctl
	
	
	
	Namespace xGui
		
		
		
		' ͼ���б���
		Type xImageList
			' �չ���
			Declare Constructor()
			
			' ����
			Declare Constructor(w As Integer, h As Integer, flag As Integer = ILC_COLOR32 Or ILC_MASK, cInit As Integer = 0)
			
			' ����
			Declare Destructor()
			
			' ����
			Declare Function Create(w As Integer, h As Integer, flag As Integer = ILC_COLOR32 Or ILC_MASK, cInit As Integer = 0) As HANDLE
			
			' ����
			Declare Sub Destroy()
			
			' ����
			Declare Property Count() As UInteger
			Declare Property Count(nval As UInteger)
			
			' ͼ���б���
			Declare Property hImageList() As HANDLE
			Declare Property hImageList(nval As HANDLE)
			
			' ����ɫ
			Declare Property BackColor() As Integer
			Declare Property BackColor(nval As Integer)
			
			' ���
			Declare Property ImageWidth() As Integer
			Declare Property ImageWidth(nval As Integer)
			
			' �߶�
			Declare Property ImageHeight() As Integer
			Declare Property ImageHeight(nval As Integer)
			
			' ��С
			Declare Function GetSize(w As Integer Ptr, h As Integer Ptr) As Integer
			Declare Sub SetSize(w As Integer, h As Integer)
			
			' ���ͼ��
			Declare Function AddIcon(hico As HICON) As Integer
			Declare Function AddIcon(ires As Integer, hInst As HINSTANCE = NULL) As Integer
			Declare Function AddIcon(file As ZString Ptr) As Integer
			
			' ���ͼƬ
			Declare Function AddImage(hbmp As HBITMAP, cMask As Integer) As Integer
			Declare Function AddImage(ires As Integer, cMask As Integer, hInst As HINSTANCE = NULL) As Integer
			Declare Function AddImage(file As ZString Ptr, cMask As Integer) As Integer
			
			' �滻
			Declare Function Replace(idx As Integer, hico As HICON) As Integer
			Declare Function Replace(idx As Integer, ImgBmp As HBITMAP, MaskBmp As HBITMAP) As Integer
			
			' ɾ��
			Declare Function Remove(idx As Integer) As Integer
			
			' ����
			Declare Function Draw(idx As Integer, dst As HDC, x As Integer, y As Integer, stl As Integer = ILD_TRANSPARENT) As Integer
			Declare Function DrawEx(idx As Integer, dst As HDC, x As Integer, y As Integer, dx As Integer, dy As Integer, stl As Integer = ILD_TRANSPARENT) As Integer
			
			' ��ȡͼ��
			Declare Function GetIcon(idx As Integer) As HICON
			
			' ��ȡͼ����Ϣ
			Declare Function GetInfo(idx As Integer) As ImageInfo
			
			' ��
			Declare Function Bind(hWin As HANDLE, idx As Integer = 0) As Integer
			Declare Function UnBind(hWin As HANDLE) As Integer
			
			' ���б�
			Declare Property BindList As xGui.xHandleList Ptr
			Declare Property BindList(NewValue As xGui.xHandleList Ptr)
			
			' �������õ��󶨵Ŀؼ��� [�޸ĺ���Ҫʹ��]
			Declare Sub ReSetup()
			
			' ˽�б���
			Private:
				Dim h_ImgList As HANDLE
				Dim i_Width As Integer
				Dim i_Height As Integer
				Dim p_List As xGui.xHandleList Ptr
				Dim b_list As Integer
		End Type
		
		
		
		' ��������
		Type xProgressBar Extends xControl
			' ��Χ
			Declare Function GetRange(pMin As Integer Ptr, pMax As Integer Ptr) As Integer
			Declare Function SetRange(iMin As Integer, iMax As Integer) As Integer
			
			' ���ֵ
			Declare Property MaxValue() As Integer
			Declare Property MaxValue(ival As Integer)
			
			' ��Сֵ
			Declare Property MinValue() As Integer
			Declare Property MinValue(ival As Integer)
			
			' ��ǰֵ
			Declare Property Value() As Integer
			Declare Property Value(ival As Integer)
			
			' ��������
			Declare Sub SetStep(ival As Integer)
			Declare Sub IncStep()
			Declare Sub IncValue(ival As Integer)
			
			' ���� [��ֱ��ˮƽ]
			Declare Property Orientation() As Integer
			Declare Property Orientation(nval As Integer)
			
			' ��������
			Declare Property Smooth() As Integer
			Declare Property Smooth(nval As Integer)
			
			' ѭ������
			Declare Property Marquee() As Integer
			Declare Property Marquee(nval As Integer)
			
			' ��ʼѭ������
			Declare Function SetMarquee(isopen As Integer, ms As Integer) As Integer
		End Type
		
		
		
		' ������
		Type xTrackBar Extends xControl
			' ���ֵ
			Declare Property MaxValue() As Integer
			Declare Property MaxValue(ival As Integer)
			
			' ��Сֵ
			Declare Property MinValue() As Integer
			Declare Property MinValue(ival As Integer)
			
			' ��ǰֵ
			Declare Property Value() As Integer
			Declare Property Value(ival As Integer)
			
			' �̶ȼ��
			Declare Property TickFreuqency(ival As UInteger)
			
			' С���ƶ�����
			Declare Property SmallChange() As Integer
			Declare Property SmallChange(ival As Integer)
			
			' ����ƶ�����
			Declare Property LargeChange() As Integer
			Declare Property LargeChange(ival As Integer)
			
			' �Ƿ�����ѡ��
			Declare Property SelectRange() As Integer
			Declare Property SelectRange(ival As Integer)
			
			' ѡ����Χ
			Declare Sub GetSelRange(pMin As Integer Ptr, pMax As Integer Ptr)
			Declare Sub SetSelRange(iMin As Integer, iMax As Integer)
			
			' ���ѡ��
			Declare Sub ClearSel()
			
			' ѡ����ʼ
			Declare Property SelStart() As Integer
			Declare Property SelStart(ival As Integer)
			
			' ѡ������
			Declare Property SelEnd() As Integer
			Declare Property SelEnd(ival As Integer)
			
			' ѡ������
			Declare Property SelLength() As Integer
			Declare Property SelLength(ival As Integer)
			
			' ���� [��ֱ��ˮƽ]
			Declare Property Orientation() As Integer
			Declare Property Orientation(nval As Integer)
		End Type
		
		
		
		' ѡ���
		Type xTabStrip Extends xControl
			' ͼ���б�
			ImageList As xGui.xImageList Ptr
			
			' ���ѡ�
			Declare Function Insert(sTitle As ZString Ptr, nIndex As Integer = -1, nImage As UInteger = 0, nParam As Integer = 0) As Integer
			
			' �Ƴ�ѡ�
			Declare Function Remove(nIndex As Integer) As Integer
			Declare Sub Clear()
			
			' ��������
			Declare Property Caption(nIndex As Integer, nVal As ZString Ptr)
			Declare Property Caption(nIndex As Integer) As ZString Ptr
			
			' ������������
			Declare Property Param(nIndex As Integer, nVal As Integer)
			Declare Property Param(nIndex As Integer) As Integer
			
			' ͼ������
			Declare Property Image(nIndex As Integer, nVal As Integer)
			Declare Property Image(nIndex As Integer) As Integer
			
			' ѡ����
			Declare Property TabIndex(nVal As UInteger)
			Declare Property TabIndex() As Integer
			
			' ������
			Declare Property TabFocus(nVal As UInteger)
			Declare Property TabFocus() As Integer
			
			' ѡ�����
			Declare Property TabCount() As Integer
			
			' �ͻ�����Χ
			Declare Property ClientLeft() As Integer
			Declare Property ClientTop() As Integer
			Declare Property ClientRight() As Integer
			Declare Property ClientBottom() As Integer
			Declare Property ClientHeight() As Integer
			Declare Property ClientWidth() As Integer
			Declare Property ClientRect() As RECT Ptr
			
			' ѡ��̶���ȡ��߶�
			Declare Function TabFixedSize(w As Integer, h As Integer) As Integer
			Declare Property TabMinWidth(nVal As UInteger)
			Declare Property TabHeight(nIndex As Integer) As UInteger
			Declare Property TabWidth(nIndex As Integer) As UInteger
			Declare Sub SetPadding(w As Integer, h As Integer)
			
			' �Ƿ��������
			Declare Property MultiRow(nVal As Integer)
			Declare Property MultiRow() As Integer
			
			' �Ƿ�̶����
			Declare Property TabFixed(nVal As Integer)
			Declare Property TabFixed() As Integer
			
			' ѡ���ť���
			Declare Property TabStyle(nVal As Integer)
			Declare Property TabStyle() As Integer
			
			' ѡ�����������
			Declare Property TabFull(nVal As Integer)
			Declare Property TabFull() As Integer
			
			' ѡ����� [������ʱ��Ч]
			Declare Property RowCount() As Integer
			
			' ����ĳ��
			Declare Sub TabHighLight(nIndex As Integer, hl As Integer)
		End Type
	End Namespace
#EndIf
