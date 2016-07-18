; #INDEX# =======================================================================================================================
; Title .........: AutoItObject v1.2.8.0
; AutoIt Version : 3.3
; Language ......: English (language independent)
; Description ...: Brings Objects to AutoIt.
; Author(s) .....: monoceres, trancexx, Kip, Prog@ndy
; Copyright .....: Copyright (C) The AutoItObject-Team. All rights reserved.
; License .......: Artistic License 2.0, see Artistic.txt
;
; This file is part of AutoItObject.
;
; AutoItObject is free software; you can redistribute it and/or modify
; it under the terms of the Artistic License as published by Larry Wall,
; either version 2.0, or (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
; See the Artistic License for more details.
;
; You should have received a copy of the Artistic License with this Kit,
; in the file named "Artistic.txt".  If not, you can get a copy from
; <http://www.perlfoundation.org/artistic_license_2_0> OR
; <http://www.opensource.org/licenses/artistic-license-2.0.php>
;
; ------------------------ AutoItObject CREDITS: ------------------------
; Copyright (C) by:
; The AutoItObject-Team:
; 	Andreas Karlsson (monoceres)
; 	Dragana R. (trancexx)
; 	Dave Bakker (Kip)
; 	Andreas Bosch (progandy, Prog@ndy)
;
; ===============================================================================================================================
#include-once
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6


; #CURRENT# =====================================================================================================================
;_AutoItObject_AddDestructor
;_AutoItObject_AddEnum
;_AutoItObject_AddMethod
;_AutoItObject_AddProperty
;_AutoItObject_Class
;_AutoItObject_CLSIDFromString
;_AutoItObject_CoCreateInstance
;_AutoItObject_Create
;_AutoItObject_DllOpen
;_AutoItObject_DllStructCreate
;_AutoItObject_IDispatchToPtr
;_AutoItObject_IUnknownAddRef
;_AutoItObject_IUnknownRelease
;_AutoItObject_ObjCreate
;_AutoItObject_ObjCreateEx
;_AutoItObject_ObjectFromDtag
;_AutoItObject_PtrToIDispatch
;_AutoItObject_RegisterObject
;_AutoItObject_RemoveMember
;_AutoItObject_Shutdown
;_AutoItObject_Startup
;_AutoItObject_UnregisterObject
;_AutoItObject_VariantClear
;_AutoItObject_VariantCopy
;_AutoItObject_VariantFree
;_AutoItObject_VariantInit
;_AutoItObject_VariantRead
;_AutoItObject_VariantSet
;_AutoItObject_WrapperAddMethod
;_AutoItObject_WrapperCreate
; ===============================================================================================================================

; #INTERNAL_NO_DOC# =============================================================================================================
;__Au3Obj_OleUninitialize
;__Au3Obj_IUnknown_AddRef
;__Au3Obj_IUnknown_Release
;__Au3Obj_GetMethods
;__Au3Obj_SafeArrayCreate
;__Au3Obj_SafeArrayDestroy
;__Au3Obj_SafeArrayAccessData
;__Au3Obj_SafeArrayUnaccessData
;__Au3Obj_SafeArrayGetUBound
;__Au3Obj_SafeArrayGetLBound
;__Au3Obj_SafeArrayGetDim
;__Au3Obj_CreateSafeArrayVariant
;__Au3Obj_ReadSafeArrayVariant
;__Au3Obj_CoTaskMemAlloc
;__Au3Obj_CoTaskMemFree
;__Au3Obj_CoTaskMemRealloc
;__Au3Obj_GlobalAlloc
;__Au3Obj_GlobalFree
;__Au3Obj_SysAllocString
;__Au3Obj_SysCopyString
;__Au3Obj_SysReAllocString
;__Au3Obj_SysFreeString
;__Au3Obj_SysStringLen
;__Au3Obj_SysReadString
;__Au3Obj_PtrStringLen
;__Au3Obj_PtrStringRead
;__Au3Obj_FunctionProxy
;__Au3Obj_EnumFunctionProxy
;__Au3Obj_ObjStructGetElements
;__Au3Obj_ObjStructMethod
;__Au3Obj_ObjStructDestructor
;__Au3Obj_ObjStructPointer
;__Au3Obj_PointerCall
;__Au3Obj_Mem_DllOpen
;__Au3Obj_Mem_FixReloc
;__Au3Obj_Mem_FixImports
;__Au3Obj_Mem_LoadLibraryEx
;__Au3Obj_Mem_FreeLibrary
;__Au3Obj_Mem_GetAddress
;__Au3Obj_Mem_VirtualProtect
;__Au3Obj_Mem_Base64Decode
;__Au3Obj_Mem_BinDll
;__Au3Obj_Mem_BinDll_X64
; ===============================================================================================================================

; #DATATYPES# =====================================================================================================================
; none - no value (only valid for return type, equivalent to void in C)
; byte - an unsigned 8 bit integer
; boolean - an unsigned 8 bit integer
; short - a 16 bit integer
; word, ushort - an unsigned 16 bit integer
; int, long - a 32 bit integer
; bool - a 32 bit integer
; dword, ulong, uint - an unsigned 32 bit integer
; hresult - an unsigned 32 bit integer
; int64 - a 64 bit integer
; uint64 - an unsigned 64 bit integer
; ptr - a general pointer (void *)
; hwnd - a window handle (pointer wide)
; handle - an handle (pointer wide)
; float - a single precision floating point number
; double - a double precision floating point number
; int_ptr, long_ptr, lresult, lparam - an integer big enough to hold a pointer when running on x86 or x64 versions of AutoIt
; uint_ptr, ulong_ptr, dword_ptr, wparam - an unsigned integer big enough to hold a pointer when running on x86 or x64 versions of AutoIt
; str - an ANSI string (a minimum of 65536 chars is allocated)
; wstr - a UNICODE wide character string (a minimum of 65536 chars is allocated)
; bstr - a composite data type that consists of a length prefix, a data string and a terminator
; variant - a tagged union that can be used to represent any other data type
; idispatch, object - a composite data type that represents object with IDispatch interface
; ===============================================================================================================================

;--------------------------------------------------------------------------------------------------------------------------------------
#Region Variable definitions

Global Const $gh_AU3Obj_kernel32dll = DllOpen("kernel32.dll")
Global Const $gh_AU3Obj_oleautdll = DllOpen("oleaut32.dll")
Global Const $gh_AU3Obj_ole32dll = DllOpen("ole32.dll")

Global Const $__Au3Obj_X64 = @AutoItX64

Global Const $__Au3Obj_VT_EMPTY = 0
Global Const $__Au3Obj_VT_NULL = 1
Global Const $__Au3Obj_VT_I2 = 2
Global Const $__Au3Obj_VT_I4 = 3
Global Const $__Au3Obj_VT_R4 = 4
Global Const $__Au3Obj_VT_R8 = 5
Global Const $__Au3Obj_VT_CY = 6
Global Const $__Au3Obj_VT_DATE = 7
Global Const $__Au3Obj_VT_BSTR = 8
Global Const $__Au3Obj_VT_DISPATCH = 9
Global Const $__Au3Obj_VT_ERROR = 10
Global Const $__Au3Obj_VT_BOOL = 11
Global Const $__Au3Obj_VT_VARIANT = 12
Global Const $__Au3Obj_VT_UNKNOWN = 13
Global Const $__Au3Obj_VT_DECIMAL = 14
Global Const $__Au3Obj_VT_I1 = 16
Global Const $__Au3Obj_VT_UI1 = 17
Global Const $__Au3Obj_VT_UI2 = 18
Global Const $__Au3Obj_VT_UI4 = 19
Global Const $__Au3Obj_VT_I8 = 20
Global Const $__Au3Obj_VT_UI8 = 21
Global Const $__Au3Obj_VT_INT = 22
Global Const $__Au3Obj_VT_UINT = 23
Global Const $__Au3Obj_VT_VOID = 24
Global Const $__Au3Obj_VT_HRESULT = 25
Global Const $__Au3Obj_VT_PTR = 26
Global Const $__Au3Obj_VT_SAFEARRAY = 27
Global Const $__Au3Obj_VT_CARRAY = 28
Global Const $__Au3Obj_VT_USERDEFINED = 29
Global Const $__Au3Obj_VT_LPSTR = 30
Global Const $__Au3Obj_VT_LPWSTR = 31
Global Const $__Au3Obj_VT_RECORD = 36
Global Const $__Au3Obj_VT_INT_PTR = 37
Global Const $__Au3Obj_VT_UINT_PTR = 38
Global Const $__Au3Obj_VT_FILETIME = 64
Global Const $__Au3Obj_VT_BLOB = 65
Global Const $__Au3Obj_VT_STREAM = 66
Global Const $__Au3Obj_VT_STORAGE = 67
Global Const $__Au3Obj_VT_STREAMED_OBJECT = 68
Global Const $__Au3Obj_VT_STORED_OBJECT = 69
Global Const $__Au3Obj_VT_BLOB_OBJECT = 70
Global Const $__Au3Obj_VT_CF = 71
Global Const $__Au3Obj_VT_CLSID = 72
Global Const $__Au3Obj_VT_VERSIONED_STREAM = 73
Global Const $__Au3Obj_VT_BSTR_BLOB = 0xfff
Global Const $__Au3Obj_VT_VECTOR = 0x1000
Global Const $__Au3Obj_VT_ARRAY = 0x2000
Global Const $__Au3Obj_VT_BYREF = 0x4000
Global Const $__Au3Obj_VT_RESERVED = 0x8000
Global Const $__Au3Obj_VT_ILLEGAL = 0xffff
Global Const $__Au3Obj_VT_ILLEGALMASKED = 0xfff
Global Const $__Au3Obj_VT_TYPEMASK = 0xfff

Global Const $__Au3Obj_tagVARIANT = "word vt;word r1;word r2;word r3;ptr data; ptr"

Global Const $__Au3Obj_VARIANT_SIZE = DllStructGetSize(DllStructCreate($__Au3Obj_tagVARIANT, 1))
Global Const $__Au3Obj_PTR_SIZE = DllStructGetSize(DllStructCreate('ptr', 1))
Global Const $__Au3Obj_tagSAFEARRAYBOUND = "ulong cElements; long lLbound;"

Global $ghAutoItObjectDLL = -1, $giAutoItObjectDLLRef = 0

;===============================================================================
#interface "IUnknown"
Global Const $sIID_IUnknown = "{00000000-0000-0000-C000-000000000046}"
; Definition
Global $dtagIUnknown = "QueryInterface hresult(ptr;ptr*);" & _
		"AddRef dword();" & _
		"Release dword();"
; List
Global $ltagIUnknown = "QueryInterface;" & _
		"AddRef;" & _
		"Release;"
;===============================================================================
;===============================================================================
#interface "IDispatch"
Global Const $sIID_IDispatch = "{00020400-0000-0000-C000-000000000046}"
; Definition
Global $dtagIDispatch = $dtagIUnknown & _
		"GetTypeInfoCount hresult(dword*);" & _
		"GetTypeInfo hresult(dword;dword;ptr*);" & _
		"GetIDsOfNames hresult(ptr;ptr;dword;dword;ptr);" & _
		"Invoke hresult(dword;ptr;dword;word;ptr;ptr;ptr;ptr);"
; List
Global $ltagIDispatch = $ltagIUnknown & _
		"GetTypeInfoCount;" & _
		"GetTypeInfo;" & _
		"GetIDsOfNames;" & _
		"Invoke;"
;===============================================================================

#EndRegion Variable definitions
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#Region Misc

DllCall($gh_AU3Obj_ole32dll, 'long', 'OleInitialize', 'ptr', 0)
OnAutoItExitRegister("__Au3Obj_OleUninitialize")
Func __Au3Obj_OleUninitialize()
	; Author: Prog@ndy
	DllCall($gh_AU3Obj_ole32dll, 'long', 'OleUninitialize')
	_AutoItObject_Shutdown(True)
EndFunc   ;==>__Au3Obj_OleUninitialize

Func __Au3Obj_IUnknown_AddRef($vObj)
	Local $sType = "ptr"
	If IsObj($vObj) Then $sType = "idispatch"
	Local $tVARIANT = DllStructCreate($__Au3Obj_tagVARIANT)
	; Actual call
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "long", "DispCallFunc", _
			$sType, $vObj, _
			"dword", $__Au3Obj_PTR_SIZE, _ ; offset (4 for x86, 8 for x64)
			"dword", 4, _ ; CC_STDCALL
			"dword", $__Au3Obj_VT_UINT, _
			"dword", 0, _ ; number of function parameters
			"ptr", 0, _ ; parameters related
			"ptr", 0, _ ; parameters related
			"ptr", DllStructGetPtr($tVARIANT))
	If @error Or $aCall[0] Then Return SetError(1, 0, 0)
	; Collect returned
	Return DllStructGetData(DllStructCreate("dword", DllStructGetPtr($tVARIANT, "data")), 1)
EndFunc   ;==>__Au3Obj_IUnknown_AddRef

Func __Au3Obj_IUnknown_Release($vObj)
	Local $sType = "ptr"
	If IsObj($vObj) Then $sType = "idispatch"
	Local $tVARIANT = DllStructCreate($__Au3Obj_tagVARIANT)
	; Actual call
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "long", "DispCallFunc", _
			$sType, $vObj, _
			"dword", 2 * $__Au3Obj_PTR_SIZE, _ ; offset (8 for x86, 16 for x64)
			"dword", 4, _ ; CC_STDCALL
			"dword", $__Au3Obj_VT_UINT, _
			"dword", 0, _ ; number of function parameters
			"ptr", 0, _ ; parameters related
			"ptr", 0, _ ; parameters related
			"ptr", DllStructGetPtr($tVARIANT))
	If @error Or $aCall[0] Then Return SetError(1, 0, 0)
	; Collect returned
	Return DllStructGetData(DllStructCreate("dword", DllStructGetPtr($tVARIANT, "data")), 1)
EndFunc   ;==>__Au3Obj_IUnknown_Release

Func __Au3Obj_GetMethods($tagInterface)
	Local $sMethods = StringReplace(StringRegExpReplace($tagInterface, "\h*(\w+)\h*(\w+\*?)\h*(\((.*?)\))\h*(;|;*\z)", "$1\|$2;$4" & @LF), ";" & @LF, @LF)
	If $sMethods = $tagInterface Then $sMethods = StringReplace(StringRegExpReplace($tagInterface, "\h*(\w+)\h*(;|;*\z)", "$1\|" & @LF), ";" & @LF, @LF)
	Return StringTrimRight($sMethods, 1)
EndFunc   ;==>__Au3Obj_GetMethods

Func __Au3Obj_ObjStructGetElements($sTag, ByRef $sAlign)
	Local $sAlignment = StringRegExpReplace($sTag, "\h*(align\h+\d+)\h*;.*", "$1")
	If $sAlignment <> $sTag Then
		$sAlign = $sAlignment
		$sTag = StringRegExpReplace($sTag, "\h*(align\h+\d+)\h*;", "")
	EndIf
	; Return StringRegExp($sTag, "\h*\w+\h*(\w+)\h*", 3) ; DO NOT REMOVE THIS LINE
	Return StringTrimRight(StringRegExpReplace($sTag, "\h*\w+\h*(\w+)\h*(\[\d+\])*\h*(;|;*\z)\h*", "$1;"), 1)
EndFunc   ;==>__Au3Obj_ObjStructGetElements

#EndRegion Misc
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#Region SafeArray
Func __Au3Obj_SafeArrayCreate($vType, $cDims, $rgsabound)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "ptr", "SafeArrayCreate", "dword", $vType, "uint", $cDims, 'ptr', $rgsabound)
	If @error Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SafeArrayCreate

Func __Au3Obj_SafeArrayDestroy($pSafeArray)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "int", "SafeArrayDestroy", "ptr", $pSafeArray)
	If @error Then Return SetError(1, 0, 1)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SafeArrayDestroy

Func __Au3Obj_SafeArrayAccessData($pSafeArray, ByRef $pArrayData)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "int", "SafeArrayAccessData", "ptr", $pSafeArray, 'ptr*', 0)
	If @error Then Return SetError(1, 0, 1)
	$pArrayData = $aCall[2]
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SafeArrayAccessData

Func __Au3Obj_SafeArrayUnaccessData($pSafeArray)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "int", "SafeArrayUnaccessData", "ptr", $pSafeArray)
	If @error Then Return SetError(1, 0, 1)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SafeArrayUnaccessData

Func __Au3Obj_SafeArrayGetUBound($pSafeArray, $iDim, ByRef $iBound)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "int", "SafeArrayGetUBound", "ptr", $pSafeArray, 'uint', $iDim, 'long*', 0)
	If @error Then Return SetError(1, 0, 1)
	$iBound = $aCall[3]
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SafeArrayGetUBound

Func __Au3Obj_SafeArrayGetLBound($pSafeArray, $iDim, ByRef $iBound)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "int", "SafeArrayGetLBound", "ptr", $pSafeArray, 'uint', $iDim, 'long*', 0)
	If @error Then Return SetError(1, 0, 1)
	$iBound = $aCall[3]
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SafeArrayGetLBound

Func __Au3Obj_SafeArrayGetDim($pSafeArray)
	Local $aResult = DllCall($gh_AU3Obj_oleautdll, "uint", "SafeArrayGetDim", "ptr", $pSafeArray)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>__Au3Obj_SafeArrayGetDim

Func __Au3Obj_CreateSafeArrayVariant(ByRef Const $aArray)
	; Author: Prog@ndy
	Local $iDim = UBound($aArray, 0), $pData, $pSafeArray, $bound, $subBound, $tBound
	Switch $iDim
		Case 1
			$bound = UBound($aArray) - 1
			$tBound = DllStructCreate($__Au3Obj_tagSAFEARRAYBOUND)
			DllStructSetData($tBound, 1, $bound + 1)
			$pSafeArray = __Au3Obj_SafeArrayCreate($__Au3Obj_VT_VARIANT, 1, DllStructGetPtr($tBound))
			If 0 = __Au3Obj_SafeArrayAccessData($pSafeArray, $pData) Then
				For $i = 0 To $bound
					_AutoItObject_VariantInit($pData + $i * $__Au3Obj_VARIANT_SIZE)
					_AutoItObject_VariantSet($pData + $i * $__Au3Obj_VARIANT_SIZE, $aArray[$i])
				Next
				__Au3Obj_SafeArrayUnaccessData($pSafeArray)
			EndIf
			Return $pSafeArray
		Case 2
			$bound = UBound($aArray, 1) - 1
			$subBound = UBound($aArray, 2) - 1
			$tBound = DllStructCreate($__Au3Obj_tagSAFEARRAYBOUND & $__Au3Obj_tagSAFEARRAYBOUND)
			DllStructSetData($tBound, 3, $bound + 1)
			DllStructSetData($tBound, 1, $subBound + 1)
			$pSafeArray = __Au3Obj_SafeArrayCreate($__Au3Obj_VT_VARIANT, 2, DllStructGetPtr($tBound))
			If 0 = __Au3Obj_SafeArrayAccessData($pSafeArray, $pData) Then
				For $i = 0 To $bound
					For $j = 0 To $subBound
						_AutoItObject_VariantInit($pData + ($j + $i * ($subBound + 1)) * $__Au3Obj_VARIANT_SIZE)
						_AutoItObject_VariantSet($pData + ($j + $i * ($subBound + 1)) * $__Au3Obj_VARIANT_SIZE, $aArray[$i][$j])
					Next
				Next
				__Au3Obj_SafeArrayUnaccessData($pSafeArray)
			EndIf
			Return $pSafeArray
		Case Else
			Return 0
	EndSwitch
EndFunc   ;==>__Au3Obj_CreateSafeArrayVariant

Func __Au3Obj_ReadSafeArrayVariant($pSafeArray)
	; Author: Prog@ndy
	Local $iDim = __Au3Obj_SafeArrayGetDim($pSafeArray), $pData, $lbound, $bound, $subBound
	Switch $iDim
		Case 1
			__Au3Obj_SafeArrayGetLBound($pSafeArray, 1, $lbound)
			__Au3Obj_SafeArrayGetUBound($pSafeArray, 1, $bound)
			$bound -= $lbound
			Local $array[$bound + 1]
			If 0 = __Au3Obj_SafeArrayAccessData($pSafeArray, $pData) Then
				For $i = 0 To $bound
					$array[$i] = _AutoItObject_VariantRead($pData + $i * $__Au3Obj_VARIANT_SIZE)
				Next
				__Au3Obj_SafeArrayUnaccessData($pSafeArray)
			EndIf
			Return $array
		Case 2
			__Au3Obj_SafeArrayGetLBound($pSafeArray, 2, $lbound)
			__Au3Obj_SafeArrayGetUBound($pSafeArray, 2, $bound)
			$bound -= $lbound
			__Au3Obj_SafeArrayGetLBound($pSafeArray, 1, $lbound)
			__Au3Obj_SafeArrayGetUBound($pSafeArray, 1, $subBound)
			$subBound -= $lbound
			Local $array[$bound + 1][$subBound + 1]
			If 0 = __Au3Obj_SafeArrayAccessData($pSafeArray, $pData) Then
				For $i = 0 To $bound
					For $j = 0 To $subBound
						$array[$i][$j] = _AutoItObject_VariantRead($pData + ($j + $i * ($subBound + 1)) * $__Au3Obj_VARIANT_SIZE)
					Next
				Next
				__Au3Obj_SafeArrayUnaccessData($pSafeArray)
			EndIf
			Return $array
		Case Else
			Return 0
	EndSwitch
EndFunc   ;==>__Au3Obj_ReadSafeArrayVariant

#EndRegion SafeArray
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#Region Memory

Func __Au3Obj_CoTaskMemAlloc($iSize)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_ole32dll, "ptr", "CoTaskMemAlloc", "uint_ptr", $iSize)
	If @error Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_CoTaskMemAlloc

Func __Au3Obj_CoTaskMemFree($pCoMem)
	; Author: Prog@ndy
	DllCall($gh_AU3Obj_ole32dll, "none", "CoTaskMemFree", "ptr", $pCoMem)
	If @error Then Return SetError(1, 0, 0)
EndFunc   ;==>__Au3Obj_CoTaskMemFree

Func __Au3Obj_CoTaskMemRealloc($pCoMem, $iSize)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_ole32dll, "ptr", "CoTaskMemRealloc", 'ptr', $pCoMem, "uint_ptr", $iSize)
	If @error Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_CoTaskMemRealloc

Func __Au3Obj_GlobalAlloc($iSize, $iFlag)
	Local $aCall = DllCall($gh_AU3Obj_kernel32dll, "ptr", "GlobalAlloc", "dword", $iFlag, "dword_ptr", $iSize)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_GlobalAlloc

Func __Au3Obj_GlobalFree($pPointer)
	Local $aCall = DllCall($gh_AU3Obj_kernel32dll, "ptr", "GlobalFree", "ptr", $pPointer)
	If @error Or $aCall[0] Then Return SetError(1, 0, 0)
	Return 1
EndFunc   ;==>__Au3Obj_GlobalFree

#EndRegion Memory
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#Region SysString

Func __Au3Obj_SysAllocString($str)
	; Author: monoceres
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "ptr", "SysAllocString", "wstr", $str)
	If @error Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SysAllocString
Func __Au3Obj_SysCopyString($pBSTR)
	; Author: Prog@ndy
	If Not $pBSTR Then Return SetError(2, 0, 0)
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "ptr", "SysAllocStringLen", "ptr", $pBSTR, "uint", __Au3Obj_SysStringLen($pBSTR))
	If @error Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SysCopyString

Func __Au3Obj_SysReAllocString(ByRef $pBSTR, $str)
	; Author: Prog@ndy
	If Not $pBSTR Then Return SetError(2, 0, 0)
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "int", "SysReAllocString", 'ptr*', $pBSTR, "wstr", $str)
	If @error Then Return SetError(1, 0, 0)
	$pBSTR = $aCall[1]
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SysReAllocString

Func __Au3Obj_SysFreeString($pBSTR)
	; Author: Prog@ndy
	If Not $pBSTR Then Return SetError(2, 0, 0)
	DllCall($gh_AU3Obj_oleautdll, "none", "SysFreeString", "ptr", $pBSTR)
	If @error Then Return SetError(1, 0, 0)
