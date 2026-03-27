
#pragma warning( disable: 4049 )  /* more than 64k source lines */

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


 /* File created by MIDL compiler version 6.00.0347 */
/* at Fri Oct 11 18:25:41 2002
 */
/* Compiler settings for C:\Work\Projects\Units\TryIContextMenu\TryIContextMenu.idl:
    Oicf, W1, Zp8, env=Win32 (32b run)
    protocol : dce , ms_ext, c_ext
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
//@@MIDL_FILE_HEADING(  )


/* verify that the <rpcndr.h> version is high enough to compile this file*/
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 440
#endif

#include "rpc.h"
#include "rpcndr.h"

#ifndef __RPCNDR_H_VERSION__
#error this stub requires an updated version of <rpcndr.h>
#endif // __RPCNDR_H_VERSION__

#ifndef COM_NO_WINDOWS_H
#include "windows.h"
#include "ole2.h"
#endif /*COM_NO_WINDOWS_H*/

#ifndef __EDMExtInitIdl_h__
#define __EDMExtInitIdl_h__

#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

/* Forward Declarations */ 

#ifndef __IEDMExtInit_FWD_DEFINED__
#define __IEDMExtInit_FWD_DEFINED__
typedef interface IEDMExtInit IEDMExtInit;
#endif 	/* __IEDMExtInit_FWD_DEFINED__ */


#ifndef __EDMExtInit_FWD_DEFINED__
#define __EDMExtInit_FWD_DEFINED__

#ifdef __cplusplus
typedef class EDMExtInit EDMExtInit;
#else
typedef struct EDMExtInit EDMExtInit;
#endif /* __cplusplus */

#endif 	/* __EDMExtInit_FWD_DEFINED__ */


/* header files for imported files */
#include "oaidl.h"
#include "ocidl.h"

#ifdef __cplusplus
extern "C"{
#endif 

void * __RPC_USER MIDL_user_allocate(size_t);
void __RPC_USER MIDL_user_free( void * ); 

#ifndef __IEDMExtInit_INTERFACE_DEFINED__
#define __IEDMExtInit_INTERFACE_DEFINED__

/* interface IEDMExtInit */
/* [hidden][unique][dual][helpstring][uuid][oleautomation][object] */ 


#ifndef INITGUID
#define INITGUID
#include <guiddef.h>
#undef INITGUID
#else
#include <guiddef.h>
#endif

//#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
//        DEFINE_GUID(name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8)
DEFINE_GUID(IID_IEDMExtInit,0x249221D6,0xD8A6,0x464E,0x8E,0x78,0x39,0x14,0x70,0x79,0xAB,0xBE);
//EXTERN_C const IID IID_IEDMExtInit;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("249221D6-D8A6-464E-8E78-39147079ABBE")
    IEDMExtInit : public IDispatch
    {
    public:
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE PutEDMServer( 
            BSTR bstrServer) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IEDMExtInitVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IEDMExtInit * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IEDMExtInit * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IEDMExtInit * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IEDMExtInit * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IEDMExtInit * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IEDMExtInit * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IEDMExtInit * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PutEDMServer )( 
            IEDMExtInit * This,
            BSTR bstrServer);
        
        END_INTERFACE
    } IEDMExtInitVtbl;

    interface IEDMExtInit
    {
        CONST_VTBL struct IEDMExtInitVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IEDMExtInit_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define IEDMExtInit_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define IEDMExtInit_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define IEDMExtInit_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define IEDMExtInit_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define IEDMExtInit_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define IEDMExtInit_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


#define IEDMExtInit_PutEDMServer(This,bstrServer)	\
    (This)->lpVtbl -> PutEDMServer(This,bstrServer)

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IEDMExtInit_PutEDMServer_Proxy( 
    IEDMExtInit * This,
    BSTR bstrServer);


void __RPC_STUB IEDMExtInit_PutEDMServer_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IEDMExtInit_INTERFACE_DEFINED__ */



#ifndef __TRYICONTEXTMENULib_LIBRARY_DEFINED__
#define __TRYICONTEXTMENULib_LIBRARY_DEFINED__

/* library TRYICONTEXTMENULib */
/* [helpstring][version][uuid] */ 


EXTERN_C const IID LIBID_TRYICONTEXTMENULib;

EXTERN_C const CLSID CLSID_EDMExtInit;

#ifdef __cplusplus

class DECLSPEC_UUID("AF5A731F-9C2E-41C2-85FA-42416A4EF62D")
EDMExtInit;
#endif
#endif /* __TRYICONTEXTMENULib_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

unsigned long             __RPC_USER  BSTR_UserSize(     unsigned long *, unsigned long            , BSTR * ); 
unsigned char * __RPC_USER  BSTR_UserMarshal(  unsigned long *, unsigned char *, BSTR * ); 
unsigned char * __RPC_USER  BSTR_UserUnmarshal(unsigned long *, unsigned char *, BSTR * ); 
void                      __RPC_USER  BSTR_UserFree(     unsigned long *, BSTR * ); 

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif


