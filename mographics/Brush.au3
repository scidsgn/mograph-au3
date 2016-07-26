#include-once

#Region Outline

Func _MoGraph_OutlineCreate($vBrush = 0, $vWidth = 1)
	Local $oValue = _AutoItObject_Create()

	_AutoItObject_AddProperty($oValue, "isOutline", $ELSCOPE_PUBLIC, 1)

	_AutoItObject_AddProperty($oValue, "brush", $ELSCOPE_PUBLIC, ($vBrush = 0) ? _MoGraph_SolidBrushCreate() : $vBrush)
	_AutoItObject_AddProperty($oValue, "width", $ELSCOPE_PUBLIC, IsNumber($vWidth) ? _MoGraph_StaticValueCreate($vWidth) : $vWidth)

	_AutoItObject_AddProperty($oValue, "tempGdipHandle", $ELSCOPE_PUBLIC, 0)

	_AutoItObject_AddMethod($oValue, "__default__", "_MoGraph_OutlineGetGdipHandle")

	Return $oValue
EndFunc

Func _MoGraph_OutlineGetGdipHandle($oOutline, $iTime)
	Local $hBrush = ($oOutline.brush)($iTime)
	$oOutline.tempGdipHandle = _GDIPlus_PenCreate2($hBrush, ($oOutline.width)($iTime))
	_GDIPlus_BrushDispose($oOutline.brush.tempGdipHandle)
	Return $oOutline.tempGdipHandle
EndFunc

#EndRegion

#Region Solid Brush

Func _MoGraph_SolidBrushCreate($vRed = 0, $vGreen = 0, $vBlue = 0, $vAlpha = 255)
	Local $oValue = _AutoItObject_Create()

	_AutoItObject_AddProperty($oValue, "isOutline", $ELSCOPE_PUBLIC, 0)

	_AutoItObject_AddProperty($oValue, "red", $ELSCOPE_PUBLIC, IsNumber($vRed) ? _MoGraph_StaticValueCreate($vRed) : $vRed)
	_AutoItObject_AddProperty($oValue, "green", $ELSCOPE_PUBLIC, IsNumber($vGreen) ? _MoGraph_StaticValueCreate($vGreen) : $vGreen)
	_AutoItObject_AddProperty($oValue, "blue", $ELSCOPE_PUBLIC, IsNumber($vBlue) ? _MoGraph_StaticValueCreate($vBlue) : $vBlue)
	_AutoItObject_AddProperty($oValue, "alpha", $ELSCOPE_PUBLIC, IsNumber($vAlpha) ? _MoGraph_StaticValueCreate($vAlpha) : $vAlpha)

	_AutoItObject_AddProperty($oValue, "tempGdipHandle", $ELSCOPE_PUBLIC, 0)

	_AutoItObject_AddMethod($oValue, "__default__", "_MoGraph_SolidBrushGetGdipHandle")

	Return $oValue
EndFunc

Func _MoGraph_SolidBrushGetGdipHandle($oBrush, $iTime)
	Local $iColor = BitOR(Int(($oBrush.blue)($iTime)), BitShift(Int(($oBrush.green)($iTime)), -8), BitShift(Int(($oBrush.red)($iTime)), -16), BitShift(Int(($oBrush.alpha)($iTime)), -24))
	$oBrush.tempGdipHandle =  _GDIPlus_BrushCreateSolid($iColor)
	Return $oBrush.tempGdipHandle
EndFunc

#EndRegion

#Region Hatch Brush

Func _MoGraph_HatchBrushCreate($iHatchType = 0, $vRed = 0, $vGreen = 0, $vBlue = 0, $vAlpha = 255, $vRed2 = 255, $vGreen2 = 255, $vBlue2 = 255, $vAlpha2 = 255)
	Local $oValue = _AutoItObject_Create()

	_AutoItObject_AddProperty($oValue, "isOutline", $ELSCOPE_PUBLIC, 0)

	_AutoItObject_AddProperty($oValue, "hatch", $ELSCOPE_PUBLIC, $iHatchType)

	_AutoItObject_AddProperty($oValue, "red", $ELSCOPE_PUBLIC, IsNumber($vRed) ? _MoGraph_StaticValueCreate($vRed) : $vRed)
	_AutoItObject_AddProperty($oValue, "green", $ELSCOPE_PUBLIC, IsNumber($vGreen) ? _MoGraph_StaticValueCreate($vGreen) : $vGreen)
	_AutoItObject_AddProperty($oValue, "blue", $ELSCOPE_PUBLIC, IsNumber($vBlue) ? _MoGraph_StaticValueCreate($vBlue) : $vBlue)
	_AutoItObject_AddProperty($oValue, "alpha", $ELSCOPE_PUBLIC, IsNumber($vAlpha) ? _MoGraph_StaticValueCreate($vAlpha) : $vAlpha)

	_AutoItObject_AddProperty($oValue, "red2", $ELSCOPE_PUBLIC, IsNumber($vRed2) ? _MoGraph_StaticValueCreate($vRed2) : $vRed2)
	_AutoItObject_AddProperty($oValue, "green2", $ELSCOPE_PUBLIC, IsNumber($vGreen2) ? _MoGraph_StaticValueCreate($vGreen2) : $vGreen2)
	_AutoItObject_AddProperty($oValue, "blue2", $ELSCOPE_PUBLIC, IsNumber($vBlue2) ? _MoGraph_StaticValueCreate($vBlue2) : $vBlue2)
	_AutoItObject_AddProperty($oValue, "alpha2", $ELSCOPE_PUBLIC, IsNumber($vAlpha2) ? _MoGraph_StaticValueCreate($vAlpha2) : $vAlpha2)

	_AutoItObject_AddProperty($oValue, "tempGdipHandle", $ELSCOPE_PUBLIC, 0)

	_AutoItObject_AddMethod($oValue, "__default__", "_MoGraph_HatchBrushGetGdipHandle")

	Return $oValue
