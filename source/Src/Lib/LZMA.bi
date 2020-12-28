#Inclib "LZMA"



#define SZ_OK 0

#define SZ_ERROR_DATA 1
#define SZ_ERROR_MEM 2
#define SZ_ERROR_CRC 3
#define SZ_ERROR_UNSUPPORTED 4
#define SZ_ERROR_PARAM 5
#define SZ_ERROR_INPUT_EOF 6
#define SZ_ERROR_OUTPUT_EOF 7
#define SZ_ERROR_READ 8
#define SZ_ERROR_WRITE 9
#define SZ_ERROR_PROGRESS 10
#define SZ_ERROR_FAIL 11
#define SZ_ERROR_THREAD 12

#define SZ_ERROR_ARCHIVE 16
#define SZ_ERROR_NO_ARCHIVE 17



#define LZMA_PROPS_SIZE 5

extern "C"

/'
RAM requirements for LZMA:
  for compression:   (dictSize * 11.5 + 6 MB) + state_size
  for decompression: dictSize + state_size
    state_size = (4 + (1.5 << (lc + lp))) KB
    by default (lc=3, lp=0), state_size = 16 KB.

LZMA properties (5 bytes) format
    Offset Size  Description
      0     1    lc, lp and pb in encoded form.
      1     4    dictSize (little endian).
'/

/'
LzmaCompress
------------

outPropsSize -
     In:  the pointer to the size of outProps buffer; *outPropsSize = LZMA_PROPS_SIZE = 5.
     Out: the pointer to the size of written properties in outProps buffer; *outPropsSize = LZMA_PROPS_SIZE = 5.

  LZMA Encoder will use defult values for any parameter, if it is
  -1  for any from: level, loc, lp, pb, fb, numThreads
   0  for dictSize
  
level - compression level: 0 <= level <= 9;

  level dictSize algo  fb
    0:    16 KB   0    32
    1:    64 KB   0    32
    2:   256 KB   0    32
    3:     1 MB   0    32
    4:     4 MB   0    32
    5:    16 MB   1    32
    6:    32 MB   1    32
    7+:   64 MB   1    64
 
  The default value for "level" is 5.

  algo = 0 means fast method
  algo = 1 means normal method

dictSize - The dictionary size in bytes. The maximum value is
        128 MB = (1 << 27) bytes for 32-bit version
          1 GB = (1 << 30) bytes for 64-bit version
     The default value is 16 MB = (1 << 24) bytes.
     It's recommended to use the dictionary that is larger than 4 KB and
     that can be calculated as (1 << N) or (3 << N) sizes.

lc - The number of literal context bits (high bits of previous literal).
     It can be in the range from 0 to 8. The default value is 3.
     Sometimes lc=4 gives the gain for big files.

lp - The number of literal pos bits (low bits of current position for literals).
     It can be in the range from 0 to 4. The default value is 0.
     The lp switch is intended for periodical data when the period is equal to 2^lp.
     For example, for 32-bit (4 bytes) periodical data you can use lp=2. Often it's
     better to set lc=0, if you change lp switch.

pb - The number of pos bits (low bits of current position).
     It can be in the range from 0 to 4. The default value is 2.
     The pb switch is intended for periodical data when the period is equal 2^pb.

fb - Word size (the number of fast bytes).
     It can be in the range from 5 to 273. The default value is 32.
     Usually, a big number gives a little bit better compression ratio and
     slower compression process.

numThreads - The number of thereads. 1 or 2. The default value is 2.
     Fast mode (algo = 0) can use only 1 thread.

Out:
  destLen  - processed output size
Returns:
  SZ_OK               - OK
  SZ_ERROR_MEM        - Memory allocation error
  SZ_ERROR_PARAM      - Incorrect paramater
  SZ_ERROR_OUTPUT_EOF - output buffer overflow
  SZ_ERROR_THREAD     - errors in multithreading functions (only for Mt version)
'/



/'
	dest					目标内存
	destLen				目标内存大小[压缩后的]
	src						待压缩内存
	srcLen				压缩数据大小
	outProps			指针缓冲区
	outPropsSize	指针缓冲大小[固定为:LZMA_PROPS_SIZE]
	level					压缩级别[0-9,越大压缩率越高,默认为5]
	dictSize			字典大小
	numThreads		线程数量
