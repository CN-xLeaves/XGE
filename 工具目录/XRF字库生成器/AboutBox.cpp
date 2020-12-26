// AboutBox.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "FontMakerApp.h"
#include "AboutBox.h"


// CAboutBox �Ի���
IMPLEMENT_DYNAMIC(CAboutBox, CDialog)

CAboutBox::CAboutBox(CWnd* pParent /*=NULL*/)
	: CDialog(CAboutBox::IDD, pParent)
{

}

CAboutBox::~CAboutBox()
{
}

void CAboutBox::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}


BEGIN_MESSAGE_MAP(CAboutBox, CDialog)
END_MESSAGE_MAP()


// CAboutBox ��Ϣ�������
static WCHAR szLicense[]=
{
	L"��������ڡ������ֿ����ɹ��ߡ����ο���\r\n��лԭ���ߡ��ǳ��ض����ṩ�Ŀ�Դ����\r\n\r\n* ע�� * ��������ɵ��ļ���ʽ�������ֿⲻͬ������XGE��Ϸ����ʹ��",
};

static WCHAR szVersion[]=
{
	L"xywhRasterFont Maker\r\n\r\n"
	L"Version : 1.0.0\r\n"
	L"Build : 2020.12.23\r\n"
	L"Developer : CN-xLeaves\r\n"
	L"QQ : 605072846\r\n"
	L"e-mail : xywhsoft@qq.com\r\n"
};

BOOL CAboutBox::OnInitDialog()
{
	CDialog::OnInitDialog();
	SetDlgItemText(IDC_EDIT1, szVersion);
	SetDlgItemText(IDC_EDIT2, szLicense);
	return TRUE;
}
