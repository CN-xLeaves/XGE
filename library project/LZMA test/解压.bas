#Include "File.bi"
#Include "lzma.bi"




Dim SurLen As Integer = FileLen(ExePath & "\Lzma.txt")
Dim Sur As Any Ptr = Allocate(SurLen)
Dim Dst As Any Ptr



GetFile(ExePath & "\Lzma.txt",Sur,0,SurLen)



Dim DstLen As Integer = DeCompressBuffer_Lzma(Sur,SurLen,Dst)
If DstLen Then
	Print "解压成功!"
	Print "数据大小",SurLen
	Print "解压大小",DstLen
	PutFile(ExePath & "\Lzma.txt.De",Dst,0,DstLen)
Else
	Print "解压失败!"
	Print "数据大小",SurLen
EndIf



Sleep