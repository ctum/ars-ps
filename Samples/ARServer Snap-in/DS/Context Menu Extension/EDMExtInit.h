// EDMExtInit.h : Declaration of the CEDMExtInit

#ifndef __EDMEXTINIT_H_
#define __EDMEXTINIT_H_

#include "resource.h"       // main symbols
#include "EDMExtInitIdl.h"


/////////////////////////////////////////////////////////////////////////////
// CEDMExtInit
class ATL_NO_VTABLE CEDMExtInit : 
	public CComObjectRootEx<CComSingleThreadModel>,
	public CComCoClass<CEDMExtInit, &CLSID_EDMExtInit>,
	public IDispatchImpl<IEDMExtInit, &IID_IEDMExtInit, &LIBID_TRYICONTEXTMENULib>,
    public IContextMenu, public IShellExtInit
{
public:
    CEDMExtInit() : m_strCommandText( _T("TryIContextMenu")), m_dwFlags(0)
	{
        
	}

DECLARE_REGISTRY_RESOURCEID(IDR_EDMEXTINIT)
DECLARE_NOT_AGGREGATABLE(CEDMExtInit)

DECLARE_PROTECT_FINAL_CONSTRUCT()

BEGIN_COM_MAP(CEDMExtInit)
	COM_INTERFACE_ENTRY(IEDMExtInit)
	COM_INTERFACE_ENTRY(IDispatch)
//	COM_INTERFACE_ENTRY(IContextMenu)
    COM_INTERFACE_ENTRY_IID(IID_IContextMenu, IContextMenu)
    COM_INTERFACE_ENTRY(IShellExtInit)
END_COM_MAP()

public:
    CString m_strCommandText;
    CString m_strDN;
    CString m_strObjectClass;
    CString m_strServer;

    //DSDISPLAYSPECOPTIONS:
    DWORD   m_dwFlags;
    CString m_strUserName;
    CString m_strPwd;
    CString m_strADServer;
    CString m_strServerConfigPath;
// IEDMExtInit
public:
	STDMETHOD(PutEDMServer)(BSTR bstrServer);

    //IContextMenu:
    STDMETHOD(QueryContextMenu)(HMENU hmenu,
                                UINT indexMenu,
                                UINT idCmdFirst,
                                UINT idCmdLast,
                                UINT uFlags);

    STDMETHOD(InvokeCommand)(LPCMINVOKECOMMANDINFO lpici);

    STDMETHOD(GetCommandString)(UINT_PTR    idCmd,
                                UINT        uType,
                                UINT      * pwReserved,
                                LPSTR       pszName,
                                UINT        cchMax);
    //IShellExtInit:
    STDMETHOD(Initialize)( 
            /* [in] */ LPCITEMIDLIST pidlFolder,
            /* [in] */ IDataObject *pdtobj,
            /* [in] */ HKEY hkeyProgID);
};

#endif //__EDMEXTINIT_H_