'/
declare function LzmaCompress(ByVal dest as ubyte ptr,ByRef destLen as size_t,ByVal src as const ubyte ptr,ByVal srcLen as size_t,ByVal outProps as ubyte ptr,_
								ByRef outPropsSize as size_t, _           ' outPropsSize must be = 5 
                byval level as integer = -1,_             ' 0 <= level <= 9, default = 5 
                byval dictSize as uinteger = 0, _         ' default = (1 << 24) 
                byval lc as integer = -1, _               ' 0 <= lc <= 8, default = 3 
                byval lp as integer = -1, _               ' 0 <= lp <= 4, default = 0 
                byval pb as integer = -1, _               ' 0 <= pb <= 4, default = 2  
                byval fb as integer = -1, _               ' 5 <= fb <= 273, default = 32 
                byval numThreads as integer = -1  _       ' 1 or 2, default = 2
                ) as integer


/'
LzmaUncompress
--------------
In:
  dest     - output data
  destLen  - output data size
  src      - input data
  srcLen   - input data size
Out:
  destLen  - processed output size
  srcLen   - processed input size
Returns:
  SZ_OK                - OK
  SZ_ERROR_DATA        - Data error
  SZ_ERROR_MEM         - Memory allocation arror
  SZ_ERROR_UNSUPPORTED - Unsupported properties
  SZ_ERROR_INPUT_EOF   - it needs more bytes in input buffer (src)
'/

declare function LzmaUncompress(ByVal dest as ubyte Ptr,ByRef destLen as size_t,ByVal src as const ubyte ptr,ByRef srcLen as size_t,ByVal props as const ubyte ptr,ByVal propsSize as size_t) as integer

end Extern



Type Lzma_FileHdr Field = 1
	FileSize As UInteger											' 压缩前文件大小
	CompLevel As Byte													' 压缩等级
	LzmaProp(0 To LZMA_PROPS_SIZE-1) As Byte	' Props
End Type



Function CompressBuffer_Lzma(ByVal InBuffer As Any Ptr,ByVal InBufferSize As Integer,ByRef OutBuffer As Any Ptr,ByVal Level As Integer) As Integer
	Dim Hdr As Lzma_FileHdr Ptr = Allocate(SizeOf(Lzma_FileHdr) + InBufferSize)
	Dim Dst As Any Ptr = Cast(Any Ptr,Hdr) + SizeOf(Lzma_FileHdr)
	Dim DstSize As UInteger = InBufferSize
	Hdr->FileSize = InBufferSize
	Hdr->CompLevel = Level
	Dim LzmaRet As Integer = LzmaCompress(Dst, DstSize, InBuffer, InBufferSize, @Hdr->LzmaProp(0), LZMA_PROPS_SIZE, Level)
	If LzmaRet = SZ_OK Then
		Hdr = ReAllocate(Hdr,SizeOf(Lzma_FileHdr) + DstSize)
		OutBuffer = Hdr
		Return SizeOf(Lzma_FileHdr) + DstSize
	Else
		DeAllocate(Hdr)
		OutBuffer = Cast(Any Ptr,LzmaRet)
		Return 0
	EndIf
End Function

Function DeCompressBuffer_Lzma(ByVal InBuffer As Any Ptr,ByVal InBufferSize As Integer,ByRef OutBuffer As Any Ptr) As Integer
	Dim Hdr As Lzma_FileHdr Ptr = InBuffer
	Dim Scr As Any Ptr = InBuffer + SizeOf(Lzma_FileHdr)
	Dim Dst As Any Ptr = Allocate(Hdr->FileSize)
	Dim OutLen As UInteger = Hdr->FileSize
	Dim LzmaRet As Integer = LzmaUncompress(Dst, OutLen, Scr, InBufferSize-SizeOf(Lzma_FileHdr), @Hdr->LzmaProp(0), LZMA_PROPS_SIZE)
	If LzmaRet = SZ_OK Then
		OutBuffer = Dst
		Return OutLen
	Else
		DeAllocate(Dst)
		OutBuffer = Cast(Any Ptr,LzmaRet)
		Return 0
	EndIf
End Function
