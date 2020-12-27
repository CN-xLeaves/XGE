#pragma once
#include "afxwin.h"


// CEditBox �Ի���
class CEditBox : public CDialog
{
	DECLARE_DYNAMIC(CEditBox)

public:
	CEditBox(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CEditBox();

// �Ի�������
	enum { IDD = IDD_EDIT };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��
	DECLARE_MESSAGE_MAP()
public:
	WCHAR* m_pzTable;
	CEdit m_editTable;
	afx_msg void OnBnClickedBtnLoad();
	afx_msg void OnBnClickedBtnSave();
	afx_msg void OnBnClickedBtnNum();
	afx_msg void OnBnClickedBtnLetter();
	afx_msg void OnBnClickedOk();
	virtual BOOL OnInitDialog();
	afx_msg void OnBnClickedBtnDedup();
};
