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



' Open a xPack file
Dim xpk As xPack
xpk.Open(ExePath & "\10.xpk", TRUE)

' Read expanded package information
Dim ExtData As MyPackHeadInfo Ptr
ExtData = xpk.GetPackExtData()
Print ExtData->PackType
Print ExtData->PackText

' Read expanded package file information
Dim ExtFile As MyPackFileInfo Ptr
ExtFile = xpk.GetFileInfo(1)
Print ExtFile->FilePath
ExtFile = xpk.GetFileInfo(2)
Print ExtFile->FilePath
ExtFile = xpk.GetFileInfo(3)
Print ExtFile->FilePath

' Unpack files
xpk.UnPackFile(1, ExePath & "\xge_unpack.bi")
xpk.UnPackFile(2, ExePath & "\xge_unpack.dll")
xpk.UnPackFile(3, ExePath & "\bass_unpack.dll")

' close xPack
' Any changes in read-only mode will not be saved
xpk.Close()

Sleep
