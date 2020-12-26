#Include Once "Windows.bi"



#Define xywh_IsFind



#Define AllFile FILE_ATTRIBUTE_ARCHIVE Or FILE_ATTRIBUTE_COMPRESSED Or FILE_ATTRIBUTE_DIRECTORY Or FILE_ATTRIBUTE_HIDDEN Or FILE_ATTRIBUTE_NORMAL Or FILE_ATTRIBUTE_READONLY Or FILE_ATTRIBUTE_SYSTEM Or FILE_ATTRIBUTE_TEMPORARY
Dim Shared ExitFind As Integer


Enum Find_Rule
	NoAttribEx = 0		' 不限制
	FloderOnly = 1		' 只查找目录
	PointFloder = 2		' 去除根目录及父级目录
End Enum



Function FindFile(RootDir As String,Filter As String,Attrib As Integer,AttribEx As Find_Rule,Recursive As Integer,BackCall As Function(Path As String,FindData As WIN32_FIND_DATA) As Integer) As Integer
	Dim FindData As WIN32_FIND_DATA
	Dim FindHdr As HANDLE
	Dim FileNum As Integer
	ExitFind = 0
	FindHdr = FindFirstFile(RootDir & Filter,@FindData)
	If FindHdr <> INVALID_HANDLE_VALUE Then
		Dim FindOver As BOOLEAN = TRUE
		Do While FindOver
			If (FindData.dwFileAttributes And Attrib) = 0 Then		' 符合查找规则
				'Print "文件符合规则"
				If (FindData.cFileName=".") Or (FindData.cFileName="..") Then
					If AttribEx And PointFloder Then
						If BackCall Then
							ExitFind = BackCall(RootDir,FindData)
							If ExitFind Then
								Exit Do
							EndIf
						EndIf
						FileNum += 1
					EndIf
				Else		' 查找到子目录文件
					If FindData.dwFileAttributes And FILE_ATTRIBUTE_DIRECTORY Then
						If BackCall Then
							ExitFind = BackCall(RootDir,FindData)
							If ExitFind Then
								Exit Do
							EndIf
						EndIf
						FileNum += 1
						If Recursive Then			' 启用递归
							If (FindData.cFileName<>".") And (FindData.cFileName<>"..") Then
								FileNum += FindFile(RootDir & FindData.cFileName & "\",Filter,Attrib,AttribEx,Recursive,BackCall)
								If ExitFind Then
									Exit Do
								EndIf
							EndIf
						EndIf
					Else
						If (AttribEx And FloderOnly) = 0 Then
							If BackCall Then
								ExitFind = BackCall(RootDir,FindData)
								If ExitFind Then
									Exit Do
								EndIf
							EndIf
							FileNum += 1
						EndIf
					EndIf
				EndIf
			EndIf
			FindOver = FindNextFile(FindHdr,@FindData)
		Loop
	EndIf
	FindClose(FindHdr) 
	FindFile = FileNum
End Function