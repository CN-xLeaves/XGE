
#Inclib "xPack"


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
	
	' �ļ�·��
	FilePath As ZString * MAX_PATH
	
	' �ļ�ͷ��Ϣ
	HeadInfo As xPack_Head
	
	' ���������
	Declare Constructor()
	Declare Constructor(sFile As ZString Ptr, bReadOnly As Integer = FALSE)
	Declare Destructor()
	
	' ���ļ���
	Declare Function Open(sFile As ZString Ptr, bReadOnly As Integer = FALSE) As Integer
	
	
	Declare Function ReBuild() As Integer
	
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


