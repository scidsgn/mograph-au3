#include-once

Func _MoGraph_ObjectCreate($aProperties, $fnRenderingFunction)
	Local $oObject = _AutoItObject_Create()

	For $i = 0 To (UBound($aProperties)-1)
		$vValue = $aProperties[$i][1]

		If UBound($aProperties, 2) = 3 And $aProperties[$i][2] And IsNumber($vValue) Then
			$vValue = _MoGraph_StaticValueCreate($vValue)
		EndIf

		_AutoItObject_AddProperty($oObject, $aProperties[$i][0], $ELSCOPE_PUBLIC, $vValue)
	Next

	_AutoItObject_AddProperty($oObject, "uid", $ELSCOPE_PUBLIC, $__g_MOGRAPH_OBJECTID)
	$__g_MOGRAPH_OBJECTID += 1

	_AutoItObject_AddMethod($oObject, "render", (IsFunc($fnRenderingFunction) ? FuncName($fnRenderingFunction) : $fnRenderingFunction))

	Return $oObject
EndFunc

Func _MoGraph_ObjectRender($oObject, $hGraphics, $iTime)
	$oObject.render($hGraphics, $iTime)
EndFunc

Func _MoGraph_ObjectGetId($oObject)
	Return $oObject.uid
EndFunc