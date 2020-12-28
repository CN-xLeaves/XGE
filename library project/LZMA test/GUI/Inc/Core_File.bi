#Include Once "win\commdlg.bi"
#Define xywhCoreFile



#Define xywh_IsFile




Type BROWSEINFO
	hwndOwner As HWND
	pidlRoot As Integer
	pszDisplayName As ZString Ptr
	lpszTitle As ZString Ptr
	ulFlags As Integer
	lpfn As Integer
	lParam As Integer
	iImage As Integer
End Type




/'
	�������� : PutFile
	�������� : Ҷ�ӵ��뿪
	�������� : ��ָ������д�뵽ָ���ļ���
	�ݴ����� : �Ͻ�������
	����˵�� : FileName[�ļ���]		OutBuffer[д�������]		StartPoint[д����ʼ��]		OutLenght[д�볤��]
	�� �� ֵ : �ɹ����� 0 , ����Ϊ GetLastError ȡ�õ���ֵ
'/
Function PutFile(ByVal FileName As ZString Ptr,ByVal OutBuffer As Any Ptr,ByVal StartPoint As Integer,ByVal OutLenght As Integer) As Integer
	#Ifdef LogOutPut
		AddLog("	PutFile	����ִ�� , �����б� : FileName[" & *FileName & "]  StartPoint[" & StartPoint & "]  OutLenght[" & OutLenght & "]")
	#EndIf
	Dim As HANDLE File_HANDLE = CreateFile(FileName,GENERIC_WRITE,FILE_SHARE_READ,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)
	If File_HANDLE = INVALID_HANDLE_VALUE Then
		#Ifdef LogOutPut
			AddLog("Error : [CreateFile] , GetLastError : " & GetLastError())
		#EndIf
		PutFile = GetLastError()
	Else
		Dim As Integer oRet = SetFilePointer(File_HANDLE,StartPoint,0,FILE_BEGIN)
		If oRet = -1 Then
			#Ifdef LogOutPut
				AddLog("Error : [SetFilePointer] , GetLastError : " & GetLastError())
			#EndIf
			PutFile = GetLastError()
		Else
			Dim TOL As OVERLAPPED
			TOL.Offset = oRet
			If WriteFile(File_HANDLE,OutBuffer,OutLenght,NULL,@TOL) Then
				PutFile = 0
			Else
				#Ifdef LogOutPut
					AddLog("Error : [WriteFile] , GetLastError : " & GetLastError())
				#EndIf
				PutFile = GetLastError()
			EndIf
		EndIf
	EndIf
	CloseHandle(File_HANDLE)
End Function


/'
	�������� : PutFile_h
	�������� : Ҷ�ӵ��뿪
	�������� : ��ָ������д�뵽ָ���ļ������
	�ݴ����� : �Ͻ�������
	����˵�� : File_HANDLE[�ļ����]		OutBuffer[д�������]		StartPoint[д����ʼ��]		OutLenght[д�볤��]
	�� �� ֵ : �ɹ����� 0 , ����Ϊ GetLastError ȡ�õ���ֵ
'/
Function PutFile_h(ByVal File_HANDLE As HANDLE,ByVal OutBuffer As Any Ptr,ByVal StartPoint As Integer,ByVal OutLenght As Integer) As Integer
	#Ifdef LogOutPut
		AddLog("	PutFile_h	����ִ�� , �����б� : File_HANDLE[" & File_HANDLE & "]  StartPoint[" & StartPoint & "]  OutLenght[" & OutLenght & "]")
	#EndIf
	Dim As Integer oRet = SetFilePointer(File_HANDLE,StartPoint,0,FILE_BEGIN)
	If oRet = -1 Then
		#Ifdef LogOutPut
			AddLog("Error : [SetFilePointer] , GetLastError : " & GetLastError())
		#EndIf
		PutFile_h = GetLastError()
	Else
		Dim TOL As OVERLAPPED
		TOL.Offset = oRet
		If WriteFile(File_HANDLE,OutBuffer,OutLenght,NULL,@TOL) Then
			PutFile_h = 0
		Else
			#Ifdef LogOutPut
				AddLog("Error : [WriteFile] , GetLastError : " & GetLastError())
			#EndIf
			PutFile_h = GetLastError()
		EndIf
	EndIf
End Function


/'
	�������� : GetFile
	�������� : Ҷ�ӵ��뿪
	�������� : ��ȡָ���ļ������ݵ�������
	�ݴ����� : �Ͻ�������
	����˵�� : FileName[�ļ���]		OutBuffer[׼��������]		StartPoint[��ȡ��ʼ��]		GetLenght[��ȡ����]
	�� �� ֵ : �ɹ����� 0 , ����Ϊ GetLastError ȡ�õ���ֵ
