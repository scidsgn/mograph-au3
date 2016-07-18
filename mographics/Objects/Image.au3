#include-once

#Region Image

Func _MoGraph_ImageCreate($hImg, $vX, $vY, $vWidth, $vHeight, $vOpacity = 255)
	Local $aProps = [["bmp", $hImg, 0], ["x", $vX, 1], ["y", $vY, 1], ["width", $vWidth, 1], ["height", $vHeight, 1], ["opacity", $vOpacity, 1]]
	Return _MoGraph_ObjectCreate($aProps, __MoGraph_ImageRender)
EndFunc

Func __MoGraph_ImageRender($oObject, $hGraphics, $iTime)
	$hIA = _GDIPlus_ImageAttributesCreate()
	$tCm = _GDIPlus_ColorMatrixCreateScale(1, 1, 1, ($oObject.opacity)($iTime)/255)
	_GDIPlus_ImageAttributesSetColorMatrix($hIA, 0, True, $tCm)

	_GDIPlus_GraphicsDrawImageRectRect($hGraphics, $oObject.bmp, 0, 0, _GDIPlus_ImageGetWidth($oObject.bmp), _GDIPlus_ImageGetHeight($oObject.bmp),($oObject.x)($iTime), ($oObject.y)($iTime), ($oObject.width)($iTime), ($oObject.height)($iTime), $hIA)

	_GDIPlus_ImageAttributesDispose($hIA)
EndFunc

#EndRegion