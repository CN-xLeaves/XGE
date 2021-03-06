' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



Type MyStruct
	index As Integer
	idstr As ZString * 8
End Type



Dim sm As xBsmm = xBsmm(SizeOf(MyStruct))

For i As Integer = 1 To 100
	Dim iPos As UInteger = sm.AppendStruct()
	Dim ms As MyStruct Ptr = sm.GetPtrStruct(iPos)
	If ms Then
		ms->index = i
		ms->idstr = Str(i)
	EndIf
Next

For i As Integer = 1 To 100
	Dim ms As MyStruct Ptr = sm.GetPtrStruct(i)
	Print ms->index, ms->idstr
Next

Dim delitem(11) As UInteger = {1, 50, 30, 80, 40, 20, 60, 10, 70, 100, 90}
sm.DeleteStructs(@delitem(0), 11, TRUE)
Sleep

Print "Count :", sm.StructCount
For i As Integer = 1 To sm.StructCount
	Dim ms As MyStruct Ptr = sm.GetPtrStruct(i)
	Print ms->index, ms->idstr
Next

Sleep
