#Include Once "Windows.bi"
#Include Once "win\commdlg.bi"



#Define xywh_library_ddlg



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



Dim Shared xywh_library_ddlg_CustColors(1 To 16) As Integer



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
			Bi.lpszTitle = StrPtr("浏览文件夹")
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
	ofn.lpstrTitle = StrPtr("打开文件")
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
	ofn.lpstrTitle = StrPtr("保存文件")
	ofn.Flags = OFN_PATHMUSTEXIST Or OFN_HIDEREADONLY Or OFN_OVERWRITEPROMPT Or OFN_EXPLORER
	If GetSaveFileName(@ofn) Then
		SaveFileDlg = -1
	EndIf
End Function

Function GetFont(ByVal hWnd As HWND,ByVal Font As LOGFONT Ptr) As Integer
	Dim cf As CHOOSEFONT
	cf.lStructSize = SizeOf(cf)
	cf.hwndOwner = hWnd
	cf.lpLogFont = Font
	cf.Flags = CF_SCREENFONTS or CF_INITTOLOGFONTSTRUCT or CF_EFFECTS
	If ChooseFont(@cf) Then
		Return -1
	EndIf
End Function

Function GetColor(ByVal hWnd As HWND,ByVal ColorVal As UInteger Ptr) As Integer
	Dim cc As CHOOSECOLOR
	cc.lStructSize = SizeOf(cc)
	cc.hwndOwner = hWnd
	cc.rgbResult = *ColorVal
	cc.lpCustColors = Cast(Any Ptr,@xywh_library_ddlg_CustColors(1))
	cc.Flags = CC_RGBINIT or CC_FULLOPEN
	If ChooseColor(@cc) Then
		*ColorVal = cc.rgbResult
		Return -1
	EndIf
End Function
