#include-once

#Region Translate

Func _MoGraph_TransformCreateTranslate($vX, $vY)
	Local $aProps = [["x", $vX, 1], ["y", $vY, 1]]
	Return _MoGraph_ObjectCreate($aProps, __MoGraph_TranslateRender)
EndFunc

Func __MoGraph_TranslateRender($oObject, $hGraphics, $iTime)
	_GDIPlus_GraphicsTranslateTransform($hGraphics, ($oObject.x)($iTime), ($oObject.y)($iTime), 1)
EndFunc

#EndRegion

#Region Scale

Func _MoGraph_TransformCreateScale($vX, $vY)
	Local $aProps = [["x", $vX, 1], ["y", $vY, 1]]
	Return _MoGraph_ObjectCreate($aProps, __MoGraph_ScaleRender)
EndFunc

Func __MoGraph_ScaleRender($oObject, $hGraphics, $iTime)
	_GDIPlus_GraphicsScaleTransform($hGraphics, ($oObject.x)($iTime), ($oObject.y)($iTime), 1)
EndFunc

#EndRegion

#Region Rotate

Func _MoGraph_TransformCreateRotate($vAngle)
	Local $aProps = [["angle", $vAngle, 1]]
	Return _MoGraph_ObjectCreate($aProps, __MoGraph_RotateRender)
EndFunc

Func __MoGraph_RotateRender($oObject, $hGraphics, $iTime)
	_GDIPlus_GraphicsRotateTransform($hGraphics, ($oObject.angle)($iTime), 1)
EndFunc

#EndRegion