EndFunc   ;==>__Au3Obj_SysFreeString

Func __Au3Obj_SysStringLen($pBSTR)
	; Author: Prog@ndy
	If Not $pBSTR Then Return SetError(2, 0, 0)
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "uint", "SysStringLen", "ptr", $pBSTR)
	If @error Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SysStringLen

Func __Au3Obj_SysReadString($pBSTR, $iLen = -1)
	; Author: Prog@ndy
	If Not $pBSTR Then Return SetError(2, 0, '')
	If $iLen < 1 Then $iLen = __Au3Obj_SysStringLen($pBSTR)
	If $iLen < 1 Then Return SetError(1, 0, '')
	Return DllStructGetData(DllStructCreate("wchar[" & $iLen & "]", $pBSTR), 1)
EndFunc   ;==>__Au3Obj_SysReadString

Func __Au3Obj_PtrStringLen($pStr)
	; Author: Prog@ndy
	Local $aResult = DllCall($gh_AU3Obj_kernel32dll, 'int', 'lstrlenW', 'ptr', $pStr)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>__Au3Obj_PtrStringLen

Func __Au3Obj_PtrStringRead($pStr, $iLen = -1)
	; Author: Prog@ndy
	If $iLen < 1 Then $iLen = __Au3Obj_PtrStringLen($pStr)
	If $iLen < 1 Then Return SetError(1, 0, '')
	Return DllStructGetData(DllStructCreate("wchar[" & $iLen & "]", $pStr), 1)
EndFunc   ;==>__Au3Obj_PtrStringRead

#EndRegion SysString
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#Region Proxy Functions

Func __Au3Obj_FunctionProxy($FuncName, $oSelf) ; allows binary code to call autoit functions
	Local $arg = $oSelf.__params__ ; fetch params
	If IsArray($arg) Then
		Local $ret = Call($FuncName, $arg) ; Call
		If @error = 0xDEAD And @extended = 0xBEEF Then Return 0
		$oSelf.__error__ = @error ; set error
		$oSelf.__result__ = $ret ; set result
		Return 1
	EndIf
	; return error when params-array could not be created
EndFunc   ;==>__Au3Obj_FunctionProxy

Func __Au3Obj_EnumFunctionProxy($iAction, $FuncName, $oSelf, $pVarCurrent, $pVarResult)
	Local $Current, $ret
	Switch $iAction
		Case 0 ; Next
			$Current = $oSelf.__bridge__(Number($pVarCurrent))
			$ret = Execute($FuncName & "($oSelf, $Current)")
			If @error Then Return False
			$oSelf.__bridge__(Number($pVarCurrent)) = $Current
			$oSelf.__bridge__(Number($pVarResult)) = $ret
			Return 1
		Case 1 ;Skip
			Return False
		Case 2 ; Reset
			$Current = $oSelf.__bridge__(Number($pVarCurrent))
			$ret = Execute($FuncName & "($oSelf, $Current)")
			If @error Or Not $ret Then Return False
			$oSelf.__bridge__(Number($pVarCurrent)) = $Current
			Return True
	EndSwitch
EndFunc   ;==>__Au3Obj_EnumFunctionProxy

#EndRegion Proxy Functions
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#Region Call Pointer

Func __Au3Obj_PointerCall($sRetType, $pAddress, $sType1 = "", $vParam1 = 0, $sType2 = "", $vParam2 = 0, $sType3 = "", $vParam3 = 0, $sType4 = "", $vParam4 = 0, $sType5 = "", $vParam5 = 0, $sType6 = "", $vParam6 = 0, $sType7 = "", $vParam7 = 0, $sType8 = "", $vParam8 = 0, $sType9 = "", $vParam9 = 0, $sType10 = "", $vParam10 = 0, $sType11 = "", $vParam11 = 0, $sType12 = "", $vParam12 = 0, $sType13 = "", $vParam13 = 0, $sType14 = "", $vParam14 = 0, $sType15 = "", $vParam15 = 0, $sType16 = "", $vParam16 = 0, $sType17 = "", $vParam17 = 0, $sType18 = "", $vParam18 = 0, $sType19 = "", $vParam19 = 0, $sType20 = "", $vParam20 = 0)
	; Author: Ward, Prog@ndy, trancexx
	Local Static $pHook, $hPseudo, $tPtr, $sFuncName = "MemoryCallEntry"
	If $pAddress Then
		If Not $pHook Then
			Local $sDll = "AutoItObject.dll"
			If $__Au3Obj_X64 Then $sDll = "AutoItObject_X64.dll"
			$hPseudo = DllOpen($sDll)
			If $hPseudo = -1 Then
				$sDll = "kernel32.dll"
				$sFuncName = "GlobalFix"
				$hPseudo = DllOpen($sDll)
			EndIf
			Local $aCall = DllCall($gh_AU3Obj_kernel32dll, "ptr", "GetModuleHandleW", "wstr", $sDll)
			If @error Or Not $aCall[0] Then Return SetError(7, @error, 0) ; Couldn't get dll handle
			Local $hModuleHandle = $aCall[0]
			$aCall = DllCall($gh_AU3Obj_kernel32dll, "ptr", "GetProcAddress", "ptr", $hModuleHandle, "str", $sFuncName)
			If @error Then Return SetError(8, @error, 0) ; Wanted function not found
			$pHook = $aCall[0]
			$aCall = DllCall($gh_AU3Obj_kernel32dll, "bool", "VirtualProtect", "ptr", $pHook, "dword", 7 + 5 * $__Au3Obj_X64, "dword", 64, "dword*", 0)
			If @error Or Not $aCall[0] Then Return SetError(9, @error, 0) ; Unable to set MEM_EXECUTE_READWRITE
			If $__Au3Obj_X64 Then
				DllStructSetData(DllStructCreate("word", $pHook), 1, 0xB848)
				DllStructSetData(DllStructCreate("word", $pHook + 10), 1, 0xE0FF)
			Else
				DllStructSetData(DllStructCreate("byte", $pHook), 1, 0xB8)
				DllStructSetData(DllStructCreate("word", $pHook + 5), 1, 0xE0FF)
			EndIf
			$tPtr = DllStructCreate("ptr", $pHook + 1 + $__Au3Obj_X64)
		EndIf
		DllStructSetData($tPtr, 1, $pAddress)
		Local $aRet
		Switch @NumParams
			Case 2
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName)
			Case 4
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1)
			Case 6
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2)
			Case 8
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3)
			Case 10
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4)
			Case 12
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5)
			Case 14
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6)
			Case 16
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7)
			Case 18
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8)
			Case 20
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9)
			Case 22
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10)
			Case 24
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11)
			Case 26
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12)
			Case 28
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12, $sType13, $vParam13)
			Case 30
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12, $sType13, $vParam13, $sType14, $vParam14)
			Case 32
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12, $sType13, $vParam13, $sType14, $vParam14, $sType15, $vParam15)
			Case 34
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12, $sType13, $vParam13, $sType14, $vParam14, $sType15, $vParam15, $sType16, $vParam16)
			Case 36
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12, $sType13, $vParam13, $sType14, $vParam14, $sType15, $vParam15, $sType16, $vParam16, $sType17, $vParam17)
			Case 38
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12, $sType13, $vParam13, $sType14, $vParam14, $sType15, $vParam15, $sType16, $vParam16, $sType17, $vParam17, $sType18, $vParam18)
			Case 40
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12, $sType13, $vParam13, $sType14, $vParam14, $sType15, $vParam15, $sType16, $vParam16, $sType17, $vParam17, $sType18, $vParam18, $sType19, $vParam19)
			Case 42
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12, $sType13, $vParam13, $sType14, $vParam14, $sType15, $vParam15, $sType16, $vParam16, $sType17, $vParam17, $sType18, $vParam18, $sType19, $vParam19, $sType20, $vParam20)
			Case Else
				If Mod(@NumParams, 2) Then Return SetError(4, 0, 0) ; Bad number of parameters
				Return SetError(5, 0, 0) ; Max number of parameters exceeded
		EndSwitch
		Return SetError(@error, @extended, $aRet) ; All went well. Error description and return values like with DllCall()
	EndIf
	Return SetError(6, 0, 0) ; Null address specified
EndFunc   ;==>__Au3Obj_PointerCall

#EndRegion Call Pointer
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#Region Embedded DLL

Func __Au3Obj_Mem_DllOpen($bBinaryImage = 0, $sSubrogor = "cmd.exe")
	If Not $bBinaryImage Then
		If $__Au3Obj_X64 Then
			$bBinaryImage = __Au3Obj_Mem_BinDll_X64()
		Else
			$bBinaryImage = __Au3Obj_Mem_BinDll()
		EndIf
	EndIf
	; Make structure out of binary data that was passed
	Local $tBinary = DllStructCreate("byte[" & BinaryLen($bBinaryImage) & "]")
	DllStructSetData($tBinary, 1, $bBinaryImage) ; fill the structure
	; Get pointer to it
	Local $pPointer = DllStructGetPtr($tBinary)
	; Start processing passed binary data. 'Reading' PE format follows.
	Local $tIMAGE_DOS_HEADER = DllStructCreate("char Magic[2];" & _
			"word BytesOnLastPage;" & _
			"word Pages;" & _
			"word Relocations;" & _
			"word SizeofHeader;" & _
			"word MinimumExtra;" & _
			"word MaximumExtra;" & _
			"word SS;" & _
			"word SP;" & _
			"word Checksum;" & _
			"word IP;" & _
			"word CS;" & _
			"word Relocation;" & _
			"word Overlay;" & _
			"char Reserved[8];" & _
			"word OEMIdentifier;" & _
			"word OEMInformation;" & _
			"char Reserved2[20];" & _
			"dword AddressOfNewExeHeader", _
			$pPointer)
	; Move pointer
	$pPointer += DllStructGetData($tIMAGE_DOS_HEADER, "AddressOfNewExeHeader") ; move to PE file header
	$pPointer += 4 ; size of skipped $tIMAGE_NT_SIGNATURE structure
	; In place of IMAGE_FILE_HEADER structure
	Local $tIMAGE_FILE_HEADER = DllStructCreate("word Machine;" & _
			"word NumberOfSections;" & _
			"dword TimeDateStamp;" & _
			"dword PointerToSymbolTable;" & _
			"dword NumberOfSymbols;" & _
			"word SizeOfOptionalHeader;" & _
			"word Characteristics", _
			$pPointer)
	; Get number of sections
	Local $iNumberOfSections = DllStructGetData($tIMAGE_FILE_HEADER, "NumberOfSections")
	; Move pointer
	$pPointer += 20 ; size of $tIMAGE_FILE_HEADER structure
	; Determine the type
	Local $tMagic = DllStructCreate("word Magic;", $pPointer)
	Local $iMagic = DllStructGetData($tMagic, 1)
	Local $tIMAGE_OPTIONAL_HEADER
	If $iMagic = 267 Then ; x86 version
		If $__Au3Obj_X64 Then Return SetError(1, 0, -1) ; incompatible versions
		$tIMAGE_OPTIONAL_HEADER = DllStructCreate("word Magic;" & _
				"byte MajorLinkerVersion;" & _
				"byte MinorLinkerVersion;" & _
				"dword SizeOfCode;" & _
				"dword SizeOfInitializedData;" & _
				"dword SizeOfUninitializedData;" & _
				"dword AddressOfEntryPoint;" & _
				"dword BaseOfCode;" & _
				"dword BaseOfData;" & _
				"dword ImageBase;" & _
				"dword SectionAlignment;" & _
				"dword FileAlignment;" & _
				"word MajorOperatingSystemVersion;" & _
				"word MinorOperatingSystemVersion;" & _
				"word MajorImageVersion;" & _
				"word MinorImageVersion;" & _
				"word MajorSubsystemVersion;" & _
				"word MinorSubsystemVersion;" & _
				"dword Win32VersionValue;" & _
				"dword SizeOfImage;" & _
				"dword SizeOfHeaders;" & _
				"dword CheckSum;" & _
				"word Subsystem;" & _
				"word DllCharacteristics;" & _
				"dword SizeOfStackReserve;" & _
				"dword SizeOfStackCommit;" & _
				"dword SizeOfHeapReserve;" & _
				"dword SizeOfHeapCommit;" & _
				"dword LoaderFlags;" & _
				"dword NumberOfRvaAndSizes", _
				$pPointer)
		; Move pointer
		$pPointer += 96 ; size of $tIMAGE_OPTIONAL_HEADER
	ElseIf $iMagic = 523 Then ; x64 version
		If Not $__Au3Obj_X64 Then Return SetError(1, 0, -1) ; incompatible versions
		$tIMAGE_OPTIONAL_HEADER = DllStructCreate("word Magic;" & _
				"byte MajorLinkerVersion;" & _
				"byte MinorLinkerVersion;" & _
				"dword SizeOfCode;" & _
				"dword SizeOfInitializedData;" & _
				"dword SizeOfUninitializedData;" & _
				"dword AddressOfEntryPoint;" & _
				"dword BaseOfCode;" & _
				"uint64 ImageBase;" & _
				"dword SectionAlignment;" & _
				"dword FileAlignment;" & _
				"word MajorOperatingSystemVersion;" & _
				"word MinorOperatingSystemVersion;" & _
				"word MajorImageVersion;" & _
				"word MinorImageVersion;" & _
				"word MajorSubsystemVersion;" & _
				"word MinorSubsystemVersion;" & _
				"dword Win32VersionValue;" & _
				"dword SizeOfImage;" & _
				"dword SizeOfHeaders;" & _
				"dword CheckSum;" & _
				"word Subsystem;" & _
				"word DllCharacteristics;" & _
				"uint64 SizeOfStackReserve;" & _
				"uint64 SizeOfStackCommit;" & _
				"uint64 SizeOfHeapReserve;" & _
				"uint64 SizeOfHeapCommit;" & _
				"dword LoaderFlags;" & _
				"dword NumberOfRvaAndSizes", _
				$pPointer)
		; Move pointer
		$pPointer += 112 ; size of $tIMAGE_OPTIONAL_HEADER
	Else
		Return SetError(1, 0, -1) ; incompatible versions
	EndIf
	; Extract data
	Local $iEntryPoint = DllStructGetData($tIMAGE_OPTIONAL_HEADER, "AddressOfEntryPoint") ; if loaded binary image would start executing at this address
	Local $pOptionalHeaderImageBase = DllStructGetData($tIMAGE_OPTIONAL_HEADER, "ImageBase") ; address of the first byte of the image when it's loaded in memory
	$pPointer += 8 ; skipping IMAGE_DIRECTORY_ENTRY_EXPORT
	; Import Directory
	Local $tIMAGE_DIRECTORY_ENTRY_IMPORT = DllStructCreate("dword VirtualAddress; dword Size", $pPointer)
	; Collect data
	Local $pAddressImport = DllStructGetData($tIMAGE_DIRECTORY_ENTRY_IMPORT, "VirtualAddress")
;~ 	Local $iSizeImport = DllStructGetData($tIMAGE_DIRECTORY_ENTRY_IMPORT, "Size")
	$pPointer += 8 ; size of $tIMAGE_DIRECTORY_ENTRY_IMPORT
	$pPointer += 24 ; skipping IMAGE_DIRECTORY_ENTRY_RESOURCE, IMAGE_DIRECTORY_ENTRY_EXCEPTION, IMAGE_DIRECTORY_ENTRY_SECURITY
	; Base Relocation Directory
	Local $tIMAGE_DIRECTORY_ENTRY_BASERELOC = DllStructCreate("dword VirtualAddress; dword Size", $pPointer)
	; Collect data
	Local $pAddressNewBaseReloc = DllStructGetData($tIMAGE_DIRECTORY_ENTRY_BASERELOC, "VirtualAddress")
	Local $iSizeBaseReloc = DllStructGetData($tIMAGE_DIRECTORY_ENTRY_BASERELOC, "Size")
	$pPointer += 8 ; size of IMAGE_DIRECTORY_ENTRY_BASERELOC
	$pPointer += 40 ; skipping IMAGE_DIRECTORY_ENTRY_DEBUG, IMAGE_DIRECTORY_ENTRY_COPYRIGHT, IMAGE_DIRECTORY_ENTRY_GLOBALPTR, IMAGE_DIRECTORY_ENTRY_TLS, IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG
	$pPointer += 40 ; five more generally unused data directories
	; Load the victim
	Local $pBaseAddress = __Au3Obj_Mem_LoadLibraryEx($sSubrogor, 1) ; "lighter" loading, DONT_RESOLVE_DLL_REFERENCES
	If @error Then Return SetError(2, 0, -1) ; Couldn't load subrogor
	Local $pHeadersNew = DllStructGetPtr($tIMAGE_DOS_HEADER) ; starting address of binary image headers
	Local $iOptionalHeaderSizeOfHeaders = DllStructGetData($tIMAGE_OPTIONAL_HEADER, "SizeOfHeaders") ; the size of the MS-DOS stub, the PE header, and the section headers
	; Set proper memory protection for writting headers (PAGE_READWRITE)
	If Not __Au3Obj_Mem_VirtualProtect($pBaseAddress, $iOptionalHeaderSizeOfHeaders, 4) Then Return SetError(3, 0, -1) ; Couldn't set proper protection for headers
	; Write NEW headers
	DllStructSetData(DllStructCreate("byte[" & $iOptionalHeaderSizeOfHeaders & "]", $pBaseAddress), 1, DllStructGetData(DllStructCreate("byte[" & $iOptionalHeaderSizeOfHeaders & "]", $pHeadersNew), 1))
	; Dealing with sections. Will write them.
	Local $tIMAGE_SECTION_HEADER
	Local $iSizeOfRawData, $pPointerToRawData
	Local $iVirtualSize, $iVirtualAddress
	Local $pRelocRaw
	For $i = 1 To $iNumberOfSections
		$tIMAGE_SECTION_HEADER = DllStructCreate("char Name[8];" & _
				"dword UnionOfVirtualSizeAndPhysicalAddress;" & _
				"dword VirtualAddress;" & _
				"dword SizeOfRawData;" & _
				"dword PointerToRawData;" & _
				"dword PointerToRelocations;" & _
				"dword PointerToLinenumbers;" & _
				"word NumberOfRelocations;" & _
				"word NumberOfLinenumbers;" & _
				"dword Characteristics", _
				$pPointer)
		; Collect data
		$iSizeOfRawData = DllStructGetData($tIMAGE_SECTION_HEADER, "SizeOfRawData")
		$pPointerToRawData = $pHeadersNew + DllStructGetData($tIMAGE_SECTION_HEADER, "PointerToRawData")
		$iVirtualAddress = DllStructGetData($tIMAGE_SECTION_HEADER, "VirtualAddress")
		$iVirtualSize = DllStructGetData($tIMAGE_SECTION_HEADER, "UnionOfVirtualSizeAndPhysicalAddress")
		If $iVirtualSize And $iVirtualSize < $iSizeOfRawData Then $iSizeOfRawData = $iVirtualSize
		; Set MEM_EXECUTE_READWRITE for sections (PAGE_EXECUTE_READWRITE for all for simplicity)
		If Not __Au3Obj_Mem_VirtualProtect($pBaseAddress + $iVirtualAddress, $iVirtualSize, 64) Then
			$pPointer += 40 ; size of $tIMAGE_SECTION_HEADER structure
			ContinueLoop
		EndIf
		; Clean the space
		DllStructSetData(DllStructCreate("byte[" & $iVirtualSize & "]", $pBaseAddress + $iVirtualAddress), 1, DllStructGetData(DllStructCreate("byte[" & $iVirtualSize & "]"), 1))
		; If there is data to write, write it
		If $iSizeOfRawData Then DllStructSetData(DllStructCreate("byte[" & $iSizeOfRawData & "]", $pBaseAddress + $iVirtualAddress), 1, DllStructGetData(DllStructCreate("byte[" & $iSizeOfRawData & "]", $pPointerToRawData), 1))
		; Relocations
		If $iVirtualAddress <= $pAddressNewBaseReloc And $iVirtualAddress + $iSizeOfRawData > $pAddressNewBaseReloc Then $pRelocRaw = $pPointerToRawData + ($pAddressNewBaseReloc - $iVirtualAddress)
		; Imports
		If $iVirtualAddress <= $pAddressImport And $iVirtualAddress + $iSizeOfRawData > $pAddressImport Then __Au3Obj_Mem_FixImports($pPointerToRawData + ($pAddressImport - $iVirtualAddress), $pBaseAddress) ; fix imports in place
		; Move pointer
		$pPointer += 40 ; size of $tIMAGE_SECTION_HEADER structure
	Next
	; Fix relocations
	If $pAddressNewBaseReloc And $iSizeBaseReloc Then __Au3Obj_Mem_FixReloc($pRelocRaw, $iSizeBaseReloc, $pBaseAddress, $pOptionalHeaderImageBase, $iMagic = 523)
	; Entry point address
	Local $pEntryFunc = $pBaseAddress + $iEntryPoint
	; DllMain simulation
	__Au3Obj_PointerCall("bool", $pEntryFunc, "ptr", $pBaseAddress, "dword", 1, "ptr", 0) ; DLL_PROCESS_ATTACH
	; Get pseudo-handle
	Local $hPseudo = DllOpen($sSubrogor)
	__Au3Obj_Mem_FreeLibrary($pBaseAddress) ; decrement reference count
	Return $hPseudo
EndFunc   ;==>__Au3Obj_Mem_DllOpen

Func __Au3Obj_Mem_FixReloc($pData, $iSize, $pAddressNew, $pAddressOld, $fImageX64)
	Local $iDelta = $pAddressNew - $pAddressOld ; dislocation value
	Local $tIMAGE_BASE_RELOCATION, $iRelativeMove
	Local $iVirtualAddress, $iSizeofBlock, $iNumberOfEntries
	Local $tEnries, $iData, $tAddress
	Local $iFlag = 3 + 7 * $fImageX64 ; IMAGE_REL_BASED_HIGHLOW = 3 or IMAGE_REL_BASED_DIR64 = 10
	While $iRelativeMove < $iSize ; for all data available
		$tIMAGE_BASE_RELOCATION = DllStructCreate("dword VirtualAddress; dword SizeOfBlock", $pData + $iRelativeMove)
		$iVirtualAddress = DllStructGetData($tIMAGE_BASE_RELOCATION, "VirtualAddress")
		$iSizeofBlock = DllStructGetData($tIMAGE_BASE_RELOCATION, "SizeOfBlock")
		$iNumberOfEntries = ($iSizeofBlock - 8) / 2
		$tEnries = DllStructCreate("word[" & $iNumberOfEntries & "]", DllStructGetPtr($tIMAGE_BASE_RELOCATION) + 8)
		; Go through all entries
		For $i = 1 To $iNumberOfEntries
			$iData = DllStructGetData($tEnries, 1, $i)
			If BitShift($iData, 12) = $iFlag Then ; check type
				$tAddress = DllStructCreate("ptr", $pAddressNew + $iVirtualAddress + BitAND($iData, 0xFFF)) ; the rest of $iData is offset
				DllStructSetData($tAddress, 1, DllStructGetData($tAddress, 1) + $iDelta) ; this is what's this all about
			EndIf
		Next
		$iRelativeMove += $iSizeofBlock
	WEnd
	Return 1 ; all OK!
EndFunc   ;==>__Au3Obj_Mem_FixReloc