'/
Function GetFile(ByVal FileName As ZString Ptr,ByVal InBuffer As Any Ptr,ByVal StartPoint As Integer,ByVal GetLenght As Integer) As Integer
	Dim File_HANDLE As HANDLE
	#Ifdef LogOutPut
	AddLog("	GetFile	����ִ�� , �����б� : FileName[" & *FileName & "]  StartPoint[" & StartPoint & "]  GetLenght[" & GetLenght & "]")
	#EndIf
	File_HANDLE = CreateFile(FileName,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)
	If File_HANDLE = INVALID_HANDLE_VALUE Then
		#Ifdef LogOutPut
			AddLog("Error : [CreateFile] , GetLastError : " & GetLastError())
		#EndIf
		GetFile = GetLastError()
	Else
		Dim As Integer oRet = SetFilePointer(File_HANDLE,StartPoint,0,FILE_BEGIN)
		If oRet = -1 Then
			#Ifdef LogOutPut
				AddLog("Error : [SetFilePointer] , GetLastError : " & GetLastError())
			#EndIf
			GetFile = GetLastError()
		Else
			Dim TOL As OVERLAPPED
			TOL.Offset = oRet
			If ReadFile(File_HANDLE,InBuffer,GetLenght,NULL,@TOL) Then
				GetFile = 0
			Else
				#Ifdef LogOutPut
					AddLog("Error : [ReadFile] , GetLastError : " & GetLastError())
				#EndIf
				GetFile = GetLastError()
			EndIf
		EndIf
	EndIf
	CloseHandle(File_HANDLE)
End Function


/'
	�������� : PutFile_h
	�������� : Ҷ�ӵ��뿪
	�������� : ��ָ������д�뵽ָ���ļ������
	�ݴ����� : �Ͻ�������
	����˵�� : File_HANDLE[�ļ����]		OutBuffer[д�������]		StartPoint[д����ʼ��]		GetLenght[��ȡ����]
	�� �� ֵ : �ɹ����� 0 , ����Ϊ GetLastError ȡ�õ���ֵ
'/
Function GetFile_h(ByVal File_HANDLE As HANDLE,ByVal InBuffer As Any Ptr,ByVal StartPoint As Integer,ByVal GetLenght As Integer) As Integer
	#Ifdef LogOutPut
	AddLog("	GetFile_h	����ִ�� , �����б� : File_HANDLE[" & File_HANDLE & "]  StartPoint[" & StartPoint & "]  GetLenght[" & GetLenght & "]")
	#EndIf
	Dim As Integer oRet = SetFilePointer(File_HANDLE,StartPoint,NULL,FILE_BEGIN)
	If oRet = -1 Then
		#Ifdef LogOutPut
			AddLog("Error : [SetFilePointer] , GetLastError : " & GetLastError())
		#EndIf
		GetFile_h = GetLastError()
	Else
		Dim TOL As OVERLAPPED
		TOL.Offset = oRet
		If ReadFile(File_HANDLE,InBuffer,GetLenght,NULL,@TOL) Then
			GetFile_h = 0
		Else
			#Ifdef LogOutPut
			AddLog("Error : [ReadFile] , GetLastError : " & GetLastError())
			#EndIf
			GetFile_h = GetLastError()
		EndIf
	EndIf
End Function


/'
	�������� : FileExists
	�������� : Ҷ�ӵ��뿪
	�������� : �ж�һ���ļ��Ƿ����
	�ݴ����� : �Ͻ�������
	����˵�� : FileName[�ļ���]
	�� �� ֵ : �ɹ����� -1 , ʧ�ܷ��� 0
'/
Function FileExists(ByVal FileName As ZString Ptr) As Integer
	Dim File_HANDLE As HANDLE
	#Ifdef LogOutPut
		AddLog("	FileExists	����ִ�� , �����б� : FileName[" & *FileName & "]")
	#EndIf
	File_HANDLE = CreateFile(FileName,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL)
	If File_HANDLE <> INVALID_HANDLE_VALUE Then
		FileExists = -1
	EndIf
	CloseHandle(File_HANDLE)
End Function


/'
	�������� : FileLen
	�������� : Ҷ�ӵ��뿪
	�������� : ȡ��ָ���ļ��Ĵ�С
	�ݴ����� : �Ͻ�������
	����˵�� : FileName[�ļ���]
	�� �� ֵ : �ɹ������ļ���С , ʧ�ܷ��� 0
'/
Function FileLen(ByVal FileName As ZString Ptr) As Integer
	Dim File_HANDLE As HANDLE
	#Ifdef LogOutPut
		AddLog("	FileLen	����ִ�� , �����б� : FileName[" & *FileName & "]")
	#EndIf
	File_HANDLE = CreateFile(FileName,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)
	If File_HANDLE = INVALID_HANDLE_VALUE Then
		#Ifdef LogOutPut
			AddLog("Error : [CreateFile] , GetLastError : " & GetLastError())
		#EndIf
	Else
		FileLen = GetFileSize(File_HANDLE,NULL)
		CloseHandle(File_HANDLE)
	EndIf
