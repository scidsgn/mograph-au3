#include-once

#Region ClipRect

Func _MoGraph_ClipCreateRect($vX, $vY, $vWidth, $vHeight)
	Local $aProps = [["x", $vX, 1], ["y", $vY, 1], ["width", $vWidth, 1], ["height", $vHeight, 1]]
	Return _MoGraph_ObjectCreate($aProps, __MoGraph_ClipRectRender)
EndFunc

Func __MoGraph_ClipRectRender($oObject, $hGraphics, $iTime)
	_GDIPlus_GraphicsSetClipRect($hGraphics, ($oObject.x)($iTime), ($oObject.y)($iTime), ($oObject.width)($iTime), ($oObject.height)($iTime))
EndFunc

#EndRegion