Func __Au3Obj_Mem_FixImports($pImportDirectory, $hInstance)
	Local $hModule, $tFuncName, $sFuncName, $pFuncAddress
	Local $tIMAGE_IMPORT_MODULE_DIRECTORY, $tModuleName
	Local $tBufferOffset2, $iBufferOffset2
	Local $iInitialOffset, $iInitialOffset2, $iOffset
	While 1
		$tIMAGE_IMPORT_MODULE_DIRECTORY = DllStructCreate("dword RVAOriginalFirstThunk;" & _
				"dword TimeDateStamp;" & _
				"dword ForwarderChain;" & _
				"dword RVAModuleName;" & _
				"dword RVAFirstThunk", _
				$pImportDirectory)
		If Not DllStructGetData($tIMAGE_IMPORT_MODULE_DIRECTORY, "RVAFirstThunk") Then ExitLoop ; the end
		$tModuleName = DllStructCreate("char Name[64]", $hInstance + DllStructGetData($tIMAGE_IMPORT_MODULE_DIRECTORY, "RVAModuleName"))
		$hModule = __Au3Obj_Mem_LoadLibraryEx(DllStructGetData($tModuleName, "Name")) ; load the module, full load
		$iInitialOffset = $hInstance + DllStructGetData($tIMAGE_IMPORT_MODULE_DIRECTORY, "RVAFirstThunk")
		$iInitialOffset2 = $hInstance + DllStructGetData($tIMAGE_IMPORT_MODULE_DIRECTORY, "RVAOriginalFirstThunk")
		If $iInitialOffset2 = $hInstance Then $iInitialOffset2 = $iInitialOffset
		$iOffset = 0 ; back to 0
		While 1
			$tBufferOffset2 = DllStructCreate("ptr", $iInitialOffset2 + $iOffset)
			$iBufferOffset2 = DllStructGetData($tBufferOffset2, 1) ; value at that address
			If Not $iBufferOffset2 Then ExitLoop ; zero value is the end
			If BitShift(BinaryMid($iBufferOffset2, $__Au3Obj_PTR_SIZE, 1), 7) Then ; MSB is set for imports by ordinal, otherwise not
				$pFuncAddress = __Au3Obj_Mem_GetAddress($hModule, BitAND($iBufferOffset2, 0xFFFFFF)) ; the rest is ordinal value
			Else
				$tFuncName = DllStructCreate("word Ordinal; char Name[64]", $hInstance + $iBufferOffset2)
				$sFuncName = DllStructGetData($tFuncName, "Name")
				$pFuncAddress = __Au3Obj_Mem_GetAddress($hModule, $sFuncName)
			EndIf
			DllStructSetData(DllStructCreate("ptr", $iInitialOffset + $iOffset), 1, $pFuncAddress) ; and this is what's this all about
			$iOffset += $__Au3Obj_PTR_SIZE ; size of $tBufferOffset2
		WEnd
		$pImportDirectory += 20 ; size of $tIMAGE_IMPORT_MODULE_DIRECTORY
	WEnd
	Return 1 ; all OK!
EndFunc   ;==>__Au3Obj_Mem_FixImports

Func __Au3Obj_Mem_Base64Decode($sData) ; Ward
	Local $bOpcode
	If $__Au3Obj_X64 Then
		$bOpcode = Binary("0x4156415541544D89CC555756534C89C34883EC20410FB64104418800418B3183FE010F84AB00000073434863D24D89C54889CE488D3C114839FE0F84A50100000FB62E4883C601E8B501000083ED2B4080FD5077E2480FBEED0FB6042884C00FBED078D3C1E20241885500EB7383FE020F841C01000031C083FE03740F4883C4205B5E5F5D415C415D415EC34863D24D89C54889CE488D3C114839FE0F84CA0000000FB62E4883C601E85301000083ED2B4080FD5077E2480FBEED0FB6042884C078D683E03F410845004983C501E964FFFFFF4863D24D89C54889CE488D3C114839FE0F84E00000000FB62E4883C601E80C01000083ED2B4080FD5077E2480FBEED0FB6042884C00FBED078D389D04D8D7501C1E20483E03041885501C1F804410845004839FE747B0FB62E4883C601E8CC00000083ED2B4080FD5077E6480FBEED0FB6042884C00FBED078D789D0C1E2064D8D6E0183E03C41885601C1F8024108064839FE0F8536FFFFFF41C7042403000000410FB6450041884424044489E84883C42029D85B5E5F5D415C415D415EC34863D24889CE4D89C6488D3C114839FE758541C7042402000000410FB60641884424044489F04883C42029D85B5E5F5D415C415D415EC341C7042401000000410FB6450041884424044489E829D8E998FEFFFF41C7042400000000410FB6450041884424044489E829D8E97CFEFFFFE8500000003EFFFFFF3F3435363738393A3B3C3DFFFFFFFEFFFFFF000102030405060708090A0B0C0D0E0F10111213141516171819FFFFFFFFFFFF1A1B1C1D1E1F202122232425262728292A2B2C2D2E2F3031323358C3")
	Else
		$bOpcode = Binary("0x5557565383EC1C8B6C243C8B5424388B5C24308B7424340FB6450488028B550083FA010F84A1000000733F8B5424388D34338954240C39F30F848B0100000FB63B83C301E8890100008D57D580FA5077E50FBED20FB6041084C00FBED078D78B44240CC1E2028810EB6B83FA020F841201000031C083FA03740A83C41C5B5E5F5DC210008B4C24388D3433894C240C39F30F84CD0000000FB63B83C301E8300100008D57D580FA5077E50FBED20FB6041084C078DA8B54240C83E03F080283C2018954240CE96CFFFFFF8B4424388D34338944240C39F30F84D00000000FB63B83C301E8EA0000008D57D580FA5077E50FBED20FB6141084D20FBEC278D78B4C240C89C283E230C1FA04C1E004081189CF83C70188410139F374750FB60383C3018844240CE8A80000000FB654240C83EA2B80FA5077E00FBED20FB6141084D20FBEC278D289C283E23CC1FA02C1E006081739F38D57018954240C8847010F8533FFFFFFC74500030000008B4C240C0FB60188450489C82B44243883C41C5B5E5F5DC210008D34338B7C243839F3758BC74500020000000FB60788450489F82B44243883C41C5B5E5F5DC210008B54240CC74500010000000FB60288450489D02B442438E9B1FEFFFFC7450000000000EB99E8500000003EFFFFFF3F3435363738393A3B3C3DFFFFFFFEFFFFFF000102030405060708090A0B0C0D0E0F10111213141516171819FFFFFFFFFFFF1A1B1C1D1E1F202122232425262728292A2B2C2D2E2F3031323358C3")
	EndIf
	Local $tCodeBuffer = DllStructCreate("byte[" & BinaryLen($bOpcode) & "]")
	DllStructSetData($tCodeBuffer, 1, $bOpcode)
	__Au3Obj_Mem_VirtualProtect(DllStructGetPtr($tCodeBuffer), DllStructGetSize($tCodeBuffer), 64)
	If @error Then Return SetError(1, 0, "")
	Local $iLen = StringLen($sData)
	Local $tOut = DllStructCreate("byte[" & $iLen & "]")
	Local $tState = DllStructCreate("byte[16]")
	Local $Call = __Au3Obj_PointerCall("int", DllStructGetPtr($tCodeBuffer), "str", $sData, "dword", $iLen, "ptr", DllStructGetPtr($tOut), "ptr", DllStructGetPtr($tState))
	If @error Then Return SetError(2, 0, "")
	Return BinaryMid(DllStructGetData($tOut, 1), 1, $Call[0])
EndFunc   ;==>__Au3Obj_Mem_Base64Decode

Func __Au3Obj_Mem_LoadLibraryEx($sModule, $iFlag = 0)
	Local $aCall = DllCall($gh_AU3Obj_kernel32dll, "handle", "LoadLibraryExW", "wstr", $sModule, "handle", 0, "dword", $iFlag)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_Mem_LoadLibraryEx

Func __Au3Obj_Mem_FreeLibrary($hModule)
	Local $aCall = DllCall($gh_AU3Obj_kernel32dll, "bool", "FreeLibrary", "handle", $hModule)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	Return 1
EndFunc   ;==>__Au3Obj_Mem_FreeLibrary

Func __Au3Obj_Mem_GetAddress($hModule, $vFuncName)
	Local $sType = "str"
	If IsNumber($vFuncName) Then $sType = "int" ; if ordinal value passed
	Local $aCall = DllCall($gh_AU3Obj_kernel32dll, "ptr", "GetProcAddress", "handle", $hModule, $sType, $vFuncName)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_Mem_GetAddress

Func __Au3Obj_Mem_VirtualProtect($pAddress, $iSize, $iProtection)
	Local $aCall = DllCall($gh_AU3Obj_kernel32dll, "bool", "VirtualProtect", "ptr", $pAddress, "dword_ptr", $iSize, "dword", $iProtection, "dword*", 0)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	Return 1
EndFunc   ;==>__Au3Obj_Mem_VirtualProtect