End Function


/'
	�������� : FileLen_h
	�������� : Ҷ�ӵ��뿪
	�������� : ȡ��ָ���ļ������Ӧ�ļ��Ĵ�С
	�ݴ����� : �Ͻ�������
	����˵�� : File_HANDLE[�ļ����]
	�� �� ֵ : �ɹ������ļ���С , ʧ�ܷ��� 0
'/
Function FileLen_h(ByVal File_HANDLE As HANDLE) As Integer
	#Ifdef LogOutPut
		AddLog("	FileLen_h	����ִ�� , �����б� : File_HANDLE[" & File_HANDLE & "]")
	#EndIf
	FileLen_h = GetFileSize(File_HANDLE,NULL)
End Function


/'
	�������� : GetOpenFile
	�������� : Ҷ�ӵ��뿪
	�������� : ��һ���ļ������ؾ��
	�ݴ����� : �Ͻ�������
	����˵�� : FileName[�ļ���]
	�� �� ֵ : �ɹ������ļ���� , ʧ�ܷ��� -1
'/
Function GetOpenFile(ByVal FileName As ZString Ptr,OnlyRead As Integer = 0) As HANDLE
	Dim File_HANDLE As HANDLE
	#Ifdef LogOutPut
		AddLog("	GetOpenFile	����ִ�� , �����б� : FileName[" & *FileName & "]")
	#EndIf
	If OnlyRead Then
		File_HANDLE = CreateFile(FileName,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)
	Else
		File_HANDLE = CreateFile(FileName,GENERIC_READ Or GENERIC_WRITE,FILE_SHARE_READ,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)
	EndIf
	If File_HANDLE = INVALID_HANDLE_VALUE Then
	Else
		GetOpenFile = File_HANDLE
	EndIf
End Function


Sub GetRandomFileName(ByVal FileName As ZString Ptr,ByVal DirStr As ZString Ptr,ByVal EndStr As ZString Ptr,ByVal RndStrLen As Integer = 8)
	Dim RndFile As ZString Ptr = Allocate(260)
	Dim i As Integer
	Do
		ZeroMemory(RndFile,260)
		Dim TempFile As ZString Ptr = Allocate(260)
		If DirStr = NULL Then
			If GetTempPath(260,TempFile) Then
				*RndFile = *TempFile
			Else
				*RndFile = ExePath()
			EndIf
		Else
			*RndFile = *DirStr
		EndIf
		DeAllocate(TempFile)
		For i = 1 To RndStrLen
			Randomize()
			*RndFile &= Chr(CByte(Rnd * 26) + 65)
		Next
		If EndStr <> NULL Then
			*RndFile &= *EndStr
		EndIf
		If FileExists(RndFile)=0 Then Exit Do
	Loop
	lstrcpy(FileName,RndFile)
	DeAllocate(RndFile)
End Sub

/'
	�������� : SetFileSize
	�������� : Ҷ�ӵ��뿪
	�������� : ֱ������һ���ļ��Ĵ�С
	�ݴ����� : ���Ͻ�������
	����˵�� : FileName[�ļ���]		FileSize[�ļ���С]
	�� �� ֵ : �ɹ����� -1 , ʧ�ܷ��� 0
'/
Function SetFileSize(ByVal FileName As ZString Ptr,ByVal FileSize As Integer) As Integer
	Dim File_HANDLE As HANDLE
	#Ifdef LogOutPut
		AddLog("	SetFileSize	����ִ�� , �����б� : FileName[" & *FileName & "]  FileSize[" & FileSize & "]")
	#EndIf
	File_HANDLE = CreateFile(FileName,GENERIC_READ Or GENERIC_WRITE,FILE_SHARE_READ,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)
	If File_HANDLE = INVALID_HANDLE_VALUE Then
		#Ifdef LogOutPut
			AddLog("Error : [CreateFile] , GetLastError : " & GetLastError())
		#EndIf
	Else
		SetFilePointer(File_HANDLE,FileSize,0,FILE_BEGIN)
		SetEndOfFile(File_HANDLE)
		SetFileSize = -1
		CloseHandle(File_HANDLE)
	EndIf
End Function


/'
	�������� : PutLogFile
	�������� : Ҷ�ӵ��뿪
	�������� : ������ݵ��ļ����Զ������ļ���С
	�ݴ����� : ���Ͻ�������
	����˵�� : FileName[�ļ���]		OutBuffer[д�������]		StartPoint[д����ʼ��]		OutLenght[д�볤��]
	�� �� ֵ : �ɹ����� 0 , ����Ϊ GetLastError ȡ�õ���ֵ
