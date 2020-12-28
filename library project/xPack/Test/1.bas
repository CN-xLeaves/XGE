#Include Once "Windows.bi"
#Include "..\Inc\Define.bi"



#Inclib "xPack"



Dim xpk As xPack

xpk.Open("1.xpk")
xpk.AppendFile(ExePath & "\xPack.bi", 1)
xpk.UnPackFile(1, "2.bi")
xpk.Close()
Sleep


