#Include "File.bi"
#Include "lzma.bi"




Dim SurLen As Integer = FileLen(ExePath & "\Lzma.txt")
Dim Sur As Any Ptr = Allocate(SurLen)
Dim Dst As Any Ptr



GetFile(ExePath & "\Lzma.txt",Sur,0,SurLen)



Dim DstLen As Integer = DeCompressBuffer_Lzma(Sur,SurLen,Dst)
If DstLen Then
	Print "��ѹ�ɹ�!"
	Print "���ݴ�С",SurLen
	Print "��ѹ��С",DstLen
	PutFile(ExePath & "\Lzma.txt.De",Dst,0,DstLen)
Else
	Print "��ѹʧ��!"
	Print "���ݴ�С",SurLen
EndIf



Sleep