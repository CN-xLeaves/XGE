'==================================================================================
	'�� xywh Point Font �����ֿ�
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================

#Include Once "Inc\SDK\File.bi"



#Define xywh_library_xpft



Type xywhPointFont_Hdr Field = 1
	FileHead As ZString * 4						' �ļ�ͷ [xpf]
	FileFlag As UShort								' �ļ���־ [1=��ASC�ֿ� , 2=��GB�ֿ� , 4=ASC��GB�ȿ� , 8=ʹ��ѹ�� , 16/32/64/128=������չ�ֿ����ҳ]
	FontWidth As UByte								' ������
	FontHeight As UByte								' ����߶�
	AddrASC As UInteger								' ASC��������ƫ��
	AddrGB As UInteger								' GB��������ƫ��
	CodePage(3) As UByte							' ��չ�ֿ����ҳ
	AddrCPS(3) As UInteger						' ��չ�ֿ�����ƫ��
	TagInfo As Integer								' ��������
End Type



Enum xpf_Align
	Hori_Left = 0				' �������
	Hori_Center = 1			' �������
	Hori_Right = 2			' �������
	Hori_Full = 3				' �������
	Vert_Top = 0				' �������
	Vert_Center = 4			' �������
	Vert_Down = 8				' �������
	Vert_Full = 12			' �������
End Enum



Type ANSIZK12
	BitData(11) As UByte
End Type
Type GBZK12
	BitData(11) As UShort
End Type
Type ANSIZK16
	BitData(15) As UByte
End Type
Type GBZK16
	BitData(15) As UShort
End Type



Type xywhPointFont Extends Object
	' [�в�����] ���������ļ�
	Declare Function LoadFont(ByVal FontFile As ZString Ptr) As Integer
	' [����ͨ��] ��������
	Declare Function MakeCache(ByVal TextColor As UInteger) As Integer
	' [����ͨ��] ��ӡ�ַ���[�߼�]
	Declare Sub DrawTextEx(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal DrawLen As Integer,ByVal px As Integer,ByVal py As Integer,ByVal zj As Integer,ByVal hj As Integer)
	' [����ͨ��] ��ӡ�ַ���
	Declare Sub DrawText(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal px As Integer,ByVal py As Integer)
	' [�в�����] ��һ�����������ʽ����ӡ�ַ��� [�����ı���ʽ���ݲ�֧��]
	Declare Sub DrawTextRect(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal zj As Integer,ByVal hj As Integer,ByVal DrawRect As RECT,ByVal Align As xpf_Align)
	' [����ͨ��] ��̬����
	Declare Virtual Sub PSetTextEx(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal DrawLen As Integer,ByVal px As Integer,ByVal py As Integer,ByVal zj As Integer,ByVal hj As Integer,ByVal TextColor As Integer)
	Declare Virtual Sub PSetText(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal px As Integer,ByVal py As Integer,ByVal TextColor As UInteger)
	Declare Virtual Sub PSetTextRect(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal zj As Integer,ByVal hj As Integer,ByVal DrawRect As RECT,ByVal Align As xpf_Align,ByVal TextColor As UInteger)
	' [����ͨ��] ��ӡ��������
	Declare Sub PrintText(ByVal Surface As Any Ptr,ByVal HiCode As UByte,ByVal LoCode As UByte,ByVal px As Integer,ByVal py As Integer,ByVal TextColor As UInteger)
	' [����ͨ��] ��ȡһ���ַ�����������
	Declare Function GetWordCount(ByVal Text As ZString Ptr) As Integer
	' [����ͨ��] ��ȡ����һ���ַ�������Ŀ��
	Declare Function GetTextWidthEx(ByVal Text As ZString Ptr,ByVal zj As Integer) As Integer
	Declare Function GetTextWidth(ByVal Text As ZString Ptr) As Integer
	' [����ͨ��] ��ȡ����һ���ַ�������ĸ߶�
	Declare Function GetTextHeightEx(ByVal Text As ZString Ptr,ByVal hj As Integer) As Integer
	Declare Function GetTextHeight(ByVal Text As ZString Ptr) As Integer
	' [����ͨ��] ��ȡ����һ���ַ�������ľ���
	Declare Sub GetTextRectEx(ByVal Text As ZString Ptr,ByVal lpRect As RECT Ptr,ByVal zj As Integer,ByVal hj As Integer)
	Declare Sub GetTextRect(ByVal Text As ZString Ptr,ByVal lpRect As RECT Ptr)
	' [����ͨ��] �ͷ���Դ
	Declare Sub FreeData()
	Declare Sub FreeCache()
	' [����ͨ��] ת������ͼ��
	Declare Sub DumpCache()
	Declare Destructor()
	Protected:
		Head As xywhPointFont_Hdr			' �ļ���Ϣͷ
		AscPtr As Any Ptr							' ASC�ֿ�����ָ��
		GbPtr As Any Ptr							' GB�ֿ�����ָ��
		GBWidth As Integer						' GB�ֿ��
		ASCWidth As Integer						' ASC�ֿ��
		FontHeight As Integer					' �ָ߶�
		AscLen As Integer							' Asc�ַ�һ��ռ�ö����ڴ�
		GbLen As Integer							' GB�ַ�һ��ռ�ö����ڴ�
		AscCache As Any Ptr						' ASC�ֿ⻺��
		GbCache As Any ptr						' GB�ֿ⻺��
