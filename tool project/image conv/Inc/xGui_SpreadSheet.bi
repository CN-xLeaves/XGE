


#Ifndef xywh_library_xui_grid
	#Define xywh_library_xui_grid
	
	
	
	' SpreadSheet �ؼ����岿��[��Ϣ]
	Const SPRM_SPLITTHOR		= WM_USER+100			' �ڵ�ǰ�д���ˮƽ�ָ�� [wParam=0,lParam=0]
	Const SPRM_SPLITTVER		= WM_USER+101			' �ڵ�ǰ�д�����ֱ�ָ�� [wParam=0,lParam=0]
	Const SPRM_SPLITTCLOSE		= WM_USER+102			' �رյ�ǰ�еķָ�� [wParam=0,lParam=0]
	Const SPRM_SPLITTSYNC		= WM_USER+103			' [?]ͬ��һ���ָ�ڵĸ� [wParam=0,lParam=TRUE/FALSE]
	Const SPRM_GETSPLITTSTATE	= WM_USER+104			' [?]ȡ�÷ָ�״̬ [wParam=nWin(0-7),if nWin=-1 active split window,lParam=0]
	Const SPRM_GETCELLRECT		= WM_USER+105			' ȡ�õ�ǰ��Ԫ������ڻ�ָ� [wParam=0,lParam=pointer to RECT struct. Returns handle of active splitt window.]
	Const SPRM_GETLOCKCOL		= WM_USER+106			' ��ȡ�������ڻ�ָ�� [wParam=0,lParam=0]
	Const SPRM_SETLOCKCOL		= WM_USER+107			' �������ڻ�ָ�� [wParam=0,lParam=cols]
	Const SPRM_GETLOCKROW		= WM_USER+108			' ��ȡ�������ڻ�ָ�� [wParam=0,lParam=0]
	Const SPRM_SETLOCKROW		= WM_USER+109			' �������ڻ�ָ�� [wParam=0,lParam=rows]
	Const SPRM_DELETECOL		= WM_USER+110			' ɾ���� [wParam=col,lParam=0]
	Const SPRM_INSERTCOL		= WM_USER+111			' ������ [wParam=col,lParam=0]
	Const SPRM_DELETEROW		= WM_USER+112			' ɾ���� [wParam=row,lParam=0]
	Const SPRM_INSERTROW		= WM_USER+113			' ������ [wParam=row,lParam=0]
	Const SPRM_GETCOLCOUNT		= WM_USER+114			' ��ȡ���� [wParam=0,lParam=0]
	Const SPRM_SETCOLCOUNT		= WM_USER+115			' �������� [wParam=nCols,lParam=0]
	Const SPRM_GETROWCOUNT		= WM_USER+116			' ��ȡ���� [wParam=0,lParam=0]
	Const SPRM_SETROWCOUNT		= WM_USER+117			' �������� [wParam=nRows,lParam=0]
	Const SPRM_RECALC			= WM_USER+118			' ���¼���� [wParam=0,lParam=0]
	Const SPRM_BLANKCELL		= WM_USER+119			' ��յ�Ԫ������ [wParam=col,lParam=row]
	Const SPRM_GETCURRENTWIN	= WM_USER+120			' ȡ�û�ķָ�� [wParam=0,lParam=0]
	Const SPRM_SETCURRENTWIN	= WM_USER+121			' ���û�ķָ�� [wParam=0, lParam=nWin (0-7)]
	Const SPRM_GETCURRENTCELL	= WM_USER+122			' ȡ�õ�ǰ��/���ڻ�ָ�� [wParam=0,lParam=0. Returns Hiword=row, Loword=col]
	Const SPRM_SETCURRENTCELL	= WM_USER+123			' ���õ�ǰ��/���ڻ�ָ�� [wParam=col,lParam=row]
	Const SPRM_GETCELLSTRING	= WM_USER+124			' ȡ�õ�ǰ��Ԫ������ [wParam=0,lParam=0. Returns a pointer to a null terminated string.]
	Const SPRM_SETCELLSTRING	= WM_USER+125			' ���õ�ǰ��Ԫ������ [wParam=type,lParam=pointer to string.]
	Const SPRM_GETCOLWIDT		= WM_USER+126			' ��ȡ�еĿ�� [wParam=col,lParam=0. Returns column width.]
	Const SPRM_SETCOLWIDT		= WM_USER+127			' �����еĿ�� [wParam=col,lParam=width.]
	Const SPRM_GETROWHEIGHT		= WM_USER+128			' ȡ���еĸ߶� [wParam=row,lParam=0. Returns row height.]
	Const SPRM_SETROWHEIGHT	 	= WM_USER+129			' �����еĸ߶� [wParam=row, lParam=height.]
	Const SPRM_GETCELLDATA		= WM_USER+130			' ��ȡ��Ԫ������ [wParam=0, lParam=Pointer to SPR_ITEM struct]
	Const SPRM_SETCELLDATA		= WM_USER+131			' ���õ�Ԫ������ [wParam=0, lParam=Pointer to SPR_ITEM struct]
	Const SPRM_GETMULTISEL		= WM_USER+132			' ��ȡ��ѡ [wParam=0, lParam=pointer to a RECT struct. Returns handle of active split window]
	Const SPRM_SETMULTISEL		= WM_USER+133			' ���ö�ѡ [wParam=0, lParam=pointer to a RECT struct. Returns handle of active split window]
	Const SPRM_GETFONT			= WM_USER+134			' ��ȡ���� [wParam=index(0-15), lParam=pointer to FONT struct. Returns font handle]
	Const SPRM_SETFONT			= WM_USER+135			' �������� [wParam=index(0-15), lParam=pointer to FONT struct. Returns font handle]
	Const SPRM_GETGLOBAL		= WM_USER+136			' ��ȡȫ�ֱ��� [wParam=0, lParam=pointer to GLOBAL struct.]
	Const SPRM_SETGLOBAL		= WM_USER+137			' ����ȫ�ֱ��� [wParam=0, lParam=pointer to GLOBAL struct.]
	Const SPRM_IMPORTLINE		= WM_USER+138			' ����һ������ [wParam=SepChar, lParam=pointer to data line.]
	Const SPRM_LOADFILE			= WM_USER+139			' �����ļ� [wParam=0, lParam=pointer to filename]
	Const SPRM_SAVEFILE			= WM_USER+140			' �����ļ� [wParam=0, lParam=pointer to filename]
	Const SPRM_NEWSHEET			= WM_USER+141			' ������ [wParam=0, lParam=0]
	Const SPRM_EXPANDCELL		= WM_USER+142			' �ϲ���Ԫ�� [wParam=0, lParam=pointer to RECT struct]
	Const SPRM_GETCELLTYPE		= WM_USER+143			' ȡ�õ�Ԫ���������� [wParam=col, lParam=row. Returns cell type.]
	Const SPRM_ADJUSTCELLREF	= WM_USER+144			' ������Ԫ�����ù�ʽ [wParam=pointer to cell, lParam=pointer to RECT.]
	Const SPRM_CREATECOMBO		= WM_USER+145			' ����һ��������Ͽ� [wPatam=0, lParam=0]
	Const SPRM_SCROLLCELL		= WM_USER+146			' ������ͼ����ǰ��Ԫ�� [wPatam=0, lParam=0]
	Const SPRM_DELETECELL		= WM_USER+147			' ɾ��һ����Ԫ�� [wParam=col, lParam=row]
	Const SPRM_GETDATEFORMAT	= WM_USER+148			' ���ظ�ʽ��������� [wParam=0, lParam=0]
	Const SPRM_SETDATEFORMAT	= WM_USER+149			' ���ø�ʽ���ı����������� [wParam=0, lParam=lpDateFormat (yyyy-MM-dd)]
	
	' SpreadSheet �ؼ����岿��[���]
	Const SPS_VSCROLL			= &h0001				' ��ֱ������
	Const SPS_HSCROLL			= &h0002				' ˮƽ������
	Const SPS_STATUS			= &h0004				' ��ʾ״̬����
	Const SPS_GRIDLINES			= &h0008				' ��ʾ�������
	Const SPS_ROWSELECT			= &h0010				' ����ѡ��
	Const SPS_CELLEDIT			= &h0020				' ��Ԫ��༭
	Const SPS_GRIDMODE			= &h0040				' ���ģʽ [�������� ����/ɾ�� �к���]
	Const SPS_COLSIZE			= &h0080				' ����ʹ���������п�
	Const SPS_ROWSIZE		    = &h0100				' ����ʹ���������и�
	Const SPS_WINSIZE			= &h0200				' ����ʹ���������ָ�ڴ�С
	Const SPS_MULTISELECT		= &h0400				' �������ѡ��
	
	' SpreadSheet �ؼ����岿�� [��Ԫ����������]
	Const TPE_EMPTY				= &h000					' ��Ԫ��ֻ������ʽ������[Ĭ���Զ���������]
	Const TPE_COLHDR			= &h001					' �б���
	Const TPE_ROWHDR			= &h002					' �б���
	Const TPE_WINHDR			= &h003					' �ָ�ھ��
	Const TPE_TEXT				= &h004					' �ı�
	Const TPE_TEXTMULTILINE		= &h005					' �����ı�
	Const TPE_INTEGER			= &h006					' Integer
	Const TPE_FLOAT				= &h007					' 80λ������
	Const TPE_FORMULA			= &h008					' ��ʽ
	Const TPE_GRAP				= &h009					' ͼ��
	Const TPE_HYPERLINK			= &h00A					' ������
	Const TPE_CHECKBOX			= &h00B					' ��ѡ��
	Const TPE_COMBOBOX			= &h00C					' ���������
	Const TPE_OWNERDRAWBLOB		= &h00D					' Owner drawn blob, first word is lenght of blob
	Const TPE_OWNERDRAWINTEGER	= &h00E					' Owner drawn integer
	Const TPE_EXPANDED			= &h00F					' ������չ��Ԫ [�ڲ�ʹ��]
	Const TPE_BUTTON			= &h010					' С��ť [����β]
	Const TPE_WIDEBUTTON		= &h020					' ��ť [ռ����]
	Const TPE_DATE				= &h030					' ����
	Const TPE_FORCETYPE			= &h040					' ǿ������
	Const TPE_FIXEDSIZE			= &h080					' �̶���С�� ��ѡ��/������Ͽ�/��ť/ͼ��
	
	' SpreadSheet �ؼ����岿��[��ʽ/����/С��]
	Const FMTA_AUTO				= &h000					' �Զ� [�ı����ж��룬�������ж���]
	Const FMTA_LEFT				= &h010					' ������
	Const FMTA_CENTER			= &h020					' ���ж���
	Const FMTA_RIGHT			= &h030					' �Ҳ����
	Const FMTA_TOP				= &h000					' ���˶���
	Const FMTA_MIDDLE			= &h040					' ������ж���
	Const FMTA_BOTTOM			= &h080					' �׶˶���
	Const FMTA_GLOBAL			= &h0F0
	Const FMTA_MASK				= &h0F0					' ��������
	Const FMTA_XMASK			= &h030					' �����������
	Const FMTA_YMASK			= &h0C0					' �����������
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
	
	' ��Ԫ���ʽ�ṹ��
	Type FORMAT
		bckcol		As Integer							' ������ɫ
		txtcol		As Integer							' �ı���ɫ
		txtal		As Byte								' �ı�����/С��
		imgal		As Byte								' ͼ������� imagelist �ؼ�ͼ��ID
		fnt			As Byte								' ����ID[0-15]
		tpe			As Byte								' ��Ԫ������
	End Type
	
	' ȫ�����ýṹ��
	Type SPS_GLOBAL
		colhdrbtn	As Integer
		rowhdrbtn	As Integer
		winhdrbtn	As Integer
		lockcol		As Integer							' ������Ԫ��ı���ɫ
		hdrgrdcol	As Integer							' ��ͷ����ɫ
		grdcol		As Integer							' ��Ԫ����ɫ
		bcknfcol	As Integer							' ���Ԫ��ı�����ɫ[ʧȥ����ʱ]
		txtnfcol	As Integer							' ���Ԫ����ı���ɫ[ʧȥ����ʱ]
		bckfocol	As Integer							' ���Ԫ��ı�����ɫ[��ȡ����ʱ]
		txtfocol	As Integer							' ���Ԫ����ı���ɫ[��ȡ����ʱ]
		ncols		As Integer
		nrows		As Integer
		ghdrwt		As Integer
		ghdrht		As Integer
		gcellwt		As Integer
		gcellht		As Integer
		colhdr		As FORMAT							' �б����ʽ
		rowhdr		As FORMAT 							' �б����ʽ
		winhdr		As FORMAT							' �ָ�ڱ����ʽ
		cell		As FORMAT							' ��Ԫ���ʽ
	End Type
	
	' ����ṹ��
	Type SPS_FONT
		hfont		As HANDLE							' ������
		face		As ZString * LF_FACESIZE			' ������
		fsize		As Integer							' �����С
		ht			As Integer							' �߶�
		bold		As Byte								' �Ӵ�
		italic		As Byte								' ��б
		underline	As Byte								' �»���
		strikeout	As Byte								' ɾ����
	End Type
	
	' ��Ԫ��״̬����
	Const STATE_LOCKED		= &h001						' ��Ԫ������ [���ܱ༭]
	Const STATE_HIDDEN		= &h002						' ��Ԫ���������� [����ʾ]
	Const STATE_REDRAW		= &h008
	Const STATE_ERROR		= &h010
	Const STATE_DIV0		= &h020
	Const STATE_UNDERFLOW	= &h030
	Const STATE_OVERFLOW	= &h040
	Const STATE_RECALC		= &h080
	Const STATE_ERRMASK		= &h0F0
	
	' ��Ԫ���ȡ���޸� ����λ���
	Const SPRIF_BACKCOLOR	= &h00000001				' ������ɫ��Ч
	Const SPRIF_TEXTCOLOR	= &h00000002				' �ı���ɫ��Ч
	Const SPRIF_TEXTALIGN	= &h00000004				' ��Ԫ���ʽ��Ч
	Const SPRIF_IMAGEALIGN	= &h00000008				' ͼ����Ч
	Const SPRIF_FONT		= &h00000010				' ������Ч
	Const SPRIF_STATE		= &h00000020				' ״̬��Ч
	Const SPRIF_TYPE		= &h00000040				' ������Ч
	Const SPRIF_WIDTH		= &h00000080				' �����Ч
	Const SPRIF_HEIGHT		= &h00000100				' �߶���Ч
	Const SPRIF_DATA		= &h00000200				' ����������Ч
	Const SPRIF_DOUBLE		= &h00000400				' �� Double ת��
	Const SPRIF_SINGLE		= &h00000800				' �� Single ת��
	Const SPRIF_COMPILE		= &h80000000				' ���빫ʽ
	#Define SPRIF_ALL		SPRIF_BACKCOLOR Or SPRIF_TEXTCOLOR Or SPRIF_TEXTALIGN Or SPRIF_IMAGEALIGN Or SPRIF_FONT Or SPRIF_STATE Or SPRIF_TYPE Or SPRIF_WIDTH Or SPRIF_HEIGHT Or SPRIF_DATA
	
	' ��Ԫ��ṹ��
	Type SPR_ITEM
		flag	As Integer
		col		As Integer
		row		As Integer
		expx	As Byte									' ��չ�� (cols)
		expy	As Byte									' ��չ�� (rows)
		state	As Byte									' ״̬
		fmt		As FORMAT								' ��Ԫ���ʽ
		wt		As Integer
		ht		As Integer
		lpdta	As ZString ptr							' ���⡢����
	End Type
	
	' SpreadSheet �ؼ����岿��[WM_NOTIFY��Ϣ֪ͨ]
	Const SPRN_SELCHANGE		= 1						' ѡ�����/�б��ı�[�ָ��]
	Const SPRN_BEFOREEDIT		= 2						' ���뵽�༭��ģʽ
	Const SPRN_AFTEREDIT		= 3						' �༭��ģʽ���
	Const SPRN_BEFOREUPDATE		= 4						' ��Ԫ����¿�ʼ
	Const SPRN_AFTERUPDATE		= 5						' ��Ԫ��������
	Const SPRN_HYPERLINKENTER	= 6						' ������������
	Const SPRN_HYPERLINKLEAVE	= 7						' ����������뿪
	Const SPRN_HYPERLINKCLICK	= 8						' �����ӱ����
	Const SPRN_BUTTONCLICK		= 9						' ��ť�����
	
	' SpreadSheet �ؼ����岿��[��Ϣ�ṹ�嶨��]
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
		
		
		
		' ���ӱ����
		Type xGrid Extends xControl
			
			' ����
			Declare Property ColCount(nVal As Integer)
			Declare Property ColCount() As Integer
			
			' ����
			Declare Property RowCount(nVal As Integer)
			Declare Property RowCount() As Integer
			
			' ������
			Declare Sub InsertRow(row As Integer = -1)
			
			' ɾ����
			Declare Sub DeleteRow(row As Integer)
			
			' ������
			Declare Sub InsertCol(col As Integer = -1)
			
			' ɾ����
			Declare Sub DeleteCol(col As Integer)
			
			' �п��
			Declare Property ColWidth(nIndex As UInteger, nVal As UInteger)
			Declare Property ColWidth(nIndex As UInteger) As Integer
			
			' �и߶�
			Declare Property RowHeight(nIndex As UInteger, nVal As UInteger)
			Declare Property RowHeight(nIndex As UInteger) As Integer
			
			' ��д�޸ĵ�Ԫ����
			Declare Sub SetCell(row As Integer, col As Integer, sText As ZString Ptr, iAlgin As Integer = -1, iFont As Integer = -1, bColor As Integer = -1, tColor As Integer = -1, iType As Integer = -1, iLock As Integer = 0)
			
			' ��Ԫ������ [�����ṹ��]
			Declare Sub Cell(row As Integer, col As Integer, nVal As SPR_ITEM Ptr)
			Declare Function Cell(row As Integer, col As Integer, flag As Integer = SPRIF_ALL) As SPR_ITEM Ptr
			
			' ��Ԫ����������
			Declare Sub CellType(row As Integer, col As Integer, nVal As Integer)
			Declare Function CellType(row As Integer, col As Integer) As Integer
			
			' ��Ԫ������ [�ı�]
			Declare Sub CellText(row As Integer, col As Integer, nVal As ZString Ptr)
			Declare Function CellText(row As Integer, col As Integer) As ZString Ptr
			
			' ��Ԫ�񱳾���ɫ
			Declare Sub CellBackColor(row As Integer, col As Integer, nVal As Integer)
			Declare Function CellBackColor(row As Integer, col As Integer) As Integer
			
			' ��Ԫ��������ɫ
			Declare Sub CellTextColor(row As Integer, col As Integer, nVal As Integer)
			Declare Function CellTextColor(row As Integer, col As Integer) As Integer
			
			' ��Ԫ�����ֶ��뷽ʽ
			Declare Sub CellTextAlign(row As Integer, col As Integer, nVal As Integer)
			Declare Function CellTextAlign(row As Integer, col As Integer) As Integer
			
			' ��Ԫ��ͼƬ���뷽ʽ
			Declare Sub CellImageAlign(row As Integer, col As Integer, nVal As Integer)
			Declare Function CellImageAlign(row As Integer, col As Integer) As Integer
			
			' ��Ԫ��������
			Declare Sub CellFont(row As Integer, col As Integer, nVal As Integer)
			Declare Function CellFont(row As Integer, col As Integer) As Integer
			
			' ��Ԫ�������༭״̬
			Declare Sub CellLock(row As Integer, col As Integer, nVal As Integer)
			Declare Function CellLock(row As Integer, col As Integer) As Integer
			
			' ��Ԫ����������״̬
			Declare Sub CellHide(row As Integer, col As Integer, nVal As Integer)
			Declare Function CellHide(row As Integer, col As Integer) As Integer
			
			' ��ȡ��ѡ��Ԫ������
			Declare Property CurCellText(nVal As ZString Ptr)
			Declare Property CurCellText() As ZString Ptr
			
			' ��յ�Ԫ������
			Declare Sub ClearCell(row As Integer, col As Integer)
			
			' ɾ����Ԫ��
			Declare Sub DeleteCell(row As Integer, col As Integer)
			
			' �ϲ���Ԫ��
			Declare Sub ExpandCell(pRect As RECT Ptr)
			Declare Sub ExpandCell(sRow As Integer, eRow As Integer, sCol As Integer, eCol As Integer)
			
			' ѡ����
			Declare Property CurRow(nVal As Integer)
			Declare Property CurRow() As Integer
			
			' ѡ����
			Declare Property CurCol(nVal As Integer)
			Declare Property CurCol() As Integer
			
			' ѡ��Ԫ��
			Declare Sub GetCurCell(row As Integer Ptr, col As Integer Ptr)
			Declare Sub SetCurCell(row As Integer, col As Integer)
			
			' ѡ��Χ
			Declare Property SelectRect(nVal As RECT Ptr)
			Declare Property SelectRect() As RECT Ptr
			
			' ������ͼ����ǰ��Ԫ��
			Declare Sub ScrollCell()
			
			' ����
			Declare Property Fonts(nIndex As UInteger, nVal As SPS_FONT Ptr)
			Declare Property Fonts(nIndex As UInteger) As SPS_FONT Ptr
			
			' ȫ��ѡ��
			Declare Property GlobalOption(nVal As SPS_GLOBAL Ptr)
			Declare Property GlobalOption() As SPS_GLOBAL Ptr
			
			' ���浽�ļ�
			Declare Sub SaveFile(sPath As ZString Ptr)
			
			' ���ļ�����
			Declare Sub LoadFile(sPath As ZString Ptr)
			
			' ��ձ��
			Declare Sub Clear()
			
			' ���¼��㹫ʽ
			Declare Sub ReCalc()
		End Type
		
		' ���ӱ�����
		Type xSpreadSheet As xGrid
	End Namespace
#EndIf