Func __Au3Obj_Mem_BinDll()
    Local $sData = "TVpAAAEAAAACAAAA//8AALgAAAAAAAAACgAAAAAAAAAOH7oOALQJzSG4AUzNIVdpbjMyIC5ETEwuDQokQAAAAFBFAABMAQMAeWXOTQAAAAAAAAAA4AACIwsBCgAAOgAAABgAAAAAAABbkwAAABAAAABQAAAAAAAQABAAAAACAAAFAAEAAAAAAAUAAQAAAAAAALAAAAACAAAAAAAAAgAABQAAEAAAEAAAAAAQAAAQAAAAAAAAEAAAAACQAABUAgAAVJIAAAgBAAAAoAAAcAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALiSAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALk1QUkVTUzEAgAAAABAAAAAqAAAAAgAAAAAAAAAAAAAAAAAA4AAA4C5NUFJFU1MyFgYAAACQAAAACAAAACwAAAAAAAAAAAAAAAAAAOAAAOAucnNyYwAAAHADAAAAoAAAAAQAAAA0AAAAAAAAAAAAAAAAAABAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAdjIuMTcIAHopAABVAIvs/3UIagj/ABVYUAAQUP8VSlQM0DXMQgAsBgXIUoPsIIPk8NkAwNlUJBjffCQCEN9sJBCLFrAIQEQCUQhMx+MNkF4oneeRzUECsMhAEhgPAAAAABgY/P///zcIAg3ABBSD0gDraCw65DLYLqMNsI5EARH3wipRh5sNwUWCYRDJw1aLAPGDJgCDZhgAFI1GCBUAgBUAi8ZIXi6xaEAOB1DoQBPOkDVojGD1D1JBqANew4sBwwGNQQjDi0EYZxAAi0UIiUEYXcIFBACLQRwgxgESgBhgdbWY33iHIGA26ANAdyBIaiAIWP8AZokG/xVBiByQeATx5cVF" & _
            "gC4wGIwQ9V/BGw8DhFUBbAT/FQQ+ADCTrCYApHUvDvAAGXyfvYAcRYDO6P//zxOJBriTAABXEIRUAjBKDQacHIEJjUYYUMcGCDxRABAdMItGCECL9QBRCINmCABAXoMgTQiLQQRAGIlBBH70ImC1WAfAcDWTPANslgjSRG8A5GoEWY0AffAz0olF8McARfYAAMAAiUUA+mbHRf4ARvMAp8dF4AQEAgAUx0XmMKMOA+4AGEZ0G4oAJ+Az0gDzp3QMi00QiQABuAJAAIDrEOBJABySAUIwA/zlhZEszJASYxONSBgBUf9wCP9wDHMTgJsQi00UiQEzyQCFwA+UwYvBXSTCENVAagBWRqEGFGA199gbwEBdIsIIRA8AoSZApAQcALgBHwBUsw6A8E/gRLBoRHAA4IxO8BgAAGC1IDMDXJwbuDhhRgCwGpP4GQRAsFjEkGjEsBhWJAKBABSJRhT1EczHY2Fwo9g3It7DcKUYFPALYvUrAFwUgEE5FvMLAVIHXVF1CASLBlb/UMwAkcgF0xXR1RXDDlsDA4MLIAAzwONgFCTILkRTrRNGGFexs4s9kLET/9e14zH8//80ix2nE0yR+AgxvZhixKGnDG4fkL9fQtIaEcAhJiBiKv0Cx2IzmhYAIgZfXlutEFkAIP82ajIDnJVogJFoRLAccEXyn0QAeEWwWIWwAz2HALCYsEgQmEgQCTojMVVfED/zf2wAwCIFAJHjB2EH4rGYIcCBW7hNV+CwuIx+awlTDzAARzt+EHLijV5ADCxgRAAAsNgD2FLRaIQC9X/d+GKEpCA4CtAVsAe4D2uwaAdSaD9soDH/cjMOswfwWVKFkSIwCMCOMbWoPBgeQGB19VAozAP2wggCD4W5EMLwQCgwIgAA0MPXHFAX0LZYxzHoh4ADICgHGwBGBDPbgwA4/Q+UwzPAhQDbD5XAi/iLBgDB5wQDxw+3CACD+RV0GYP5FAB0FIP5GnQbgwD5E3QWg/kDdAAR6Q8GAABqExVqAFDjA6zjEzZ8" & _
            "AkAJHAxOMGAMJfBP54OQ3mIEPWB65hEEgDCIhwAA8UBIawKDwDiLAE0c/zFQ6209Rnk88FBYOE9AZJGORIK0vv0Fk0bwBREg8VCIBwOLBi1AHsYtEDcAGnQgLRA3AAMAdBa4BQACgOkpbgw3wAYVFnUg7zglM8BA0rOHG13PBNK4oA4buNBY1DhghwDzX4HqBIXAdWQ5TQCdCWgQxwJmieTXBqEZJpAYdHnAoUaQgGWWGHRfwJFIA4eRVYMnpEgwaNyAYrXOmA9zZIBQDlABla7yEYFHEhLZYCCkBdkQWOvhPXeBMOGy2Icw+AcTRoswsFgHkqo3qnFHRnIA00OQPtMUgc+vUsdUCIJBBlhk0QcCckVGDVhqKGYGiQfo1PjlBJkDEwD/diCLyP92HAL/dhhW6N8hA+sGAjPAiUefR6AyI7C9M/zA+GAvCACLfhBHO8cPjUAAHOHHsMhzmAjQh2C2s/xQeKSNB78jPhDyO8A9S/EMg77+PUANCTleCBQPhMgmo20CSA8hhF/HAkgPhbMoUVLH0bIwiA8IgTgQagTWDJDLAAKQqRDAYZaD8FCYoQWVaxIVoJsR+PsCByJAukWRvEWgNpCiMAMcsVWYHEaQ2ARyRiZgtoNBtzDVQpsDUgTyQtZIdIMAFT0mQCucQJA+p5A1UDKw1Q5QWHoBDnIBMtYIAheAAnV/D1BqBxGRv3jsZhCD4AKJEEIGBeEGg8AQWfEChUD/7QEDwItExgjQkgrAQ0BAc/+98S8weO4/eCxQJZAIUEQ/4N9YBH9lGB4Ako6DkG2Qs5Ji2U7wbxMcsFI2UF/yz+h2AM/o0xkSkgCSaARG4gmQ3QKLWAiDZQDsAI1DAolF6ACNRehQagFqDBD/FZhGAdHEEAUFkViEX682VbjtF2G0OFwlcFxEnzMAAJDYxb/YRZ/IVKQLEAPDqggVBQCwONCE0UiEAB8YADaAnRyDbRgQg8MQAf9N/HXP/3VZAIBdG4teYItF+McjRmDJAQDpCR0NgXdeeYE3"
    $sData &= "klkCJUitFCk4fehQUX2ULmBYWreIjxvYWmGWc/BQKBF9YXUXfQkQfWHQZ5BVL4BAMIjzXzcSyWeWWOchUhFSDtAAQamaEAZdNGx1sgfAFJBMEGtRkkDtCVARKpoR+gWC4dd0ixoGiz35EEVBB0Ux19iRZ0BmkyqQdbBohwGQWEc/6P9fdwLeGWc5EaURg33wAlbP0RdFSulZLQqtAa0HRBXWRgQBBHQKuA7FUQE5XSAPhPf6wgxg0oSQHJK+6kUQ7c0M1SkUOfgx/Dn4Cvg5+CL4ORjDWQA5aPyDZmDIoP0AQDApJ2oDZolGKC5YVhSAFSiSUCIxEYMCfSAAiV5geQV0cQ0NIk4HlSX574QQERBYadL/3/9XMBA+gLFegIsRwgyQLEzCLs5B9g7g7RAg3g6gJhEMuIalI1DozTJqDeBLEA+E5g4CPoj8L9Axi8cx6/ZqE4Ib8eh18RoC2IP7/34jCQBXBYs8mIX/7g/w7P4gQFeGDjPV6MSA3uVvPACiEaLsYeUVsSC0kAECD1l4QDeDVWaDOH4AdCWLRwxTixxwsEIRDwAGtRMMsFvrQAspAY1PDOg4GsiJEF4SMrNtMwFXiz3AMRV2EpPoRZDohWCQ6MWQ6MUClhiAAgCV6IWR6MWRaOAFkuhF4h9RLhKFJUgBaiDoXvLWCLATMEy3sIiM/tnZQmmLAP9TxQHeNKAmYAoC7yCAhuWkASzws9qLcOWwAe85Al/6GWAmIThRUTnxNFIM4B4AOV8QJXZ9ZQHE8WUxDGVBAIlFCOsDiV0IgF0j/IsMiIlN+NdOAVI5AFUbsggErgACFP+2BAEUuRtAkiEBFKErQCHeItFoUSPzX8TfmLATcAQhN7h4hNENAODwfwey6Px/V8ABhV45UCuUHGcjEhWl9HEPhZYKA9GDGJ4BQNcX0zBYxg/YOOAHAfR0XIQ/KjQAAKIZQOc0JY4R9UiB5RZ1OI1eKFOlPxiNRfhJjYFbZokDocxjlbf7VEe7ZZdR6y02VRs9C18pAnkV" & _
            "CXIhF9wbVBsA8W+DBtdgUNytpkMSHMcANhLwbyEiSxiSCYBGSKgLhGJnESzr3HDACfcBdhWx/isLB7RwH6BFEeuicICsDPcBRhixXggH4HDqQAwn9hSR7vkgvhBo/Px8HyBREXxUwxHH4msBAYNS+JYZ0JIkgGvgQRCgwITQ0qIGspiPPof2LkgxqWrwqQr2agH+1QP1F4IokXJAIlEXeTcMryTAzwRWIRvRGoIkFQUk5REFTyAQBTTYF3WggJ8GU5QRBBMJmwY7mMeQAHAcwF/AUJfgJBLXUi3i02IIPi2AoJci/iaBC+2aKSNjIpVGSOjQO82ZNFCRjiPRQ4LF9wGbfJiGxqexNZp8sC4HB1V8cB+QCRdVcEAJ9wFVmHCBAwewcB9wCRdVG3AADKcNcGJZlgKvZAApFoEpESMMg/mcAHUQ9kUYAnUQSLh+DlJKIacBRRgBMuvuOipQRWDEoLcRdAoPg/mbQgwAgRijqYhwBR4uaQA5WM4OYJec9yHRcY4fcVDjoMkBx0ZGUgwBkJ7JDAkAdUpBZQg5WchgiQU7UMNVBUZVRWpo6B9T7ZIBk5BvENWg2kF8BOovAAwVQJp1YYt9AByLdwiD/gJ0AQmD/gMPhUgBEQAHi84DyTPSZgCDfMjwCI1O/hAPlcI8sG02yAOAjPBQObww/QBT+MIJEhrgP1CXAGCWg4RAN6AmAJC1aB01IP1PhwKNzgD4xjOBRLAu0DeYn1nn5NUQSEgI7h5AiF6PkT/wAHL4XZUBsRg8AEyZCSAMHyLAjSYBdgEEi1zC6DP/lABQJ7Cov+hEcAUw9U8njI8ODfGYL4ZZ95IE4DACkhXgKRBoi+4BkQCQyRJOBFOVUgGAxh1fscd8l7GSUAXlEV+h8hB1Srng5B0AnTKJAHU6HQJRi2DWndIuBbKONJhvmVN3VBYkMwPWE7HOExcDigMIONGyiIdwlYJGXoZ6YI4i6xKtEjvosM0MgSjOD9Tl/EBqBtKagYBQ3RNha9OeNoKg+wMCDABq" & _
            "aMcGqR3oOBfrGT8d9wMqQLEYPAiABPE/k5yIkKiARJCIRAEMekBiFEbgB5R+PyDxb8dAIxT/dghUk0UPQQTkYjcDzBY/j2CobvFDRgTyGj9pAAAhEFozlOOTCy+wCNCFMJNslrPwgEIYW2kxHEWwU/cAYDaIJwBAN3AEsl6QYZAIEdRIALQEBgB14YXJdCQBR1YjQDhIC41Bki49oCZQEpPo0xKj75TeEjAFpbEDJTGEQJCmpVMCtXHYhLHoJHgDEAiJCBwwAzzzT2CWE0BnAxpODISZBwE7dRa9B4kcQAE80EgUILDoFICQSKAwKEzAAwhHjQQ/jIAAUIchvT5gYgQaFbQYBEGuUmQeROfGw3UkvQY5Rh8wdBVmNtBbBAIOQRF3kETlRyDrTf48XOcBTeQxD9Cl0XPrxt4vAgNgQgdhbhBAGNYGAQkR9K0I2gUh2YNlATRlQYHsQQDuDTEDDAWFRhKgjkXQqNcQUWr//3ZWQEIjwaDsEIVMoS8DNBT/FQhVFsk9Vn0IwjIC0HLRSHfkr4oEKgJ1OjPAV2qKSIEuxx6wojoEejOgpuIYE7gm//82JRFAZzQAvgMwxJSo5wEQx90QxQbrG4IBFw90EovHjQY6LnQTtQZPtSYCKxBHAgEA0Ejz1GgkgAYDNiXfBIEsM9tZQ6iNHAUNExjyIjDo56+k0g9Ql2LoAf4J8QBGUf4NYaqSQ4GxbpgaTqaTGhaNkBNQ/bAoLJHOfGHlMDP20QIMADl1CH4P/zS3gPEpRlk7dQh88epaHdNOwEEUHITBQRyMHDJITFFS4YUgUVHEDhVi1RD/FeiCIoK/OFLF72tRjUX8UQWmUCBLSLSuI2NUAEX8ZiawDhVBJbBtKjvIG8AK99j32OzVbZ0ERQL/UFFR3RxaN4AbSD4FikX/6who0IKukgWQLFg0qMOPWk1gqGNg5pUBrO8AzPoZasQJQagfgYxK2aiQEIgG2V0M2UUMrE8Ax5wFn+AeAQEWEXQqiwbBV4N9DE4TkIPAQlAH"
    $sData &= "oeayrjUFOC4AdQZqLF9miTgJQo0EUaEo2l/WSQToLDCNSAE7Tgh2QUbyUKBG0EgEYAhAlPU/muWWK4DvdAQ5RgAEdg6LDosMgQCJDIdAO0YEcmDywkeUAJDVyAQgQJHok+i5EQ6qR5BIgRD4b0Tg31RRM8AYOEUQPkuhhTTHBmzxZQrKAaDdBM5NkGhEI5cDWFdqHdBolBQOK4Sw2IXAMFiGIOgBGA+2BUUUg2UUKICDAgEYU4lGPIldvgIALFcgelPAn1iF0UhANGU1JHx1Dn0MiQgQjURTQi2AsE42CJCvQFdgVphcF6aVJxCugIB+TO6DMJDyIiFQIS8SEOsEgyFlEAIY0gSBTsQE1AYYgQKNKEKBEnoW4NUqNimhehKLRRj/RRUUjUTaLsGgjwRCDQEDO1X8D4ZzahTgI0I+FACGS9UrYboipiGiuGQW3nkAiku6lQdhuBQlM/oTMUjn5yoAKgOmvgA0jgnyX4EFASc4cCAjBP8VFPi6WOGLQFpLoKQgnitxB7E+pqFlAn4tAosOVAzg15JXTtYr8OfXgsZ+LeLHQrASKcABFxySNvFf16C6gi/rJz0G8L4n4cdiNYJ+LGbjtdWKEHFj1edi7QL9VxmaSPEf7Qqd3qjkAfod4eCJAQAgSVLwXfxLbR3YSf8f2PS/wl3WCP8f4Nbw30D/DIwCADhBf/5BkFhQxf/dhp8Bf4CfAUrElwHUXYSfAb8wA/xoEgM4XQwZDrkNDU4iMQue4KDNEMUtEFeJXjjApQ0CHgCiRoEuFf4u43HRHBIWARXD1e1XvmJxUphqX8u5ofb1AW4NAfF/U4OGEROgknERkiLCLeMAoNZdg6HiFIN+PAB0AxOLB4lGQBEdeTqODQvc/zd1AI0amipVx5TsNSLrxGZY5DUC7EwCg+IBVnUGbiNBJ4ESmN8GUQciF4UTzDYMYR0QQBiGAiBIBfUvwD5W0jyQg8VTl7ADsMwHsYME0bdAYbYzrUhCCnIbkk4vCBpQDIsUiv0AiwBJCAMK" & _
            "iVXYixDRgeJyIQCY2AQdkFegNKjsL4QLwP5Bghv/QAiNQf8AmSvCi/BX0f6SUheyaKx1MXXc3gUj7vH9/2+9BDoXwzZgk6wKJgxgDwALJvhgAKEKtpdgwg/2AH5gsAhQB51YRN5o5A/oKgLEFIl91IlFROCmL+E4kNAvAV4CWCGRV4A0iOwPBPFAGG7eBItN2DkCOXVii3XgJiJxQDNgb4cB5iMRzwb/dGHwrg4kbhQHi0TwBkcAqGIB/IvzweYEjTE8BhoVkHkxUEceTgArejDYSgpQPlEETgeDhNQ0EI0vERUB6ysg6ImBBovIi8YrO0XgXKIeBnZOwC5+MIEAAOumiwkDwI1EGMHwUDUAEkOx2AQftAgIdeyNREieFiCCo0IJD4UXxhfRBK1XAcIWEWBBIYtV8FkBWWoqWQ+3wGYSMHJ1lQVglqjgxUTFAQVN9A0AQJo4QYAISAaOKICPIDoFZoN9AOwAiU3wD4QEgCEj7GaD+RF1NwFqAegz3v//LkpgApAVAkDX4PsB/gRBCtiUsP6gFqEGYAXdF5AGoaiTBE3siAER6WYlpjqRv1Bn4QEd6Pbd8ChxAPDC2+BAkX4v4gkEC/z38AtuvQVQwQ4CdSJqAjLouuwZDvXREQ6Ag6AmsG7CCRJ1OaicIMn5AuGBERBqErWBcGauctElkJgYNpEJQEGAPoX/Al2ZEDdqUROZIAMdAwToK5wvcKTJGQ9qA5lwlTCRcEMMkQAQ6O7cjgBQaBOddtH/wN5llC5mwilwFLZgEJRAAhUPhLatJEMQDiLLDuHg1+EwUAThcNnhAEXs2Ri54VAF8OC4A/Av4OEBL1QF8NcNL93w5lEXB9Z1YEUTlRrrKmrWc4DMWhYCMLEYAqIWYAWRWMeuXiDrB8dFMOwoqgLgXwABAOj+ettmJtGVYCUSQGBlIwJ1Yuw2ItUs9VE3VQkfwmJYCSMAgI5ZCdEFsBgHDw2KKBEGhVCnFAaxVBAAsF5SBQxRBZYEw1HgCxMEwAfqZVLEjNFY" & _
            "xGxNFmohwIOZHkKY0gOi8UC4W8qwGLlRUleRReBRDpBFJVDHoUax/sIWJix1QmwgwEZokEUHV5FM5J0QXSeJUQTrG01qFcGHRlLB7q8iji8Qsh4TApHwUNjXC1AYb1Cr/f9vZQIJoSD3rikQh5MgYAwHBvIo5bcTzQEQiTyZpkqQSJCZvrSYHYBGI46gYxUAqfQfXDxBZi0dAUH2CAJroOZRsn5GBGhA1aBz1fAiTUyBZrfZgcahEB8KAqBuHxDuPZJZcBcugCleAok1NJjhIhURUBWhRRUhuTX3FVzoUAjg5CYEWY0AjIEA6bskygfhYyBF9IASBcGDRUeghrAO9+BmAIYGIVsAD7cEwXJQHioDDfYEkJUrqiI7CsEPhNc+T2DmGgiExGJPERPxULiswiMIiQFN7IP4C3Upsg308XB7IF0AfVHlEr4DJL4CEAjpfnUCg/gRdWgotK+gVhCIsFZQ57GM+AD9Ht1eiEWA+AJ+AOGWjWgKcOCqFACYD5Clkb4lxliKjBsscYcEmggwYDWIP1Dnl3HTHi8ATANhEgiKRezpeVwnORASDkAgiBbuGsCeTrWEJBP+R8EeMkdQp4KwDQe/cFIAM5ygMFJhSwT4FA+F+YiRFEXsmYlBBQ+FxB5VISsA3V3oGfEJFd0MRehRUX0ChiqAjt+eKNEURLYjwQdpQQJkS/VEdhNku0cWVSja+TFkakoWLTIDZCstynwVVRMUdSR4gA6DbC0vAUUEVgzrFNEx8gJtGzRhG4MkmJYYAAA9NPP/3wQ+GNAH/v/w2G/vNwEGRdiJfdC2jdE0kJOBQ2fmrwFeEYIxVaZApqaMEpYaUEdvswV15INSZlGHP4UeVTOgOQQVuCeAwhYwL2wBviQBr5cirEHKlhjwj4SwSGVMOgTmGUHtgCYD9gCLXPD4D7dE8D7wU9E7rQDNC/Jm4G0jWURZjjTAUUfk7BeNRUXgDAANNeWyAV0SNxBf3WDYFcqI0Av4X8ddDBKYE7J+mNMHTacCACAcFaYS"
    $sData &= "MdjH4UEXdIARH3UOD7dGfyBTRM0W4kFRRKvnQTkAfjx0MIvOM9sh6CGNADvHdTHSVcLaCD/wEi8RICoDwhew6AWBgW4n0ALB4AKLAn3cjU20UWUxV4W+OPBfBw7l6gV4OiuBUoYcC0Ds6wVHagwViX3EGm2FYWUX8BptRfFQyOeQKBQ0MLMNkNiFndPF/eCIBOmuBDP2Wi7QSGSQrbwZchhDHw/gDABIqTYWQfFAKGsGADUocos8igpRrDEFBeUHAOoW9mSmwQeEZ5ygEQOZCpJ9AajWBPgQD5TCC8rBIkOgRwZMDgiKCWIgEIDIZIGR/t8SP2FqFwAdmhpBZOB3BBJPUAnsSwkKb2CWSOSAkc5S4IIoAhqEgShmixEA6+FEIEHnTgHx8QpcpP0myDlAV04BeAxKVdDYkg4ACUUYiQdN4A+3CfVR6VFMwBiv4FE3FgEgViBEDoBUsQiEMDWl9r8BNTWl5gE6kKNl4AAeH2hiNy2AIMyJ/QfGCQFuMjXlPAZ10LKH5VgE0ONVEfIl0xYyiP+hogedoMcOZQIc6Q0s6h8iGQWRA02JkQOLQOUKYRIcYVJiFM1ykEewno0GFejNIt0OgJTtWhPZXAaqUWMFaNaNFt1o6JErjwRFUQFlw7CSPpYVUMoIH4xf8E/HCMuMY4agpxhJtetoXKAoAUXBfjdAAiV1F2oDtUiRFWDp+PhjUkdgtQHQhRaOEXAioxVVGGoJn8YKwGSRQxCAIlIJ2TK1EJkqOlDErwwZuqBTRM5iPOnGYQJwkAlQ7oCEbyqNEVw1EAhZURZFMACSbfYJmtFt9hrrOL4YwdEdCBMH8m/zCKRUMXIhPACMTQz/NIipfIYd8V8EhK3uEMYQO0XcD3yMJQ9mKOAqAGI6ENJxX6TEUc1BZ5J8UZF8EGCxWMTLApkakdGjAAXBkA6qwRJNCOlcw8UPFgFA7VGH1YfTKUMNHJkizJliHJmCs9C3mSIcDhNQKcFcKWGbQRUAYFaZAKpCU4eQte6CmAfxUaeR" & _
            "nxXwXzfEGykXhLDeICwg7RHmYnxiLyAxFf91DgHg3CdFE/CNfn5jUAdi2Qc+ceR10DHkpAoVtGM28AVOMrDFKlUDJCAAZDoD4iJQ/yxoJDQHi8jpzZ5fMPMCPOw/Bt9U6L0VVCAkA6BgYAxGCIvIXelm22Rit3roHiID0A6A/iTYjZCVZXpEEkPSU1AV8e8TJpKi5JQwul5C+gJCYEFqXDhsMRZcpIaEbtMTJKoCrz0QyBURZfYj4XgDVUCUcAVBSReUQUEZKRCskffpExSs4to2ujgw7qz+dve6OKH+NoZv42c0FCTgZEQkYCxqFHkBVuhQYhYgflpWiIUFEDP2soHxX4FB2F2Bv+NfJ74K6z+gPQGAiRA5dQx1Egk7xnQkingQYBUL4NodQkEEEjygwQg9ElbphSGuNRAKQOGtAIvGllm2McjOoOUTwqzBIGAExQHneRDCUxInUQEBJQEOsQWA/kayDj5YRg+wOIBg1VhFLxV1osUBvmDAIFMEWlTAKOoAASL3Q966UwA9UkSfe6AFNY+x0DLA6zYCgAuREshgBpEBQU+F9p4+YO9TgRB9CK3SdFAHE9gHwfDuCwInVmr1GP8VJLofkSbQWIQgAKUmgoZAJWkiIN9UgAEcZmOj9FouXuPkepUw7DxHQv0cDBARJoAGMCl1ExUobg6BLiDgKvEMAQgIdAVqCliutEAwY59TA63dB3YejLUTNLVILGCndBFGSDt0IieuKyFeXcMEZosEdQBEsD4P6AdEiwaNTQhRaE5Q7mBg9a8aEn5zEBaxKAD/HwWy/oFHQLp4NoEngpEAGBRqJ4IA3QVQYgJjWhg5XQx1GhBXvjJi4VALpQDwdbNeIUcROSb0AhGkYxb1ANPCFNE5QBBT8kAoTBhIxIVv5kHHSEAY8pNC8CDk6KAYagRoiPojoFZH0IcQOKlRGZcJIAhCE9GZaFO3kWwhxzsxWAi6TQDeTuJBBJpRwADQWIVv24LAbxMZXIERcdhZtgMxXwddiNJYBS/F0FgF" & _
            "LuVMBnkAvIsBdfA5XRB1XuESkjZtsN6atlC2LGs0n2pTkk/QtFSZFMDvlDl1ol69ANAS0FhE740hajkBU9kSjQwhM4VkjguAaC4A6DYzmRP0Wetinf0eUTAPhEZwMCUuWADhDWlM6T002mEySOjCAlZXM9twUIFw3wIQFmBUNz1F1D0VumjgeBG13YSson8RSfgbSUMZSW8w7hIYAgAQEGCFTpgY4IYBuO6j0S9tAWUL2i2ATqYc8P9vtYiPzsUBJGpEfpaALkUCi/ApahAOLWHEAoPEGjOA63sJ5GEHQltg9xH/FUyQjgBRgyS9MkNo/3/SYmQSI0CEBGigPQFXMv/WvEABaNQ0s+6A0lhE3QCgCgxxSIRHG3J+kq6Io6ElHgli5RIiaNjEs1iHHuvAfl9AAACGAoAHQHigIASOCgOoYlZZWTldCHR+wiYgINYHBbi4C1EDCgQz0ln38aKPkNgFhCHAADvDdky/A8H1A8kY/zb/FTyOHuHQh1BnkzejahCBY3UsIWqCQ4Dj6iBCa4Cxk1DEIXcMGwlT6CFEAxY2iz0wHHE98W9HYMcJXfChATEhiOJOlJWOWCWA04VBU9fgRhBaBQCPC+sJoSjCYlgw+w+E/prFsINGnysi4ibxAAwoYLwVEOkVNrkBTfRRaEEwSRdNxFH/0LEEFeEz9lUQQn4DIpAD0kWWUfMSihBBYMsJaEAjUKAm4LWeQWVsoNUQ8KYEYD9o7j9IZexkAfSNG/iNC9RSYFNmBWESAHU783Rjik0sjVUY5QtRZrpQB5Dk5ERX4ETHUbJOIwMWcBR+FaBhOwxjURwgHAL/FXCmD0L2An90xhgkhQttHdJUUNsWDwASF+knN34kMK9LBWgufQD4YSx5Bo4qUC3hjwX460KViQytx909LHUc+OVdVhxkMElGEuEs9gyCr2mlMNhX6l5gpSDDbp+CAQKw5sQLS0VSTkUATDMyLmRsbAAAbHN0cmNweVeAIMJW5nYFcFQGQAcl9zYWREYGIFc2Nwdw"
    $sData &= "lUYGUDaEFiZH9dYEUMdGlyaUR1cGAGAkV1bGlCZGIBcmlwdAZVRvgqgFwPQWRsZHRQB4VwBGbHVzaABGaWxlQnVmZiFlck0Acml0ZUABGAsxRUeGFOZGBggDQ29tcGFyZQFTdHJpbmdXFZABVwBDbG9zZZwEQFUm15bmFkYHVtYZ0RgxxVZWBgfYAlGEl0Y39EbGCGZDcmWYlybS9AZBVsfWDuIU1lammC0zFkbHJkJRAHIIeVR5cFyAVBYGBpcpASJBbGxvY+JhUyUATAEAQFmt8EbCVhZCNPTWGwiQJJBEZCT31pYiA4AxxDTFM/xwlkQEyApJbml0aWFsI2l61RJVbmk4yFqg7PWWEVHlVjdXJlgHlFY2V4RXEyEFUudGDmdPYmplB2N0VGFiCRTBInkSAU1vbmlrZXL8EEAVNrfWVNZWIwIy9EY4SW5zdGECbmNlAABERgHwRMBUFFRFFSIUUAAQEHALEDAKEACgGxCgCxCwGwAQIAkQQAUQgAAAEJAAECAAEACgBBCQARAwAQAQ8AAQoAEQEAEAEIABEHABEADAABBwABDQBwAU4CULCgABMwABABIBAUcAAT0AIAGI+BAQYAMQAFMRIAYIunwyhcR0pREEldQM0ipA1TRAh2JD03sBoIgQi3gEAAv/UHQ1i1AIAIswA/Ar8oveAYtIECvLdCNCXQAwID/gvwK8Ig2wAM0aLH4AjQ4gZ78AvSBNhwAwoJ2ysHMvRx6A3rcDAIBV4E8NQADwEQBkEADEAIA1AKAAXPfWAugbCgCAOE11ZYsAeDwD+CvAZosARxQD+IPHP+hgvNRQtwWAfsYDEACwAEzng56NBQFWaXJ0dWFsAQZodLEEnm3QRjcgUFSBDlGAd7WI/Q+NAwAQsGCIB4hHKAhYUFRQVPA/jQWx6N/qzAV0PQP4QFZFIIvYrArAsIiCQfBfZ08CdOE8ASB2BE5W6wkhAQytTsYGwibQBrIqAwbMCIRQZ79+jS7URARfgcfu8gMAi5CuiuvhZQCr" & _
            "YelR+l4k4GIiGiVRRtUDMCVVFADw/7QDxhEAEEG1DPArAQBBxABUcQxAyQC3DPAFAPAFQAZQBmAGEBAGUAfABkDHA0Rf+gHwBeBEBXcAFkUAblzQJiQgZCG2ACAHkEYMZ3RAOqhcA8cPcgzQBjA3yqVlVCAH8MYAXVBeXyxQRgm1kA1QpAG3AzDWAeBCAWzq1gbSDGc1xEhBzHBGIfUQeZBs8jLRKwPtAQABNccChgwA+AEAUVNQoa0LBQJqHQBj7QCuADFUExJGA/YNAABBiG0CZABNNEAHgNZaE0DGZFB1QUUSdKUgq1xDVCNCRwV1VSCtEtVsVT8nRQltbGDHAbt1EG0dASUQAOGne0At9QYEViEAEEUM0EqS2lzjxQJmDKAk0l/TB1cPUjYFcFUxAHNHo2sA9QA8O1YOMlYNIMUASib9M9ouvXD+LPCF8AIAMUYOaQA6xczEciAAL80Cdf0iVkkUMNMugFcEwhRlOQBTJFB+0RoBAuBVB+0AQBHcMcUE9Rd0JCDeNNE4URZBxMbmVQFDDGxhc3NWFcMETG8AbC4gWW91IGYAb3VuZCB0aGUAIGVhc3Rlci0DZWdnLiANCtNQELDdaNubkdYr0JhBRwVOh9F2V5wIEGREUF5B1kNWbW4DNQNvBQZnTJpGBNtlFUQFQAktsGyFqjyxXgHdFFEBi9YP4FaLwhJfYSzC1pTEWM2VPZYkZYXWDUzWDVBHDR1QZuclIQ0THXI2AEIw0BNGM192NSJpFSGswTYdcgDhz18A0TnXQdkYQVKMMVffw1JpARA0KUYCb+Uo1SzX1OHGI3ltbW6VILcsA6D0DwABTDOqFcZT7PK8ARA8pQBEPAU4AlD9d+C0AeHaYoAAsOJy7MwSAP/viBAhArBAAAIAEgQwAUogAwTAAEABUDFqMAQFPOAB8OGfBWxnTBA0MwGQQAAAQaDpMgX4Ve5jwADcDACtygDADEDLAKgMwKnKAJAMQMgAfAzApsoAYAwAxQBEDECjygAkDMDBABAM" & _
            "QKDKAPwuZ8DOAOAMAK3KALwMwMoAnAyAqMoAdAwAxgBQDMCDywAsDGAwMgD/n+ERROEAAOIwYMFD6CEDAEQE4sEwIIcFYASpREIiAq0DMKBmNgA6gMMBAOUhoQTqgTQAYEknJAam4qwFwCElo2LNg0JCgAKnoQdPI14yAAUuDMRODAPoAXAcQBRmRDoAIAA0oG4HBEQS+AAFgpCqxAMCRgADFAMSavwgJgDiA6hELEhWWABYVlgDoDpSAwBUbjoeA3x6fIAI4AgniodfIArAQyGnomgLKAzgrGQhqYfFgwSAxOMiJONgrgugxIPkocTjggVAJCPPAcRhZATghKTDIc8x4AfAUcDly8LBwQMgNmAnKzYAggTAyIjhSwXEgw9gpUIhYUNxYAIgrAIL6eHgIAmgg0FCguJD5gLAYuIBAoJCMiAgYKGCyaHCAsQADCYKHCQ2CjQAkkQyEF4WHg4AFhxAIiy0NCUliggAMgDLQXAc84lDM4gcA/AJTnD/79gAABCLRQyJNJiLRfiDJJgAi3XQQzP//03gg33g/w+P/fb//4tF2Il90MdF4AQAAAA5OHRmi8joiRUAAIsYU2oI62r/dQyLdQj/dfSLzv915P91/P91+FPoURgAAP9OCLgngAKA6fMvAAC+J4ACgP91DItNCP919P915P91/P91+FMAAAAAeGXOTQAAAAB4kAAAAQAAABQAAAAUAAAAKJAAAImQAAApkgAAkEAAAGZAAACoQAAAiEMAAAxFAAAwQAAAGkAAAARAAABbQQAAwEAAAOZAAACnQgAAt0IAAE1AAABnQgAAvkEAAH5AAADHQgAALUIAABJBAABBdXRvSXRPYmplY3QuZGxsANmQAADhkAAA65AAAPeQAAAQkQAAK5EAAD2RAABQkQAAaJEAAHyRAACQkQAAppEAALWRAADFkQAA0JEAAOCRAADvkQAA/JEAAAeSAAAYkgAAQWRkRW51bQBBZGRNZXRob2QAQWRkUHJvcGVydHkAQXV0b0l0T2Jq"
    $sData &= "ZWN0Q3JlYXRlT2JqZWN0AEF1dG9JdE9iamVjdENyZWF0ZU9iamVjdEV4AENsb25lQXV0b0l0T2JqZWN0AENyZWF0ZUF1dG9JdE9iamVjdABDcmVhdGVBdXRvSXRPYmplY3RDbGFzcwBDcmVhdGVEbGxDYWxsT2JqZWN0AENyZWF0ZVdyYXBwZXJPYmplY3QAQ3JlYXRlV3JhcHBlck9iamVjdEV4AElVbmtub3duQWRkUmVmAElVbmtub3duUmVsZWFzZQBJbml0aWFsaXplAE1lbW9yeUNhbGxFbnRyeQBSZWdpc3Rlck9iamVjdABSZW1vdmVNZW1iZXIAUmV0dXJuVGhpcwBVblJlZ2lzdGVyT2JqZWN0AFdyYXBwZXJBZGRNZXRob2QAAAABAAIAAwAEAAUABgAHAAgACQAKAAsADAANAA4ADwAQABEAEgATAAAAALiSAAAAAAAAAAAAAAyTAAC4kgAAxJIAAAAAAAAAAAAAGZMAAMSSAADMkgAAAAAAAAAAAAAykwAAzJIAANSSAAAAAAAAAAAAAD+TAADUkgAAAAAAAAAAAAAAAAAAAAAAAAAAAADokgAA+5IAAAAAAAAjkwAAAAAAAAUBAIAAAAAAS5MAAAAAAAAAAAAAAAAAAAAAAAAAAEdldE1vZHVsZUhhbmRsZUEAAABHZXRQcm9jQWRkcmVzcwBLRVJORUwzMi5ETEwAb2xlMzIuZGxsAAAAQ29Jbml0aWFsaXplAE9MRUFVVDMyLmRsbABTSExXQVBJLmRsbAAAAFN0clRvSW50NjRFeFcAYOgAAAAAWAWfAgAAizAD8CvAi/5mrcHgDIvIUK0ryAPxi8hXUUmKRDkGiAQxdfaL1ovP6FwAAABeWivAiQQytBAr0CvJO8pzJovZrEEk/jzodfJDg8EErQvAeAY7wnPl6wYDw3jfA8Irw4lG/OvW6AAAAABfgceM////sOmquJsCAACr6AAAAABYBRwCAADpDAIAAFWL7IPsFIoCVjP2Rjl1CIlN" & _
            "8IgBiXX4xkX/AA+G4wEAAFNXgH3/AIoMMnQMikQyAcDpBMDgBArIRoNl9ACITf4PtkX/i30IK/g79w+DoAEAAITJD4kXAQAAgH3/AIscMnQDwesEgeP//w8ARoF9+IEIAACL+3Mg0e/2wwF0FIHn/wcAAAPwgceBAAAAgHX/AetLg+d/60WD4wPB7wKD6wB0N0t0J0t0FUt1MoHn//8DAI10MAGBx0FEAADrz4Hn/z8AAIHHQQQAAEbrEYHn/wMAAAPwg8dB67OD5z9HgH3/AHQJD7ccMsHrBOsMM9tmixwygeP/DwAAD7ZF/4B1/wED8IvDg+APg/gPdAWNWAPrOEaB+/8PAAB0CMHrBIPDEusngH3/AHQNiwQywegEJf//AADrBA+3BDJGjZgRAQAARoH7EAEBAHRfi0X4K8eF23RCi33wA8eJXeyLXfiKCP9F+ED/TeyIDB9174pN/uskgH3/AA+2HDJ0DQ+2RDIBwesEweAEC9iLffiLRfD/RfiIHDhG/0X00OGDffQIiE3+D4ya/v//60kzwDhF/3QTikQy/MZF/wAl/AAAAMHgBUbrDGaLRDL7JcAPAADR4IPhfwPIjUQJCIXAdBaLDDKLXfiLffCDRfgEg8YESIkMH3XqD7ZF/4tNCCvIO/EPgiH+//9fW4tF+F7JwgQA6T+1//8Aev//YQEAAAAQAAAAgAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" & _
            "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAQAAAAGAAAgAAAAAAAAAAAAAAAAAAAAQABAAAAMAAAgAAAAAAAAAAAAAAAAAAAAQAJBAAASAAAAFigAAAYAwAAAAAAAAAAAAAYAzQAAABWAFMAXwBWAEUAUgBTAEkATwBOAF8ASQBOAEYATwAAAAAAvQTv/gAAAQACAAEAAAAIAAIAAQAAAAgAAAAAAAAAAAAEAAAAAgAAAAAAAAAAAAAAAAAAAHYCAAABAFMAdAByAGkAbgBnAEYAaQBsAGUASQBuAGYAbwAAAFICAAABADAANAAwADkAMAA0AEIAMAAAADAACAABAEYAaQBsAGUAVgBlAHIAcwBpAG8AbgAAAAAAMQAuADIALgA4AC4AMAAAADQACAABAFAAcgBvAGQAdQBjAHQAVgBlAHIAcwBpAG8AbgAAADEALgAyAC4AOAAuADAAAAB6ACkAAQBGAGkAbABlAEQAZQBzAGMAcgBpAHAAdABpAG8AbgAAAAAAUAByAG8AdgBpAGQAZQBzACAAbwBiAGoAZQBjAHQAIABmAHUAbgBjAHQAaQBvAG4AYQBsAGkAdAB5ACAAZgBvAHIAIABBAHUAdABvAEkAdAAAAAAAOgANAAEAUAByAG8AZAB1AGMAdABOAGEAbQBlAAAAAABBAHUAdABvAEkAdABPAGIA"
    $sData &= "agBlAGMAdAAAAAAAWAAaAAEATABlAGcAYQBsAEMAbwBwAHkAcgBpAGcAaAB0AAAAKABDACkAIABUAGgAZQAgAEEAdQB0AG8ASQB0AE8AYgBqAGUAYwB0AC0AVABlAGEAbQAAAEoAEQABAE8AcgBpAGcAaQBuAGEAbABGAGkAbABlAG4AYQBtAGUAAABBAHUAdABvAEkAdABPAGIAagBlAGMAdAAuAGQAbABsAAAAAAB6ACMAAQBUAGgAZQAgAEEAdQB0AG8ASQB0AE8AYgBqAGUAYwB0AC0AVABlAGEAbQAAAAAAbQBvAG4AbwBjAGUAcgBlAHMALAAgAHQAcgBhAG4AYwBlAHgAeAAsACAASwBpAHAALAAgAFAAcgBvAGcAQQBuAGQAeQAAAAAARAAAAAEAVgBhAHIARgBpAGwAZQBJAG4AZgBvAAAAAAAkAAQAAABUAHIAYQBuAHMAbABhAHQAaQBvAG4AAAAAAAkEsAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
    Return __Au3Obj_Mem_Base64Decode($sData)