End Type

Type xywhPointFont_Fast12 Extends xywhPointFont
	Declare Sub PSetTextEx(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal DrawLen As Integer,ByVal px As Integer,ByVal py As Integer,ByVal zj As Integer,ByVal hj As Integer,ByVal TextColor As Integer)
	Declare Sub PSetText(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal px As Integer,ByVal py As Integer,ByVal TextColor As UInteger)
End Type

Type xywhPointFont_Fast16 Extends xywhPointFont
	Declare Sub PSetTextEx(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal DrawLen As Integer,ByVal px As Integer,ByVal py As Integer,ByVal zj As Integer,ByVal hj As Integer,ByVal TextColor As Integer)
	Declare Sub PSetText(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal px As Integer,ByVal py As Integer,ByVal TextColor As UInteger)
End Type



Function xywhPointFont.LoadFont(ByVal FontFile As ZString Ptr) As Integer
	Dim FileHdr As HANDLE = Open_File(FontFile)
	Get_File(FileHdr,@Head,0,SizeOf(xywhPointFont_Hdr))
	If Head.FileHead = "xpf" Then
		' ����������
		GBWidth = Head.FontWidth
		FontHeight = Head.FontHeight
		' ASC��GB�ȿ�
		If Head.FileFlag And 4 Then
			ASCWidth = Head.FontWidth
		Else
			ASCWidth = Head.FontWidth \ 2
		EndIf
		' �����ַ�ռ�ö����ڴ�
		AscLen = ((ASCWidth+7)\8)*FontHeight
		GbLen = ((GBWidth+7)\8)*FontHeight
		' ���ֿ����ݵ��ڴ�
		If Head.FileFlag And 1 Then
			Dim AscSize As Integer = AscLen*128
			AscPtr = Allocate(AscSize)
			Get_File(FileHdr,AscPtr,Head.AddrASC,AscSize)
		EndIf
		If Head.FileFlag And 2 Then
			Dim GbSize As Integer = GbLen*8178
			GbPtr = Allocate(GbSize)
			Get_File(FileHdr,GbPtr,Head.AddrGB,GbSize)
		EndIf
		CloseHandle(FileHdr)
		Return -1
	EndIf
End Function

Sub xywhPointFont.DumpCache()
	BSave(ExePath & "\asc.bmp",AscCache)
	BSave(ExePath & "\gb.bmp",GbCache)
End Sub

