/****************************** Module Header ******************************\
Module Name:  dllmain.cpp
Project:      MantaPropertyExtension
Copyright (c) Microsoft Corporation.

The file implements DllMain, and the DllGetClassObject, DllCanUnloadNow, 
DllRegisterServer, DllUnregisterServer functions that are necessary for a COM 
DLL. 

DllGetClassObject invokes the class factory defined in ClassFactory.h/cpp and 
queries to the specific interface.

DllCanUnloadNow checks if we can unload the component from the memory.

DllRegisterServer registers the COM server and the property sheet handler in 
the registry by invoking the helper functions defined in Reg.h/cpp.

DllUnregisterServer unregisters the COM server. 

This source is subject to the Microsoft Public License.
See http://www.microsoft.com/opensource/licenses.mspx#Ms-PL.
All other rights reserved.

THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, 
EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
\***************************************************************************/

#include <Windows.h>
#include <Guiddef.h>
#include <strsafe.h>
#include "ClassFactory.h"           // For the class factory
#include "Reg.h"


// {4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}
#define CLSID_MANTAPROPERTYEXTENSION		L"{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"
static const CLSID CLSID_MantaPropertyExtension =
{ 0x4cc940b1, 0xab1b, 0x40aa, { 0x99, 0xe3, 0xb9, 0x74, 0xfd, 0x2b, 0xe, 0xc4 } };


HINSTANCE   g_hInst     = NULL;
long        g_cDllRef   = 0;


BOOL APIENTRY DllMain(HMODULE hModule, DWORD dwReason, LPVOID lpReserved)
{
	switch (dwReason)
	{
	case DLL_PROCESS_ATTACH:
        // Hold the instance of this DLL module, we will use it to get the 
        // path of the DLL to register the component.
        g_hInst = hModule;
        DisableThreadLibraryCalls(hModule);

        break;
	}

	return TRUE;
}


//
//   FUNCTION: DllGetClassObject
//
//   PURPOSE: Create the class factory and query to the specific interface.
//
//   PARAMETERS:
//   * rclsid - The CLSID that will associate the correct data and code.
//   * riid - A reference to the identifier of the interface that the caller 
//     is to use to communicate with the class object.
//   * ppv - The address of a pointer variable that receives the interface 
//     pointer requested in riid. Upon successful return, *ppv contains the 
//     requested interface pointer. If an error occurs, the interface pointer 
//     is NULL. 
//
STDAPI DllGetClassObject(REFCLSID rclsid, REFIID riid, void **ppv)
{
    HRESULT hr = CLASS_E_CLASSNOTAVAILABLE;

	if (IsEqualCLSID(CLSID_MantaPropertyExtension, rclsid))
    {
        hr = E_OUTOFMEMORY;

        ClassFactory *pClassFactory = new ClassFactory();
        if (pClassFactory)
        {
            hr = pClassFactory->QueryInterface(riid, ppv);
            pClassFactory->Release();
        }
    }

    return hr;
}


//
//   FUNCTION: DllCanUnloadNow
//
//   PURPOSE: Check if we can unload the component from the memory.
//
//   NOTE: The component can be unloaded from the memory when its reference 
//   count is zero (i.e. nobody is still using the component).
// 
STDAPI DllCanUnloadNow(void)
{
    return g_cDllRef > 0 ? S_FALSE : S_OK;
}


//
//   FUNCTION: DllRegisterServer
//
//   PURPOSE: Register the COM server and the property handler.
// 
STDAPI DllRegisterServer(void)
{
    HRESULT hr;

    wchar_t szModule[MAX_PATH];
    if (GetModuleFileName(g_hInst, szModule, ARRAYSIZE(szModule)) == 0)
    {
        hr = HRESULT_FROM_WIN32(GetLastError());
        return hr;
    }

    // Register the component.
	hr = RegisterInprocServer(szModule, CLSID_MantaPropertyExtension,
								L"MantaPropertyExtension.PropertyHandler Class", 
								L"Apartment");

	// After proper entries have been made to 'HKEY_CLASSES_ROOT\CLSID',
	// also add a DWORD value named 'DisableProcessIsolation' under this
	// component's CLSID key. This is required for implementinf 'IInitializeWithFile'
	// inherited in 'PropertyExtension' class
	if (SUCCEEDED(hr))
	{
		HKEY hkeyCLSID;

		hr = RegOpenKeyEx(HKEY_CLASSES_ROOT, L"CLSID\\" CLSID_MANTAPROPERTYEXTENSION, 0, KEY_WRITE, &hkeyCLSID);
		if (FAILED(hr))
			return hr;
		
		const DWORD DisableProcessIsolation = 1;
		hr = RegSetValueEx(hkeyCLSID, L"DisableProcessIsolation", 0, REG_DWORD, (const BYTE *) &DisableProcessIsolation, sizeof(DisableProcessIsolation));
		RegCloseKey(hkeyCLSID);
	}

    return hr;
}


//
//   FUNCTION: DllUnregisterServer
//
//   PURPOSE: Unregister the COM server and the property handler.
// 
STDAPI DllUnregisterServer(void)
{
    HRESULT hr = S_OK;

    wchar_t szModule[MAX_PATH];
    if (GetModuleFileName(g_hInst, szModule, ARRAYSIZE(szModule)) == 0)
    {
        hr = HRESULT_FROM_WIN32(GetLastError());
        return hr;
    }

    // Unregister the component.
	hr = UnregisterInprocServer(CLSID_MantaPropertyExtension);

    return hr;
}