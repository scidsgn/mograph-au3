#include-once

#Region Text

Func _MoGraph_TextCreate($vString, $vX, $vY, $vWidth = 0, $vHeight = 0, $sFontName = "Arial", $vSize = 12, $iStyle = 0, $vBrush = _MoGraph_SolidBrushCreate(), $iHorzAlign = 0, $iVertAlign = 0)
	Local $aProps = [["str", (IsObj($vString)) ? $vString : _MoGraph_StaticStringCreate($vString), 0], ["x", $vX, 1], ["y", $vY, 1], ["width", $vWidth, 1], ["height", $vHeight, 1], ["font", $sFontName, 0], ["size", $vSize, 1], ["style", $iStyle, 0], ["brush", $vBrush, 0], ["horz", $iHorzAlign, 0], ["vert", $iVertAlign, 0]]
	Return _MoGraph_ObjectCreate($aProps, __MoGraph_TextRender)
EndFunc

Func __MoGraph_TextRender($oObject, $hGraphics, $iTime)
	Local $hFamily = _GDIPlus_FontFamilyCreate($oObject.font)
    Local $tLayout = _GDIPlus_RectFCreate(($oObject.x)($iTime), ($oObject.y)($iTime), ($oObject.width)($iTime), ($oObject.height)($iTime))
	Local $hFormat = _GDIPlus_StringFormatCreate()
	Local $hPath = _GDIPlus_PathCreate()
	_GDIPlus_StringFormatSetAlign($hFormat, $oObject.horz)
	_GDIPlus_StringFormatSetLineAlign($hFormat, $oObject.vert)
	_GDIPlus_PathAddString($hPath, ($oObject.str)($iTime), $tLayout, $hFamily, $oObject.style, ($oObject.size)($iTime), $hFormat)
	If $oObject.brush.isOutline Then
		_GDIPlus_GraphicsDrawPath($hGraphics, $hPath, ($oObject.brush)($iTime))
		_GDIPlus_PenDispose($oObject.brush.tempGdipHandle)
	Else
		_GDIPlus_GraphicsFillPath($hGraphics, $hPath, ($oObject.brush)($iTime))
		_GDIPlus_BrushDispose($oObject.brush.tempGdipHandle)
	EndIf
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_FontFamilyDispose($hFamily)
EndFunc

#EndRegion
