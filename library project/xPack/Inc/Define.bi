


#Define XGE_EXTERNMODULE "windows"
#Define XGE_EXTERNCLASS "windows"



#Define XGE_EXPORT_ALL Export
#Define XGE_EXPORT_OBJ Export



/' -------------------------- 文件查找规则 -------------------------- '/
#Define XFILE_RULE_NoAttribEx		0				' 不限制
#Define XFILE_RULE_FloderOnly		0				' 只查找目录
#Define XFILE_RULE_PointFloder		0				' 去除根目录及父级目录



Extern XGE_EXTERNMODULE
	/' -------------------------- 文件操作库 -------------------------- '/
	Namespace xFile
		Declare Function Create(FilePath As ZString Ptr) As Integer
		Declare Function Open(FilePath As ZString Ptr, OnlyRead As Integer = 0) As HANDLE
		Declare Function Close(FileHdr As HANDLE) As Integer
		Declare Function Exists(FilePath As ZString Ptr) As Integer
		Declare Function hWrite(FileHdr As HANDLE, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger
		Declare Function Write(FilePath As ZString Ptr, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger
		Declare Function hRead(FileHdr As HANDLE, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger
		Declare Function Read(FilePath As ZString Ptr, Buffer As Any Ptr, Addr As UInteger, Length As UInteger) As UInteger
		Declare Function eRead(FilePath As ZString Ptr, Buffer As Any Ptr Ptr) As UInteger
		Declare Function hSize(FileHdr As HANDLE) As UInteger
		Declare Function Size(FilePath As ZString Ptr) As UInteger
		Declare Function hCut(FileHdr As HANDLE, FileSize As UInteger) As Integer
		Declare Function Cut(FilePath As ZString Ptr, FileSize As UInteger) As Integer
		Declare Function Scan(RootDir As ZString Ptr, Filter As ZString Ptr, Attrib As Integer, AttribEx As Integer, Recursive As Integer, CallBack As Function(Path As ZString Ptr, FindData As WIN32_FIND_DATA Ptr, param As Integer) As Integer, param As Integer = 0) As Integer
	End Namespace
End Extern
Extern XGE_EXTERNCLASS
	/' -------------------------- 结构化内存管理器 -------------------------- '/
	Type xBsmm
		' 管理器内存指针
		StructMemory As Any Ptr
		
		' 成员占用内存长度
		StructLenght As UInteger
		
		' 管理器中存在多少成员
		StructCount As UInteger
		
		' 已经申请的结构数量
		AllocCount As UInteger
		
		' 预分配内存步长
		AllocStep As UInteger
		
		' 构造函数
		Declare Constructor()
		Declare Constructor(iItemLenght As UInteger, PreassignStep As UInteger = 32, PreassignLenght As UInteger = 0)
		
		' 析构函数
		Declare Destructor()
		
		' 添加成员
		Declare Function InsertStruct(iPos As UInteger, iCount As UInteger = 1) As UInteger
		Declare Function AppendStruct(iCount As UInteger = 1) As UInteger
		
		' 删除成员
		Declare Function DeleteStruct(iPos As UInteger, iCount As UInteger = 1) As Integer
		
		' 移动成员
		Declare Function SwapStruct(iPosA As UInteger, iPosB As UInteger) As Integer
		
		' 获取成员指针
		Declare Function GetPtrStruct(iPos As UInteger) As Any Ptr
		
		' 分配内存
		Declare Function CallocMemory(iCount As UInteger) As Integer
		
		' 重置（释放资源）
		Declare Sub ReInitManage()
	End Type
End Extern



#Define XPACK_SUBVER			0				' 子版本


#Define XPACK_VERSION			&H054B5058		' 文件头识别信息 [xpk5]


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
	
	' 文件头信息
	HeadInfo As xPack_Head
	
	' 构造和析构
	Declare Constructor()
	Declare Constructor(sFile As ZString Ptr, bReadOnly As Integer = FALSE)
	Declare Destructor()
	
	' 打开文件包
	Declare Function Open(sFile As ZString Ptr, bReadOnly As Integer = FALSE) As Integer
	
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
