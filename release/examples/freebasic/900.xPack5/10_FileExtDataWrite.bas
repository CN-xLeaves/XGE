' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Expanded package information (Maximum 65535 bytes)
Type MyPackHeadInfo
	PackType As Integer
	PackText As ZString * 256
End Type

' Expanded package file information (Maximum 65535 bytes)
Type MyPackFileInfo Extends xPack_FileInfo
	FilePath As ZString * MAX_PATH
End Type



' Create xPack
xPack_Create(ExePath & "\10.xpk", SizeOf(MyPackHeadInfo), SizeOf(MyPackFileInfo) - SizeOf(xPack_FileInfo))

' Open a xPack file
Dim xpk As xPack
xpk.Open(ExePath & "\10.xpk")

' Write expanded package information
Dim ExtData As MyPackHeadInfo Ptr
ExtData = xpk.GetPackExtData()
ExtData->PackType = 1234
ExtData->PackText = "1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890"

' Add files to xPack and write expanded package file information
Dim FileInfo As MyPackFileInfo Ptr
FileInfo = xpk.AppendFile(ExePath & "\..\..\..\include\xge.bi", 1, XPACK_COMPRESS_LZ4)
FileInfo->FilePath = ExePath & "\..\..\..\include\xge.bi"

' Add files to xPack and write expanded package file information
FileInfo = xpk.AppendFile(ExePath & "\xge.dll", 2, XPACK_COMPRESS_LZMA)
FileInfo->FilePath = ExePath & "\xge.dll"

' Add files to xPack and write expanded package file information
FileInfo = xpk.AppendFile(ExePath & "\bass.dll", 3, XPACK_COMPRESS_NULL)
FileInfo->FilePath = ExePath & "\bass.dll"

' Save and close xPack (Execute xpk.Save() to save the package immediately)
' Save expanded package information and expanded package file information
xpk.Close()
