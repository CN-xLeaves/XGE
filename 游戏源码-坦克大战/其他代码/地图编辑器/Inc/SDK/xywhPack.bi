'==================================================================================
	'�� xywhPack �ļ���������ͷ�ļ�
	'#-------------------------------------------------------------------------------
	'# ���� : xywhPack ����Է��� .xpk ��ʽ���ļ���
	'# ˵�� : 
'==================================================================================

#Include Once "Windows.bi"

#Define xywh_library_xpkl

#Inclib "xywhPack"



' �����
#Define FormatLDB 0			' �ṹ���洢�ļ��б��
#Define CompreLDB 1			' ѹ���洢�ļ��б��
#Define CompreExt 2			' ѹ���洢��������
#Define UseCRC32	4			' ʹ��CRC32�����ļ�

' ���±��
#Define IsUpdateFile 1	' �ļ�������
#Define IsMemoryData 2	' �����Ѿ����뵽�ڴ�
#Define IsClearEncry 4	' �����㷨
#Define IsChangEncry 8	' �㷨����

' �㷨���
#Define xywh_DE_IsLZMA		1
#Define xywh_DE_IsXE1			2
#Define xywh_DE_IsXF1			4
#Define xywh_DE_IsUse			(xywh_DE_IsLZMA Or xywh_DE_IsXE1 Or xywh_DE_IsXF1)



' �Զ����㷨�ṹ��
Type EncryRetStu
	DataPtr As Any Ptr
	DataSize As Integer
	Mask As Integer
	PassWord As ZString Ptr
	SizeofPW As Integer
	CompLevel As Integer
End Type



Type PackFileInfo Field = 1  '20
  FileAddr		As UInteger							' ��ַƫ��
  FileSize		As UInteger							' �ļ���С
  FileCRC			As Integer							' �ļ�CRC32����
  FileEncry		As UByte								' �ļ��㷨λ���
  FileByte		As UByte								' �ļ���������		[UByte]
  FileSrt			As UShort								' �ļ���������		[UShort]
  FileInt			As Integer							' �ļ���������		[Int]
End Type

Type FileUpdateInfo Field = 1	'16
	UpdateFlag As Byte									' ���±�־
	FileEncry As UByte									' ���㷨
	DataPtr As Any Ptr									' ���ļ�·��[��פ���ڴ��ָ��]
	DataInt As Integer									' Intֵ [���ݳ���]
	PassWord As ZString Ptr							' ����
	SizeofPW As UByte										' ���볤��
	CompLevel As UByte									' ѹ������ [1-10]
End Type