EndFunc

Func _MoGraph_HatchBrushGetGdipHandle($oBrush, $iTime)
	Local $iColor1 = BitOR(Int(($oBrush.blue)($iTime)), BitShift(Int(($oBrush.green)($iTime)), -8), BitShift(Int(($oBrush.red)($iTime)), -16), BitShift(Int(($oBrush.alpha)($iTime)), -24))
	Local $iColor2 = BitOR(Int(($oBrush.blue2)($iTime)), BitShift(Int(($oBrush.green2)($iTime)), -8), BitShift(Int(($oBrush.red2)($iTime)), -16), BitShift(Int(($oBrush.alpha2)($iTime)), -24))
	$oBrush.tempGdipHandle =  _GDIPlus_HatchBrushCreate($oBrush.hatch, $iColor1, $iColor2)
	Return $oBrush.tempGdipHandle
EndFunc

#EndRegion

#Region LineBrush

Func _MoGraph_LineBrushCreate($iX1 = 0, $iY1 = 0, $iX2 = 100, $iY2 = 0, $vRed = 0, $vGreen = 0, $vBlue = 0, $vAlpha = 255, $vRed2 = 255, $vGreen2 = 255, $vBlue2 = 255, $vAlpha2 = 255)
	Local $oValue = _AutoItObject_Create()

	_AutoItObject_AddProperty($oValue, "isOutline", $ELSCOPE_PUBLIC, 0)

	_AutoItObject_AddProperty($oValue, "x1", $ELSCOPE_PUBLIC, IsNumber($iX1) ? _MoGraph_StaticValueCreate($iX1) : $iX1)
	_AutoItObject_AddProperty($oValue, "x2", $ELSCOPE_PUBLIC, IsNumber($iX2) ? _MoGraph_StaticValueCreate($iX2) : $iX2)
	_AutoItObject_AddProperty($oValue, "y1", $ELSCOPE_PUBLIC, IsNumber($iY1) ? _MoGraph_StaticValueCreate($iY1) : $iY1)
	_AutoItObject_AddProperty($oValue, "y2", $ELSCOPE_PUBLIC, IsNumber($iY2) ? _MoGraph_StaticValueCreate($iY2) : $iY2)

	_AutoItObject_AddProperty($oValue, "red", $ELSCOPE_PUBLIC, IsNumber($vRed) ? _MoGraph_StaticValueCreate($vRed) : $vRed)
	_AutoItObject_AddProperty($oValue, "green", $ELSCOPE_PUBLIC, IsNumber($vGreen) ? _MoGraph_StaticValueCreate($vGreen) : $vGreen)
	_AutoItObject_AddProperty($oValue, "blue", $ELSCOPE_PUBLIC, IsNumber($vBlue) ? _MoGraph_StaticValueCreate($vBlue) : $vBlue)
	_AutoItObject_AddProperty($oValue, "alpha", $ELSCOPE_PUBLIC, IsNumber($vAlpha) ? _MoGraph_StaticValueCreate($vAlpha) : $vAlpha)

	_AutoItObject_AddProperty($oValue, "red2", $ELSCOPE_PUBLIC, IsNumber($vRed2) ? _MoGraph_StaticValueCreate($vRed2) : $vRed2)
	_AutoItObject_AddProperty($oValue, "green2", $ELSCOPE_PUBLIC, IsNumber($vGreen2) ? _MoGraph_StaticValueCreate($vGreen2) : $vGreen2)
	_AutoItObject_AddProperty($oValue, "blue2", $ELSCOPE_PUBLIC, IsNumber($vBlue2) ? _MoGraph_StaticValueCreate($vBlue2) : $vBlue2)
	_AutoItObject_AddProperty($oValue, "alpha2", $ELSCOPE_PUBLIC, IsNumber($vAlpha2) ? _MoGraph_StaticValueCreate($vAlpha2) : $vAlpha2)

	_AutoItObject_AddProperty($oValue, "tempGdipHandle", $ELSCOPE_PUBLIC, 0)

	_AutoItObject_AddMethod($oValue, "__default__", "_MoGraph_LineBrushGetGdipHandle")

	Return $oValue
EndFunc

Func _MoGraph_LineBrushGetGdipHandle($oBrush, $iTime)
	Local $iColor1 = BitOR(Int(($oBrush.blue)($iTime)), BitShift(Int(($oBrush.green)($iTime)), -8), BitShift(Int(($oBrush.red)($iTime)), -16), BitShift(Int(($oBrush.alpha)($iTime)), -24))
	Local $iColor2 = BitOR(Int(($oBrush.blue2)($iTime)), BitShift(Int(($oBrush.green2)($iTime)), -8), BitShift(Int(($oBrush.red2)($iTime)), -16), BitShift(Int(($oBrush.alpha2)($iTime)), -24))
	$oBrush.tempGdipHandle =  _GDIPlus_LineBrushCreate(($oBrush.x1)($iTime), ($oBrush.y1)($iTime), ($oBrush.x2)($iTime), ($oBrush.y2)($iTime), $iColor1, $iColor2)
	Return $oBrush.tempGdipHandle
EndFunc

#EndRegion
