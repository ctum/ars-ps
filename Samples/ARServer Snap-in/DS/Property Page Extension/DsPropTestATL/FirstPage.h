#pragma once

typedef struct _DSA_SEC_PAGE_INFO 
{  
	HWND hwndParentSheet;  
	DWORD offsetTitle;  
	DSOBJECTNAMES dsObjectNames;
} DSA_SEC_PAGE_INFO, *PDSA_SEC_PAGE_INFO;

#define WM_ADSPROP_SHEET_CREATE (WM_USER + 1108)


// CFirstPage dialog

class CFirstPage : public CPropertyPage
{
	DECLARE_DYNAMIC(CFirstPage)
protected:
	// description for target directory object
	CString m_strDescription;
	HWND	m_hwndNotifyObject;
public:
	CString m_strDN;
	CString m_strUserName;
	CString m_strPassword;
	CComPtr<IDataObject> m_piDataObject;

public:
	CFirstPage();
	virtual ~CFirstPage();
	virtual BOOL OnInitDialog();

// Dialog Data
	enum { IDD = IDD_PROPPAGE_LARGE };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	static UINT CALLBACK PropPageCallback(HWND hWnd, UINT uMessage, LPPROPSHEETPAGE pPropPage);
	afx_msg void OnButtonShowDN();
	DECLARE_MESSAGE_MAP()
};
