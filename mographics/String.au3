#include-once

#Region StaticString

Func _MoGraph_StaticStringCreate($sStr)
	Local $oValue = _AutoItObject_Create()

	_AutoItObject_AddProperty($oValue, "value", $ELSCOPE_PUBLIC, $sStr)
	_AutoItObject_AddMethod($oValue, "__default__", "__MoGraph_StaticStringGetValue")

	Return $oValue
EndFunc

Func __MoGraph_StaticStringGetValue($oValue, $iTime = 0)
	Return $oValue.value
EndFunc

#EndRegion

#Region AnimatedString

Func _MoGraph_AnimatedStringCreate($sStr, $iStart, $iEnd, $iType = $MOGRAPH_TXTANIM_LEFTTORIGHT)
	Local $oValue = _AutoItObject_Create()

	_AutoItObject_AddProperty($oValue, "value", $ELSCOPE_PUBLIC, $sStr)
	_AutoItObject_AddProperty($oValue, "start", $ELSCOPE_PUBLIC, $iStart)
	_AutoItObject_AddProperty($oValue, "end", $ELSCOPE_PUBLIC, $iEnd)
	_AutoItObject_AddProperty($oValue, "type", $ELSCOPE_PUBLIC, $iType)
	_AutoItObject_AddMethod($oValue, "__default__", "__MoGraph_AnimatedStringGetValue")

	Return $oValue
EndFunc

Func __MoGraph_AnimatedStringGetValue($oValue, $iTime = 0)
	Local $fEase = (_MoGraph_EaseValueCreate(0, 1, $oValue.start, $oValue.end))($iTime)
	Local $sStr = $oValue.value

	Switch $oValue.type
		Case $MOGRAPH_TXTANIM_LEFTTORIGHT
			$sStr = StringLeft($sStr, $fEase*StringLen($sStr))
		Case $MOGRAPH_TXTANIM_RIGHTTOLEFT
			$sStr = StringRight($sStr, $fEase*StringLen($sStr))
		Case $MOGRAPH_TXTANIM_RANDOMLTR
			$iChars = Round($fEase*StringLen($sStr))
			$sNewStr = StringLeft($sStr, $iChars)

			For $i = $iChars To StringLen($sStr)-1
				$sNewStr &= ChrW(Random(0x41, 0x7A, 1))
			Next

			$sStr = $sNewStr
		Case $MOGRAPH_TXTANIM_RANDOMRTL
			$sNewStr = ""
			$iChars = StringLen($sStr) - Round($fEase*StringLen($sStr))

			For $i = 1 To $iChars
				$sNewStr &= ChrW(Random(0x41, 0x7A, 1))
			Next
			$sNewStr &= StringRight($sStr, StringLen($sStr) - $iChars)

			$sStr = $sNewStr
	EndSwitch

	Return $sStr
EndFunc

#EndRegion