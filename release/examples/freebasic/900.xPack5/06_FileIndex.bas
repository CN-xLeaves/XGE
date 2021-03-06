' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Create xPack object
Dim xpk As xPack

' Open a xPack file (File does not exist. Automatically caeated.)
xpk.Open(ExePath & "\06.xpk")

' Add memory to xPack
Dim pMemory As ZString * 40 = "1234567890abcdefghijklmnopqrstuvwxyz"
xpk.AppendMemory(@pMemory, 36, 1)

' Read the contents of the file directly into memory.
Dim pText As ZString Ptr
Dim fi As xPack_FileInfo Ptr = xpk.UnPackMemory(1, @pText)
pText[fi->FileSize] = 0
Print *pText
DeAllocate(pText)

' Continue to add file, and still use 1 as the file index
pMemory = "abcdefghijklmnopqrstuvwxyz1234567890"
xpk.AppendMemory(@pMemory, 36, 1)

' Read 1 index file, Data is overwritten
fi = xpk.UnPackMemory(1, @pText)
pText[fi->FileSize] = 0
Print *pText
DeAllocate(pText)

' The file index is unique, Once the existing file index is used, the privious file will be overwritten
' xPack will not release the covered file space for performance reasons.
' Long-term writing package may become very large, which can be freed bt using xPack_ReBuild command.

' Save and close xPack (Execute xpk.Save() to save the package immediately)
xpk.Close()

Sleep
