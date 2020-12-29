


' ‘À––≥Ã–Ú
Function xShell(Path As ZString Ptr, WinShow As Integer = SW_SHOW) As HANDLE
	Dim si As STARTUPINFO
	Dim pi As PROCESS_INFORMATION
	GetStartupInfo(@si)
	si.wShowWindow = WinShow
	CreateProcess(NULL, Path, NULL, NULL, FALSE, 0, NULL, NULL, @si, @pi)
	WaitForInputIdle(Cast(Any Ptr, pi.hProcess), INFINITE)
	Return pi.hProcess
End Function

Function xRun(Path As ZString Ptr,WinShow As Integer) As Integer
	Dim si As STARTUPINFO
	Dim pi As PROCESS_INFORMATION
	GetStartupInfo(@si)
	si.wShowWindow = WinShow
	CreateProcess(NULL, Path, NULL, NULL, FALSE, 0, NULL, NULL, @si, @pi)
	Return Cast(Integer, pi.hProcess)
End Function
