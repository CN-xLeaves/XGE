#LibPath "..\lib"
#Include "..\src\sdk\xge.bi"
#Include "..\src\sdk\InputBox.bi"
#Include "..\src\sdk\Public.bi"

#LibPath "lib"
#Include "Src\SDK\Public.bi"
#Include "Src\SDK\xGui.bi"



Type ModuleInfo
	ModulePath As ZString * MAX_PATH		' Module 目录
	ModuleFile As ZString * MAX_PATH		' Modile 配置文件
	ModuleName As ZString * 64				' Module 目录名
	ModuleTitle As ZString * 64				' Module 标题
End Type

Dim Shared mm As xBsmm = xBsmm(SizeOf(ModuleInfo), 16)



#Include "Src\APP\ModuleEdit.bi"
#Include "Src\APP\GameLoader.bi"



DialogBoxParam(GetModuleHandle(NULL), Cast(ZString Ptr, 1000), NULL, @GameLoaderProc, NULL)
ExitProcess(0)
