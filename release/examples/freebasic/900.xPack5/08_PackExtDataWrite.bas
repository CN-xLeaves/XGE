' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Expanded package information (Maximum 65535 bytes)
Type MyPackHeadInfo
	PackType As Integer
	PackText As ZString * 256
End Type



' Create xPack (Expanded MyPackHeadInfo bytes)
xPack_Create(ExePath & "\08.xpk", SizeOf(MyPackHeadInfo))

' Open a xPack file
Dim xpk As xPack
xpk.Open(ExePath & "\08.xpk")

' Write expanded package information
Dim ExtData As MyPackHeadInfo Ptr
ExtData = xpk.GetPackExtData()
ExtData->PackType = 1234
ExtData->PackText = "1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890"

' Add files to xPack (Use lz4 algorithm compressed file)
xpk.AppendFile(ExePath & "\..\..\..\include\xge.bi", 1, XPACK_COMPRESS_LZ4)

' Add files to xPack (Use LZMA algorithm compressed file)
xpk.AppendFile(ExePath & "\xge.dll", 2, XPACK_COMPRESS_LZMA)

' Add files to xPack (No compression)
xpk.AppendFile(ExePath & "\bass.dll", 3, XPACK_COMPRESS_NULL)

' Save and close xPack (Execute xpk.Save() to save the package immediately)
' Save expanded package information
xpk.Close()
