#LibPath "..\lib"
#Include "..\src\sdk\xge.bi"



xPack_Create(ExePath & "\res.xpk")

Dim xpk As xPack
xpk.Open(ExePath & "\res.xpk")

' add font
xpk.AppendFile(ExePath & "\simsun_12px_gb2312.xrf", 1, XPACK_COMPRESS_LZMA)
xpk.AppendFile(ExePath & "\simsun_16px_gb2312.xrf", 2, XPACK_COMPRESS_LZMA)

' add system image
xpk.AppendFile(ExePath & "\Logo.bmp", 100, XPACK_COMPRESS_LZMA)
xpk.AppendFile(ExePath & "\back.bmp", 101, XPACK_COMPRESS_LZMA)
xpk.AppendFile(ExePath & "\Pass.bmp", 102, XPACK_COMPRESS_LZMA)
xpk.AppendFile(ExePath & "\End.bmp" , 103, XPACK_COMPRESS_LZMA)

' add tank image
xpk.AppendFile(ExePath & "\tank01.bmp", 200, XPACK_COMPRESS_LZMA)
xpk.AppendFile(ExePath & "\tank02.bmp", 201, XPACK_COMPRESS_LZMA)
xpk.AppendFile(ExePath & "\tank03.bmp", 202, XPACK_COMPRESS_LZMA)
xpk.AppendFile(ExePath & "\tank04.bmp", 203, XPACK_COMPRESS_LZMA)

' add else image
xpk.AppendFile(ExePath & "\boom.bmp", 300, XPACK_COMPRESS_LZMA)
xpk.AppendFile(ExePath & "\map.bmp" , 301, XPACK_COMPRESS_LZMA)

' add sound
xpk.AppendFile(ExePath & "\fire.ogg", 400, XPACK_COMPRESS_LZMA)
xpk.AppendFile(ExePath & "\boom.ogg", 401, XPACK_COMPRESS_LZMA)

xpk.Close()
