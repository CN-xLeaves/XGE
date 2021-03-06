' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Create xPack object
Dim xpk As xPack

' Open a xPack file (File does not exist. Automatically caeated.)
xpk.Open(ExePath & "\02.xpk")

' Add files to xPack (Use lz4 algorithm compressed file)
xpk.AppendFile(ExePath & "\..\..\..\include\xge.bi", 1, XPACK_COMPRESS_LZ4)

' Add files to xPack (Use LZMA algorithm compressed file)
xpk.AppendFile(ExePath & "\xge.dll", 2, XPACK_COMPRESS_LZMA)

' Add files to xPack (No compression)
xpk.AppendFile(ExePath & "\bass.dll", 3, XPACK_COMPRESS_NULL)

' Save and close xPack (Execute xpk.Save() to save the package immediately)
xpk.Close()
