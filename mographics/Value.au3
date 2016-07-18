#include-once

#Region TimeLoop ; weird name

Func _MoGraph_TimeLoopCreate($oValueObject, $iStart, $iLength)
	Local $oValue = _AutoItObject_Create()

	_AutoItObject_AddProperty($oValue, "value", $ELSCOPE_PUBLIC, $oValueObject)
	_AutoItObject_AddProperty($oValue, "start", $ELSCOPE_PUBLIC, $iStart)
	_AutoItObject_AddProperty($oValue, "length", $ELSCOPE_PUBLIC, $iLength)
	_AutoItObject_AddMethod($oValue, "__default__", "_MoGraph_TimeLoopGetValue")

	Return $oValue
EndFunc

Func _MoGraph_TimeLoopGetValue($oValue, $iTime = 0)
	Local $iLocalTime = $iTime-$oValue.start
	Local $iOutTime = Mod($iLocalTime, $oValue.length)

	If $iLocalTime < 0 Then $iOutTime = $oValue.length+$iLocalTime

	Return ($oValue.value)($iOutTime)
EndFunc

#EndRegion

#Region TimeTransform

Func _MoGraph_TimeTransformCreate($oValueObject, $iPostOffset = 0, $fScale = 1, $iPreOffset = 0)
	Local $oValue = _AutoItObject_Create()

	_AutoItObject_AddProperty($oValue, "value", $ELSCOPE_PUBLIC, $oValueObject)
	_AutoItObject_AddProperty($oValue, "post", $ELSCOPE_PUBLIC, $iPostOffset)
	_AutoItObject_AddProperty($oValue, "pre", $ELSCOPE_PUBLIC, $iPreOffset)
	_AutoItObject_AddProperty($oValue, "scale", $ELSCOPE_PUBLIC, $fScale)
	_AutoItObject_AddMethod($oValue, "__default__", "_MoGraph_TimeTransformGetValue")

	Return $oValue
EndFunc

Func _MoGraph_TimeTransformGetValue($oValue, $iTime = 0)
	Return ($oValue.value)(($iTime+$oValue.pre)*$oValue.scale + $oValue.post)
EndFunc

#EndRegion

#Region Value

Func _MoGraph_StaticValueCreate($iValue)
	Local $oValue = _AutoItObject_Create()

	_AutoItObject_AddProperty($oValue, "value", $ELSCOPE_PUBLIC, $iValue)
	_AutoItObject_AddMethod($oValue, "__default__", "_MoGraph_StaticValueGetValue")

	Return $oValue
EndFunc

Func _MoGraph_StaticValueGetValue($oValue, $iTime = 0)
	Return $oValue.value
EndFunc

Func _MoGraph_EaseValueCreate($iValueStart, $iValueEnd, $iStart = 0, $iEnd = 100, $oEasing = _MoGraph_LinearEasingCreate())
	Local $oValue = _AutoItObject_Create()

	_AutoItObject_AddProperty($oValue, "startv", $ELSCOPE_PUBLIC, $iValueStart)
	_AutoItObject_AddProperty($oValue, "endv", $ELSCOPE_PUBLIC, $iValueEnd)

	_AutoItObject_AddProperty($oValue, "startt", $ELSCOPE_PUBLIC, $iStart)
	_AutoItObject_AddProperty($oValue, "endt", $ELSCOPE_PUBLIC, $iEnd)

	_AutoItObject_AddProperty($oValue, "easing", $ELSCOPE_PUBLIC, $oEasing)

	_AutoItObject_AddMethod($oValue, "__default__", "_MoGraph_EaseValueGetValue")

	Return $oValue
EndFunc

Func _MoGraph_EaseValueGetValue($oValue, $iTime = 0)
	If $iTime < $oValue.startt Then
		Return $oValue.startv
	ElseIf $iTime > $oValue.endt Then
		Return $oValue.endv
	EndIf

	Local $oEasing = $oValue.easing
	Local $fEase = ($iTime-$oValue.startt)/($oValue.endt-$oValue.startt)

	Return $oValue.startv + ($oValue.endv-$oValue.startv)*($oEasing($fEase))
