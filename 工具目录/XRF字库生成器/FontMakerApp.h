// FontMaker.h : PROJECT_NAME Ӧ�ó������ͷ�ļ�
//

#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"		// ������


// CFontMakerApp:
// �йش����ʵ�֣������ FontMaker.cpp
//

class CFontMakerApp : public CWinApp
{
public:
	CFontMakerApp();
private:
	BOOL bHelp;
// ��д
public:
	virtual BOOL InitApplication();
	virtual BOOL InitInstance();
	BOOL GetPath(CString& path);
	void OnHelp();
// ʵ��
	DECLARE_MESSAGE_MAP()
};

extern CFontMakerApp theApp;