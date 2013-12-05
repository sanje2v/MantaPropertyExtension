#pragma once
#include <Windows.h>
#include <Propsys.h>


class PropertyExtension :
	public IPropertyStore, public IInitializeWithStream
{
private:
	// Private enums
	enum Format {Unknown, EXE, DLL, OBJ, LIB};
	enum ArchType {_32bit, _64bit, _I64};
	enum SubsystemType {Native, CUI, GUI};

	// Private constants

	// Private variables
	long m_Ref;
	bool m_bValidPE;
	bool m_bDotNet;
	Format m_Format;
	ArchType m_ArchType;
	SubsystemType m_SubsysType;

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

	// IIntitializeWithStream
	IFACEMETHODIMP Initialize(IStream *pstream, DWORD grfMode);

protected:
	~PropertyExtension();
};


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