EndFunc

Func _MoGraph_KeyframedValueCreate($aKeyframes)
	Local $oValue = _AutoItObject_Create()
	Local $i

	_AutoItObject_AddProperty($oValue, "keyframes", $ELSCOPE_PUBLIC, LinkedList())

	If UBound($aKeyframes) < 1 Then Return SetError(1, 0, 0)

	For $i = 0 To (UBound($aKeyframes)-1)
		Local $oKeyframe = _AutoItObject_Create()

		_AutoItObject_AddProperty($oKeyframe, "time", $ELSCOPE_PUBLIC, $aKeyframes[$i][0])
		_AutoItObject_AddProperty($oKeyframe, "value", $ELSCOPE_PUBLIC, $aKeyframes[$i][1])

		$oValue.keyframes.add($oKeyframe)
	Next

	_AutoItObject_AddMethod($oValue, "__default__", "_MoGraph_KeyframedValueGetValue")

	Return $oValue
EndFunc

Func _MoGraph_KeyframedValueGetValue($oValue, $iTime = 0)
	Local $oStart = $oValue.keyframes.at(0)
	Local $oEnd = $oValue.keyframes.at($oValue.keyframes.count-1)

	If $iTime < $oStart.time Then Return $oStart.value
	If $iTime > $oEnd.time Then Return $oEnd.value

	Local $i
	Local $oV1, $oV2
	Local $oEase

	For $i = 0 To ($oValue.keyframes.count-2)
		$oV1 = $oValue.keyframes.at($i)
		$oV2 = $oValue.keyframes.at($i+1)

		If $iTime >= $oV1.time And $iTime <= $oV2.time Then
			$oEase = _MoGraph_EaseValueCreate($oV1.value, $oV2.value, $oV1.time, $oV2.time)
			Return ($oEase)($iTime)
		EndIf
	Next
EndFunc

#EndRegion

#Region Easing

Func _MoGraph_LinearEasingCreate()
	Local $oValue = _AutoItObject_Create()

	_AutoItObject_AddMethod($oValue, "__default__", "_MoGraph_LinearEasingGetEaseValue")

	Return $oValue
EndFunc

Func _MoGraph_LinearEasingGetEaseValue($oEasing, $fTime)
	Return $fTime
EndFunc

Func _MoGraph_ExponentialEasingCreate($fExponent = 1)
	Local $oValue = _AutoItObject_Create()

	_AutoItObject_AddProperty($oValue, "exp", $ELSCOPE_PUBLIC, $fExponent)

	_AutoItObject_AddMethod($oValue, "__default__", "_MoGraph_ExponentialEasingGetEaseValue")

	Return $oValue
EndFunc

Func _MoGraph_ExponentialEasingGetEaseValue($oEasing, $fTime)
	Return $fTime^$oEasing.exp
EndFunc

#EndRegion

#Region OscillatorValue

Func _MoGraph_OscillatorValueCreate($fFrequency = 1, $fAmplitude = 1, $fPhase = 0, $fOffset = 0)
	Local $oValue = _AutoItObject_Create()

	_AutoItObject_AddProperty($oValue, "freq", $ELSCOPE_PUBLIC, $fFrequency)
	_AutoItObject_AddProperty($oValue, "amplitude", $ELSCOPE_PUBLIC, $fAmplitude)
	_AutoItObject_AddProperty($oValue, "phase", $ELSCOPE_PUBLIC, $fPhase)
	_AutoItObject_AddProperty($oValue, "offset", $ELSCOPE_PUBLIC, $fOffset)

	_AutoItObject_AddMethod($oValue, "__default__", "_MoGraph_OscillatorValueGetValue")

	Return $oValue
EndFunc

Func _MoGraph_OscillatorValueGetValue($oValue, $iTime)
	Return Sin($iTime*$oValue.freq + $oValue.phase)*$oValue.amplitude + $oValue.offset
EndFunc

#EndRegion
