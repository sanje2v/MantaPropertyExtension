#include "PropertyExtension.h"
#include <Shlwapi.h>
#include <Propvarutil.h>
#include <ImageHlp.h>
#include <string>
#include <algorithm>
#include <memory>

using namespace std;


const int BUFFER_SIZE = 8;
__declspec(thread) BYTE pData[BUFFER_SIZE];
__declspec(thread) static ULONG cbRead = 0;
#define HANDLE_READ_FAIL(objptr, sizetoread)	if (FAILED(objptr->Read(pData, sizetoread, &cbRead)) || sizetoread != cbRead) return E_FAIL


PropertyExtension::PropertyExtension()
: m_Ref(1)
{}

PropertyExtension::~PropertyExtension() {}


// IUknown methods implementation
IFACEMETHODIMP PropertyExtension::QueryInterface(REFIID riid, void **ppv)
{
	static const QITAB qit[] =
	{
		QITABENT(PropertyExtension, IPropertyStore),
		QITABENT(PropertyExtension, IInitializeWithStream),
		{ NULL },
	};

	return QISearch(this, qit, riid, ppv);
}

IFACEMETHODIMP_(ULONG)	PropertyExtension::AddRef()
{
	return InterlockedIncrement(&m_Ref);
}

IFACEMETHODIMP_(ULONG) PropertyExtension::Release()
{
	ULONG Ref = InterlockedDecrement(&m_Ref);

	if (m_Ref == NULL)
		delete this;

	return Ref;
}


// IPropertyStore methods implementations
IFACEMETHODIMP PropertyExtension::GetCount(DWORD *cProps)
{
	return E_NOTIMPL;	// Not supported
}

IFACEMETHODIMP PropertyExtension::GetAt(DWORD iProp, PROPERTYKEY *pkey)
{
	return E_NOTIMPL;	// Not supported
}

IFACEMETHODIMP PropertyExtension::GetValue(REFPROPERTYKEY key, PROPVARIANT *pv)
{
	if (pv == NULL)
		return E_INVALIDARG;

	if (key.pid != PIDSI_COMMENTS)	// We only handle 'Comments' property
	{
		pv->vt = VT_EMPTY;

		return S_OK;
	}

	// Go through collected data and prepare a string buffer
	wstring Buffer;

	switch (m_Format)
	{
		case EXE:
		case DLL:
			if (m_Format != Unknown)
			{
				if (m_bValidPE)
				{
					switch (m_ArchType)
					{
						case _32bit: Buffer = L"32-bit "; break;
						case _64bit: Buffer = L"64-bit ";
					}

					if (m_bDotNet)
						Buffer += L".NET ";

					switch (m_Format)
					{
						case EXE:
						{
							switch (m_SubsysType)
							{
								case Native: Buffer += L"Native "; break;
								case CUI: Buffer += L"CUI "; break;
								case GUI: Buffer += L"GUI ";
							}

							Buffer += L"Executable";
						}

							break;

						case DLL:
							Buffer += L"DLL";
					};
				}
				else
					Buffer = L"Invalid PE file";
			}

			break;

		case OBJ:
			switch (m_ArchType)
			{
				case _32bit: Buffer = L"32-bit Object file"; break;
				case _64bit: Buffer = L"64-bit Object file"; break;
				case _I64: Buffer = L"Itanium Object file";
			}

			break;

		case LIB:
			switch (m_ArchType)
			{
				case _32bit: Buffer = L"32-bit Library file"; break;
				case _64bit: Buffer = L"64-bit Library file"; break;
				case _I64: Buffer = L"Itanium Library file";
			}
	}

	// Copy string buffer to 'pv' and return it
	InitPropVariantFromString(Buffer.c_str(), pv);

	return S_OK;
}

IFACEMETHODIMP PropertyExtension::SetValue(REFPROPERTYKEY key, REFPROPVARIANT propvar)
{
	return E_NOTIMPL;	// Not supported
}

IFACEMETHODIMP PropertyExtension::Commit(void)
{
	return E_NOTIMPL;	// Not supported
}


