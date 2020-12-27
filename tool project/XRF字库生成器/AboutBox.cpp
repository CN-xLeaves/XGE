// AboutBox.cpp : 实现文件
//

#include "stdafx.h"
#include "FontMakerApp.h"
#include "AboutBox.h"


// CAboutBox 对话框
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


// CAboutBox 消息处理程序
static WCHAR szLicense[]=
{
	L"本软件基于《点阵字库生成工具》二次开发\r\n感谢原作者【星沉地动】提供的开源代码\r\n\r\n* 注意 * 本软件生成的文件格式与其他字库不同，仅供XGE游戏引擎使用",
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
