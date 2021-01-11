// EditBox.cpp : 实现文件
#include "stdafx.h"
#include "FontMakerApp.h"
#include "EditBox.h"

static int UnicodeToUTF8(const WCHAR* input, char* output, int size)
{
	return WideCharToMultiByte(CP_UTF8, 0, input, -1, output, size, NULL, NULL);		
}

static int UTF8ToUnicode(const char* input, WCHAR* output, int size)
{
	return MultiByteToWideChar(CP_UTF8, 0, input, -1, output, size);
}

// CEditBox 对话框
IMPLEMENT_DYNAMIC(CEditBox, CDialog)

CEditBox::CEditBox(CWnd* pParent /*=NULL*/)
	: CDialog(CEditBox::IDD, pParent)
{
	m_pzTable = (WCHAR*)malloc(4);
	wcscpy_s(m_pzTable, 4, L"0");
}

CEditBox::~CEditBox()
{
	if(m_pzTable != NULL)
	{
		free(m_pzTable);
	}
}

void CEditBox::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_EDIT_TABLE, m_editTable);
}


BEGIN_MESSAGE_MAP(CEditBox, CDialog)
	ON_BN_CLICKED(IDC_BTN_LOAD, &CEditBox::OnBnClickedBtnLoad)
	ON_BN_CLICKED(IDC_BTN_SAVE, &CEditBox::OnBnClickedBtnSave)
	ON_BN_CLICKED(IDC_BTN_NUM, &CEditBox::OnBnClickedBtnNum)
	ON_BN_CLICKED(IDC_BTN_LETTER, &CEditBox::OnBnClickedBtnLetter)
	ON_BN_CLICKED(IDOK, &CEditBox::OnBnClickedOk)
	ON_BN_CLICKED(IDC_BTN_DEDUP, &CEditBox::OnBnClickedBtnDedup)
END_MESSAGE_MAP()


// CEditBox 消息处理程序
void CEditBox::OnBnClickedBtnLoad()
{
	int len;
	UINT size;
	char *buf;
	WCHAR *text;
	CFile cf;
	CString name;
	CFileDialog fd(1,NULL,NULL,OFN_HIDEREADONLY|OFN_FILEMUSTEXIST|OFN_ENABLESIZING,L"文本文件|*.txt|所有文件|*.*||");
	if(fd.DoModal()!=IDOK)
	{
		return;
	}
	name = fd.GetPathName();
	if(!cf.Open(name,CFile::modeRead|CFile::shareDenyNone))
	{
		MessageBox(L"无法打开文件!",L"载入失败",MB_OK|MB_ICONINFORMATION);
		return;
	}
	size = (UINT)cf.GetLength();
	buf = (char *)HeapAlloc(GetProcessHeap(),HEAP_ZERO_MEMORY, size + 1);
	if(buf == NULL)
	{
		cf.Close();
		MessageBox(L"内存不足!",L"载入失败",MB_OK|MB_ICONINFORMATION);
		return;
	}

	if(cf.Read(buf, size) != size)
	{
		cf.Close();
		HeapFree(GetProcessHeap(), 0, buf);
		MessageBox(L"读取文件时发生错误!",L"载入失败",MB_OK|MB_ICONINFORMATION);
		return;
	}
	cf.Close();

	len = UTF8ToUnicode(buf, NULL, 0) + 1;
	text = (WCHAR *)HeapAlloc(GetProcessHeap(),HEAP_ZERO_MEMORY, len * sizeof(WCHAR));
	if(text == NULL)
	{
		HeapFree(GetProcessHeap(), 0, buf);
		MessageBox(L"内存不足!",L"载入失败",MB_OK|MB_ICONINFORMATION);
		return;
	}

	len = UTF8ToUnicode(buf, text, len);
	m_editTable.SetWindowText(text);
	HeapFree(GetProcessHeap(), 0, text);
}

void CEditBox::OnBnClickedBtnSave()
{
	int len;
	char *buf;
	CFile cf;
	CString name;
	CString text;
	
	m_editTable.GetWindowText(text);
	len = UnicodeToUTF8(text, NULL, 0) + 1;
	buf = (char *)HeapAlloc(GetProcessHeap(),HEAP_ZERO_MEMORY, len);
	if(buf == NULL)
	{
		MessageBox(L"内存不足!",L"操作失败",MB_OK|MB_ICONINFORMATION);
		return;
	}
	len = UnicodeToUTF8(text, buf, len);

	CFileDialog fd(0,NULL,NULL,OFN_OVERWRITEPROMPT|OFN_ENABLESIZING,L"所有文件|*.*||");
	if(fd.DoModal()!=IDOK)
	{
		HeapFree(GetProcessHeap(), 0, buf);
		return;
	}
	name = fd.GetPathName();
	if(!cf.Open(name,CFile::modeCreate|CFile::modeReadWrite|CFile::shareDenyNone))
	{
		HeapFree(GetProcessHeap(), 0, buf);
		MessageBox(L"无法创建文件!",L"保存失败",MB_OK|MB_ICONINFORMATION);
		return;
	}
	cf.Write(buf, len - 1);
	cf.Close();
	HeapFree(GetProcessHeap(), 0, buf);
}

void CEditBox::OnBnClickedBtnNum()
{
	m_editTable.ReplaceSel(L"0123456789");
	m_editTable.SetFocus();
}

void CEditBox::OnBnClickedBtnLetter()
{
	m_editTable.ReplaceSel(L"abcdefghijklmnopqrstuvwxyz");
	m_editTable.ReplaceSel(L"ABCDEFGHIJKLMNOPQRSTUVWXYZ");
	m_editTable.SetFocus();
}

void CEditBox::OnBnClickedBtnDedup()
{
	int i;
	int len;
	int cnt;
	WCHAR ch;
	WCHAR *buf;
	CString text;

	m_editTable.GetWindowText(text);
	cnt = 0;
	len = text.GetLength();
	buf = (WCHAR *)HeapAlloc(GetProcessHeap(),HEAP_ZERO_MEMORY, (len + 1) * sizeof(WCHAR));
	if(buf == NULL)
	{
		MessageBox(L"内存不足!",L"操作失败",MB_OK|MB_ICONINFORMATION);
		return;
	}
	for(i=0; i<len; i++)
	{
		ch = text.GetAt(i);
		if(wcschr(buf, ch) == NULL)
		{
			buf[cnt] = ch;
			cnt++;
		}
	}
	m_editTable.SetWindowText(buf);
	HeapFree(GetProcessHeap(), 0, buf);
}

void CEditBox::OnBnClickedOk()
{
	int len;
	len = m_editTable.GetWindowTextLength();
	if(len<=0)
	{
		MessageBox(L"码表不能为空!",L"警告",MB_OK|MB_ICONWARNING);
		return;
	}
	if(m_pzTable!=NULL)
	{
		free(m_pzTable);
	}
	m_pzTable = (WCHAR*)malloc(len*2+2);
	if(m_pzTable != NULL)
	{
		m_editTable.GetWindowText(m_pzTable,len+1);
	}
	OnOK();
}

BOOL CEditBox::OnInitDialog()
{
	CDialog::OnInitDialog();
	SetWindowText(L"自定义码表");
	if(m_pzTable!=NULL)
	{
		m_editTable.SetWindowText(m_pzTable);
	}
	return TRUE;
}