Sub xywhPointFont.PrintText(ByVal Surface As Any Ptr,ByVal HiCode As UByte,ByVal LoCode As UByte,ByVal px As Integer,ByVal py As Integer,ByVal TextColor As UInteger)
	Dim BW As Integer
	If HiCode Then
		BW = GbLen \ FontHeight
		Dim tb As UByte Ptr = Allocate(GbLen)
		tb = GbPtr + (((HiCode-&HA1)*&H5E)+(LoCode-&HA1))*GbLen
		/' ר���㷨
		Dim zk As GBZK12 Ptr
		zk = GbPtr + (((HiCode-&HA1)*&H5E)+(LoCode-&HA1))*GbLen
		'/
		Dim As Integer x,y
		For y = 0 To FontHeight-1
			For x = 0 To GbWidth-1
				/'
				ͨ���㷨10�����ܲ��Խ����
					0.125151
					0.133294
					0.135221
					0.129087
					0.134331
					0.128994
					0.127871
					0.128903
					0.127615
					0.133457
				ƽ��ִ�д���GB�ֿ⻺������ʱ�� 0.1303924 ��
				���ܶԱ��½� 7.81%
				'/
				If tb[(y*BW)+(x\8)] And (1 Shl (x And 7)) Then
					If Surface Then
						PSet Surface,(px+x,py+y),TextColor
					Else
						PSet (px+x,py+y),TextColor
					EndIf
				EndIf
				/'
				ר���㷨10�����ܲ��Խ����
					0.125226
					0.130846
					0.120821
					0.113233
					0.118263
					0.121746
					0.122822
					0.125088
					0.116723
					0.114656
				ƽ��ִ�д���GB�ֿ⻺������ʱ�� 0.1209424 ��
				'/
				/' ר���㷨
				If zk->BitData(y) And (1 Shl x) Then
					If Surface Then
						PSet Surface,(px+x,py+y),TextColor
					Else
						PSet (px+x,py+y),TextColor
					EndIf
				EndIf
				'/
			Next
		Next
	Else
		BW = AscLen \ FontHeight
		Dim tb As UByte Ptr = Allocate(AscLen)
		tb = AscPtr + (LoCode*AscLen)
		Dim As Integer x,y
		For y = 0 To FontHeight-1
			For x = 0 To AscWidth-1
				If tb[(y*BW)+(x\8)] And (1 Shl (x And 7)) Then
					If Surface Then
						PSet Surface,(px+x,py+y),TextColor
					Else
						PSet (px+x,py+y),TextColor
					EndIf
				EndIf
			Next
		Next
	EndIf
End Sub

Sub xywhPointFont.DrawTextEx(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal DrawLen As Integer,ByVal px As Integer,ByVal py As Integer,ByVal zj As Integer,ByVal hj As Integer)
	Dim As Integer i,x,y,z,hi,lo,sx
	Dim AscStu As ANSIZK12 Ptr
	Dim GbStu As GBZK12 Ptr
	Dim Text As UByte Ptr
	If DrawLen=NULL Then
		DrawLen = strlen(DrawStr)
	EndIf
	sx = px
	Text = DrawStr
	For i = 0 To DrawLen-1
		If Text[i]<128 Then				' С��128��ASC
			Select Case Text[i]
				Case 10
					px = sx
					py += FontHeight + hj
				Case 13
					
				Case Else
					If Surface Then
						Put Surface,(px,py),AscCache,(Text[i]*AscWidth,0)-Step(AscWidth-1,FontHeight-1),Trans
					Else
						Put (px,py),AscCache,(Text[i]*AscWidth,0)-Step(AscWidth-1,FontHeight-1),Trans
					EndIf
					px += ASCWidth + zj
			End Select
		Else											' ���ھ���GB
			hi = Text[i]
			lo = Text[i+1]
			i+=1
			If Surface Then
				Put Surface,(px,py),GbCache,((lo-&HA1)*GbWidth,(hi-&HA1)*FontHeight)-Step(GbWidth-1,FontHeight-1),Trans
			Else
				Put (px,py),GbCache,((lo-&HA1)*GbWidth,(hi-&HA1)*FontHeight)-Step(GbWidth-1,FontHeight-1),Trans
			EndIf
			px += GBWidth + zj
		EndIf
	Next
End Sub

Sub xywhPointFont.DrawText(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal px As Integer,ByVal py As Integer)
	DrawTextEx(Surface,DrawStr,NULL,px,py,0,0)
End Sub

Function xywhPointFont.MakeCache(ByVal TextColor As UInteger) As Integer
	' ����ASC�ֿ⻺��
	AscCache = ImageCreate(AscWidth*128,FontHeight)
	If AscCache Then
		Dim i As Integer
		For i = 0 To 127
			PrintText(AscCache,0,i,i*AscWidth,0,TextColor)
		Next
		GbCache = ImageCreate(94*GbWidth,87*FontHeight)
		If GbCache Then
			Dim As Integer x,y
			For y = &HA1 To &HF7		'87
				For x = &HA1 To &HFE	'94
					PrintText(GbCache,y,x,(x-&HA1)*GbWidth,(y-&HA1)*FontHeight,TextColor)
				Next
			Next
			Return -1
		EndIf
	EndIf
