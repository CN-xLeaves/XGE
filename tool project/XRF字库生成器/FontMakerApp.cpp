// FontMaker.cpp : ����Ӧ�ó��������Ϊ��
//

#include "stdafx.h"
#include "FontMakerApp.h"
#include "FontMakerDlg.h"
#include "AboutBox.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CFontMakerApp
BEGIN_MESSAGE_MAP(CFontMakerApp, CWinApp)
	ON_COMMAND(ID_HELP, OnHelp)
END_MESSAGE_MAP()


// CFontMakerApp ����
CFontMakerApp::CFontMakerApp()
{
	bHelp=TRUE;
}


// Ψһ��һ�� CFontMakerApp ����
CFontMakerApp theApp;

BOOL CFontMakerApp::InitApplication()
{
	INITCOMMONCONTROLSEX InitCtrls;
	InitCtrls.dwSize = sizeof(InitCtrls);
	InitCtrls.dwICC = ICC_WIN95_CLASSES;
	InitCommonControlsEx(&InitCtrls);
	return TRUE;
}

// CFontMakerApp ��ʼ��
BOOL CFontMakerApp::InitInstance()
{
	CWinApp::InitInstance();
	CFontMakerDlg dlg;
	m_pMainWnd = &dlg;
	dlg.DoModal();
	return FALSE;
}

BOOL CFontMakerApp::GetPath(CString& path)
{
	int len;
	CString str;
	WCHAR* temp;
	temp= _wcsdup(m_pszHelpFilePath);
	str = m_pszHelpFilePath;
	len = str.ReverseFind(L'\\');
	temp[len+1] = L'\0';
	path = temp;
	free(temp);
	return TRUE;
}

void CFontMakerApp::OnHelp()
{
	CAboutBox abox;
	if(bHelp==TRUE)
	{
		bHelp=FALSE;
		abox.DoModal();
		bHelp=TRUE;
	}
}
