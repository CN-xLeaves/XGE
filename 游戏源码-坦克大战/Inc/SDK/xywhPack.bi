'==================================================================================
	'★ xywhPack 文件包操作库头文件
	'#-------------------------------------------------------------------------------
	'# 功能 : xywhPack 库可以访问 .xpk 格式的文件包
	'# 说明 : 
'==================================================================================

#Include Once "Windows.bi"

#Define xywh_library_xpkl

#Inclib "xywhPack"



' 包标记
#Define FormatLDB 0			' 结构化存储文件列表段
#Define CompreLDB 1			' 压缩存储文件列表段
#Define CompreExt 2			' 压缩存储附加数据
#Define UseCRC32	4			' 使用CRC32检验文件

' 更新标记
#Define IsUpdateFile 1	' 文件被更新
#Define IsMemoryData 2	' 数据已经载入到内存
#Define IsClearEncry 4	' 撤销算法
#Define IsChangEncry 8	' 算法更新

' 算法标记
#Define xywh_DE_IsLZMA		1
#Define xywh_DE_IsXE1			2
#Define xywh_DE_IsXF1			4
#Define xywh_DE_IsUse			(xywh_DE_IsLZMA Or xywh_DE_IsXE1 Or xywh_DE_IsXF1)



' 自定义算法结构体
Type EncryRetStu
	DataPtr As Any Ptr
	DataSize As Integer
	Mask As Integer
	PassWord As ZString Ptr
	SizeofPW As Integer
	CompLevel As Integer
End Type



Type PackFileInfo Field = 1  '20
  FileAddr		As UInteger							' 地址偏移
  FileSize		As UInteger							' 文件大小
  FileCRC			As Integer							' 文件CRC32检验
  FileEncry		As UByte								' 文件算法位标记
  FileByte		As UByte								' 文件附加数据		[UByte]
  FileSrt			As UShort								' 文件附加数据		[UShort]
  FileInt			As Integer							' 文件附加数据		[Int]
End Type

Type FileUpdateInfo Field = 1	'16
	UpdateFlag As Byte									' 更新标志
	FileEncry As UByte									' 新算法
	DataPtr As Any Ptr									' 新文件路径[或驻留内存的指针]
	DataInt As Integer									' Int值 [数据长度]
	PassWord As ZString Ptr							' 密码
	SizeofPW As UByte										' 密码长度
	CompLevel As UByte									' 压缩级别 [1-10]
End Type



' 文件包类
Type xywhPack
	Public:
		OnError As Sub(ByVal ErrorID As Integer)
		
		' 自定义加密函数 [数据指针、数据长度、算法掩码、返回指针]
		Encode As Function(ByVal RetData as EncryRetStu Ptr) As Integer
		Decode As Function(ByVal RetData as EncryRetStu Ptr) As Integer
		
		' 包文件路径
		PackFile As ZString * 260
		
		' 包操作
		Declare Function Open(ByVal PackFile As ZString Ptr,ByVal OnlyRead As Integer) As Integer
		Declare Function Create(ByVal PackFile As ZString Ptr) As Integer
		Declare Function Update() As Integer
		Declare Function Rebuild() As Integer
		Declare Sub Close()
		
		' 包属性
		Declare Function Count() As Integer
		Declare Function Ver() As Integer
		Declare Function CptVer() As Integer
		Declare Function IsFlag(ByVal Flag As Integer) As Integer
		Declare Sub SetFlag(ByVal Flag As Integer,ByVal Value As Integer)
		Declare Function GetExtInt(ByVal Index As Integer) As Integer
		Declare Sub SetExtInt(ByVal Index As Integer,ByVal Value As Integer)
		
		' 文件常规操作
		Declare Function AppendFile(ByVal FileName As ZString Ptr) As UInteger
		Declare Function InsertFile(ByVal Index As UInteger,ByVal FileName As ZString Ptr) As UInteger
		Declare Function ChangeFile(ByVal Index As UInteger,ByVal FileName As ZString Ptr) As Integer
		Declare Function AppendFile_Memory(ByVal Size As UInteger,ByVal Memory As Any Ptr) As UInteger
		Declare Function InsertFile_Memory(ByVal Index As UInteger,ByVal Size As UInteger,ByVal Memory As Any Ptr) As UInteger
		Declare Function ChangeFile_Memory(ByVal Index As UInteger,ByVal Size As UInteger,ByVal Memory As Any Ptr) As Integer
		Declare Function DeleteFile(ByVal Index As UInteger) As Integer
		Declare Function UnPackFile(ByVal Index As UInteger,ByVal FileName As ZString Ptr,ByVal PassWord As ZString Ptr,ByVal SozeofPW As Integer) As Integer
		Declare Function GetFileData(ByVal Index As UInteger,ByVal Addr As UInteger,ByVal Size As UInteger,ByVal DataPtr As Any Ptr,ByVal PassWord As ZString Ptr,ByVal SozeofPW As Integer) As Integer
		
		' 文件属性操作 [无错误处理]
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
		
		' 文件查找操作
		Declare Function Find_ExtByte(ByVal FindByte As Integer) As UInteger
		Declare Function Find_ExtByte_And(ByVal FindByte As Integer) As UInteger
		Declare Function Find_ExtSrt(ByVal FindSrt As Integer) As UInteger
		Declare Function Find_ExtInt(ByVal FindInt As Integer) As UInteger
		Declare Sub Find_Over()
		
		' 文件高级操作
		Declare Function OpenFile(ByVal Index As UInteger) As Integer
		Declare Function ReadFile(ByVal Index As UInteger,ByVal Addr As UInteger,ByVal Size As UInteger,ByVal DataPtr As Any Ptr) As Integer
		Declare Function WriteFile(ByVal Index As UInteger,ByVal Addr As UInteger,ByVal Size As UInteger,ByVal DataPtr As Any Ptr) As Integer
		Declare Function SaveFile(ByVal Index As UInteger) As Integer
		Declare Function CloseFile(ByVal Index As UInteger) As Integer
		
		' 内部函数 [无错误处理]
		Declare Function CheckIndex(ByVal Index As UInteger) As Integer
		Declare Sub Dump(ByVal LDB As ZString Ptr,ByVal UDB As ZString Ptr)
		
		'*构造/析构
		Declare Constructor()
		Declare Destructor()
	Protected:
		Dim ElseData As ZString * 120
End Type



Declare Function xpk_Ver() As Integer
Declare Function xpk_CptVer() As Integer
Declare Function xpk_NewPack(ByVal FileName As ZString Ptr) As Integer
Declare Sub xpk_Bind(ByVal hWin As HWND)