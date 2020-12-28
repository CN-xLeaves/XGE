


#Define XGE_EXTERNMODULE "windows"
#Define XGE_EXTERNCLASS "windows"



#Define XGE_EXPORT_ALL Export
#Define XGE_EXPORT_OBJ Export



/' -------------------------- �ļ����ҹ��� -------------------------- '/
#Define XFILE_RULE_NoAttribEx		0				' ������
#Define XFILE_RULE_FloderOnly		0				' ֻ����Ŀ¼
#Define XFILE_RULE_PointFloder		0				' ȥ����Ŀ¼������Ŀ¼



Extern XGE_EXTERNMODULE
	/' -------------------------- �ļ������� -------------------------- '/
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
	/' -------------------------- �ṹ���ڴ������ -------------------------- '/
	Type xBsmm
		' �������ڴ�ָ��
		StructMemory As Any Ptr
		
		' ��Առ���ڴ泤��
		StructLenght As UInteger
		
		' �������д��ڶ��ٳ�Ա
		StructCount As UInteger
		
		' �Ѿ�����Ľṹ����
		AllocCount As UInteger
		
		' Ԥ�����ڴ沽��
		AllocStep As UInteger
		
		' ���캯��
		Declare Constructor()
		Declare Constructor(iItemLenght As UInteger, PreassignStep As UInteger = 32, PreassignLenght As UInteger = 0)
		
		' ��������
		Declare Destructor()
		
		' ��ӳ�Ա
		Declare Function InsertStruct(iPos As UInteger, iCount As UInteger = 1) As UInteger
		Declare Function AppendStruct(iCount As UInteger = 1) As UInteger
		
		' ɾ����Ա
		Declare Function DeleteStruct(iPos As UInteger, iCount As UInteger = 1) As Integer
		
		' �ƶ���Ա
		Declare Function SwapStruct(iPosA As UInteger, iPosB As UInteger) As Integer
		
		' ��ȡ��Աָ��
		Declare Function GetPtrStruct(iPos As UInteger) As Any Ptr
		
		' �����ڴ�
		Declare Function CallocMemory(iCount As UInteger) As Integer
		
		' ���ã��ͷ���Դ��
		Declare Sub ReInitManage()
	End Type
End Extern



#Define XPACK_SUBVER			0				' �Ӱ汾


#Define XPACK_VERSION			&H054B5058		' �ļ�ͷʶ����Ϣ [xpk5]


' �ļ��Ƿ�ѹ��
#Define XPACK_FILE_COMPRESS		1				' ����ѹ�����ļ�


' Ĭ��ѹ���㷨
#Define XPACK_COMPRESS_NULL		0				' ��ʹ��ѹ���㷨
#Define XPACK_COMPRESS_LZ4		1				' LZ4  ѹ���㷨
#Define XPACK_COMPRESS_LZMA		2				' LZMA ѹ���㷨



' �ļ�ͷ [40byte]
Type xPack_Head Field = 1
	PackVer As UInteger							' ��־ͷ [xpk5]
	SubVer As UByte								' �Ӱ汾 [0]
	Compress As UByte							' Ĭ��ѹ���㷨
	Flag As UShort								' λ���
	FileCount As UInteger						' �ļ�����
	LDB_Addr As UInteger						' �ļ��б��ƫ��
	LDB_Size As UInteger						' �ļ��б�γ���
	LDB_Hash As Integer							' �ļ��б��HASHֵ
	ElseData As ZString * 16					' Ԥ������
End Type

' �ļ���Ϣ [60byte]
Type xPack_FileInfo Field = 1
	FileAddr As UInteger						' �ļ�λ��
	DataSize As UInteger						' �ļ����ݴ�С
	FileSize As UInteger						' �ļ�ʵ�ʴ�С
	FileHash As Integer							' �ļ�HASHֵ
	FileIndex As UInteger						' �ļ����
	Compress As UByte							' �ļ�ʹ�õ�ѹ���㷨
	FileFlag As UByte							' �ļ�λ���
	Tag_Short As UShort							' ��������������
	Tag_Int As Integer							' ������������
	Tag_Str As ZString * 32						' �ַ�����������
End Type



' xPack Class
Type xPack
	
	' �ļ�ͷ��Ϣ
	HeadInfo As xPack_Head
	
	' ���������
	Declare Constructor()
	Declare Constructor(sFile As ZString Ptr, bReadOnly As Integer = FALSE)
	Declare Destructor()
	
	' ���ļ���
	Declare Function Open(sFile As ZString Ptr, bReadOnly As Integer = FALSE) As Integer
	
	' �ر��ļ���
	Declare Sub Close()
	
	' ��ȡ�ļ�����
	Declare Function Count() As UInteger
	
	' ����ļ�
	Declare Function AppendFile(sFile As ZString Ptr, iIndex As UInteger) As xPack_FileInfo Ptr
	
	' ɾ���ļ�
	Declare Sub RemoveFile(iIndex As UInteger)
	
	' ��ѹ�ļ�
	Declare Function UnPackFile(iIndex As UInteger, sFile As ZString Ptr) As Integer
	
	' �ڲ�����
	FileHdr As HANDLE			' �ļ����
	LDB As xBsmm				' �ļ��б�
	OnlyRead As Integer			' ֻ��ģʽ
	
	' �ڲ�����
	Declare Function IndexToPos(iIndex As UInteger) As UInteger
	Declare Sub RemoveFile_Pos(iPos As UInteger)
End Type



Declare Function xPack_Create(sFile As ZString Ptr) As Integer
Declare Function xPack_ReBuild(sFile As ZString Ptr) As Integer
