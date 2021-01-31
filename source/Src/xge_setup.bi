#Include "windows.bi"



#LibPath "Lib"



Dim Shared hInst As HINSTANCE



Sub xge_Library_Init(hdr As HINSTANCE)
	hInst = hdr
	Randomize
End Sub

Sub xge_Library_Unit()
	
End Sub


