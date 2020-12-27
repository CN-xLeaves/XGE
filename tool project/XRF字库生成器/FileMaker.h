#pragma once
#include "BitFont.h"
#include "Charset.h"

class CFileMaker
{
public:
    BOOL MakeCppFile(CBitFont* pBitFont, CCharset* pCharset, CFile* pFile, int scan, BOOL msb, BOOL var_width);
    BOOL MakeBinFile(CBitFont* pBitFont, CCharset* pCharset, CFile* pFile, int scan, BOOL msb, BOOL var_width);
	BOOL MakeXrfFile(CBitFont* pBitFont, CCharset* pCharset, CFile* pFile, int scan, BOOL msb, BOOL var_width, int charsetIndex, BYTE w, BYTE aw, BYTE h);
};
