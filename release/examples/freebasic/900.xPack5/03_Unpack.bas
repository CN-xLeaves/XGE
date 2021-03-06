' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Create xPack object
Dim xpk As xPack

' Open a xPack file (The File must exist in read-only mode)
xpk.Open(ExePath & "\02.xpk", TRUE)

' Unpack files
xpk.UnPackFile(1, ExePath & "\xge_unpack.bi")
xpk.UnPackFile(2, ExePath & "\xge_unpack.dll")
xpk.UnPackFile(3, ExePath & "\bass_unpack.dll")

' Package opened in read-only mode do not save changes when closed
xpk.Close()