EndFunc   ;==>__Au3Obj_Mem_BinDll

Func __Au3Obj_Mem_BinDll_X64()
    Local $sData = "TVpAAAEAAAACAAAA//8AALgAAAAAAAAACgAAAAAAAAAOH7oOALQJzSG4AUzNIVdpbjY0IC5ETEwuDQokQAAAAFBFAABkhgMAkWXOTQAAAAAAAAAA8AAiIgsCCgAASgAAACAAAAAAAACLwwAAABAAAAAAAIABAAAAABAAAAACAAAFAAIAAAAAAAUAAgAAAAAAAOAAAAACAAAAAAAAAgAAAQAAEAAAAAAAACAAAAAAAAAAABAAAAAAAAAQAAAAAAAAAAAAABAAAAAAwAAAWAIAAFjCAAA4AQAAANAAAHADAAAAkAAAuAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC8wgAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC5NUFJFU1MxALAAAAAQAAAAKgAAAAIAAAAAAAAAAAAAAAAAAOAAAOAuTVBSRVNTMpUOAAAAwAAAABAAAAAsAAAAAAAAAAAAAAAAAADgAADgLnJzcmMAAABwAwAAANAAAAAEAAAAPAAAAAAAAAAAAAAAAAAAQAAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAdjIuMTcLALkpAAAAAQAgFf9LwNUagdOS+vXucGtQtg9DS6IQmf+s8pSAof/lzpNbvs5vGDaqkwL0lyayt6KDCqSJQ4o1tatkkGwANofdA4t1w8Ib1+wlEQkEKJCbSipLHHBKr6/Y6mEy+GC/8kjnyRwAZHJdcZTrXuvNMrnCg3BRI2lK4m0YSV+mgIIsJS4+ON3sS8ev6rNoPHGTAT/zhqn2XNSdvG27Ud3miHX3jEeposu9O7XAa3qNTrWtRpeHrq/IlNPagqV3SgL8djtDQ8go7wfRA/TviPI08dlbDCCxpmRXrQ6lWTEIXF8FjDB5sAzzRvVyMdC/f5f2X5Kjua11c4Pu" & _
            "tme6yRPrz56iIfEQsdwIdGWWh9Q6P+u8DVkszTmHrfDf+SAcoMG24j+IrWPA9CFTh7io92CJ4Qz2NYrDG/PSau2fO1brNo6tGDczkSazOKoiBBPLXpoBDANzoA/Rc7CjPZFQiRIJBuYbQ23s9cOqgpS9NUzX5uEZJ0XQ5FCgWolKFX6PpCjzLSdKVsHhUk6tbEspisogzVv1ZZBplsnLG0VwDMiIOmozpFj+XHMjwMWOGO6/cnmxVyb/JzY4H0qiGgN0lVI9Ln6Ad42s/wPHeWADRBWb3ztMm6IF8Xi8IPsK7hMWXejlgs22H/uFr5riwoJ0qiA07x19tUPt0Lbh+Stde9NfqaK1OF1iu44qpvxOE0z7WVVCUBApYEGDtMDvSMa8WqTW+rO+UFTzpTap4NDSteMuC/1cHW79WRbykRAKJCkuEiXcshkz5Z/5zWV1kO04F7tyHLdDzpYgBYiIQBM3ewE+FS6cgTXoC/WD2rkhy3wWrLEqKJEJqVfc5leKo5rsZDrsgOQotjOLl1ERDdMlIH/alMzaMfJhJpEjSkws4xOG+Odc1LYJG3FC5S7Dy5KvvK2e0kE+07hXD/5yGOoZPtUzxAntkQa9gwA/juNOB3Y9q2GrQ/UmHI6QR8sUsgdqBuRhxiLl5Uctt3IWTYuTI/5Kpbz3mRrcDEmLTpJmIrWZQJC4FMjsQplBNwKGHbx8BTRcq8ARreprLlGUnBcjjG6/5020/OpPiUdW2Hbec4khnWjE4/c72xOTRZHhA/R9wGo88420ANe1D7k820S2V9W9xjS+Uhcp8tBvatKmh7rEoiqAMPX7wvhsLYSn1ea3I9cB9iQvg3isLdLgAaixWNkhkREaSEd1xugMGKSvoX4nrvbhw9zpE8kOOWL47aT1+JxkfZCQCFwYz9ZMaCjczjVJnZhRvfOYoQabF+2+9MGc+O/AFZw+JA/tXHcGCKaeLpZrAKc0hbrAoNLQC4cgqmsoyizXJavMwGJ4SjKOfrWFLHliGF/yOxg6uVtb" & _
            "dsMJV8dDzkI1sDf9j5VHP6aVTzilxLB8p6FnHTbBZ/EqbksvqQP3tOQxlBnvVey8NjusiZ8csMFmTUkXx1RlMQvUkETQdu9TofUxvEA8vUjlTqg9aLUobnjnR3FZUYIjm70VOTfPnw1x88aDsD8nS/HGC33yeaavHocurPq97/n7YzDQVHmCN42fTo4o1cHC28E6WSQQlGkjPuHAs767iNkRUdxczTIgPDSOMah0pC2ITTyN0i3FAoOF8HW7qSqy1VDiB39zKrBpQC8qzBS/DJ8HhUDQDru9AY2jZ7cpUQyKt0UasDWo88YHoWDLuXW3i3ZM3/7j0v4jiBWpuhfB/XyB7/uZFBT8P53TjDpERhUa9tNCE2Wnqp37jENzZRdMK1TwOM+1nmkojETbmstKoiQXcyy9G82RlP6IHvaXOCcssZ3RjR7M6/hJYuPUCPnq6FuVkz0AmfEoGAw1mw8qJDf10u3W7YOKq8OM1FaFzMd0HbBzWKbLAdiaJ6ZkGCbG6m7xFZm589mehAkBMqDpduzsmRXlMA0Pm0gdatTFxwovEkazk41mioDEDgYWx7Rs76jkCLbJJ7pYUHfPPZPJdKjxPFLlvFWpDdYcoevH6RQKMVXnb5vbed0qkG0nfUBfNCNcRAtyGaNa9H8k9ug9Z6RIrkA16uNZob6fqywPiUA1S/n+XP7WG2IkhVVL6qCqKLqEOWVVyxIIhMauRc33FYxe2Kw6q8Ui5CJlNO7qtO6jqbbRtgarps0697leu66OAtptpvpoAjCzw+X5EFzDMZDTPtrgkJ38XMVgH1fAbiUmJLJ3GOWjnGWZvyP1LossfSE2zxuiAsofEHhNfiAAIbGlZwegvVvcETXVtdMUzz6fToonlbjACjFUhdiDTcPHhhcFYg8fdjslyu1pViYLZ7WWWETbjqPz4h30Lztd8QPK2/0jmuXrK+CromtqHP6GNozy9IY2lkO6IUeTwg7pf8YoHg9fJ+SzxaM2bjXvIjZbKy2r3l9e2ax1HsfRD2Nj"
    $sData &= "iuWXhqFdGvKZW7BpLwJQOU9eIlfX56Ghh2R2H3WLu34uZq6VDWtVqfdnEoP48KHZbFoTJfv6CogHv+T6+yjUVDPi19lz+WYvfNDwyUfLVG5xqI8m7H24Jq56qKvC4TxR6vyR7MPtm7D+EMj94YLw8c82/OegW99gb/SaZ40BMiz701xPETLox5g5fFuMOb5ENahIAux5GoPZxUfZOydE5KL55/JHnU3dtBsh5Hbf0hFSacseJLveBtDBw9bHhGgo/2p/bOXM3RqOtIuTXhGh2YPNeJThPAvKbyNC0wP9FCB9w2kEJ1xzAMYu1DUrMi7sk8vPfnz93sanlaIBrm8bKmEU7D+ZHanTGGxH/gPoqmfI6IoC//ucKSkgqhL+6uwciF117gcFXp2Kt3hPuu6azBQ5daec0OIgVLg3zvQN6E5/5yqcNrSUv8vqOsdgBZl/5vyMqGPFJuCxhFNgEKxWeoZEkYi6J2UmdSHXcUjzLWetoHqO3tXXw6v3q394s49nXWF53LXgTpR0V7XQtP6tBv7Ic3/wK1pZv/EkpSScYwTARsAyAzzk8LIXhX096nDFSmhPk/2hq9x0l5gBBlOuwZnq6FyK1c01/tS7VwGKb7FloLCvFjdPGCeBCJgoQMgBBV86QJ1C0PVphhXh+fHucP6CdhOY7f2LJTft56YuJOh4Asf2Y/9+T5p60NRjgOpicABpXjkVQEaGlEvR8aPpzPwQOM+rfb3ZWbQ5KVdbRk1KpweaNa7ho61iIi9ZlYXPZG2qU7j06ox+jSFX1KmoJWZGRJmGekpaJV7uJ2NTHZ2G/i+eCn8cgCN7ubTdZgVSnWB/VsF3sstkuAr+c6rsu3b3o/XcVzth2yEuOc7Sjb//199qlF3stiYCX+ohpJP0of0URSnURIIyatVbYswUgIk51q2k40n5HVELsTJaSeUKHKJzM82th+G5TL/82fbcd5hxaem0ZWa8Yqip0EDI6i0ZvnmKAeHaTE3QwXIud4nBRIZnODLBEHAsINHX4jHK" & _
            "CP3aP3W72KzU43hmGo22VRJw2tIgpz0X4gjiReLLrsDRYllJoYammBKJIdALzgM/sooBtTIWpY9vVz1PmFeCA5gdQsv37csDjqTtTfK+sT0pIUFAKUPPmTqKLhF10xqSHbC2G483tqrsbFVDp9A5+9y1Y0Rb/8oCwltn4GZjHOdT56ibGv8ff2/Uu4A3NMQYbW0Oi3WliWR0UGy48bCeL0bpTz+hjOCnm9u2qVJ8l0Y7zolYy1LL8C1XBJ3xZBbs7iAq73hyZ8w2cGolXoh7Co7FiQr2xpfBNWCeClzjKjtJXVBYT1pKW2fHskvrRJyhyeFhppPKuYLNNHJjZDpUu1q8fa0EcjW5YuY65WDhHqhbWQ+TQNpJ9shHUPjEZjaqW4mzoqFXNOZMRNm3ThAsy4wEO0gWTCo1ttzciNKcd5/6+mSOtHYi3juoFC2MxMNY7yq324VO8/oFDS/K5IxtVCBwlncGAvtO2ajudZBCmR3hWhjQgn22jlXs+Cw2ONj2BbFSv1dLp+0+JpPM4snhKqKhjnp5ePwvildU5LcpueJlyPsGfzPTeasgxM7HQwUaXusnKPK3zPVoj/S3/LB59MT67bHEJvcPzsKVEFBIrKjiF2ebCcKj/SOCby/TBoYiZJPilEDraFyQ6QdGCDOyD3TzMeaanb/rkUzim3J6wdvDHEsWh9qvklhmN8yWsxO+ZDzq5cAyrs2COuOaepnS/VAFNuzV0cv50FcBP2vWN9e0ONWk9RlwARoT7P1neMmCV40QVamx1I4XV+lkX39MbNCNOJNdaPFRE8hElBDy6wtg6vYQPELcc4fcpb5Mv1w6u10zZcpKmkK5sn118h+y01cMdZG/LFxwozBlIgUFmNC6dEJRWlH3DgDn96ssBC1xQB6eg/AIuGEX5kFl9Ho3OxJB48sS68S9K4BW9PjLKznPE2rbNAPPWLDegStEz5xVVlG/A1RrBmciblsgRRbQsM/t/sI/C0OdI+Vdkheut0c3WDup/zb8o/YsJxH/RkPV" & _
            "uVBP0AEu203IqOJi3o9pIMHL9lo3itnCz6FLQBCiANBr1x36E5EuQD4SERi0ZugBrRALjAdBb4lnRZl2t6ZzS/B4VFDcy5PxEzGMo4OOhZTXQyXMKWtJFXHdV9UTf2JEgIATNDR0h67qyj4bt+wlVXxUaTGREBisPH2PIJUjDX+qB/eYStWfs5qRcD8lAXMy2HilUG+BTvf/gPeeH5afjL6RaJx0RqjcYk3ofmK6iba4tbr1ptFtel7eYXrBtwJhg3vIsh4gnJuLQaFHzJR4uUnLBxuLJSUsfMBZMWf6Zb1rRR/aczw+wAn/tcnqmHUeT4mqZ8KdP63buBQ7eWJlpUBz2mvDmudEz5Y3vVjSlji7Fh46Nnj7rIBxDCwC5U14ThFm3frOQL9BOSWhWHG1fl70DNmCUhjXCYk2xiqa6GPlIo9S+eQ0gnjZY7L3ZakNTN0iJ7YezCnkSK+2XuJ6WgeCL4nT9K3HdZtGxlint+qcAY33DX8KI9pzDbsKMPUbCorBrXVJi93z3wJIEwsnl/geCSz05MYUXuUP4mCfT1xR6vGhx3BLzpI4uK4Ui0MJ60J7EnD4qtPvS/DuGnM7NqK8VGUfKSLoV4sSQNx1Udl0lTDZv0PhF5AW3MpJI17oC1vCSmHNUjRhmx3D1uzUcfwrveE1nxt0DrtxnkuRh2UEh7n2Ia0DT2wa0R0eY6vLcQ/8vCYn6NGDr2SrxuDkpPyI+cB14eceI/bHj5eleSXhcySuVHiIemL10orIHf6/qn4gUoG78c4532JMw1peBBc17kqDvWBIIVHUn3MFdHKSzUHI2CoJRB/P7hi3kR/GiOFhXtH/VlsuAaUiqL/6lbj8I3ftvQfH46l4Dte1knjVDGUZDWpBo7ABsP48tVJxcqcva4GG/2z8u2YMVbF+xT5YuchvlFmX120riXhTUIQjHNgy3KzB29x76VNFG5CjbtzBLJKHoo1j2pMkw7vKZLXEi3NUz8iueVogn7gzMVtE4oil1KoM+7E6AmW5QZBQ"
    $sData &= "DXSjYaAjTZNlmY1xUQfLwJ+GnOkQdg7bDwoI5jqd/D+N62UAXyT9CLrgmmoNW5900kqlMcAdIZFaoCYVc63mRM2rzEax8HNNJY0ScHh442ddRph4SofhpGg0uSIJ/NcdQsjFA1lVX6Gnarw1GK8hxrYZMwUrcYg61sn6/73rDxH1+VWC6e+fnBnVFkgssbOD/BP5C60FOiZpnkutcatp8raQ3j1UTGS2Er3BEw8l3azBeJnt5jVnWxFcqych4f9/J8PNlSmd09gUlXgT/IkiXUbn1V9vEwFa1m3Ilos6hhlhzq2CGjhEd2S1CLvgnUymIgDOdO/XZuhZ+GQhBrfGbVO2Dk66zTLBzcn/apChYWYS5D/YQ/izRMWiziTuiMiK9W/UEIyCNXoo8zZ1RruGBBjrRdd2LH/NpuBD+Ky92lQTV2osyzAHCD8+Mr7USGWKc0nnyRK2nbwqcnxsZ6fCfKyrIxnj/FwBuLH5el/F/ko/tn5RSpU1oHZdJItdrIIQfk9JDsNoRde0UpJKebIhF6POA7lwy4zu2QxuhMgAkTWPTvZCKEm2Z5oRcEBclJAlc5eCv0Od0QhkiGWCWCfiEj33IV/25Lcgr/u0czEkCAUc0f+cY5esSida6IfoICvWKEJto+A2fisL5jUd/Fuv3mVA1+VZGvOKzRHEnN2Ol1Yv6V+R/eL7jeGEdHQ8mVAvbTMfHLhNLieODJ8M4bDYypMwm0Pk3JPWSmpLcFmp1yyT8ri0VNtJXxstolo4hBbWNYZ1E0aB12V0DTG1YsH6ohr7jjrbV2JKcRZZfJRCNYjx5foCfcsBs6ASyxnPZ6ucpH9ZwVc4iEgOGZOldiJI3ghZhQgUE5u04TGyjXvlEuw1Pk8PH6dRPS5ZGxcibKQ1HL78rau2INE6j2tIxQvbPKVovnvc7nLzTsFTCew4PUVJMOrr8CN8iXp/Yo+LmDp7aQpIGNQORlnqshVrRAxjiIqx27UOtOkOKlIjlTvTf8szIO1GW+/X5JkoazY857Pg" & _
            "LlYjMFCj/n2CN6APnxDRuT00SyB4FKjzko42t3KqoUkvFcYA5Ik2bSEQEu5Hk07U97mXDGijlqGkogi758uc9Cv15RPtsCSOvkKn8D/9WeO+m7qLkV7Jc5SLLtrgL6/AbwCDgeO5pn+2PFQsn92hANQgx3Yg+UCvStzqjsbH5l9mMnhQ4ICxyCXYN+6OOftKRw39/lPOA9GHrS17sy9z6AYO3QGgD0TTnbMT9k7SKuA5b4OO5TJ1yGTj3631ExfPW7rps7rcgB9ffE3r66ILygfDduOjnx7KvTnR5wQ812SSg5aP8eTZfwnELLv4QOfwkSLsez3a9HtiRwldWjavgQIsNkeRzWaccxGvTlJJXMHx+ZV2vSwL741nSG/LVwTrPcMcemhJ+Mnv4NFN6cBpNfKbGPkQCbFUcUQ/qkFKEQsTh2hOc79G2LHLqgzfKAUOAs7qaRLuzGrESBuWS79t7ufdhlN4g8NCpgrEE4ua0HOdYqckk9x2vztrOap2COE5n3yW2kqLc9FqegbkTedCe+H89R0DlcvVta2EHRordw++WiTQhw4Vr1QH4mWK0mhIF/QQO3+jOgc4rawX50pEFujejHvJzKHvOuDJCtXa8usLqtb7EbBVcKvbALoEOUr9hwl0zVDgqpf1s4HtWewSOsIedmQfsVyY0U/MMnZYpNSyPQvtZHZiHUSsjGsvCBHd5Pp3+bInVj5b53WzG9utNKdTrWW90PqLnzK6dqJJGUAlVrCiPKIAOz+tFb7dPK9WAqyaVz4j9K3NBT5x9tNj3Wgq3xa+Qhvrj+R0gwmD+5EOmzUgoqnV8bp4+mn2U4rEcjBILLpiqrIXQXtdZnrJqh8d3UD0K3vU7fVsomJKUaCpYDGTZvCZhjubNuj9hEmKQAhQpysSC2hto4a/ZciTmA72MVMo/NddbI9C9hH6990IK4v2g/8wKX3uEstoSMO0DWOKx/o66BJ4qg/Xo9mDxQoeGrSphBjcYgHpnd/MNdpS6cwiIkqRqUCnoMpnIAdm" & _
            "n/nO9/OlPKfAicJ3dVBuBmrS/V9KiK2UW9TO/hAuNv9uHPbwF1bbjM+cLKGb1G/e+HPo1HOIEkY/nIp9tS3NvK6t6rpmHYbvTFIJgXkDHdWpWIJUAOnw+wdd4K5D1d92gXvz/zQwjMLi9SPO83aK9rdMxe/gL7iCu5Yoe+ySPIakXVFIVd5e6EY8S7TxDXrH6aQTbFqworcIsl6OHghLzI1BXgSNRNB3uJvwfrHwdbfw26o+V5KKRmAYkdrJTr2zqIheHYeoF+X2LJLSqSbPsuFUUdgWsyrXvucsChqF1UJou9Q0gPMZGPbU9kwB5KqqXST519PGPpg7RSHvwFXLGCaB1bAd82VAEQzC3aLANLwnBmKPbRl47TTFFVdGLe0140R0hS9nm7dBGQRuNeSH7Gxtbr5z2TsIogB7caiEIheQ25d2YWb6H2B3N2dYQWZfzZTN2WzOvXuxgr7GF5CaHzsxwYN4ZGBT8mbUECw34r0Ohct52fwb6bsINIjFLbpGcKQ2O5f+TsMSroI6SdJLWtC3DjmWsLmYbpNCu5wWwVyHaWs8ADuLBm8GGmEXMaLRI+JIwLSys1qdrI8Bohg92ElJyGFi4NC7cDVT5nk2avRIItZK0e4MeE0RIsgUbl47jEB2ndstn7bDda+Gl+ZMEb8blyPWAJnInNyzkE6eD0frNnfjYaSEo1S7k42Sc28rbhS++obk0/KIsAvgw520rPq4JKQdX14KlRAcoJNeh/sJKtdwA7RcVlpijx52utp8Zz6o6f6kWgUOZjuFVv6Ggvgb770jAd2aeu0ILYXYCX52+Ve97SZkkKbv71I41T8Q4QwExcNQj8yFHAK3H+fJ8mhLh4lnP7flmY1H8+k79tLIJ3hezS9SIvrMwfjy3xMQGDEgzmkt9JAHqNf6mCz2DSym62WCV+ukTbRyoeja7nSTBgxOUS8L59lnWyk8ZeINneaQC++6vadbA0DtlKTQH3H434SbpvlvzJ00X2AyI6VaiVFAh31EzMVFa9YwCN5x"
    $sData &= "RB7HMQVxUvwQpH6P6c8sb3URxKtI6OAmVoj/7hNcjVMqG3/SJAe8wdIBm12IM2cIv/uZ11rVyil0Ual3vVMFkn1t9Vz8t6MEyBa9JjvUOdYNp74V6WzJKsRDHwr4ziwLcoQX8GiviGv7TR85SqeFx6W4z6sIwpoct0McMnSPcG7KG+f5tJ8qwXcCZFl7zgf5hz4tJmdYpuX0nLHCkAVhcSzjpa+Kazk4+lXz7xx+zo8MDp1wX07Z9V1OJTQ/4PcVtH5wMeP9Sx2AbAer6NgdvoD9Jtf2WTa8Y2UDwJLVWYQx843KJe2ptXpgDP0R/fKk2AnjMcViZnFbARfdvnTfQRacVohWckRON6pwsuHQCRaJWl9kmzHlDA6F7UiGgpMTc7OgeoTugVBbKDsPvpzo1dguYIVa2bBHdGydTrdxuxAfiyZ+9p5pluYL8HSEM/Fpcz6NAZi2Wi2IMMYVHmhFOc6jqdGPxAPwf5hcuaVGdWliL5kiDNaIkt3Sm3AKbTGPIEWwN2i0Fd5GUETtSHDzzLCc+fiLJUXw4sXawkkiOWvUrPPeUhG3y4Rk9cFdHAKeOGgR8EnUoxPaYuuY79Xn0wuU+9CxRY/ou2/PExlUMxZkTMl8zRTsukD1Rkh1y82TGl8Z6s5xbBS1vaCed1YEN3QbUlr1oQ67i3bYccoBYk7pgVdc5s+XngFpQCGwIyHbC6d8B7Xjk0kbDHHKgyohoaY6oRnCpCMhCqUzXRu+qxgSKL1xr8D3bFF+4GSq1Q+j+sm1nj4NHmX39HmomA32GstSCX8KeEpIKUjaG4FFmiM/4xUtrIOecksxWd1krdnoYIgUMV4E9YWYqUSo7OMKhI2yuuBEF+nQpk4xIFBzVdqUP7shBHMfu5A5FBK1+4ucHec+T8hjd3slPM76XqD71+A2BKYVgkWv4addyPGzAZ34vascDSbBhXhXvWPXMX0XXOR73bDzqM9RigcgCaviLpIHcN1LZ431h/I9DByjew37qwiDWF9EMd0tTbfjO1FU" & _
            "PjodLTmTXGnjDLAIi4ySHEzwN8lVmpUEXM/VLaIqxxnJv8ebbsFhcvcer90sz5cCJMSt7O7xLLrPlesG20t9qPkrMEofkcrZGU0LQ3ju0CQuRMT4vwCoirysEFsX24O7l4BcAbMR8j55bNX8rH++iKeMERSiwpSgKax0XgbLNg4HUHkHZd2ZRdYMepAsEZrWKJMY8A+VxzDbunYLlB/UengdwbLS3/eLynuNFITuQ4E+01tQGI95V7WuVgxS+xsdkZdGSi5lmuwytMPFfKYlcxpovIHsj4w3YGmI0hor5LDJRNJv34shE6mS7IuI+gBtQB4Y8aeviHAy/GBtgz1ZiL2oEDFIsA4ZU1uTc+tvwNDRh5boFUvEBK2bwR2edtqq1e4vPJMWkkbtiTJLMBksHXwtY06bDCcyefIQk5MutneL9Lqr08ROcQjpFz3oBkVUQfgwPkkmZfydWCu/thCrWtZLqcyuNeLMoy7q3pjXgee2p+t3lfi2w1s10yNBPO1mgrqaNTcU66wvvaJAAdObxbq4NS0Zow/OzdNMEHXcqfJJ6MhpR1rtVUi+zQITy36dPaimFoEim5sl1beIsBcBwLYZRK6cxg+tk3DHlC+GwN/U1R1y3hm7PI1XBrnEzP/XX/2uhvoYcQhAhzAlUOAinRo0jKpLqtZR0weggynNfu9MYIO0h8N/NTLkxEhCwtBUOtPSwqanXfYBiBlMnae9l+/EsTStQlu7jDF/DR0Elr1P5eyJrcjfBXInh5YFVZEb7J8zUiQEJ5BjGKEqHkbmomZCWR8u7PUo17QWSc8PBZOFm/awQEV/BX/+akChJY2uiy7dX2/ZxWT1Z0PO5vbPzoiwQ4FRnzcsi/MWcQqeCdTGiwZm13HyF7nj+sP/e94hd5yaftf7kw4A0voJrw3oCNFUeQ7kmZkKDc8WRCnpcPvY6CUIA7aniHNJF7Y4eFxYaQqfX1/KKD0qkIvryrwtlEgy5OsAzryoEQrlP9t25rGevtRDKqLTYTEADji8vcTk" & _
            "2YCD/fywf2iTiMtlooYpGhZPM/K4BmrwIkiXgV6ovNMq0M9OKyYqujcpgIqBWFvCob00n1bfkbU+VquFvZ5N8IR1nbkroP25LgGMhGIPgJXk/s/T2lMF52plKp+a3woc6r2VP87I8KHskeTjiOwK9wOg8SJKprVux6N3g7h75iPNR0s50SL2/9jrVCafFLkPxS8aZ2CE3e/dTu4z0muYuW4zkRc18IfUtrv837BvFDlZx/+L7vVwoSb5Z+3sq/bz2CTBreK+oNE5gVNacH4YOMM2hfYnp93LeDq95kKvKdEg/XsIJaFEkYkBkAy4VcXu84IciYTUDO3h92Z8kuDiT/D/0HRxy7MEVFLsGYgh8TTayRpjPEmMVtta/qFjQtRi37UovLxfbVAYrptrjeECQ6WxWus54AI5onQOQYY5bfxe03skUVxOqKalRAdUmOaYP+DG6JkxzoTOJjq+WlQfyXiZIhLGJglYTt9UPdvIBrEzJq9nPM1TS6OmUcjDAUrZxE6HDFyvNZ52qZs4aca2OTssI+v4BnUeVLt3uebfdORNT5s5VgSb9sqzcHgvRrB4mYlKSSJSWReWkkSLiRcpQlZsPZ1xHYJImtZS4aieIdO/M++Km9CeFhFeje/yxs9xMEBK1wC7E7GbCirxNg4jgyNzVONLWbpVxJ7Y1yL0OZKHkqkCBdKH7VmpMAByBNAmKw5aBcYPbk74WCU3HYAkRxHQYf4O5tKPhp29ChefRjJeVVjO2aOU04cBPNxRZZgYM1ujX+nxcMQNQXZKyqaaaNxg6rYEhGO13leu4PvTRnPdSRWxCvkM3L7ao5xnoztsZ0fNarP2v3DJ7Pyct+H1pfvVYzxXJZQzH0EZEaT/pAIAVRLdc2IdQ8kED5jaJhabacaLXL5masXckobLu1RRZemdv7tks3rt9dCHPH5zgcYHsYIXjAgv0O272STaI7W4aTcpVdkpsAGJWoSynWCSdMHxJ2XyNyrPjmSy/baCSxWl+ISkzyOohCVUhpGf2VjV"
    $sData &= "Rh4i7aYJBqMH3aWJjOZyVAxBmr1exU/xH3v1RicUfrqfGsqO6xaM33qy2sR2OHxks4+YfgLbd8V7xfB8jWYX/GUMf2Ck1gdpTtKqvKJ0kI8tLrh3XUCHMRrwEbJCMzhnXa0GuugIfxiIz+1IvRYX+rVZIJbYZBO4xJXD1cbmKZuCMUVW74NIzv7ldcsuz0gRqrZfBcvh2aA6f1JnZl4FGze0jAttfHZhLTi98kQtZ6cYdX/iA0+t37W1s772Px/ESkYSNCI3TxTcqlwXoLVhj//2mOAmnakB+/pbKwk8RgzWIStBZuaXKzmYZOyZ74/iW0PRJlNLmwGj2sISlJLShEZvvNABav9yB5+OWFEV8TZv/UsTWB9qVSkOXR92KotoLs9nWfcQLgZwnTd6j3TbCOlxVSaoir9NMJpyGuMZhd/VbGxTHQoP1WkgcOew59xHM6jjmNXiaO/dzfewF3bI0fWk/ikGCbMSoLDwULGpab8rZnFkQNIt2Tg6Jqgz/e8hLc7I/XT9XWmmxqKbssgNNjEz8gx9toxugmlK5WKmvjNqBY2ulARKiLi3kboE3UkPSsIvLm3ahrHmJoBJ9IXEuRg61kGMJVbpAvp3it9RTJbHepST8mQodQD4NbuIvYiDiYUR2eDYQtGonhJP3+w0N2cattEe87IQ8FeDd8tc7x5WuAn6esECKHvS9W1gFXi93jVsSmwSETofpXuAomLqy4lOIuuB4OPNHFvDUEzHNTrGWqKQeasrL/QNSIBgYO78ZtYRcFqeCbMLfdMYbSC5PDIKMRPzMQYdPbMj3YNl3IyyhkQgJ5A1qc5NwHCFs3vpp+IsLuCisKpdMWVJSovb2r+z9N13wcCTXiweNC1yhF/JmNqhNrF/wR93GbDpLF4LN299swo6Z/popP/nQZTg+MJlXMRQmTFiht6Sm8IPg3vnfk8eboKzq2yPcZzEocZf3+UyFyyLzFDLxBNqXbKbVR10hIaOHAWgGW0IZMZotC6SxruAQWM5MQ0JAcf4ZLO5" & _
            "UROuvM3qlpOEn7M/oHv4XT1DDgd2L7XTgKv4TK1uoUaSK6Skjj9G9JHBGuUgvmb/ppEDDkR2Jx4oIhGECP2am/YDPU5op1hOrR6O8J6QcMb8Sl5+AaKrXOs9xNiMQZr/XPsNNJlPNa3WlBuV5AqOLHRGvFDmAeLuZF/t3zNMDH6ia/HYfF90HVRRaLOGbqG0Ff1ZMsYI2W3bczPA+320ZnfuyDhsSGf8upvkHzheSPWwPiv6f11GPQyhF6tkXZtVc3xJgmOsXkwm3IuX/f8gx+dRh+PCwla8pVURVA7i9GXqO3flt/gV/AMpQppIh1aSJWiSWzKb4CMLuJ3UgJTJh6zhwLA8+g46avgVAU/Ii0g7JMBAvY143hHaQZbZVS+HNA75gNpzARjG8eGhkT3pKZ16tRcuHQZggjFatjz1OEwHfB+CzIfvUqOTOxh2QK4uqGxs1BeCGsX5zfaKty3VTcLlvFnsjDfwnQ2McTT34sQqMWrYOj+kmhwv5SMQFl2f3pBTjCLvGLtwfkwkUtcpTxWz/hgx76lLDO/KAtmyouWwPPgjExSBMe3moeHWuVCNAbnXHZhO8DC99CPfM96diospt0XnB8pYpEFe0cC9VeVVqEXVGaRrWkFAAwWN3nusqA42YrSIVLy9CYaIPMG90KF4GQjP9jAW9YSQU/VbhCiJStzN7AXqYwMo/y1Y3H3Tvn5+5/Rav6r3y9dWm8+2D8bnCuLGfKVppgSOesg47jXdxX9ZuYWWHbgoawon8JSEU2nKwMsLWlKpno+dnE/DpeB6SDsM32Q8msIvkPJxRN1AEClZ+4JBZtztpG5n/wHnIYXkFWXtPLCLfDqchc0XxTjEnJmx5+4WNCBAjME/Pn+RG7Xpp3jh5xe8UNbEcW+lxUY1ga4X7nAQ3eehE56VcXGoYDbwlmrOAbGUu5fWLb/ftowLxw4a5KNXnDtV3gTX7Jz3nGTiDhliZU7mOADSw8p16n5vYuiAdfxM9KxZL9RTGlIXJCvO7jg+V7+pQnjf" & _
            "vQaWviq5DAFyIKVgxg6eqJoThwp3IIuctC+rIndOoL0Z6iN613xbDYKxoBjQJnV0RtnYANzV8l8XZe9+PYTeMGHaxfQmmvZkK1BBpJSlspTAs8bqUw3bpvuiIPy0Y/E05Trp8s9pgeQwefXH7WwLxux9DWiApM9bgi8KUQsT8cHNOD3utzYbdA2R817d7r3Hl6CennNrHZ+Yv17HXcaRBVbOp6MwfhJIreIkVAx4dsHKNjE4kiRCI9q/03oueCBwZRPeK+SYdut9LLFCNtDZHdgT9jG3YdvdFPDslWJN6aB5bitdYgCY1a1w4oYZ2Jttsu3kyNxvb+O4yEUKf1Tc6pvEDPNxyINWNzIGoJZfdPoMTsS+t0rPOQ7drVO2imHXm+w9XW0HJzMsvOfwgbiZ+XdXp11eLOdLklxvqdRZpXy23t7jr252/379t8a/JzapbPnaproW4lQDa5n8CRhUzU+oqvM2kcVggNcfWv37vILLyZo9KWNvbEVDVfPMuaWLTOuQxO0DmTnSbLC1yq9fzKErelQB/sFcFwsNieduKsXngU7WSqov1d0SvEoCt0iK5By4w2PcNfpperi+oRsAAQAAgH0H/8iDyP7/wIXAD4ReDAAARDkHdTZIi0VnSI08SUiLCLgIAAAAZjkE+Q+FTQwAAEiLTPkI/xVcUQAAiUUAAAAAkGXOTQAAAAB4wAAAAQAAABQAAAAUAAAAKMAAAI3AAAAtwgAAPE8AACxPAABETwAAWFMAAFBVAADkTgAAwE4AAJxOAABwUAAATE8AAIhPAAA0UgAAPFIAABBPAADgUQAA/FAAADRPAABEUgAAnFEAAOhPAABBdXRvSXRPYmplY3RfWDY0LmRsbADdwAAA5cAAAO/AAAD7wAAAFMEAAC/BAABBwQAAVMEAAGzBAACAwQAAlMEAAKrBAAC5wQAAycEAANTBAADkwQAA88EAAADCAAALwgAAHMIAAEFkZEVudW0AQWRkTWV0aG9kAEFkZFByb3BlcnR5AEF1dG9J"
    $sData &= "dE9iamVjdENyZWF0ZU9iamVjdABBdXRvSXRPYmplY3RDcmVhdGVPYmplY3RFeABDbG9uZUF1dG9JdE9iamVjdABDcmVhdGVBdXRvSXRPYmplY3QAQ3JlYXRlQXV0b0l0T2JqZWN0Q2xhc3MAQ3JlYXRlRGxsQ2FsbE9iamVjdABDcmVhdGVXcmFwcGVyT2JqZWN0AENyZWF0ZVdyYXBwZXJPYmplY3RFeABJVW5rbm93bkFkZFJlZgBJVW5rbm93blJlbGVhc2UASW5pdGlhbGl6ZQBNZW1vcnlDYWxsRW50cnkAUmVnaXN0ZXJPYmplY3QAUmVtb3ZlTWVtYmVyAFJldHVyblRoaXMAVW5SZWdpc3Rlck9iamVjdABXcmFwcGVyQWRkTWV0aG9kAAAAAQACAAMABAAFAAYABwAIAAkACgALAAwADQAOAA8AEAARABIAEwAAAAC8wgAAAAAAAAAAAABAwwAAvMIAANTCAAAAAAAAAAAAAEnDAADUwgAA5MIAAAAAAAAAAAAAYsMAAOTCAAD0wgAAAAAAAAAAAABvwwAA9MIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHMMAAAAAAAAvwwAAAAAAAAAAAAAAAAAAU8MAAAAAAAAAAAAAAAAAAAUBAAAAAACAAAAAAAAAAAB7wwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABHZXRNb2R1bGVIYW5kbGVBAAAAR2V0UHJvY0FkZHJlc3MAS0VSTkVMMzIAb2xlMzIuZGxsAAAAQ29Jbml0aWFsaXplAE9MRUFVVDMyLmRsbABTSExXQVBJLmRsbAAAAFN0clRvSW50NjRFeFcAV1ZTUVJBUEiNBd4KAABIizBIA/BIK8BIi/5mrcHgDEiLyFCtK8hIA/GLyFdEi8H/yYpEOQaIBDF19UFRVSvArIvIwekEUSQPUKyLyAIMJFBIx8UA/f//SNPlWVhIweAgSAPIWEiL3EiNpGyQ8f//UFFIK8lR" & _
            "UUiLzFFmixfB4gxSV0yNSQhJjUkIVlpIg+wg6MgAAABIi+NdQVleWoHqABAAACvJO8pzSovZrP/BPP91DYoGJP08FXXrrP/B6xc8jXUNigYkxzwFddqs/8HrBiT+POh1z1Fbg8EErQvAeAY7wnPB6wYDw3i7A8Irw4lG/OuySI09Bv///7DpqrjiCgAAq0iNBeIJAACLUAyLeAgL/3Q9SIswSAPwSCvySIveSItIFEgry3Qoi1AQSAPySAP+K8Ar0gvQrMHiB9DocvYL0AvSdAtIA9pIKQtIO/dy4UiNBZQJAADpigkAAEyJTCQgSIlUJBBTVVZXQVRBVUFWQVdIg+woM/ZMi/JIi8GNXgFMjWkMi0kIRIvTi9NMi/5B0+KLSAREit7T4kiLjCSgAAAARCvTK9OL7kSL44lUJAyLEEmJMYlUJAhIiTGLSAQDyroAAwAARIlUJBDT4omcJIAAAACJXCRwgcI2BwAAiVwkBHQNi8pJi/24AAQAAPNmq02Lzk0D8Iv+QYPI/4vOTTvOD4TKCAAAQQ+2AcHnCAPLC/hMA8uD+QV85Eg5tCSYAAAAD4aKCAAAi8VBi/e6CAAAAMHgBEEj8kG6AAAAAUhj2EhjxkgD2EU7wnMaTTvOD4Q/CAAAQQ+2AcHnCEHB4AgL+EmDwQFBD7dMXQBBi8DB6AsPr8E7+A+DtQEAAESLwLgACAAAQboBAAAAK8HB+AVmA8GLykEPttNmQYlEXQCLXCQIi0QkDEkjxyrLSNPqi8tI0+BIA9BIjQRSSMHgCYP9B0mNtAVsDgAAD4y7AAAAQYvESYvPSCvISIuEJJAAAAAPthwIA9tJY8JEi9tBgeMAAQAASWPTSAPQQYH4AAAAAXMaTTvOD4SIBwAAQQ+2AcHnCEHB4AgL+EmDwQEPt4xWAAIAAEGLwMHoCw+vwTv4cyhEi8C4AAgAAEUD0ivBwfgFZgPBZomEVgACAAAzwEQ72A+FmwAAAOsjRCvAK/gPt8FmwegFR41UEgFmK8gzwEQ7" & _
            "2GaJjFYAAgAAdHZBgfoAAQAAfXbpWv///0GB+AAAAAFJY9JzGk07zg+E9AYAAEEPtgHB5whBweAIC/hJg8EBD7cMVkGLwMHoCw+vwTv4cxlEi8C4AAgAACvBwfgFZgPBRQPSZokEVusYRCvAK/gPt8FmwegFR41UEgFmK8hmiQxWQYH6AAEAAHyPSIuEJJAAAABFitpGiBQ4SYPHAYP9BH0JM8CL6OljBgAAg/0KfQiD7QPpVgYAAIPtBulOBgAARCvAK/gPt8FmwegFSGPVZivIRTvCZkGJTF0AcyFNO84PhDwGAABBD7YBwecIQbsBAAAAC/hBweAITQPL6wZBuwEAAABBD7eMVYABAABBi8DB6AsPr8E7+HNRRIvAuAAIAAArwcH4BWYDwYP9B2ZBiYRVgAEAAItEJHBJjZVkBgAAiUQkBIuEJIAAAABEiaQkgAAAAIlEJHC4AwAAAI1Y/Q9Mw41rCOlOAgAARCvAK/gPt8FmwegFZivIRTvCZkGJjFWAAQAAcxlNO84PhJgFAABBD7YBwecIQcHgCAv4TQPLRQ+3lFWYAQAAQYvIwekLQQ+vyjv5D4PIAAAAuAAIAABEi8FBK8LB+AVmQQPCQboAAAABQTvKZkGJhFWYAQAAcxlNO84PhD4FAABBD7YBwecIQcHgCAv4TQPLQQ+3jF3gAQAAQYvAwegLD6/BO/hzVkSLwLgACAAAK8HB+AVmA8FmQYmEXeABAAAzwEw7+A+E9AQAAEiLlCSQAAAAuAsAAACD/QeNSP4PTMFJi8+L6EGLxEgryESKHApGiBw6SYPHAemnBAAARCvAK/gPt8FmwegFZivIZkGJjF3gAQAA6R4BAABBD7fCRCvBK/lmwegFZkQr0GZFiZRVmAEAAEG6AAAAAUU7wnMZTTvOD4R3BAAAQQ+2AcHnCEHB4AgL+E0Dy0EPt4xVsAEAAEGLwMHoCw+vwTv4cyVEi8C4AAgAACvBwfgFZgPBZkGJhFWwAQAAi4QkgAAAAOmaAAAARCvA"
    $sData &= "K/gPt8FmwegFZivIRTvCZkGJjFWwAQAAcxlNO84PhAYEAABBD7YBwecIQcHgCAv4TQPLQQ+3jFXIAQAAQYvAwegLD6/BO/hzH0SLwLgACAAAK8HB+AVmA8FmQYmEVcgBAACLRCRw6yREK8Ar+A+3wWbB6AVmK8iLRCQEZkGJjFXIAQAAi0wkcIlMJASLjCSAAAAAiUwkcESJpCSAAAAARIvgg/0HuAsAAABJjZVoCgAAjWj9D0zFM9tFO8KJBCRzGU07zg+EXwMAAEEPtgHB5whBweAIC/hNA8sPtwpBi8DB6AsPr8E7+HMlRIvAuAAIAABEi9MrwcH4BWYDwWaJAovGweADSGPITI1cSgTraEQrwCv4D7fBZsHoBWYryEU7wmaJCnMZTTvOD4T6AgAAQQ+2AcHnCEHB4AgL+E0Dyw+3SgJBi8DB6AsPr8E7+HMuRIvAuAAIAABEi9UrwcH4BWYDwWaJQgKLxsHgA0hjyEyNnEoEAQAAuwMAAADrIkQrwCv4D7fBZsHoBUyNmgQCAABBuhAAAABmK8iL3WaJSgKL870BAAAAQYH4AAAAAUhj1XMaTTvOD4RmAgAAQQ+2AcHnCEHB4AgL+EmDwQFBD7cMU0GLwMHoCw+vwTv4cxlEi8C4AAgAACvBwfgFZgPBA+1mQYkEU+sYRCvAK/gPt8FmwegFjWwtAWYryGZBiQxTg+4BdZKNRgGLy9PgRCvQiwQkQQPqg/gED42gAQAAg8AHg/0EjV4GiQQkjUYDjVYBD0zFweAGSJhNjZxFYAMAAEGB+AAAAAFMY9JzGk07zg+EvQEAAEEPtgHB5whBweAIC/hJg8EBQw+3DFNBi8DB6AsPr8E7+HMZRIvAuAAIAAArwcH4BWYDwQPSZkOJBFPrGEQrwCv4D7fBZsHoBY1UEgFmK8hmQ4kMU4PrAXWSg+pAg/oERIviD4z7AAAAQYPkAUSL0kHR+kGDzAJBg+oBg/oOfRlBi8pIY8JB0+RBi8xIK8hJjZxNXgUAAOtQQYPq" & _
            "BEGB+AAAAAFzGk07zg+EDwEAAEEPtgHB5whBweAIC/hJg8EBQdHoRQPkQTv4cgdBK/hBg8wBQYPqAXXFSY2dRAYAAEHB5ARBugQAAAC+AQAAAIvWQYH4AAAAAUxj2nMaTTvOD4S5AAAAQQ+2AcHnCEHB4AgL+EmDwQFCD7cMW0GLwMHoCw+vwTv4cxlEi8C4AAgAACvBwfgFZgPBA9JmQokEW+sbRCvAK/gPt8FmwegFjVQSAWYryEQL5mZCiQxbA/ZBg+oBdYxBg8QBdGBBi8SDxQJJY8xJO8d3RkiLlCSQAAAASYvHSCvBSAPCRIoYSIPAAUaIHDpJg8cBg+0BdApMO7wkmAAAAHLiiywkTDu8JJgAAABzFkSLVCQQ6ZT3//+4AQAAAOs4QYvD6zNBgfgAAAABcwlNO8505kmDwQFIi4QkiAAAAEwrTCR4TIkISIuEJKAAAABMiTgzwOsCi8NIg8QoQV9BXkFdQVxfXl1bw+kijv//iUH///////9DAAAAABAAAACwAAAAAACAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" & _
            "AAAAAAAAAAAAAAAAAAABABAAAAAYAACAAAAAAAAAAAAAAAAAAAABAAEAAAAwAACAAAAAAAAAAAAAAAAAAAABAAkEAABIAAAAWNAAABgDAAAAAAAAAAAAABgDNAAAAFYAUwBfAFYARQBSAFMASQBPAE4AXwBJAE4ARgBPAAAAAAC9BO/+AAABAAIAAQAAAAgAAgABAAAACAAAAAAAAAAAAAQAAAACAAAAAAAAAAAAAAAAAAAAdgIAAAEAUwB0AHIAaQBuAGcARgBpAGwAZQBJAG4AZgBvAAAAUgIAAAEAMAA0ADAAOQAwADQAQgAwAAAAMAAIAAEARgBpAGwAZQBWAGUAcgBzAGkAbwBuAAAAAAAxAC4AMgAuADgALgAwAAAANAAIAAEAUAByAG8AZAB1AGMAdABWAGUAcgBzAGkAbwBuAAAAMQAuADIALgA4AC4AMAAAAHoAKQABAEYAaQBsAGUARABlAHMAYwByAGkAcAB0AGkAbwBuAAAAAABQAHIAbwB2AGkAZABlAHMAIABvAGIAagBlAGMAdAAgAGYAdQBuAGMAdABpAG8AbgBhAGwAaQB0AHkAIABmAG8AcgAgAEEAdQB0AG8ASQB0AAAAAAA6AA0AAQBQAHIAbwBkAHUAYwB0AE4AYQBtAGUAAAAAAEEAdQB0AG8ASQB0AE8AYgBqAGUAYwB0AAAAAABYABoAAQBMAGUAZwBhAGwAQwBvAHAAeQByAGkAZwBoAHQAAAAoAEMAKQAgAFQAaABlACAAQQB1AHQAbwBJAHQATwBiAGoAZQBjAHQALQBUAGUAYQBtAAAASgARAAEATwByAGkAZwBpAG4AYQBsAEYAaQBsAGUAbgBhAG0AZQAAAEEAdQB0AG8ASQB0AE8AYgBqAGUAYwB0AC4AZABsAGwAAAAAAHoAIwABAFQAaABlACAAQQB1AHQAbwBJAHQATwBiAGoAZQBjAHQALQBUAGUAYQBtAAAAAABtAG8AbgBvAGMAZQByAGUAcwAsACAAdAByAGEA"
    $sData &= "bgBjAGUAeAB4ACwAIABLAGkAcAAsACAAUAByAG8AZwBBAG4AZAB5AAAAAABEAAAAAQBWAGEAcgBGAGkAbABlAEkAbgBmAG8AAAAAACQABAAAAFQAcgBhAG4AcwBsAGEAdABpAG8AbgAAAAAACQSwBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=="
    Return __Au3Obj_Mem_Base64Decode($sData)
