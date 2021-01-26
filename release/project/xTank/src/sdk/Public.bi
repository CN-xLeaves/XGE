


Function GetRand(first As Double, last As Double) As Double
	Return Rnd * (last - first) + first
End Function

Function RandTest(RndNum As Integer) As Integer
	Dim GetNum As Integer = GetRand(0, 9999)
	If GetNum < RndNum Then
		Return -1
	EndIf
End Function

Function ResToFile(ResID As Integer,sFile As ZString Ptr) As Integer
	Dim ResHdr As HRSRC = FindResource(NULL, MAKEINTRESOURCE(ResID), RT_RCDATA)
	If ResHdr Then
		Dim ResSize As Integer = SizeofResource(NULL, ResHdr)
		If ResSize Then
			Dim ResData As HGLOBAL = LoadResource(NULL, ResHdr)
			If ResData Then
				xFile_Write(sFile, ResData, 0, ResSize)
				Return -1
			EndIf
		EndIf
	EndIf
End Function