End Function

Sub xywhPointFont.DrawTextRect(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal zj As Integer,ByVal hj As Integer,ByVal DrawRect As RECT,ByVal Align As xpf_Align)
	Dim OldRect As RECT
	GetTextRectEx(DrawStr,@OldRect,zj,hj)
	Dim Hori As Integer = Align And 3
	Dim Vert As Integer = Align And 12
	Dim TempSurface As Any Ptr = ImageCreate(DrawRect.right-DrawRect.left,DrawRect.bottom-DrawRect.top)
	Dim As Integer px,py
	Select Case Hori
		Case 0			' �������
			px = 0
		Case 1			' �������
			px = ((DrawRect.right - DrawRect.left) - OldRect.right) \ 2
		Case 2			' �������
			px = (DrawRect.right - DrawRect.left) - OldRect.right
		Case 3			' �������
			px = 0
			zj = ((DrawRect.right - DrawRect.left) - OldRect.right) \ (GetWordCount(DrawStr)-1)
	End Select
	Select Case Vert
		Case 0			' �������
			py = 0
		Case 4			' �������
			py = ((DrawRect.bottom - DrawRect.top) - OldRect.bottom) \ 2
		Case 8			' �������
			py = (DrawRect.bottom - DrawRect.top) - OldRect.bottom
		Case 12			' �������[�ݲ�֧��]
			
	End Select
	DrawTextEx(TempSurface,DrawStr,NULL,px,py,zj,hj)
	If Surface Then
		Put Surface,(DrawRect.left,DrawRect.top),TempSurface,Trans
	Else
		Put (DrawRect.left,DrawRect.top),TempSurface,Trans
	EndIf
	ImageDestroy(TempSurface)
End Sub

Sub xywhPointFont.PSetTextEx(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal DrawLen As Integer,ByVal px As Integer,ByVal py As Integer,ByVal zj As Integer,ByVal hj As Integer,ByVal TextColor As Integer)
	Dim As Integer i,x,y,z,sx
	Dim AscStu As ANSIZK12 Ptr
	Dim GbStu As GBZK12 Ptr
	Dim Text As UByte Ptr
	If DrawLen=NULL Then
		DrawLen = strlen(DrawStr)
	EndIf
	sx = px
	Text = DrawStr
	For i = 0 To DrawLen-1
		If Text[i]<128 Then				' С��128��ASC
			Select Case Text[i]
				Case 10
					px = sx
					py += FontHeight + hj
				Case 13
					
				Case Else
					PrintText(Surface,0,Text[i],px,py,TextColor)
					px += ASCWidth + zj
			End Select
		Else											' ���ھ���GB
			PrintText(Surface,Text[i],Text[i+1],px,py,TextColor)
			i+=1
			px += GBWidth + zj
		EndIf
	Next
End Sub

Sub xywhPointFont.PSetText(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal px As Integer,ByVal py As Integer,ByVal TextColor As UInteger)
	PSetTextEx(Surface,DrawStr,NULL,px,py,0,0,TextColor)
End Sub

Sub xywhPointFont.PSetTextRect(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal zj As Integer,ByVal hj As Integer,ByVal DrawRect As RECT,ByVal Align As xpf_Align,ByVal TextColor As UInteger)
	Dim OldRect As RECT
	GetTextRectEx(DrawStr,@OldRect,zj,hj)
	Dim Hori As Integer = Align And 3
	Dim Vert As Integer = Align And 12
	Dim TempSurface As Any Ptr = ImageCreate(DrawRect.right-DrawRect.left,DrawRect.bottom-DrawRect.top)
	Dim As Integer px,py
	Select Case Hori
		Case 0			' �������
			px = 0
		Case 1			' �������
			px = ((DrawRect.right - DrawRect.left) - OldRect.right) \ 2
		Case 2			' �������
			px = (DrawRect.right - DrawRect.left) - OldRect.right
		Case 3			' �������
			px = 0
			zj = ((DrawRect.right - DrawRect.left) - OldRect.right) \ (GetWordCount(DrawStr)-1)
	End Select
	Select Case Vert
		Case 0			' �������
			py = 0
		Case 4			' �������
			py = ((DrawRect.bottom - DrawRect.top) - OldRect.bottom) \ 2
		Case 8			' �������
			py = (DrawRect.bottom - DrawRect.top) - OldRect.bottom
		Case 12			' �������[�ݲ�֧��]
			
	End Select
	PSetTextEx(TempSurface,DrawStr,NULL,px,py,zj,hj,TextColor)
	If Surface Then
		Put Surface,(DrawRect.left,DrawRect.top),TempSurface,Trans
	Else
		Put (DrawRect.left,DrawRect.top),TempSurface,Trans
	EndIf
	ImageDestroy(TempSurface)
