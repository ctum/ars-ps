// EDMExtInit.cpp : Implementation of CEDMExtInit
#include "stdafx.h"
#include "TryIContextMenu.h"
#include "EDMExtInit.h"

/////////////////////////////////////////////////////////////////////////////
// CEDMExtInit


STDMETHODIMP CEDMExtInit::PutEDMServer(BSTR bstrServer)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState())
    m_strServer = bstrServer;	

	return S_OK;
}

//IContextMenu:
STDMETHODIMP CEDMExtInit::QueryContextMenu(HMENU hmenu,
                            UINT indexMenu,
                            UINT idCmdFirst,
                            UINT idCmdLast,
                            UINT uFlags)
{
    AFX_MANAGE_STATE(AfxGetStaticModuleState())
    HRESULT hr;
    if(hmenu && !(uFlags & CMF_DEFAULTONLY) )
    {
        ::InsertMenu(hmenu, indexMenu, MF_STRING | MF_BYPOSITION, idCmdFirst, m_strCommandText);
        //result should be:
        //offset of the largest command identifier was assigned plus one
        //here I insert only one command with ID == idCmdFirst.
        //So return code equal to idCmdFirst - idCmdFirst + 1 i.e. 1
        hr = MAKE_HRESULT(SEVERITY_SUCCESS, 0, USHORT(1));
    }
    else
    {
        //if I decide what this situation is error then I should return some OLE return value
        //for example E_UNEXPECTED
        hr = MAKE_HRESULT(SEVERITY_SUCCESS, 0, USHORT(0));
    }
    return hr;
}

STDMETHODIMP CEDMExtInit::InvokeCommand(LPCMINVOKECOMMANDINFO lpici)
{
    AFX_MANAGE_STATE(AfxGetStaticModuleState())
    HRESULT hr = E_INVALIDARG;
    if(lpici && !HIWORD(lpici->lpVerb))
    {
        if(!LOWORD(lpici->lpVerb))
        {            
            //cmd offset is always 0 for CEDMExtInit 
            //because of we have only one command inserted into menu! 
            CString strParam;
            CString strFlags;
            if(m_dwFlags & DSDSOF_HASUSERANDSERVERINFO)
            {
                strFlags = _T("DSDSOF_HASUSERANDSERVERINFO");
            }
            if(m_dwFlags & DSDSOF_SIMPLEAUTHENTICATE)
            {
                strFlags += _T(" | DSDSOF_SIMPLEAUTHENTICATE");
            }
            if(m_dwFlags & DSDSOF_DONTSIGNSEAL)
            {
                strFlags += _T(" | DSDSOF_DONTSIGNSEAL");
            }

            if(m_dwFlags & DSDSOF_DSAVAILABLE)
            {
                strFlags += _T(" | DSDSOF_DSAVAILABLE");
            }
            

            strParam.Format(_T("Path: %s\nClass: %s\nEDMServer:%s\nDSDISPLAYSPECOPTIONS:\n")
                _T("\tdwFlags: %s\n\tUserName: %s\n\tPassword: %s\n\tServer: %s\n\tConfig:%s"), m_strDN, m_strObjectClass, m_strServer, strFlags,
                m_strUserName, m_strPwd, m_strADServer, m_strServerConfigPath);
            ::MessageBox(lpici->hwnd, strParam, ::AfxGetAppName(), MB_OK | MB_ICONEXCLAMATION);

            hr = S_OK;
        }
    }
    return hr;
}

STDMETHODIMP CEDMExtInit::GetCommandString(UINT_PTR    idCmd,
                            UINT        uType,
                            UINT      * pwReserved,
                            LPSTR       pszName,
                            UINT        cchMax)
{
    AFX_MANAGE_STATE(AfxGetStaticModuleState())
    HRESULT hr = E_INVALIDARG;
    if(!idCmd)
    {
        //cmd offset is always 0 for CEDMExtInit! 
        if(uType == GCS_HELPTEXTW)
        {
            //Unicode help string for command is requested
            //for detailed information see MSDN IContextMenu::GetCommandString 
            hr = S_OK;
            lstrcpyn((LPTSTR)pszName, m_strCommandText, cchMax);
        }
    }
    return hr;
}

//IShellExtInit:
STDMETHODIMP CEDMExtInit::Initialize( 
        /* [in] */ LPCITEMIDLIST pidlFolder,
        /* [in] */ IDataObject *pdtobj,
        /* [in] */ HKEY hkeyProgID)
{
    AFX_MANAGE_STATE(AfxGetStaticModuleState())
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