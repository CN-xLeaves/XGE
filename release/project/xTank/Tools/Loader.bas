#LibPath "..\lib"
#Include "..\src\sdk\xge.bi"
#Include "..\src\sdk\InputBox.bi"
#Include "..\src\sdk\Public.bi"

#LibPath "lib"
#Include "Src\SDK\Public.bi"
#Include "Src\SDK\xGui.bi"



Type ModuleInfo
	ModulePath As ZString * MAX_PATH		' Module Ŀ¼
	ModuleFile As ZString * MAX_PATH		' Modile �����ļ�
	ModuleName As ZString * 64				' Module Ŀ¼��
	ModuleTitle As ZString * 64				' Module ����
End Type

Dim Shared mm As xBsmm = xBsmm(SizeOf(ModuleInfo), 16)



#Include "Src\APP\ModuleEdit.bi"
#Include "Src\APP\GameLoader.bi"



DialogBoxParam(GetModuleHandle(NULL), Cast(ZString Ptr, 1000), NULL, @GameLoaderProc, NULL)
ExitProcess(0)