End Sub

Function xywhPointFont.GetWordCount(ByVal Text As ZString Ptr) As Integer
	Dim i As Integer
	Dim ByteCount As Integer
	Dim WordCount As Integer
	ByteCount = strlen(Text)
	For i = 0 To ByteCount-1
		If Text[i]>127 Then
			i += 1
		EndIf
		WordCount += 1
	Next
	Return WordCount
End Function

Function xywhPointFont.GetTextWidthEx(ByVal Text As ZString Ptr,ByVal zj As Integer) As Integer
	Dim i As Integer
	Dim ByteCount As Integer
	Dim RetWidth As Integer
	Dim TempWidth As Integer
	Dim Text2 As UByte Ptr
	Text2 = Text
	ByteCount = strlen(Text)
	For i = 0 To ByteCount-1
		If Text2[i]<128 Then
			Select Case Text2[i]
				Case 10
					TempWidth = 0
				Case 13
					
				Case Else
					TempWidth += AscWidth + zj
			End Select
		Else
			i += 1
			TempWidth += GbWidth + zj
		EndIf
		If TempWidth > RetWidth Then RetWidth = TempWidth
	Next
	Return RetWidth - zj
End Function

Function xywhPointFont.GetTextWidth(ByVal Text As ZString Ptr) As Integer
	Return GetTextWidthEx(Text,0)
End Function

Function xywhPointFont.GetTextHeightEx(ByVal Text As ZString Ptr,ByVal hj As Integer) As Integer
	Dim i As Integer
	Dim ByteCount As Integer
	Dim RetHeight As Integer
	Dim Text2 As UByte Ptr
	Text2 = Text
	ByteCount = strlen(Text)
	For i = 0 To ByteCount-1
		If Text2[i] = 10 Then
			RetHeight += FontHeight + hj
		EndIf
	Next
	Return RetHeight + FontHeight
End Function

Function xywhPointFont.GetTextHeight(ByVal Text As ZString Ptr) As Integer
	Return GetTextHeightEx(Text,0)
End Function

Sub xywhPointFont.GetTextRectEx(ByVal Text As ZString Ptr,ByVal lpRect As RECT Ptr,ByVal zj As Integer,ByVal hj As Integer)
	Dim i As Integer
	Dim ByteCount As Integer
	Dim RetWidth As Integer
	Dim RetHeight As Integer
	Dim TempWidth As Integer
	Dim Text2 As UByte Ptr
	Text2 = Text
	ByteCount = strlen(Text)
	For i = 0 To ByteCount-1
		If Text2[i]<128 Then
			Select Case Text2[i]
				Case 10
					TempWidth = 0
					RetHeight += FontHeight + hj
				Case 13
					
				Case Else
					TempWidth += AscWidth + zj
			End Select
		Else
			i += 1
			TempWidth += GbWidth + zj
		EndIf
		If TempWidth > RetWidth Then RetWidth = TempWidth
	Next
	lpRect->Right = RetWidth - zj
	lpRect->bottom = RetHeight + FontHeight
End Sub

Sub xywhPointFont.GetTextRect(ByVal Text As ZString Ptr,ByVal lpRect As RECT Ptr)
	GetTextRectEx(Text,lpRect,0,0)
End Sub

Sub xywhPointFont.FreeData()
	DeAllocate(AscPtr)
	AscPtr = NULL
	DeAllocate(GbPtr)
	GbPtr = NULL
End Sub

Sub xywhPointFont.FreeCache()
	If AscCache Then
		ImageDestroy(AscCache)
		AscCache = NULL
	EndIf
	If GbCache Then
		ImageDestroy(GbCache)
		GbCache = NULL
	EndIf
