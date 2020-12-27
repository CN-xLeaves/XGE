


Function GetRand(first As Double, last As Double) As Double
	Return Rnd * (last - first) + first
End Function

Function RandTest(RndNum As Integer) As Integer
	Dim GetNum As Integer = GetRand(0, 9999)
	If GetNum < RndNum Then
		Return -1
	EndIf
End Function