EndFunc   ;==>__Au3Obj_Mem_BinDll_X64

#EndRegion Embedded DLL
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#Region DllStructCreate Wrapper

Func __Au3Obj_ObjStructMethod(ByRef $oSelf, $vParam1 = 0, $vParam2 = 0)
	Local $sMethod = $oSelf.__name__
	Local $tStructure = DllStructCreate($oSelf.__tag__, $oSelf.__pointer__)
	Local $vOut
	Switch @NumParams
		Case 1
			$vOut = DllStructGetData($tStructure, $sMethod)
		Case 2
			If $oSelf.__propcall__ Then
				$vOut = DllStructSetData($tStructure, $sMethod, $vParam1)
			Else
				$vOut = DllStructGetData($tStructure, $sMethod, $vParam1)
			EndIf
		Case 3
			$vOut = DllStructSetData($tStructure, $sMethod, $vParam2, $vParam1)
	EndSwitch
	If IsPtr($vOut) Then Return Number($vOut)
	Return $vOut
EndFunc   ;==>__Au3Obj_ObjStructMethod

Func __Au3Obj_ObjStructDestructor(ByRef $oSelf)
	If $oSelf.__new__ Then __Au3Obj_GlobalFree($oSelf.__pointer__)
EndFunc   ;==>__Au3Obj_ObjStructDestructor

