// DsPropTestATL.cpp : Implementation of DLL Exports.

#include "stdafx.h"
#include "resource.h"
#include "DsPropTestATL.h"

class CDsPropTestATLModule : public CAtlDllModuleT< CDsPropTestATLModule >
{
public :
	DECLARE_LIBID(LIBID_DsPropTestATLLib)
	DECLARE_REGISTRY_APPID_RESOURCEID(IDR_DSPROPTESTATL, "{4CDDCAA9-0114-48D6-AF2F-757918EF910D}")
};

CDsPropTestATLModule _AtlModule;

class CDsPropTestATLApp : public CWinApp
{
public:

// Overrides
    virtual BOOL InitInstance();
    virtual int ExitInstance();

    DECLARE_MESSAGE_MAP()
};

BEGIN_MESSAGE_MAP(CDsPropTestATLApp, CWinApp)
END_MESSAGE_MAP()

CDsPropTestATLApp theApp;

BOOL CDsPropTestATLApp::InitInstance()
{
    return CWinApp::InitInstance();
}

int CDsPropTestATLApp::ExitInstance()
{
    return CWinApp::ExitInstance();
}


// Used to determine whether the DLL can be unloaded by OLE
STDAPI DllCanUnloadNow(void)
{
    AFX_MANAGE_STATE(AfxGetStaticModuleState());
    return (AfxDllCanUnloadNow()==S_OK && _AtlModule.GetLockCount()==0) ? S_OK : S_FALSE;
}


// Returns a class factory to create an object of the requested type
STDAPI DllGetClassObject(REFCLSID rclsid, REFIID riid, LPVOID* ppv)
{
    return _AtlModule.DllGetClassObject(rclsid, riid, ppv);
}


// DllRegisterServer - Adds entries to the system registry
STDAPI DllRegisterServer(void)
{
    // registers object, typelib and all interfaces in typelib
    HRESULT hr = _AtlModule.DllRegisterServer();
	return hr;
}


// DllUnregisterServer - Removes entries from the system registry
STDAPI DllUnregisterServer(void)
{
	HRESULT hr = _AtlModule.DllUnregisterServer();
	return hr;
}
