// TestDsPropSheetExt.cpp : Implementation of CTestDsPropSheetExt

#include "stdafx.h"
#include "FirstPage.h"
#include "TestDsPropSheetExt.h"
#include <Dsclient.h>
#include <Adsprop.h>


// CTestDsPropSheetExt

    //IShellExtInit:
STDMETHODIMP CTestDsPropSheetExt::Initialize( 
            /* [in] */ LPCITEMIDLIST pidlFolder,
            /* [in] */ IDataObject *pdtobj,
            /* [in] */ HKEY hkeyProgID)
{
    AFX_MANAGE_STATE(AfxGetStaticModuleState())
//_asm
//{
//	int 3
//}

	m_piDataObject = pdtobj;
    HRESULT hr = S_OK;
    if(!pdtobj)
    {
        hr = E_INVALIDARG;
    }
    else
    {
        // Register clipboard format and use it.
        CLIPFORMAT cfDsObjectNames = RegisterClipboardFormat(CFSTR_DSOBJECTNAMES);
        CLIPFORMAT cfDsDisplayScopeOptions = RegisterClipboardFormat(CFSTR_DS_DISPLAY_SPEC_OPTIONS);

        LPDSOBJECTNAMES pDsObjectNames;
        FORMATETC fmte = { cfDsObjectNames, NULL, DVASPECT_CONTENT, -1, TYMED_HGLOBAL};
        STGMEDIUM objMedium = {TYMED_NULL};
 
        hr = pdtobj->GetData(&fmte, &objMedium);
 
        if (SUCCEEDED(hr))
        {
            pDsObjectNames = (LPDSOBJECTNAMES)::GlobalLock(objMedium.hGlobal); 
 
            if (!pDsObjectNames || pDsObjectNames->cItems != 1)
            {
                hr = E_FAIL;
                if(pDsObjectNames)
                {
                    ::GlobalUnlock(objMedium.hGlobal); 
                }
            }
            else
            {           
                m_strDN = (PWSTR)(((LPBYTE)pDsObjectNames) + pDsObjectNames->aObjects[0].offsetName);
                m_strObjectClass   = (PWSTR)(((LPBYTE)pDsObjectNames) + pDsObjectNames->aObjects[0].offsetClass);

			 //   HWND        hwndNotifyObject = NULL;

    //        
	   //         hr = ADsPropCreateNotifyObj(pdtobj, 
				//	(PWSTR)(((LPBYTE)pDsObjectNames) + pDsObjectNames->aObjects[0].offsetName), 
				//	&hwndNotifyObject);

				//ADSPROPINITPARAMS Param = {0};
				//Param.dwSize = sizeof(ADSPROPINITPARAMS);				
				//hr = ::ADsPropGetInitInfo(hwndNotifyObject, &Param);


                ::GlobalUnlock(objMedium.hGlobal); 
            }
            // Release the objMedium.
            ReleaseStgMedium(&objMedium);
        } 
        memset(&objMedium, 0, sizeof(STGMEDIUM));
        fmte.cfFormat = cfDsDisplayScopeOptions;

        hr = pdtobj->GetData(&fmte, &objMedium);
        if(SUCCEEDED(hr))
        {
            DSDISPLAYSPECOPTIONS* pdso = (DSDISPLAYSPECOPTIONS*)objMedium.hGlobal;
            if(pdso)
            {
                //if any of next pdso fields: offsetUserName, offsetPassword, offsetServer or 
                //offsetServerConfigPath is equal to 0 then corresponding string is unavailable
                m_dwFlags = pdso->dwFlags;
                if(pdso->offsetUserName)
                {
                    m_strUserName = (LPWSTR)((LPBYTE)pdso + pdso->offsetUserName);
                }
                if(pdso->offsetPassword)
                {
                    m_strPwd = (LPWSTR)((LPBYTE)pdso + pdso->offsetPassword);
                }
                if(pdso->offsetServer)
                {
                    m_strADServer = (LPWSTR)((LPBYTE)pdso + pdso->offsetServer);
                }
                if(pdso->offsetServerConfigPath)
                {
                    m_strServerConfigPath = (LPWSTR)((LPBYTE)pdso + pdso->offsetServerConfigPath);
                }
            }
            ReleaseStgMedium(&objMedium);
        }
    }
    return hr;
}


//IShellPropSheetExt 
STDMETHODIMP CTestDsPropSheetExt::AddPages( 
    /* [in] */ LPFNSVADDPROPSHEETPAGE pfnAddPage,
    /* [in] */ LPARAM lParam)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState())
    HRESULT hr = E_FAIL;
	CFirstPage* pPage = new CFirstPage;
	if(pPage)
	{
		pPage->m_strDN = m_strDN;
		pPage->m_strUserName = m_strUserName;
		pPage->m_strPassword = m_strPwd;
		pPage->m_piDataObject = m_piDataObject;
		HPROPSHEETPAGE hPage = CreatePropertySheetPage( (PROPSHEETPAGE*)&pPage->m_psp );
		if (hPage != NULL)
		{
			if(pfnAddPage(hPage, lParam))
			{
				hr = S_OK;
			}
			else
			{
				::DestroyPropertySheetPage(hPage);
			}
		}
	}
    return hr;
}

STDMETHODIMP CTestDsPropSheetExt::ReplacePage( 
    /* [in] */ EXPPS uPageID,
    /* [in] */ LPFNSVADDPROPSHEETPAGE pfnReplaceWith,
    /* [in] */ LPARAM lParam)
{
	return E_NOTIMPL;
}