Func __Au3Obj_ObjStructPointer(ByRef $oSelf, $vParam = Default)
	If $oSelf.__propcall__ Then Return SetError(1, 0, 0)
	If @NumParams = 1 Or IsKeyword($vParam) Then Return $oSelf.__pointer__
	Return Number(DllStructGetPtr(DllStructCreate($oSelf.__tag__, $oSelf.__pointer__), $vParam))
EndFunc   ;==>__Au3Obj_ObjStructPointer

#EndRegion DllStructCreate Wrapper
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#Region Public UDFs

Global Enum $ELTYPE_NOTHING, $ELTYPE_METHOD, $ELTYPE_PROPERTY
Global Enum $ELSCOPE_PUBLIC, $ELSCOPE_READONLY, $ELSCOPE_PRIVATE

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_AddDestructor
; Description ...: Adds a destructor to an AutoIt-object
; Syntax.........: _AutoItObject_AddDestructor(ByRef $oObject, $sAutoItFunc)
; Parameters ....: $oObject     - the object to modify
;                  $sAutoItFunc - the AutoIt-function wich represents this destructor.
; Return values .: Success      - True
;                  Failure      - 0
; Author ........: monoceres (Andreas Karlsson)
; Modified.......:
; Remarks .......: Adding a method that will be called on object destruction. Can be called multiple times.
; Related .......: _AutoItObject_AddProperty, _AutoItObject_AddEnum, _AutoItObject_RemoveMember, _AutoItObject_AddMethod
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_AddDestructor(ByRef $oObject, $sAutoItFunc)
	Return _AutoItObject_AddMethod($oObject, "~", $sAutoItFunc, True)
EndFunc   ;==>_AutoItObject_AddDestructor

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_AddEnum
; Description ...: Adds an Enum to an AutoIt-object
; Syntax.........: _AutoItObject_AddEnum(ByRef $oObject, $sNextFunc, $sResetFunc [, $sSkipFunc = ''])
; Parameters ....: $oObject     - the object to modify
;                  $sNextFunc   - The function to be called to get the next entry
;                  $sResetFunc  - The function to be called to reset the enum
;                  $sSkipFunc   - [optional] The function to be called to skip elements (not supported by AutoIt)
; Return values .: Success      - True
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_AddMethod, _AutoItObject_AddProperty, _AutoItObject_RemoveMember
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_AddEnum(ByRef $oObject, $sNextFunc, $sResetFunc, $sSkipFunc = '')
	; Author: Prog@ndy
	If Not IsObj($oObject) Then Return SetError(2, 0, 0)
	DllCall($ghAutoItObjectDLL, "none", "AddEnum", "idispatch", $oObject, "wstr", $sNextFunc, "wstr", $sResetFunc, "wstr", $sSkipFunc)
	If @error Then Return SetError(1, @error, 0)
	Return True
EndFunc   ;==>_AutoItObject_AddEnum

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_AddMethod
; Description ...: Adds a method to an AutoIt-object
; Syntax.........: _AutoItObject_AddMethod(ByRef $oObject, $sName, $sAutoItFunc [, $fPrivate = False])
; Parameters ....: $oObject     - the object to modify
;                  $sName       - the name of the method to add
;                  $sAutoItFunc - the AutoIt-function wich represents this method.
;                  $fPrivate    - [optional] Specifies whether the function can only be called from within the object. (default: False)
; Return values .: Success      - True
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The first parameter of the AutoIt-function is always a reference to the object. ($oSelf)
;                  This parameter will automatically be added and must not be given in the call.
;                  The function called '__default__' is accesible without a name using brackets ($return = $oObject())
; Related .......: _AutoItObject_AddProperty, _AutoItObject_AddEnum, _AutoItObject_RemoveMember
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_AddMethod(ByRef $oObject, $sName, $sAutoItFunc, $fPrivate = False)
	; Author: Prog@ndy
	If Not IsObj($oObject) Then Return SetError(2, 0, 0)
	Local $iFlags = 0
	If $fPrivate Then $iFlags = $ELSCOPE_PRIVATE
	DllCall($ghAutoItObjectDLL, "none", "AddMethod", "idispatch", $oObject, "wstr", $sName, "wstr", $sAutoItFunc, 'dword', $iFlags)
	If @error Then Return SetError(1, @error, 0)
	Return True
EndFunc   ;==>_AutoItObject_AddMethod

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_AddProperty
; Description ...: Adds a property to an AutoIt-object
; Syntax.........: _AutoItObject_AddProperty(ByRef $oObject, $sName [, $iFlags = $ELSCOPE_PUBLIC [, $vData = ""]])
; Parameters ....: $oObject     - the object to modify
;                  $sName       - the name of the property to add
;                  $iFlags      - [optional] Specifies the access to the property
;                  $vData       - [optional] Initial data for the property
; Return values .: Success      - True
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The property called '__default__' is accesible without a name using brackets ($value = $oObject())
;                  + $iFlags can be:
;                  |$ELSCOPE_PUBLIC   - The Property has public access.
;                  |$ELSCOPE_READONLY - The property is read-only and can only be changed from within the object.
;                  |$ELSCOPE_PRIVATE  - The property is private and can only be accessed from within the object.
;                  +
;                  + Initial default value for every new property is nothing (no value).
; Related .......: _AutoItObject_AddMethod, _AutoItObject_AddEnum, _AutoItObject_RemoveMember
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_AddProperty(ByRef $oObject, $sName, $iFlags = $ELSCOPE_PUBLIC, $vData = "")
	; Author: Prog@ndy
	Local Static $tStruct = DllStructCreate($__Au3Obj_tagVARIANT)
	If Not IsObj($oObject) Then Return SetError(2, 0, 0)
	Local $pData = 0
	If @NumParams = 4 Then
		$pData = DllStructGetPtr($tStruct)
		_AutoItObject_VariantInit($pData)
		$oObject.__bridge__(Number($pData)) = $vData
	EndIf
	DllCall($ghAutoItObjectDLL, "none", "AddProperty", "idispatch", $oObject, "wstr", $sName, 'dword', $iFlags, 'ptr', $pData)
	Local $error = @error
	If $pData Then _AutoItObject_VariantClear($pData)
	If $error Then Return SetError(1, $error, 0)
	Return True
EndFunc   ;==>_AutoItObject_AddProperty

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_Class
; Description ...: AutoItObject COM wrapper function
; Syntax.........: _AutoItObject_Class()
; Parameters ....:
; Return values .: Success      - object with defined:
;                   -methods:
;                  |	Create([$oParent = 0]) - creates AutoItObject object
;                  |	AddMethod($sName, $sAutoItFunc [, $fPrivate = False]) - adds new method
;                  |	AddProperty($sName, $iFlags = $ELSCOPE_PUBLIC, $vData = 0) - adds new property
;                  |	AddDestructor($sAutoItFunc) - adds destructor
;                  |	AddEnum($sNextFunc, $sResetFunc [, $sSkipFunc = '']) - adds enum
;                  |	RemoveMember($sMember) - removes member
;                   -properties:
;                  |	Object - readonly property representing the last created AutoItObject object
; Author ........: trancexx
; Modified.......:
; Remarks .......: "Object" propery can be accessed only once for one object. After that new AutoItObject object is created.
;                  +Method "Create" will discharge previous AutoItObject object and create a new one.
; Related .......: _AutoItObject_Create
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_Class()
	Local $aCall = DllCall($ghAutoItObjectDLL, "idispatch", "CreateAutoItObjectClass")
	If @error Then Return SetError(1, @error, 0)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_Class

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_CLSIDFromString
; Description ...: Converts a string to a CLSID-Struct (GUID-Struct)
; Syntax.........: _AutoItObject_CLSIDFromString($sString)
; Parameters ....: $sString     - The string to convert
; Return values .: Success      - DLLStruct in format $tagGUID
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_CoCreateInstance
; Link ..........: http://msdn.microsoft.com/en-us/library/ms680589(VS.85).aspx
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_CLSIDFromString($sString)
	Local $tCLSID = DllStructCreate("dword;word;word;byte[8]")
	Local $aResult = DllCall($gh_AU3Obj_ole32dll, 'long', 'CLSIDFromString', 'wstr', $sString, 'ptr', DllStructGetPtr($tCLSID))
	If @error Then Return SetError(1, @error, 0)
	If $aResult[0] <> 0 Then Return SetError(2, $aResult[0], 0)
	Return $tCLSID
EndFunc   ;==>_AutoItObject_CLSIDFromString

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_CoCreateInstance
; Description ...: Creates a single uninitialized object of the class associated with a specified CLSID.
; Syntax.........: _AutoItObject_CoCreateInstance($rclsid, $pUnkOuter, $dwClsContext, $riid, ByRef $ppv)
; Parameters ....: $rclsid       - The CLSID associated with the data and code that will be used to create the object.
;                  $pUnkOuter    - If NULL, indicates that the object is not being created as part of an aggregate.
;                  +If non-NULL, pointer to the aggregate object's IUnknown interface (the controlling IUnknown).
;                  $dwClsContext - Context in which the code that manages the newly created object will run.
;                  +The values are taken from the enumeration CLSCTX.
;                  $riid         - A reference to the identifier of the interface to be used to communicate with the object.
;                  $ppv          - [out byref] Variable that receives the interface pointer requested in riid.
;                  +Upon successful return, *ppv contains the requested interface pointer. Upon failure, *ppv contains NULL.
; Return values .: Success      - True
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_ObjCreate, _AutoItObject_CLSIDFromString
; Link ..........: http://msdn.microsoft.com/en-us/library/ms686615(VS.85).aspx
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_CoCreateInstance($rclsid, $pUnkOuter, $dwClsContext, $riid, ByRef $ppv)
	$ppv = 0
	Local $aResult = DllCall($gh_AU3Obj_ole32dll, 'long', 'CoCreateInstance', 'ptr', $rclsid, 'ptr', $pUnkOuter, 'dword', $dwClsContext, 'ptr', $riid, 'ptr*', 0)
	If @error Then Return SetError(1, @error, 0)
	$ppv = $aResult[5]
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_AutoItObject_CoCreateInstance

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_Create
; Description ...: Creates an AutoIt-object
; Syntax.........: _AutoItObject_Create( [$oParent = 0] )
; Parameters ....: $oParent     - [optional] an AutoItObject whose methods & properties are copied. (default: 0)
; Return values .: Success      - AutoIt-Object
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_Class
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_Create($oParent = 0)
	; Author: Prog@ndy
	Local $aResult
	Switch IsObj($oParent)
		Case True
			$aResult = DllCall($ghAutoItObjectDLL, "idispatch", "CloneAutoItObject", 'idispatch', $oParent)
		Case Else
			$aResult = DllCall($ghAutoItObjectDLL, "idispatch", "CreateAutoItObject")
	EndSwitch
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_AutoItObject_Create

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_DllOpen
; Description ...: Creates an object associated with specified dll
; Syntax.........: _AutoItObject_DllOpen($sDll [, $sTag = "" [, $iFlag = 0]])
; Parameters ....: $sDll - Dll for which to create an object
;                  $sTag - [optional] String representing function return value and parameters.
;                  $iFlag - [optional] Flag specifying the level of loading. See MSDN about LoadLibraryEx function for details. Default is 0.
; Return values .: Success      - Dispatch-Object
;                  Failure      - 0
; Author ........: trancexx
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_WrapperCreate
; Link ..........: http://msdn.microsoft.com/en-us/library/ms684179(VS.85).aspx
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_DllOpen($sDll, $sTag = "", $iFlag = 0)
	Local $sTypeTag = "wstr"
	If $sTag = Default Or Not $sTag Then $sTypeTag = "ptr"
	Local $aCall = DllCall($ghAutoItObjectDLL, "idispatch", "CreateDllCallObject", "wstr", $sDll, $sTypeTag, __Au3Obj_GetMethods($sTag), "dword", $iFlag)
	If @error Or Not IsObj($aCall[0]) Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_DllOpen

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_DllStructCreate
; Description ...: Object wrapper for DllStructCreate and related functions
; Syntax.........: _AutoItObject_DllStructCreate($sTag [, $vParam = 0])
; Parameters ....: $sTag     - A string representing the structure to create (same as with DllStructCreate)
;                  $vParam   - [optional] If this parameter is DLLStruct type then it will be copied to newly allocated space and maintained during lifetime of the object. If this parameter is not suplied needed memory allocation is done but content is initialized to zero. In all other cases function will not allocate memory but use parameter supplied as the pointer (same as DllStructCreate)
; Return values .: Success      - Object-structure
;                  Failure      - 0, @error is set to error value of DllStructCreate() function.
; Author ........: trancexx
; Modified.......:
; Remarks .......: AutoIt can't handle pointers properly when passed to or returned from object methods. Use Number() function on pointers before using them with this function.
;                  +Every element of structure must be named. Values are accessed through their names.
;                  +Created object exposes:
;                  +  - set of dynamic methods in names of elements of the structure
;                  +  - readonly properties:
;                  |	__tag__ - a string representing the object-structure
;                  |	__size__ - the size of the struct in bytes
;                  |	__alignment__ - alignment string (e.g. "align 2")
;                  |	__count__ - number of elements of structure
;                  |	__elements__ - string made of element names separated by semicolon (;)
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_DllStructCreate($sTag, $vParam = 0)
	Local $fNew = False
	Local $tSubStructure = DllStructCreate($sTag)
	If @error Then Return SetError(@error, 0, 0)
	Local $iSize = DllStructGetSize($tSubStructure)
	Local $pPointer = $vParam
	Select
		Case @NumParams = 1
			; Will allocate fixed 128 extra bytes due to possible misalignment and other issues
			$pPointer = __Au3Obj_GlobalAlloc($iSize + 128, 64) ; GPTR
			If @error Then Return SetError(3, 0, 0)
			$fNew = True
		Case IsDllStruct($vParam)
			$pPointer = __Au3Obj_GlobalAlloc($iSize, 64) ; GPTR
			If @error Then Return SetError(3, 0, 0)
			$fNew = True
			DllStructSetData(DllStructCreate("byte[" & $iSize & "]", $pPointer), 1, DllStructGetData(DllStructCreate("byte[" & $iSize & "]", DllStructGetPtr($vParam)), 1))
		Case @NumParams = 2 And $vParam = 0
			Return SetError(3, 0, 0)
	EndSelect
	Local $sAlignment
	Local $sNamesString = __Au3Obj_ObjStructGetElements($sTag, $sAlignment)
	Local $aElements = StringSplit($sNamesString, ";", 2)
	Local $oObj = _AutoItObject_Class()
	For $i = 0 To UBound($aElements) - 1
		$oObj.AddMethod($aElements[$i], "__Au3Obj_ObjStructMethod")
	Next
	$oObj.AddProperty("__tag__", $ELSCOPE_READONLY, $sTag)
	$oObj.AddProperty("__size__", $ELSCOPE_READONLY, $iSize)
	$oObj.AddProperty("__alignment__", $ELSCOPE_READONLY, $sAlignment)
	$oObj.AddProperty("__count__", $ELSCOPE_READONLY, UBound($aElements))
	$oObj.AddProperty("__elements__", $ELSCOPE_READONLY, $sNamesString)
	$oObj.AddProperty("__new__", $ELSCOPE_PRIVATE, $fNew)
	$oObj.AddProperty("__pointer__", $ELSCOPE_READONLY, Number($pPointer))
	$oObj.AddMethod("__default__", "__Au3Obj_ObjStructPointer")
	$oObj.AddDestructor("__Au3Obj_ObjStructDestructor")
	Return $oObj.Object
