#include-once

#Region Rectangle

Func _MoGraph_ShapeCreateRectangle($vX, $vY, $vWidth, $vHeight, $vBrush = _MoGraph_SolidBrushCreate())
	Local $aProps = [["x", $vX, 1], ["y", $vY, 1], ["width", $vWidth, 1], ["height", $vHeight, 1], ["brush", $vBrush, 0]]
	Return _MoGraph_ObjectCreate($aProps, __MoGraph_RectangleRender)
EndFunc

Func __MoGraph_RectangleRender($oObject, $hGraphics, $iTime)
	If $oObject.brush.isOutline Then
		_GDIPlus_GraphicsDrawRect($hGraphics, ($oObject.x)($iTime), ($oObject.y)($iTime), ($oObject.width)($iTime), ($oObject.height)($iTime), ($oObject.brush)($iTime))
		_GDIPlus_PenDispose($oObject.brush.tempGdipHandle)
	Else
		_GDIPlus_GraphicsFillRect($hGraphics, ($oObject.x)($iTime), ($oObject.y)($iTime), ($oObject.width)($iTime), ($oObject.height)($iTime), ($oObject.brush)($iTime))
		_GDIPlus_BrushDispose($oObject.brush.tempGdipHandle)
	EndIf
EndFunc

#EndRegion

#Region Ellipse

Func _MoGraph_ShapeCreateEllipse($vX, $vY, $vWidth, $vHeight, $vBrush = _MoGraph_SolidBrushCreate())
	Local $aProps = [["x", $vX, 1], ["y", $vY, 1], ["width", $vWidth, 1], ["height", $vHeight, 1], ["brush", $vBrush, 0]]
	Return _MoGraph_ObjectCreate($aProps, __MoGraph_EllipseRender)
EndFunc

Func __MoGraph_EllipseRender($oObject, $hGraphics, $iTime)
	If $oObject.brush.isOutline Then
		_GDIPlus_GraphicsDrawEllipse($hGraphics, ($oObject.x)($iTime), ($oObject.y)($iTime), ($oObject.width)($iTime), ($oObject.height)($iTime), ($oObject.brush)($iTime))
		_GDIPlus_PenDispose($oObject.brush.tempGdipHandle)
	Else
		_GDIPlus_GraphicsFillEllipse($hGraphics, ($oObject.x)($iTime), ($oObject.y)($iTime), ($oObject.width)($iTime), ($oObject.height)($iTime), ($oObject.brush)($iTime))
		_GDIPlus_BrushDispose($oObject.brush.tempGdipHandle)
	EndIf
EndFunc

#EndRegion

#Region Line

Func _MoGraph_ShapeCreateLine($vX, $vY, $vX2, $vY2, $vOutline = _MoGraph_OutlineCreate())
	Local $aProps = [["x", $vX, 1], ["y", $vY, 1], ["x2", $vX2, 1], ["y2", $vY2, 1], ["outline", $vOutline, 0]]
	Return _MoGraph_ObjectCreate($aProps, __MoGraph_LineRender)
EndFunc

Func __MoGraph_LineRender($oObject, $hGraphics, $iTime)
	If $oObject.outline.isOutline Then
		_GDIPlus_GraphicsDrawLine($hGraphics, ($oObject.x)($iTime), ($oObject.y)($iTime), ($oObject.x2)($iTime), ($oObject.y2)($iTime), ($oObject.outline)($iTime))
		_GDIPlus_PenDispose($oObject.outline.tempGdipHandle)
	EndIf
EndFunc

#EndRegion

#Region Arc

Func _MoGraph_ShapeCreateArc($vX, $vY, $vWidth, $vHeight, $vStartAngle, $vSweepAngle, $vOutline = _MoGraph_OutlineCreate())
	Local $aProps = [["x", $vX, 1], ["y", $vY, 1], ["width", $vWidth, 1], ["height", $vHeight, 1], ["start", $vStartAngle, 1], ["sweep", $vSweepAngle, 1], ["outline", $vOutline, 0]]
	Return _MoGraph_ObjectCreate($aProps, __MoGraph_ArcRender)
EndFunc

Func __MoGraph_ArcRender($oObject, $hGraphics, $iTime)
	If $oObject.outline.isOutline Then
		_GDIPlus_GraphicsDrawArc($hGraphics, ($oObject.x)($iTime), ($oObject.y)($iTime), ($oObject.width)($iTime), ($oObject.height)($iTime), ($oObject.start)($iTime), ($oObject.sweep)($iTime), ($oObject.outline)($iTime))
		_GDIPlus_PenDispose($oObject.outline.tempGdipHandle)
	EndIf
EndFunc

#EndRegion
