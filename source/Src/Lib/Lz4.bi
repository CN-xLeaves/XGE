


#Inclib "lz4"



#Define LZ4HC_CLEVEL_MIN         3
#Define LZ4HC_CLEVEL_DEFAULT     9
#Define LZ4HC_CLEVEL_OPT_MIN    10
#Define LZ4HC_CLEVEL_MAX        12



Extern "Windows-MS"
	Declare Function LZ4_compress_default(src As Any Ptr, dst As Any Ptr, srcSize As Integer, dstCapacity As Integer) As Integer
	Declare Function LZ4_decompress_safe(src As Any Ptr, dst As Any Ptr, compressedSize As Integer, dstCapacity As Integer) As Integer
	Declare Function LZ4_compressBound(inputSize As Integer) As Integer
	' �������ü������ӣ�����������=1ʱ��LZ4_compress_default��ͬ
	Declare Function LZ4_compress_fast(src As Any Ptr, dst As Any Ptr, srcSize As Integer, dstCapacity As Integer, acceleration As Integer) As Integer
	
	' ��ѹ�����㷨
	Declare Function LZ4_compress_HC(src As Any Ptr, dst As Any Ptr, srcSize As Integer, maxDstSize As Integer, compressionLevel As Integer) As Integer
	
	' xxHash
	Declare Function XXH32(src As Any Ptr, length As UInteger, seed As UInteger) As UInteger
	Declare Function XXH64(src As Any Ptr, length As UInteger, seed As ULongInt) As ULongInt
End Extern
