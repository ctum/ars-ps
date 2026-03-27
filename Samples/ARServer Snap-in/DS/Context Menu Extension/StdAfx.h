// stdafx.h : include file for standard system include files,
//      or project specific include files that are used frequently,
//      but are changed infrequently

#if !defined(AFX_STDAFX_H__C1899124_6DE8_4794_9E6D_E46ACE3C1AC8__INCLUDED_)
#define AFX_STDAFX_H__C1899124_6DE8_4794_9E6D_E46ACE3C1AC8__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/*#define STRICT
#ifndef _WIN32_WINNT
#define _WIN32_WINNT 0x0400
#endif
*/
#define _WIN32_WINNT 0x0500
#define WINVER 0x0500
#define _ATL_APARTMENT_THREADED




#include <afxwin.h>
#include <afxdisp.h>
#include <afxole.h>         // MFC ole support
#include <afxtempl.h>       // MFC collections templates
#include <afxdtctl.h>		// MFC support for Internet Explorer 4 Common Controls
#include <afxcmn.h>			// MFC support for Windows Common Controls
#include <afxmt.h>          // MFC multithread support

#include <atlbase.h>
//You may derive a class from CComModule and use it if you want to override
//something, but do not change the name of _Module
extern CComModule _Module;
#include <atlcom.h>
#include <atlwin.h>         // ATL
//ADU&C
#include <Dsclient.h>

#include "Shlobj.h"
//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STDAFX_H__C1899124_6DE8_4794_9E6D_E46ACE3C1AC8__INCLUDED)