'/
Function PutLogFile(ByVal FileName As ZString Ptr,ByVal OutBuffer As Any Ptr,ByVal StartPoint As Integer,ByVal OutLenght As Integer) As Integer
	PutLogFile = PutFile(FileName,OutBuffer,StartPoint,OutLenght)
	SetFileSize(FileName,OutLenght+StartPoint)
End Function


/'
	�������� : NewFile
	�������� : Ҷ�ӵ��뿪
	�������� : �½�һ���ļ�
	�ݴ����� : �Ͻ�������
	����˵�� : FileName[�ļ���]
	�� �� ֵ : �ɹ����� -1 , ʧ�ܷ��� 0
'/
Function NewFile(ByVal FileName As ZString Ptr) As Integer
	Dim File_HANDLE As HANDLE
	#Ifdef LogOutPut
		AddLog("	NewFile	����ִ�� , �����б� : FileName[" & *FileName & "]")
	#EndIf
	File_HANDLE = CreateFile(FileName,GENERIC_WRITE,FILE_SHARE_READ,NULL,CREATE_NEW,FILE_ATTRIBUTE_NORMAL,NULL)
	If File_HANDLE = INVALID_HANDLE_VALUE Then
		#Ifdef LogOutPut
			AddLog("Error : [CreateFile] , GetLastError : " & GetLastError())
		#EndIf
	Else
		NewFile = -1
	EndIf
	CloseHandle(File_HANDLE)
End Function



Function OpenFolderDlg(ByVal hWin As HWND,ByVal OutPath As ZString Ptr) As Integer
	Dim ShellHdr As HANDLE
	ShellHdr = LoadLibrary("shell32.dll")
	If ShellHdr Then
		Dim SHBrowseForFolder As Function(lpBrowseInfo As Any Ptr) As Any Ptr
		SHBrowseForFolder = Cast(Any Ptr,GetProcAddress(ShellHdr,"SHBrowseForFolderA"))
		If SHBrowseForFolder Then
			Dim Bi As BROWSEINFO
			Bi.hwndOwner = hWin
			Bi.pidlRoot = NULL
			Bi.pszDisplayName = Allocate(256)
			Bi.lpszTitle = StrPtr("����ļ��� :")
			Bi.ulFlags = 0
			Bi.lpfn = NULL
			Bi.lParam = 0
			Bi.iImage = NULL
			Dim IDList As Any Ptr
			IDList = SHBrowseForFolder(@Bi)
			If IDList Then
				Dim SHGetPathFromIDList As Function(lpIDList As Any Ptr,OutBuffer As Any Ptr) As Integer
				SHGetPathFromIDList = Cast(Any Ptr,GetProcAddress(ShellHdr,"SHGetPathFromIDListA"))
				If SHGetPathFromIDList Then
					SHGetPathFromIDList(IDList,OutPath)
					OpenFolderDlg = -1
				EndIf
			EndIf
		EndIf
	EndIf
End Function

Function OpenFileDlg(ByVal hWin As HWND,ByVal FilePath As ZString Ptr,ByVal FilterStr As ZString Ptr) As Integer
	Dim ofn As OPENFILENAME
	ofn.lStructSize = SizeOf(OPENFILENAME)
	ofn.hwndOwner = hWin
	ofn.hInstance = GetModuleHandle(NULL)
	ofn.lpstrFilter = FilterStr
	ofn.lpstrFile = FilePath
	ofn.lpstrInitialDir = FilePath
	ofn.nMaxFile = 260
	ofn.lpstrTitle = StrPtr("���ļ� :")
	ofn.Flags = OFN_PATHMUSTEXIST Or OFN_HIDEREADONLY Or OFN_FILEMUSTEXIST Or OFN_EXPLORER
	If GetOpenFileName(@ofn) Then
		OpenFileDlg = -1
	EndIf
End Function

Function SaveFileDlg(ByVal hWin As HWND,ByVal FilePath As ZString Ptr,ByVal FilterStr As ZString Ptr) As Integer
	Dim ofn As OPENFILENAME
	ofn.lStructSize = SizeOf(OPENFILENAME)
	ofn.hwndOwner = hWin
	ofn.hInstance = GetModuleHandle(NULL)
	ofn.lpstrFilter = FilterStr
	ofn.lpstrFile = FilePath
	ofn.lpstrInitialDir = FilePath
	ofn.nMaxFile = 260
	ofn.lpstrTitle = StrPtr("�����ļ� :")
	ofn.Flags = OFN_PATHMUSTEXIST Or OFN_HIDEREADONLY Or OFN_OVERWRITEPROMPT Or OFN_EXPLORER
	If GetSaveFileName(@ofn) Then
		SaveFileDlg = -1
	EndIf
End Function