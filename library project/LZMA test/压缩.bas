#Include "File.bi"
#Include "lzma.bi"




Dim SurLen As Integer = FileLen(ExePath & "\libLZMA.a")
Dim Sur As Any Ptr = Allocate(SurLen)
Dim Dst As Any Ptr



GetFile(ExePath & "\libLZMA.a",Sur,0,SurLen)



Dim DstLen As Integer = CompressBuffer_Lzma(Sur,SurLen,Dst)
If DstLen Then
	Print "ѹ���ɹ�!"
	Print "���ݴ�С",SurLen
	Print "ѹ����С",DstLen
	PutFile(ExePath & "\Lzma.txt",Dst,0,DstLen)
Else
	Print "ѹ��ʧ��!"
	Print "���ݴ�С",SurLen
EndIf



Sleep