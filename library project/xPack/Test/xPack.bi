
#Inclib "xPack"


' 文件是否压缩
#Define XPACK_FILE_COMPRESS		1				' 经过压缩的文件


' 默认压缩算法
#Define XPACK_COMPRESS_NULL		0				' 不使用压缩算法
#Define XPACK_COMPRESS_LZ4		1				' LZ4  压缩算法
#Define XPACK_COMPRESS_LZMA		2				' LZMA 压缩算法



' 文件头 [40byte]
Type xPack_Head Field = 1
	PackVer As UInteger							' 标志头 [xpk5]
	SubVer As UByte								' 子版本 [0]
	Compress As UByte							' 默认压缩算法
	Flag As UShort								' 位标记
	FileCount As UInteger						' 文件数量
	LDB_Addr As UInteger						' 文件列表段偏移
	LDB_Size As UInteger						' 文件列表段长度
	LDB_Hash As Integer							' 文件列表段HASH值
	ElseData As ZString * 16					' 预留数据
End Type

' 文件信息 [60byte]
Type xPack_FileInfo Field = 1
	FileAddr As UInteger						' 文件位置
	DataSize As UInteger						' 文件数据大小
	FileSize As UInteger						' 文件实际大小
	FileHash As Integer							' 文件HASH值
	FileIndex As UInteger						' 文件编号
	Compress As UByte							' 文件使用的压缩算法
	FileFlag As UByte							' 文件位标记
	Tag_Short As UShort							' 短整数附加数据
	Tag_Int As Integer							' 整数附加数据
	Tag_Str As ZString * 32						' 字符串附加数据
End Type



' xPack Class
Type xPack
	
	' 文件路径
	FilePath As ZString * MAX_PATH
	
	' 文件头信息
	HeadInfo As xPack_Head
	
	' 构造和析构
	Declare Constructor()
	Declare Constructor(sFile As ZString Ptr, bReadOnly As Integer = FALSE)
	Declare Destructor()
	
	' 打开文件包
	Declare Function Open(sFile As ZString Ptr, bReadOnly As Integer = FALSE) As Integer
	
	
	Declare Function ReBuild() As Integer
	
	' 关闭文件包
	Declare Sub Close()
	
	' 获取文件数量
	Declare Function Count() As UInteger
	
	' 添加文件
	Declare Function AppendFile(sFile As ZString Ptr, iIndex As UInteger) As xPack_FileInfo Ptr
	
	' 删除文件
	Declare Sub RemoveFile(iIndex As UInteger)
	
	' 解压文件
	Declare Function UnPackFile(iIndex As UInteger, sFile As ZString Ptr) As Integer
	
	' 内部数据
	FileHdr As HANDLE			' 文件句柄
	LDB As xBsmm				' 文件列表
	OnlyRead As Integer			' 只读模式
	
	' 内部函数
	Declare Function IndexToPos(iIndex As UInteger) As UInteger
	Declare Sub RemoveFile_Pos(iPos As UInteger)
End Type



Declare Function xPack_Create(sFile As ZString Ptr) As Integer
Declare Function xPack_ReBuild(sFile As ZString Ptr) As Integer


