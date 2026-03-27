// TestDsPropSheetExt.h : Declaration of the CTestDsPropSheetExt

#pragma once
#include "resource.h"       // main symbols

#include "DsPropTestATL.h"


// CTestDsPropSheetExt

class ATL_NO_VTABLE CTestDsPropSheetExt : 
	public CComObjectRootEx<CComSingleThreadModel>,
	public CComCoClass<CTestDsPropSheetExt, &CLSID_TestDsPropSheetExt>,
//	public IDispatchImpl<ITestDsPropSheetExt, &IID_ITestDsPropSheetExt, &LIBID_DsPropTestATLLib, /*wMajor =*/ 1, /*wMinor =*/ 0>
	public IShellExtInit, 
	public IShellPropSheetExt
{
protected:
    CString m_strDN;
    CString m_strObjectClass;

    //DSDISPLAYSPECOPTIONS:
    DWORD   m_dwFlags;
    CString m_strUserName;
    CString m_strPwd;
    CString m_strADServer;
    CString m_strServerConfigPath;
	CComPtr<IDataObject> m_piDataObject;

public:
	CTestDsPropSheetExt()
	{
	}

DECLARE_REGISTRY_RESOURCEID(IDR_TESTDSPROPSHEETEXT)


BEGIN_COM_MAP(CTestDsPropSheetExt)
//	COM_INTERFACE_ENTRY(ITestDsPropSheetExt)
//	COM_INTERFACE_ENTRY(IDispatch)
    COM_INTERFACE_ENTRY(IShellPropSheetExt)
    COM_INTERFACE_ENTRY(IShellExtInit)
END_COM_MAP()


	DECLARE_PROTECT_FINAL_CONSTRUCT()

	HRESULT FinalConstruct()
	{
		return S_OK;
	}
	
	void FinalRelease() 
	{
	}

public:
    //IShellExtInit:
    STDMETHOD(Initialize)( 
            /* [in] */ LPCITEMIDLIST pidlFolder,
            /* [in] */ IDataObject *pdtobj,
            /* [in] */ HKEY hkeyProgID);

    //IShellPropSheetExt 
    STDMETHOD(AddPages)( 
        /* [in] */ LPFNSVADDPROPSHEETPAGE pfnAddPage,
        /* [in] */ LPARAM lParam);
    
    STDMETHOD(ReplacePage)( 
        /* [in] */ EXPPS uPageID,
        /* [in] */ LPFNSVADDPROPSHEETPAGE pfnReplaceWith,
        /* [in] */ LPARAM lParam);       
};

OBJECT_ENTRY_AUTO(__uuidof(TestDsPropSheetExt), CTestDsPropSheetExt)
