' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"
#include "string.bi"



Dim pMemory As ZString * 40
Dim rm As xge.ResManage

Print "load pack 00"
rm.AddPack(ExePath & "\00.xpk")

Print "load pack 01"
rm.AddPack(ExePath & "\01.xpk")

Print "CreateIndex"
Dim ST As Double = Timer
rm.CreateIndex()
Print "CreateIndex Over!", Format(Timer - ST, "0.0000s")
Print "Index Count", rm.IndexList.StructCount
Sleep

/'
Print "IndexList :"
For i As UInteger = 1 To rm.IndexList.StructCount
	Dim Item As ResManage_Item Ptr = rm.IndexList.GetPtrStruct(i)
	Dim xpk As xPack Ptr = Item->ResPack
	Dim FileInfo As xPack_FileInfo Ptr = xpk->LDB.GetPtrStruct(Item->ResPos)
	xpk->Private_UnPackMemory(FileInfo, @pMemory)
	pMemory[FileInfo->FileSize] = 0
	Print Item->ResIndex, pMemory
Next
Sleep
'/

/'
Print "RangeList :"
Print "IndexMin :", rm.IndexMin
Print "IndexMax :", rm.IndexMax
For i As UInteger = 1 To rm.RangeList.StructCount
	Dim rlv As UInteger Ptr = rm.RangeList.GetPtrStruct(i)
	Print *rlv
Next
Sleep
'/

/'
ST = Timer
For i As UInteger = 1 To rm.IndexList.StructCount
	Dim Item As ResManage_Item Ptr = rm.IndexList.GetPtrStruct(i)
	rm.IndexToPos(Item->ResIndex)
Next
Print Format(Timer - ST, "0.0000s")
Sleep
'/

'/'
For i As UInteger = 1 To rm.IndexList.StructCount
	Dim Item As ResManage_Item Ptr = rm.IndexList.GetPtrStruct(i)
	Dim iPos As UInteger = rm.IndexToPos(Item->ResIndex)
	Item = rm.IndexList.GetPtrStruct(iPos)
	Dim xpk As xPack Ptr = Item->ResPack
	Dim FileInfo As xPack_FileInfo Ptr = xpk->LDB.GetPtrStruct(Item->ResPos)
	xpk->Private_UnPackMemory(FileInfo, @pMemory)
	pMemory[FileInfo->FileSize] = 0
	Print Item->ResIndex, pMemory
Next
Sleep
'/

Dim iPos As UInteger = rm.IndexToPos(100000)
Print iPos
Sleep