// IIntitializeWithStream methods implementations
IFACEMETHODIMP PropertyExtension::Initialize(IStream *pstream, DWORD grfMode)
{
	if (grfMode & STGM_READWRITE)
		return STG_E_ACCESSDENIED;	// Tell Explorer we don't support writing back properties

	// Collect filename
	STATSTG statstg;
	pstream->Stat(&statstg, STATFLAG_DEFAULT);
	
	// Create 'temp' string from filename
	wstring Filename(statstg.pwcsName);
	CoTaskMemFree(statstg.pwcsName);	// Anything created must be destroyed,
										// Laws of Universe 101

	// Make filename lowercase
	transform(Filename.begin(), Filename.end(), Filename.begin(), ::tolower);

	// Go through filename and stream then collect data
	//	which will be returned in 'GetValue'

	// Check extension to determine type of file
	size_t ExtensionPos = Filename.find_last_of(L".");
	if (ExtensionPos == Filename.size() - 1)
		return E_NOTIMPL;
	else
		ExtensionPos++;

	wstring FileExtension = Filename.substr(ExtensionPos);
	if (FileExtension == L"exe")
			m_Format = EXE;
	else if (FileExtension == L"dll")
			m_Format = DLL;
	else if ((FileExtension == L"obj") || (FileExtension == L"o"))
			m_Format = OBJ;
	else if ((FileExtension == L"lib") || (FileExtension == L"a"))
			m_Format = LIB;
	else
		return E_NOTIMPL;

	// Reset file pointer
	LARGE_INTEGER pos = { 0 };
	pstream->Seek(pos, STREAM_SEEK_SET, NULL);

	// According to the format, read data
	switch (m_Format)
	{
		case EXE:
		case DLL:
			// Check MZ header			
			HANDLE_READ_FAIL(pstream, sizeof(WORD));
			if (cast<WORD>(pData) != IMAGE_DOS_SIGNATURE)	// Check MSDOS signature
			{
				m_bValidPE = false;
				return S_OK;
			}
			else
				m_bValidPE = true;

			// Check PE header
			pos.QuadPart = 0x3C;	// Offset to PE header is always at 0x3C
			pstream->Seek(pos, STREAM_SEEK_SET, NULL);
			HANDLE_READ_FAIL(pstream, sizeof(DWORD));
			pos.QuadPart = cast<DWORD>(pData);
			if (pos.QuadPart == 0)
			{
				m_bValidPE = false;
				return S_OK;
			}

			pstream->Seek(pos, STREAM_SEEK_SET, NULL);
			HANDLE_READ_FAIL(pstream, sizeof(DWORD));
			if (cast<DWORD>(pData) != IMAGE_NT_SIGNATURE)
			{
				m_bValidPE = false;
				return S_OK;
			}

			// Find PE type field
			pos.QuadPart = 20;
			pstream->Seek(pos, STREAM_SEEK_CUR, NULL);
			HANDLE_READ_FAIL(pstream, sizeof(WORD));
			switch (cast<WORD>(pData))
			{
			case IMAGE_NT_OPTIONAL_HDR32_MAGIC:
				m_ArchType = _32bit;

				break;

			case IMAGE_NT_OPTIONAL_HDR64_MAGIC:
				m_ArchType = _64bit;

				break;

			case IMAGE_ROM_OPTIONAL_HDR_MAGIC:	// Who uses ROM PEs anyway?
				return E_NOTIMPL;

			default:
				m_bValidPE = false;
				return S_OK;
			}

			// Find PE subsystem field
			pos.QuadPart = 66;
			pstream->Seek(pos, STREAM_SEEK_CUR, NULL);
			HANDLE_READ_FAIL(pstream, sizeof(WORD));
			switch (cast<WORD>(pData))
			{
			case IMAGE_SUBSYSTEM_NATIVE:
				m_SubsysType = Native;

				break;

			case IMAGE_SUBSYSTEM_WINDOWS_CUI:
				m_SubsysType = CUI;

				break;

			case IMAGE_SUBSYSTEM_WINDOWS_GUI:
			case IMAGE_SUBSYSTEM_WINDOWS_CE_GUI:
				m_SubsysType = GUI;

				break;

			default:
				m_bValidPE = false;
				return S_OK;
			}

			// Is this .NET image?
			// First read no. of data directory
			switch (m_ArchType)
			{
			case _32bit: pos.QuadPart = 22; break;
			case _64bit: pos.QuadPart = 38;
			}

			pstream->Seek(pos, STREAM_SEEK_CUR, NULL);
			HANDLE_READ_FAIL(pstream, sizeof(DWORD));
			if (min(cast<DWORD>(pData), IMAGE_NUMBEROF_DIRECTORY_ENTRIES) < 15)
			{
				m_bDotNet = false;
				return S_OK;
			}

			// Then check CLR data directory
			pos.QuadPart = 112;
			pstream->Seek(pos, STREAM_SEEK_CUR, NULL);
			HANDLE_READ_FAIL(pstream, sizeof(DWORD));
			m_bDotNet = cast<DWORD>(pData) != 0;
			
			break;

		case OBJ:
			// Check machine type
			HANDLE_READ_FAIL(pstream, sizeof(WORD));
			switch (cast<WORD>(pData))
			{
				case IMAGE_FILE_MACHINE_I386: m_ArchType = _32bit; break;
				case IMAGE_FILE_MACHINE_AMD64: m_ArchType = _64bit;	break;
				case IMAGE_FILE_MACHINE_IA64: m_ArchType = _I64; break;
				default: return E_NOTIMPL;
			}

			break;
		
		case LIB:
			// Check signature '!<arch>/n'
			HANDLE_READ_FAIL(pstream, IMAGE_ARCHIVE_START_SIZE);
			if (string(cast<char *>(pData), IMAGE_ARCHIVE_START_SIZE) != IMAGE_ARCHIVE_START)
				return E_NOTIMPL;

			// Skip first header + No. of symbols field
			//	and read file offset to either header for first symbol
			pos.QuadPart = IMAGE_SIZEOF_ARCHIVE_MEMBER_HDR + sizeof(DWORD);
			pstream->Seek(pos, STREAM_SEEK_CUR, NULL);
			HANDLE_READ_FAIL(pstream, sizeof(DWORD));

			pos.QuadPart = _byteswap_ulong(cast<DWORD>(pData));	// Convert big endian to little endian
			pstream->Seek(pos, STREAM_SEEK_SET, NULL);

			// Skip this header
			pos.QuadPart = IMAGE_SIZEOF_ARCHIVE_MEMBER_HDR;
			pstream->Seek(pos, STREAM_SEEK_CUR, NULL);

			// Check if this is a short version library used with static libs
			HANDLE_READ_FAIL(pstream, sizeof(DWORD));
			if (cast<DWORD>(pData) == MAKELONG(IMAGE_FILE_MACHINE_UNKNOWN, 0xFFFF))
			{
				// Is a short version library
				// This is a Import header
				// Skip version field to read 'Machine' field
				pos.QuadPart = sizeof(WORD);
				pstream->Seek(pos, STREAM_SEEK_CUR, NULL);
			}
			else
			{
				// Is a long version library
				// Rewind file pointer by size of 'DWORD'
				pos.QuadPart = -static_cast<LONGLONG>(sizeof(DWORD));
				pstream->Seek(pos, STREAM_SEEK_CUR, NULL);
			}

			// Else it's a File header
			// Check machine type
			HANDLE_READ_FAIL(pstream, sizeof(WORD));
			switch (cast<WORD>(pData))
			{
				case IMAGE_FILE_MACHINE_I386: m_ArchType = _32bit; break;
				case IMAGE_FILE_MACHINE_AMD64: m_ArchType = _64bit;	break;
				case IMAGE_FILE_MACHINE_IA64: m_ArchType = _I64; break;
				default: return E_NOTIMPL;
			}

			break;
		
		default:
#ifdef _DEBUG
			throw exception("Unhandled file format");	// Execution shouldn't reach here
#else
			return E_NOTIMPL;
#endif
	}

	return S_OK;
}