EndFunc   ;==>_AutoItObject_DllStructCreate

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_IDispatchToPtr
; Description ...: Returns pointer to AutoIt's object type
; Syntax.........: _AutoItObject_IDispatchToPtr(ByRef $oIDispatch)
; Parameters ....: $oIDispatch  - Object
; Return values .: Success      - Pointer to object
;                  Failure      - 0
; Author ........: monoceres, trancexx
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_PtrToIDispatch, _AutoItObject_CoCreateInstance, _AutoItObject_ObjCreate
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_IDispatchToPtr($oIDispatch)
	Local $aCall = DllCall($ghAutoItObjectDLL, "ptr", "ReturnThis", "idispatch", $oIDispatch)
	If @error Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_IDispatchToPtr

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_IUnknownAddRef
; Description ...: Increments the refrence count of an IUnknown-Object
; Syntax.........: _AutoItObject_IUnknownAddRef($vUnknown)
; Parameters ....: $vUnknown    - IUnkown-pointer or object itself
; Return values .: Success      - New reference count.
;                  Failure      - 0, @error is set.
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_IUnknownRelease
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_IUnknownAddRef(Const $vUnknown)
	; Author: Prog@ndy
	Local $sType = "ptr"
	If IsObj($vUnknown) Then $sType = "idispatch"
	Local $aCall = DllCall($ghAutoItObjectDLL, "dword", "IUnknownAddRef", $sType, $vUnknown)
	If @error Then Return SetError(1, @error, 0)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_IUnknownAddRef

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_IUnknownRelease
; Description ...: Decrements the refrence count of an IUnknown-Object
; Syntax.........: _AutoItObject_IUnknownRelease($vUnknown)
; Parameters ....: $vUnknown    - IUnkown-pointer or object itself
; Return values .: Success      - New reference count.
;                  Failure      - 0, @error is set.
; Author ........: trancexx
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_IUnknownAddRef
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_IUnknownRelease(Const $vUnknown)
	Local $sType = "ptr"
	If IsObj($vUnknown) Then $sType = "idispatch"
	Local $aCall = DllCall($ghAutoItObjectDLL, "dword", "IUnknownRelease", $sType, $vUnknown)
	If @error Then Return SetError(1, @error, 0)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_IUnknownRelease

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_ObjCreate
; Description ...: Creates a reference to a COM object
; Syntax.........: _AutoItObject_ObjCreate($sID [, $sRefId = Default [, $tagInterface = Default ]] )
; Parameters ....: $sID - Object identifier. Either string representation of CLSID or ProgID
;                  $sRefId - [optional] String representation of the identifier of the interface to be used to communicate with the object. Default is the value of IDispatch
;                  $tagInterface - [optional] String defining the methods of the Interface, see Remarks for _AutoItObject_WrapperCreate function for details
; Return values .: Success      - Dispatch-Object
;                  Failure      - 0
; Author ........: trancexx
; Modified.......:
; Remarks .......: Prefix object identifier with "cbi:" to create object from ROT.
; Related .......: _AutoItObject_ObjCreateEx, _AutoItObject_WrapperCreate
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_ObjCreate($sID, $sRefId = Default, $tagInterface = Default)
	Local $sTypeRef = "wstr"
	If $sRefId = Default Or Not $sRefId Then $sTypeRef = "ptr"
	Local $sTypeTag = "wstr"
	If $tagInterface = Default Or Not $tagInterface Then $sTypeTag = "ptr"
	Local $aCall = DllCall($ghAutoItObjectDLL, "idispatch", "AutoItObjectCreateObject", "wstr", $sID, $sTypeRef, $sRefId, $sTypeTag, __Au3Obj_GetMethods($tagInterface))
	If @error Or Not IsObj($aCall[0]) Then Return SetError(1, 0, 0)
	If $sTypeRef = "ptr" And $sTypeTag = "ptr" Then _AutoItObject_IUnknownRelease($aCall[0])
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_ObjCreate

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_ObjCreateEx
; Description ...: Creates a reference to a COM object
; Syntax.........: _AutoItObject_ObjCreateEx($sModule, $sCLSID [, $sRefId = Default [, $tagInterface = Default [, $fWrapp = False]]] )
; Parameters ....: $sModule - Full path to the module with class (object)
;                  $sCLSID - Object identifier. String representation of CLSID.
;                  $sRefId - [optional] String representation of the identifier of the interface to be used to communicate with the object. Default is the value of IDispatch
;                  $tagInterface - [optional] String defining the methods of the Interface, see Remarks for _AutoItObject_WrapperCreate function for details
;                  $fWrapped - [optional] Specifies whether to wrapp created object.
; Return values .: Success      - Dispatch-Object
;                  Failure      - 0
; Author ........: trancexx
; Modified.......:
; Remarks .......: This function doesn't require any additional registration of the classes and interaces supported in the server module.
;                 +In case $tagInterface is specified $fWrapp parameter is ignored.
;                 +If $sRefId is left default then first supported interface by the coclass is returned (the default dispatch).
;                 +
;                 +If used to for ROT objects $sModule parameter represents the full path to the server (any form: exe, a3x or au3). Default time-out value for the function is 3000ms in that case. If required object isn't created in that time function will return failure.
;                 +This function sends "/StartServer" command to the server to initialize it.
; Related .......: _AutoItObject_ObjCreate, _AutoItObject_WrapperCreate
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_ObjCreateEx($sModule, $sID, $sRefId = Default, $tagInterface = Default, $fWrapp = False, $iTimeOut = Default)
	Local $sTypeRef = "wstr"
	If $sRefId = Default Or Not $sRefId Then $sTypeRef = "ptr"
	Local $sTypeTag = "wstr"
	If $tagInterface = Default Or Not $tagInterface Then
		$sTypeTag = "ptr"
	Else
		$fWrapp = True
	EndIf
	If $iTimeOut = Default Then $iTimeOut = 0
	Local $aCall = DllCall($ghAutoItObjectDLL, "idispatch", "AutoItObjectCreateObjectEx", "wstr", $sModule, "wstr", $sID, $sTypeRef, $sRefId, $sTypeTag, __Au3Obj_GetMethods($tagInterface), "bool", $fWrapp, "dword", $iTimeOut)
	If @error Or Not IsObj($aCall[0]) Then Return SetError(1, 0, 0)
	If Not $fWrapp Then _AutoItObject_IUnknownRelease($aCall[0])
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_ObjCreateEx

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_ObjectFromDtag
; Description ...: Creates custom object defined with "dtag" interface description string
; Syntax.........: _AutoItObject_ObjectFromDtag($sFunctionPrefix, $dtagInterface [, $fNoUnknown = False])
; Parameters ....: $sFunctionPrefix  - The prefix of the functions you define as object methods
;                  $dtagInterface - string describing the interface (dtag)
;                  $fNoUnknown - [optional] NOT an IUnkown-Interface. Do not call "Release" method when out of scope (Default: False, meaining to call Release method)
; Return values .: Success      - object type
;                  Failure      - 0
; Author ........: trancexx
; Modified.......:
; Remarks .......: Main purpose of this function is to create custom objects that serve as event handlers for other objects.
;                  +Registered callback functions (defined methods) are left for AutoIt to free at its convenience on exit.
; Related .......: _AutoItObject_ObjCreate, _AutoItObject_ObjCreateEx, _AutoItObject_WrapperCreate
; Link ..........: http://msdn.microsoft.com/en-us/library/ms692727(VS.85).aspx
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_ObjectFromDtag($sFunctionPrefix, $dtagInterface, $fNoUnknown = False)
	Local $sMethods = __Au3Obj_GetMethods($dtagInterface)
	$sMethods = StringReplace(StringReplace(StringReplace(StringReplace($sMethods, "object", "idispatch"), "variant*", "ptr"), "hresult", "long"), "bstr", "ptr")
	Local $aMethods = StringSplit($sMethods, @LF, 3)
	Local $iUbound = UBound($aMethods)
	Local $sMethod, $aSplit, $sNamePart, $aTagPart, $sTagPart, $sRet, $sParams
	; Allocation. Read http://msdn.microsoft.com/en-us/library/ms810466.aspx to see why like this (object + methods):
	Local $tInterface = DllStructCreate("ptr[" & $iUbound + 1 & "]", __Au3Obj_CoTaskMemAlloc($__Au3Obj_PTR_SIZE * ($iUbound + 1)))
	If @error Then Return SetError(1, 0, 0)
	For $i = 0 To $iUbound - 1
		$aSplit = StringSplit($aMethods[$i], "|", 2)
		If UBound($aSplit) <> 2 Then ReDim $aSplit[2]
		$sNamePart = $aSplit[0]
		$sTagPart = $aSplit[1]
		$sMethod = $sFunctionPrefix & $sNamePart
		$aTagPart = StringSplit($sTagPart, ";", 2)
		$sRet = $aTagPart[0]
		$sParams = StringReplace($sTagPart, $sRet, "", 1)
		$sParams = "ptr" & $sParams
		DllStructSetData($tInterface, 1, DllCallbackGetPtr(DllCallbackRegister($sMethod, $sRet, $sParams)), $i + 2) ; Freeing is left to AutoIt.
	Next
	DllStructSetData($tInterface, 1, DllStructGetPtr($tInterface) + $__Au3Obj_PTR_SIZE) ; Interface method pointers are actually pointer size away
	Return _AutoItObject_WrapperCreate(DllStructGetPtr($tInterface), $dtagInterface, $fNoUnknown, True) ; and first pointer is object pointer that's wrapped
EndFunc   ;==>_AutoItObject_ObjectFromDtag

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_PtrToIDispatch
; Description ...: Converts IDispatch pointer to AutoIt's object type
; Syntax.........: _AutoItObject_PtrToIDispatch($pIDispatch)
; Parameters ....: $pIDispatch  - IDispatch pointer
; Return values .: Success      - object type
;                  Failure      - 0
; Author ........: monoceres, trancexx
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_IDispatchToPtr, _AutoItObject_WrapperCreate
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_PtrToIDispatch($pIDispatch)
	Local $aCall = DllCall($ghAutoItObjectDLL, "idispatch", "ReturnThis", "ptr", $pIDispatch)
	If @error Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_PtrToIDispatch

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_RegisterObject
; Description ...: Registers the object to ROT
; Syntax.........: _AutoItObject_RegisterObject($vObject, $sID)
; Parameters ....: $vObject - Object or object pointer.
;                  $sID - Object's desired identifier.
; Return values .: Success      - Handle of the ROT object.
;                  Failure      - 0
; Author ........: trancexx
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_UnregisterObject
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_RegisterObject($vObject, $sID)
	Local $sTypeObj = "ptr"
	If IsObj($vObject) Then $sTypeObj = "idispatch"
	Local $aCall = DllCall($ghAutoItObjectDLL, "dword", "RegisterObject", $sTypeObj, $vObject, "wstr", $sID)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_RegisterObject

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_RemoveMember
; Description ...: Removes a property or a function from an AutoIt-object
; Syntax.........: _AutoItObject_RemoveMember(ByRef $oObject, $sMember)
; Parameters ....: $oObject     - the object to modify
;                  $sMember     - the name of the member to remove
; Return values .: Success      - True
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_AddMethod, _AutoItObject_AddProperty, _AutoItObject_AddEnum
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_RemoveMember(ByRef $oObject, $sMember)
	; Author: Prog@ndy
	If Not IsObj($oObject) Then Return SetError(2, 0, 0)
	If $sMember = '__default__' Then Return SetError(3, 0, 0)
	DllCall($ghAutoItObjectDLL, "none", "RemoveMember", "idispatch", $oObject, "wstr", $sMember)
	If @error Then Return SetError(1, @error, 0)
	Return True
EndFunc   ;==>_AutoItObject_RemoveMember

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_Shutdown
; Description ...: frees the AutoItObject DLL
; Syntax.........: _AutoItObject_Shutdown()
; Parameters ....: $fFinal    - [optional] Force shutdown of the library? (Default: False)
; Return values .: Remaining reference count (one for each call to _AutoItObject_Startup)
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: Usage of this function is optonal. The World wouldn't end without it.
; Related .......: _AutoItObject_Startup
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_Shutdown($fFinal = False)
	; Author: Prog@ndy
	If $giAutoItObjectDLLRef <= 0 Then Return 0
	$giAutoItObjectDLLRef -= 1
	If $fFinal Then $giAutoItObjectDLLRef = 0
	If $giAutoItObjectDLLRef = 0 Then DllCall($ghAutoItObjectDLL, "ptr", "Initialize", "ptr", 0, "ptr", 0)
	Return $giAutoItObjectDLLRef
EndFunc   ;==>_AutoItObject_Shutdown

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_Startup
; Description ...: Initializes AutoItObject
; Syntax.........: _AutoItObject_Startup( [$fLoadDLL = False [, $sDll = "AutoitObject.dll"]] )
; Parameters ....: $fLoadDLL    - [optional] specifies whether an external DLL-file should be used (default: False)
;                  $sDLL        - [optional] the path to the external DLL (default: AutoitObject.dll or AutoitObject_X64.dll)
; Return values .: Success      - True
;                  Failure      - False
; Author ........: trancexx, Prog@ndy
; Modified.......:
; Remarks .......: Automatically switches between 32bit and 64bit mode if no special DLL is specified.
; Related .......: _AutoItObject_Shutdown
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_Startup($fLoadDLL = False, $sDll = "AutoitObject.dll")
	Local Static $__Au3Obj_FunctionProxy = DllCallbackGetPtr(DllCallbackRegister("__Au3Obj_FunctionProxy", "int", "wstr;idispatch"))
	Local Static $__Au3Obj_EnumFunctionProxy = DllCallbackGetPtr(DllCallbackRegister("__Au3Obj_EnumFunctionProxy", "int", "dword;wstr;idispatch;ptr;ptr"))
	If $ghAutoItObjectDLL = -1 Then
		If $fLoadDLL Then
			If $__Au3Obj_X64 And @NumParams = 1 Then $sDll = "AutoItObject_X64.dll"
			$ghAutoItObjectDLL = DllOpen($sDll)
		Else
			$ghAutoItObjectDLL = __Au3Obj_Mem_DllOpen()
		EndIf
		If $ghAutoItObjectDLL = -1 Then Return SetError(1, 0, False)
	EndIf
	If $giAutoItObjectDLLRef <= 0 Then
		$giAutoItObjectDLLRef = 0
		DllCall($ghAutoItObjectDLL, "ptr", "Initialize", "ptr", $__Au3Obj_FunctionProxy, "ptr", $__Au3Obj_EnumFunctionProxy)
		If @error Then
			DllClose($ghAutoItObjectDLL)
			$ghAutoItObjectDLL = -1
			Return SetError(2, 0, False)
		EndIf
	EndIf
	$giAutoItObjectDLLRef += 1
	Return True
EndFunc   ;==>_AutoItObject_Startup

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_UnregisterObject
; Description ...: Unregisters the object from ROT
; Syntax.........: _AutoItObject_UnregisterObject($iHandle)
; Parameters ....: $iHandle - Object's ROT handle as returned by _AutoItObject_RegisterObject function.
; Return values .: Success      - 1
;                  Failure      - 0
; Author ........: trancexx
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_RegisterObject
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_UnregisterObject($iHandle)
	Local $aCall = DllCall($ghAutoItObjectDLL, "dword", "UnRegisterObject", "dword", $iHandle)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	Return 1
EndFunc   ;==>_AutoItObject_UnregisterObject

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_VariantClear
; Description ...: Clears the value of a variant
; Syntax.........: _AutoItObject_VariantClear($pvarg)
; Parameters ....: $pvarg       - the VARIANT to clear
; Return values .: Success      - 0
;                  Failure      - nonzero
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_VariantFree
; Link ..........: http://msdn.microsoft.com/en-us/library/ms221165.aspx
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_VariantClear($pvarg)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "long", "VariantClear", "ptr", $pvarg)
	If @error Then Return SetError(1, 0, 1)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_VariantClear

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_VariantCopy
; Description ...: Copies a VARIANT to another
; Syntax.........: _AutoItObject_VariantCopy($pvargDest, $pvargSrc)
; Parameters ....: $pvargDest   - Destionation variant
;                  $pvargSrc    - Source variant
; Return values .: Success      - 0
;                  Failure      - nonzero
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_VariantRead
; Link ..........: http://msdn.microsoft.com/en-us/library/ms221697.aspx
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_VariantCopy($pvargDest, $pvargSrc)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "long", "VariantCopy", "ptr", $pvargDest, 'ptr', $pvargSrc)
	If @error Then Return SetError(1, 0, 1)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_VariantCopy

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_VariantFree
; Description ...: Frees a variant created by _AutoItObject_VariantSet
; Syntax.........: _AutoItObject_VariantFree($pvarg)
; Parameters ....: $pvarg       - the VARIANT to free
; Return values .: Success      - 0
;                  Failure      - nonzero
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: Use this function on variants created with _AutoItObject_VariantSet function (when first parameter for that function is 0).
; Related .......: _AutoItObject_VariantClear
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_VariantFree($pvarg)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "long", "VariantClear", "ptr", $pvarg)
	If @error Then Return SetError(1, 0, 1)
	If $aCall[0] = 0 Then __Au3Obj_CoTaskMemFree($pvarg)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_VariantFree

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_VariantInit
; Description ...: Initializes a variant.
; Syntax.........: _AutoItObject_VariantInit($pvarg)
; Parameters ....: $pvarg       - the VARIANT to initialize
; Return values .: Success      - 0
;                  Failure      - nonzero
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_VariantClear
; Link ..........: http://msdn.microsoft.com/en-us/library/ms221402.aspx
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_VariantInit($pvarg)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "long", "VariantInit", "ptr", $pvarg)
	If @error Then Return SetError(1, 0, 1)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_VariantInit

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_VariantRead
; Description ...: Reads the value of a VARIANT
; Syntax.........: _AutoItObject_VariantRead($pVariant)
; Parameters ....: $pVariant    - Pointer to VARaINT-structure
; Return values .: Success      - value of the VARIANT
;                  Failure      - 0
; Author ........: monoceres, Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_VariantSet
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_VariantRead($pVariant)
	; Author: monoceres, Prog@ndy
	Local $var = DllStructCreate($__Au3Obj_tagVARIANT, $pVariant), $data
	; Translate the vt id to a autoit dllcall type
	Local $VT = DllStructGetData($var, "vt"), $type
	Switch $VT
		Case $__Au3Obj_VT_I1, $__Au3Obj_VT_UI1
			$type = "byte"
		Case $__Au3Obj_VT_I2
			$type = "short"
		Case $__Au3Obj_VT_I4
			$type = "int"
		Case $__Au3Obj_VT_I8
			$type = "int64"
		Case $__Au3Obj_VT_R4
			$type = "float"
		Case $__Au3Obj_VT_R8
			$type = "double"
		Case $__Au3Obj_VT_UI2
			$type = 'word'
		Case $__Au3Obj_VT_UI4
			$type = 'uint'
		Case $__Au3Obj_VT_UI8
			$type = 'uint64'
		Case $__Au3Obj_VT_BSTR
			Return __Au3Obj_SysReadString(DllStructGetData($var, "data"))
		Case $__Au3Obj_VT_BOOL
			$type = 'short'
		Case BitOR($__Au3Obj_VT_ARRAY, $__Au3Obj_VT_UI1)
			Local $pSafeArray = DllStructGetData($var, "data")
			Local $bound, $pData, $lbound
			If 0 = __Au3Obj_SafeArrayGetUBound($pSafeArray, 1, $bound) Then
				__Au3Obj_SafeArrayGetLBound($pSafeArray, 1, $lbound)
				$bound += 1 - $lbound
				If 0 = __Au3Obj_SafeArrayAccessData($pSafeArray, $pData) Then
					Local $tData = DllStructCreate("byte[" & $bound & "]", $pData)
					$data = DllStructGetData($tData, 1)
					__Au3Obj_SafeArrayUnaccessData($pSafeArray)
				EndIf
			EndIf
			Return $data
		Case BitOR($__Au3Obj_VT_ARRAY, $__Au3Obj_VT_VARIANT)
			Return __Au3Obj_ReadSafeArrayVariant(DllStructGetData($var, "data"))
		Case $__Au3Obj_VT_DISPATCH
			Return _AutoItObject_PtrToIDispatch(DllStructGetData($var, "data"))
		Case $__Au3Obj_VT_PTR
			Return DllStructGetData($var, "data")
		Case $__Au3Obj_VT_ERROR
			Return Default
		Case Else
			_AutoItObject_VariantClear($pVariant)
			Return SetError(1, 0, '')
	EndSwitch

	$data = DllStructCreate($type, DllStructGetPtr($var, "data"))

	Switch $VT
		Case $__Au3Obj_VT_BOOL
			Return DllStructGetData($data, 1) <> 0
	EndSwitch
	Return DllStructGetData($data, 1)

EndFunc   ;==>_AutoItObject_VariantRead

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_VariantSet
; Description ...: sets the value of a varaint or creates a new one.
; Syntax.........: _AutoItObject_VariantSet($pVar, $vVal, $iSpecialType = 0)
; Parameters ....: $pVar        - Pointer to the VARIANT to modify (0 if you want to create it new)
;                  $vVal        - Value of the VARIANT
;                  $iSpecialType - [optional] Modify the automatic type. NOT FOR GENERAL USE!
; Return values .: Success      - Pointer to the VARIANT
;                  Failure      - 0
; Author ........: monoceres, Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_VariantRead
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_VariantSet($pVar, $vVal, $iSpecialType = 0)
	; Author: monoceres, Prog@ndy
	If Not $pVar Then
		$pVar = __Au3Obj_CoTaskMemAlloc($__Au3Obj_VARIANT_SIZE)
		_AutoItObject_VariantInit($pVar)
	Else
		_AutoItObject_VariantClear($pVar)
	EndIf
	Local $tVar = DllStructCreate($__Au3Obj_tagVARIANT, $pVar)
	Local $iType = $__Au3Obj_VT_EMPTY, $vDataType = ''

	Switch VarGetType($vVal)
		Case "Int32"
			$iType = $__Au3Obj_VT_I4
			$vDataType = 'int'
		Case "Int64"
			$iType = $__Au3Obj_VT_I8
			$vDataType = 'int64'
		Case "String", 'Text'
			$iType = $__Au3Obj_VT_BSTR
			$vDataType = 'ptr'
			$vVal = __Au3Obj_SysAllocString($vVal)
		Case "Double"
			$vDataType = 'double'
			$iType = $__Au3Obj_VT_R8
		Case "Float"
			$vDataType = 'float'
			$iType = $__Au3Obj_VT_R4
		Case "Bool"
			$vDataType = 'short'
			$iType = $__Au3Obj_VT_BOOL
			If $vVal Then
				$vVal = 0xffff
			Else
				$vVal = 0
			EndIf
		Case 'Ptr'
			If $__Au3Obj_X64 Then
				$iType = $__Au3Obj_VT_UI8
			Else
				$iType = $__Au3Obj_VT_UI4
			EndIf
			$vDataType = 'ptr'
		Case 'Object'
			_AutoItObject_IUnknownAddRef($vVal)
			$vDataType = 'ptr'
			$iType = $__Au3Obj_VT_DISPATCH
		Case "Binary"
			; ARRAY OF BYTES !
			Local $tSafeArrayBound = DllStructCreate($__Au3Obj_tagSAFEARRAYBOUND)
			DllStructSetData($tSafeArrayBound, 1, BinaryLen($vVal))
			Local $pSafeArray = __Au3Obj_SafeArrayCreate($__Au3Obj_VT_UI1, 1, DllStructGetPtr($tSafeArrayBound))
			Local $pData
			If 0 = __Au3Obj_SafeArrayAccessData($pSafeArray, $pData) Then
				Local $tData = DllStructCreate("byte[" & BinaryLen($vVal) & "]", $pData)
				DllStructSetData($tData, 1, $vVal)
				__Au3Obj_SafeArrayUnaccessData($pSafeArray)
				$vVal = $pSafeArray
				$vDataType = 'ptr'
				$iType = BitOR($__Au3Obj_VT_ARRAY, $__Au3Obj_VT_UI1)
			EndIf
		Case "Array"
			$vDataType = 'ptr'
			$vVal = __Au3Obj_CreateSafeArrayVariant($vVal)
			$iType = BitOR($__Au3Obj_VT_ARRAY, $__Au3Obj_VT_VARIANT)
		Case Else ;"Keyword" ; all keywords and unknown Vartypes will be handled as "default"
			$iType = $__Au3Obj_VT_ERROR
			$vDataType = 'int'
	EndSwitch
	If $vDataType Then
		DllStructSetData(DllStructCreate($vDataType, DllStructGetPtr($tVar, 'data')), 1, $vVal)

		If @NumParams = 3 Then $iType = $iSpecialType
		DllStructSetData($tVar, 'vt', $iType)
	EndIf
	Return $pVar
EndFunc   ;==>_AutoItObject_VariantSet

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_WrapperAddMethod
; Description ...: Adds additional methods to the Wrapper-Object, e.g if you want alternative parameter types
; Syntax.........: _AutoItObject_WrapperAddMethod(ByRef $oWrapper, $sReturnType, $sName, $sParamTypes, $ivtableIndex)
; Parameters ....: $oWrapper     - The Object you want to modify
;                  $sReturnType  - the return type of the function
;                  $sName        - The name of the function
;                  $sParamTypes  - the parameter types
;                  $ivTableIndex - Index of the function in the object's vTable
; Return values .: Success      - True
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_WrapperCreate
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_WrapperAddMethod(ByRef $oWrapper, $sReturnType, $sName, $sParamTypes, $ivtableIndex)
	; Author: Prog@ndy
	If Not IsObj($oWrapper) Then Return SetError(2, 0, 0)
	DllCall($ghAutoItObjectDLL, "none", "WrapperAddMethod", 'idispatch', $oWrapper, 'wstr', $sName, "wstr", StringRegExpReplace($sReturnType & ';' & $sParamTypes, "\s|(;+\Z)", ''), 'dword', $ivtableIndex)
	If @error Then Return SetError(1, @error, 0)
	Return True
EndFunc   ;==>_AutoItObject_WrapperAddMethod

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_WrapperCreate
; Description ...: Creates an IDispatch-Object for COM-Interfaces normally not supporting it.
; Syntax.........: _AutoItObject_WrapperCreate($pUnknown, $tagInterface [, $fNoUnknown = False [, $fCallFree = False]])
; Parameters ....: $pUnknown     - Pointer to an IUnknown-Interface not supporting IDispatch
;                  $tagInterface - String defining the methods of the Interface, see Remarks for details
;                  $fNoUnknown   - [optional] $pUnknown is NOT an IUnkown-Interface. Do not release when out of scope (Default: False)
;                  $fCallFree   - [optional] Internal parameter. Do not use.
; Return values .: Success      - Dispatch-Object
;                  Failure      - 0, @error set
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: $tagInterface can be a string in the following format (dtag):
;                  +  "FunctionName ReturnType(ParamType1;ParamType2);FunctionName2 ..."
;                  +    - FunctionName is the name of the function you want to call later
;                  +    - ReturnType is the return type (like DLLCall)
;                  +    - ParamType is the type of the parameter (like DLLCall) [do not include the THIS-param]
;                  +
;                  +Alternative Format where only method names are listed (ltag) results in different format for calling the functions/methods later. You must specify the datatypes in the call then:
;                  +  $oObject.function("returntype", "1stparamtype", $1stparam, "2ndparamtype", $2ndparam, ...)
;                  +
;                  +The reuturn value of a call is always an array (except an error occured, then it's 0):
;                  +  - $array[0] - containts the return value
;                  +  - $array[n] - containts the n-th parameter
; Related .......: _AutoItObject_WrapperAddMethod
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_WrapperCreate($pUnknown, $tagInterface, $fNoUnknown = False, $fCallFree = False)
	If Not $pUnknown Then Return SetError(1, 0, 0)
	Local $sMethods = __Au3Obj_GetMethods($tagInterface)
	Local $aResult
	If $sMethods Then
		$aResult = DllCall($ghAutoItObjectDLL, "idispatch", "CreateWrapperObjectEx", 'ptr', $pUnknown, 'wstr', $sMethods, "bool", $fNoUnknown, "bool", $fCallFree)
	Else
		$aResult = DllCall($ghAutoItObjectDLL, "idispatch", "CreateWrapperObject", 'ptr', $pUnknown, "bool", $fNoUnknown)
	EndIf
	If @error Then Return SetError(2, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_AutoItObject_WrapperCreate

#EndRegion Public UDFs
;--------------------------------------------------------------------------------------------------------------------------------------