End Sub

Destructor xywhPointFont()
	FreeData()
	FreeCache()
End Destructor





Sub xywhPointFont_Fast12.PSetTextEx(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal DrawLen As Integer,ByVal px As Integer,ByVal py As Integer,ByVal zj As Integer,ByVal hj As Integer,ByVal TextColor As Integer)
	Dim As Integer i,x,y,z,hi,lo,sx
	Dim AscStu As ANSIZK12 Ptr
	Dim GbStu As GBZK12 Ptr
	Dim Text As UByte Ptr
	If DrawLen=NULL Then
		DrawLen = strlen(DrawStr)
	EndIf
	sx = px
	Text = DrawStr
	For i = 0 To DrawLen-1
		If Text[i]<128 Then				' С��128��ASC
			Select Case Text[i]
				Case 10
					px = sx
					py += FontHeight + hj
				Case 13
					
				Case Else
					AscStu = AscPtr + (Text[i]*12)
					For y = 0 To 11
						For x = 0 To 5
							If AscStu->BitData(y) And (1 Shl x) Then
								If Surface Then
									PSet Surface,(px+x,py+y),TextColor
								Else
									PSet (px+x,py+y),TextColor
								EndIf
							EndIf
						Next
					Next
					px += ASCWidth + zj
			End Select
		Else											' ���ھ���GB
			hi = Text[i]
			lo = Text[i+1]
			i+=1
			GbStu = GbPtr + (((hi-&HA1)*&H5E)+(lo-&HA1))*24
			For y = 0 To 11
				For x = 0 To 11
					If GbStu->BitData(y) And (1 Shl x) Then
						If Surface Then
							PSet Surface,(px+x,py+y),TextColor
						Else
							PSet (px+x,py+y),TextColor
						EndIf
					EndIf
				Next
			Next
			px += GBWidth + zj
		EndIf
	Next
End Sub

Sub xywhPointFont_Fast12.PSetText(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal px As Integer,ByVal py As Integer,ByVal TextColor As UInteger)
	PSetTextEx(Surface,DrawStr,NULL,px,py,0,0,TextColor)
End Sub





Sub xywhPointFont_Fast16.PSetTextEx(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal DrawLen As Integer,ByVal px As Integer,ByVal py As Integer,ByVal zj As Integer,ByVal hj As Integer,ByVal TextColor As Integer)
	Dim As Integer i,x,y,z,hi,lo,sx
	Dim AscStu As ANSIZK16 Ptr
	Dim GbStu As GBZK16 Ptr
	Dim Text As UByte Ptr
	If DrawLen=NULL Then
		DrawLen = strlen(DrawStr)
	EndIf
	sx = px
	Text = DrawStr
	For i = 0 To DrawLen-1
		If Text[i]<128 Then				' С��128��ASC
			Select Case Text[i]
				Case 10
					px = sx
					py += FontHeight + hj
				Case 13
					
				Case Else
					AscStu = AscPtr + (Text[i]*16)
					For y = 0 To 15
						For x = 0 To 7
							If AscStu->BitData(y) And (1 Shl x) Then
								If Surface Then
									PSet Surface,(px+x,py+y),TextColor
								Else
									PSet (px+x,py+y),TextColor
								EndIf
							EndIf
						Next
					Next
					px += ASCWidth + zj
			End Select
		Else											' ���ھ���GB
			hi = Text[i]
			lo = Text[i+1]
			i+=1
			GbStu = GbPtr + (((hi-&HA1)*&H5E)+(lo-&HA1))*32
			For y = 0 To 15
				For x = 0 To 15
					If GbStu->BitData(y) And (1 Shl x) Then
						If Surface Then
							PSet Surface,(px+x,py+y),TextColor
						Else
							PSet (px+x,py+y),TextColor
						EndIf
					EndIf
				Next
			Next
			px += GBWidth + zj
		EndIf
	Next
End Sub

Sub xywhPointFont_Fast16.PSetText(ByVal Surface As Any Ptr,ByVal DrawStr As ZString Ptr,ByVal px As Integer,ByVal py As Integer,ByVal TextColor As UInteger)
	PSetTextEx(Surface,DrawStr,NULL,px,py,0,0,TextColor)
End Sub
