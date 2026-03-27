// FirstPage.cpp : implementation file
//

#include "stdafx.h"
#include "DsPropTestATL.h"
#include "FirstPage.h"
#include "resource.h"

// CFirstPage dialog

IMPLEMENT_DYNAMIC(CFirstPage, CPropertyPage)
CFirstPage::CFirstPage()
	: CPropertyPage(CFirstPage::IDD), m_hwndNotifyObject(NULL)
{
	m_psp.pfnCallback   = PropPageCallback;
}

CFirstPage::~CFirstPage()
{
}

void CFirstPage::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_DESCRIPTION_EDIT, m_strDescription);
}

BOOL CFirstPage::OnInitDialog()
{
	HWND        hwndNotifyObject = NULL;

	HRESULT hr = ADsPropCreateNotifyObj(m_piDataObject, 
		(PWSTR)m_strDN.GetBuffer(), 
		&m_hwndNotifyObject);

	m_strDN.ReleaseBuffer();
	ADSPROPINITPARAMS Param = {0};
	Param.dwSize = sizeof(ADSPROPINITPARAMS);				
	hr = ::ADsPropGetInitInfo(hwndNotifyObject, &Param);

	IADs *pads = NULL;
	LPCTSTR pszUserName = NULL;
	if(!m_strUserName.IsEmpty())
	{
		pszUserName = m_strUserName;
	}
	LPCTSTR pszPassword = NULL; 
	if(!m_strPassword.IsEmpty())
	{
		pszPassword = m_strPassword;
	}
	hr = ADsOpenObject(m_strDN, 
		pszUserName,
		pszPassword,
		ADS_SECURE_AUTHENTICATION, IID_IADs, (VOID**)&pads);
	if(SUCCEEDED(hr) && pads)
	{
		COleVariant var;
		pads->Get(L"Description", &var);
		m_strDescription = var;
		pads->Release();
	}
	return CPropertyPage::OnInitDialog();
}


BEGIN_MESSAGE_MAP(CFirstPage, CPropertyPage)
	ON_COMMAND(IDC_SHOW_PROPERTIES_BUTTON, OnButtonShowDN)
END_MESSAGE_MAP()

// was taken from MFC/src/DlgProp.cpp
__declspec(dllimport) UINT CALLBACK AfxPropPageCallback(HWND hWnd, UINT uMessage, LPPROPSHEETPAGE pPropPage);

// CFirstPage message handlers
UINT CALLBACK CFirstPage::PropPageCallback(HWND hWnd, UINT uMessage, LPPROPSHEETPAGE pPropPage)
{
    UINT uRes = AfxPropPageCallback(hWnd, uMessage, pPropPage);
    CFirstPage* pPage = (CFirstPage*)pPropPage->lParam;
    switch(uMessage)
    {
        case PSPCB_CREATE:
        {
            break;
        }
        case PSPCB_RELEASE:
        {            
            if (pPage)                 
            {
				if(pPage->m_hwndNotifyObject)
                {
					::SendMessage(pPage->m_hwndNotifyObject, 
                        WM_ADSPROP_NOTIFY_EXIT, 
                        0, 
                        0);

                    pPage->m_hwndNotifyObject = NULL;
                }

                delete pPage;                               
            }
            break;                
        }
    }
    return uRes;
}

void CFirstPage::OnButtonShowDN()
{
	CString strDN;
	CWnd* pwndDN = GetDlgItem(IDC_DN_FOR_PROPERTIES_EDIT);
	if(pwndDN)
	{
		pwndDN->GetWindowText(strDN);
	}
	if(!strDN.IsEmpty())
	{
		CString strObjectClass(_T("organizationalUnit"));
		CString strTitle = _T("Title");

		// fix bug for CR0167156...
		BOOL bChangeDN;

		strDN = strDN.TrimLeft();
		if (strDN.Left(5) != _T("LDAP:") && strDN.Left(5) != _T("EDMS:"))
		{
			strDN = _T("LDAP://")+strDN;
			bChangeDN = TRUE;
		}
		else bChangeDN = FALSE;
		if (strDN.Replace(_T("\\"), _T("/")) != 0) bChangeDN = TRUE;
		if (bChangeDN != 0) pwndDN->SetWindowText(strDN);

		int nSize = sizeof(DSA_SEC_PAGE_INFO) + 
			(strDN.GetLength() + 1) * sizeof(TCHAR) + //strDN 
			(strObjectClass.GetLength() + 1) * sizeof(TCHAR) + //strObjectClass
			(strTitle.GetLength() + 1) * sizeof(TCHAR);	//strTitle

		DSA_SEC_PAGE_INFO* pInfo = reinterpret_cast<DSA_SEC_PAGE_INFO*>(LocalAlloc(LPTR, nSize));
		ASSERT(pInfo);
		if(pInfo)
		{
			pInfo->dsObjectNames.cItems = 1;
			pInfo->dsObjectNames.aObjects[0].dwProviderFlags = DSPROVIDER_ADVANCED;
			pInfo->dsObjectNames.aObjects[0].offsetName = sizeof(DSOBJECTNAMES);
			pInfo->dsObjectNames.aObjects[0].offsetClass = sizeof(DSOBJECTNAMES) + 
				(strDN.GetLength() + 1) * sizeof(TCHAR);
			LPTSTR psz = (LPTSTR)(((BYTE*)(&pInfo->dsObjectNames)) + 
				pInfo->dsObjectNames.aObjects[0].offsetName);
			::_tcscpy(psz, strDN);
			psz =  (LPTSTR)(((BYTE*)(&pInfo->dsObjectNames)) + pInfo->dsObjectNames.aObjects[0].offsetClass);
			::_tcscpy(psz, strObjectClass);
			pInfo->offsetTitle = sizeof(DSA_SEC_PAGE_INFO) + 
				(strDN.GetLength() + 1) * sizeof(TCHAR) +
				(strObjectClass.GetLength() + 1) * sizeof(TCHAR);
			psz =  (LPTSTR)(((BYTE*)(pInfo)) + pInfo->offsetTitle);
			::_tcscpy(psz, strTitle);
			::SendMessage(m_hwndNotifyObject, WM_ADSPROP_SHEET_CREATE, (WPARAM)pInfo, 0);
		}
	}
}