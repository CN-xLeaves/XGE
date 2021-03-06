' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Create xPack object
Dim xpk As xPack

' Open a xPack file (File does not exist. Automatically caeated.)
xpk.Open(ExePath & "\04.xpk")

' Add memory to xPack (Default use lz4 algorithm compressed)
' (When compression fails [Compression makes the file bigger instead], the compression algorithm is cancelled)
Dim pMemory As ZString * 40 = "1234567890abcdefghijklmnopqrstuvwxyz"
xpk.AppendMemory(@pMemory, 36, 1)

pMemory = "abcdefghijklmnopqrstuvwxyz1234567890"
xpk.AppendMemory(@pMemory, 36, 2)

' Save and close xPack (Execute xpk.Save() to save the package immediately)
xpk.Close()
