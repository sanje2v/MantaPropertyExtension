#pragma once
#include <Windows.h>
#include <Propsys.h>
#include <Shlwapi.h>
#include <Propvarutil.h>
#include <Propkey.h>
#include <string>
#include <atlbase.h>


class PropertyExtension :
	public IPropertyStore,
	public IInitializeWithFile,
	public IPropertyStoreCapabilities
{
private:
	// Private enums
	enum Format {Invalid, EXE, DLL, OBJ, LIB};
	enum ArchType {_32bit, _64bit, _I64};
	enum SubsystemType {Native, CUI, GUI};

	// Private declarations
	typedef std::wstring(PropertyExtension::*PFUNCGETVALUE)(void);
	struct KEY_FUNCVALUE
	{
		PROPERTYKEY key;
		PFUNCGETVALUE funcValue;
	};
	static const KEY_FUNCVALUE m_KeyfuncValue[];	// Size of this array is 'NUM_OF_ADDED_PROPERTIES'

	// Private constants
	static const unsigned int NUM_OF_ADDED_PROPERTIES = 1;

	// Private variables
	bool m_bCOMInitialized = false;		// If call to 'CoInitialize()' failed in constructor, there's no going any further
	bool m_bAlreadyInitialized = false;	// To prevent multiple initialization call to 'IInitializeWithFile::Initialize()'
	long m_Ref = 0;						// Reference count for this object
	bool m_bPreviousHandlerInitialized;	// There is version data in the 'Resource Directory' of PE
	bool m_bDotNet = false;				// Are we dealing with a .NET Portable Executable?
	Format m_Format;
	ArchType m_ArchType;
	SubsystemType m_SubsysType;
	DWORD m_cSupportedProperties;

	ATL::CComPtr<IPropertyStore> m_interfacePropertyStore;
	ATL::CComPtr<IPropertyStoreCapabilities> m_interfacePropertyStoreCapabilities;

	// Private functions
	bool IsAddedProperty(DWORD iProp) {	return iProp >= m_cSupportedProperties - NUM_OF_ADDED_PROPERTIES; }
	bool IsAddedProperty(REFPROPERTYKEY key)
	{
		for (unsigned int i = 0; i < NUM_OF_ADDED_PROPERTIES; i++)
			if (key == m_KeyfuncValue[i].key)
				return true;

		return false;
	}
	bool IsSourcePEFormat() { return m_Format == EXE || m_Format == DLL; }
	// Property functions
	std::wstring GetCommentProperty();

public:
	PropertyExtension();

	// IUnknown
	IFACEMETHODIMP QueryInterface(REFIID riid, void **ppv);
	IFACEMETHODIMP_(ULONG) AddRef();
	IFACEMETHODIMP_(ULONG) Release();

	// IPropertyStore
	IFACEMETHODIMP GetCount(DWORD *cProps);
	IFACEMETHODIMP GetAt(DWORD iProp, PROPERTYKEY *pkey);
	IFACEMETHODIMP GetValue(REFPROPERTYKEY key, PROPVARIANT *pv);
	IFACEMETHODIMP SetValue(REFPROPERTYKEY key, REFPROPVARIANT propvar);
	IFACEMETHODIMP Commit(void);

	// IInitializeWithFile
	IFACEMETHODIMP Initialize(LPCWSTR pszFilePath, DWORD grfMode);

	// IPropertyStoreCapabilities
	IFACEMETHODIMP IsPropertyWritable(REFPROPERTYKEY key);

protected:
	~PropertyExtension();
};


// Macros and inline functions to make life easier
#define READ(objptr, sizetoread)	if (FAILED(objptr->Read(pData, (sizetoread), &cbRead)) || (sizetoread) != cbRead) return E_FAIL
#define SEEK(objptr, pos, type)		objptr->Seek(pos, type, NULL)

template<typename T>
inline bool TestFlag(T val, T flag)
{
	return (val & flag) == flag;
}

template<typename T>
inline T cast(BYTE *ptr)
{
	return *reinterpret_cast<T *>(ptr);
}

// Specialized template for above function for 'char *'
template<>
inline char *cast<char *>(BYTE *ptr)
{
	return reinterpret_cast<char *>(ptr);
}