' �ļ�����
Type xywhPack
	Public:
		OnError As Sub(ByVal ErrorID As Integer)
		
		' �Զ�����ܺ��� [����ָ�롢���ݳ��ȡ��㷨���롢����ָ��]
		Encode As Function(ByVal RetData as EncryRetStu Ptr) As Integer
		Decode As Function(ByVal RetData as EncryRetStu Ptr) As Integer
		
		' ���ļ�·��
		PackFile As ZString * 260
		
		' ������
		Declare Function Open(ByVal PackFile As ZString Ptr,ByVal OnlyRead As Integer) As Integer
		Declare Function Create(ByVal PackFile As ZString Ptr) As Integer
		Declare Function Update() As Integer
		Declare Function Rebuild() As Integer
		Declare Sub Close()
		
		' ������
		Declare Function Count() As Integer
		Declare Function Ver() As Integer
		Declare Function CptVer() As Integer
		Declare Function IsFlag(ByVal Flag As Integer) As Integer
		Declare Sub SetFlag(ByVal Flag As Integer,ByVal Value As Integer)
		Declare Function GetExtInt(ByVal Index As Integer) As Integer
		Declare Sub SetExtInt(ByVal Index As Integer,ByVal Value As Integer)
		
		' �ļ��������
		Declare Function AppendFile(ByVal FileName As ZString Ptr) As UInteger
		Declare Function InsertFile(ByVal Index As UInteger,ByVal FileName As ZString Ptr) As UInteger
		Declare Function ChangeFile(ByVal Index As UInteger,ByVal FileName As ZString Ptr) As Integer
		Declare Function AppendFile_Memory(ByVal Size As UInteger,ByVal Memory As Any Ptr) As UInteger
		Declare Function InsertFile_Memory(ByVal Index As UInteger,ByVal Size As UInteger,ByVal Memory As Any Ptr) As UInteger
		Declare Function ChangeFile_Memory(ByVal Index As UInteger,ByVal Size As UInteger,ByVal Memory As Any Ptr) As Integer
		Declare Function DeleteFile(ByVal Index As UInteger) As Integer
		Declare Function UnPackFile(ByVal Index As UInteger,ByVal FileName As ZString Ptr,ByVal PassWord As ZString Ptr,ByVal SozeofPW As Integer) As Integer
		Declare Function GetFileData(ByVal Index As UInteger,ByVal Addr As UInteger,ByVal Size As UInteger,ByVal DataPtr As Any Ptr,ByVal PassWord As ZString Ptr,ByVal SozeofPW As Integer) As Integer
		
		' �ļ����Բ��� [�޴�����]
		Declare Function File_GetInfo(ByVal Index As UInteger) As PackFileInfo Ptr
		Declare Function File_UpdInfo(ByVal Index As UInteger) As FileUpdateInfo Ptr
		Declare Function File_SetExtByte(ByVal Index As UInteger,ByVal Value As Integer) As Integer
		Declare Function File_SetExtSrt(ByVal Index As UInteger,ByVal Value As Integer) As Integer
		Declare Function File_SetExtInt(ByVal Index As UInteger,ByVal Value As Integer) As Integer
		Declare Function File_SetEncry(ByVal Index As UInteger,ByVal Encry As Integer,ByVal PassWord As ZString Ptr,ByVal SozeofPW As Integer,ByVal CompLevel As Integer) As Integer
		Declare Function File_KilEncry(ByVal Index As UInteger,ByVal PassWord As ZString Ptr,ByVal SozeofPW As Integer) As Integer
		Declare Function File_GetExtByte(ByVal Index As UInteger) As Integer
		Declare Function File_GetExtSrt(ByVal Index As UInteger) As Integer
		Declare Function File_GetExtInt(ByVal Index As UInteger) As Integer
		Declare Function File_GetEncry(ByVal Index As UInteger) As Integer
		Declare Function File_Size(ByVal Index As UInteger) As UInteger
		Declare Function File_CRC32(ByVal Index As UInteger) As Integer
		Declare Function File_Addr(ByVal Index As UInteger) As UInteger
		Declare Function File_UseSize(ByVal Index As UInteger) As UInteger
		Declare Function File_CheckCRC(ByVal Index As UInteger) As Integer
		Declare Function File_IsUsePassWord(ByVal Index As UInteger) As Integer
		Declare Function File_CanRead(ByVal Index As UInteger) As Integer
		
		' �ļ����Ҳ���
		Declare Function Find_ExtByte(ByVal FindByte As Integer) As UInteger
		Declare Function Find_ExtByte_And(ByVal FindByte As Integer) As UInteger
		Declare Function Find_ExtSrt(ByVal FindSrt As Integer) As UInteger
		Declare Function Find_ExtInt(ByVal FindInt As Integer) As UInteger
		Declare Sub Find_Over()
		
		' �ļ��߼�����
		Declare Function OpenFile(ByVal Index As UInteger) As Integer
		Declare Function ReadFile(ByVal Index As UInteger,ByVal Addr As UInteger,ByVal Size As UInteger,ByVal DataPtr As Any Ptr) As Integer
		Declare Function WriteFile(ByVal Index As UInteger,ByVal Addr As UInteger,ByVal Size As UInteger,ByVal DataPtr As Any Ptr) As Integer
		Declare Function SaveFile(ByVal Index As UInteger) As Integer
		Declare Function CloseFile(ByVal Index As UInteger) As Integer
		
		' �ڲ����� [�޴�����]
		Declare Function CheckIndex(ByVal Index As UInteger) As Integer
		Declare Sub Dump(ByVal LDB As ZString Ptr,ByVal UDB As ZString Ptr)
		
		'*����/����
		Declare Constructor()
		Declare Destructor()
	Protected:
		Dim ElseData As ZString * 120
End Type



Declare Function xpk_Ver() As Integer
Declare Function xpk_CptVer() As Integer
Declare Function xpk_NewPack(ByVal FileName As ZString Ptr) As Integer
Declare Sub xpk_Bind(ByVal hWin As HWND)