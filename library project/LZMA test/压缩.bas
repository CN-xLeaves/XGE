#Include "File.bi"
#Include "lzma.bi"




Dim SurLen As Integer = FileLen(ExePath & "\libLZMA.a")
Dim Sur As Any Ptr = Allocate(SurLen)
Dim Dst As Any Ptr



GetFile(ExePath & "\libLZMA.a",Sur,0,SurLen)



Dim DstLen As Integer = CompressBuffer_Lzma(Sur,SurLen,Dst)
If DstLen Then
	Print "压缩成功!"
	Print "数据大小",SurLen
	Print "压缩大小",DstLen
	PutFile(ExePath & "\Lzma.txt",Dst,0,DstLen)
Else
	Print "压缩失败!"
	Print "数据大小",SurLen
EndIf



Sleep