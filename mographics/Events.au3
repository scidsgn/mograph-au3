#include-once

#Region Event

Func _MoGraph_EventCreate($fnFuncName, $iEventType, $oEventOpts = _MoGraph_EventOptionsCreate())
	Local $oEvent = _AutoItObject_Create()

	_AutoItObject_AddProperty($oEvent, "type", $ELSCOPE_PUBLIC, $iEventType)
	_AutoItObject_AddProperty($oEvent, "opts", $ELSCOPE_PUBLIC, $oEventOpts)
	_AutoItObject_AddProperty($oEvent, "hasFired", $ELSCOPE_PUBLIC, 0)

	_AutoItObject_AddMethod($oEvent, "__default__", (IsFunc($fnFuncName) ? FuncName($fnFuncName) : $fnFuncName))

	Return $oEvent
EndFunc

Func _MoGraph_EventHasFired($oEvent)
	Return $oEvent.hasFired
EndFunc

Func _MoGraph_EventGetType($oEvent)
	Return $oEvent.type
EndFunc

Func _MoGraph_EventGetOptions($oEvent)
	Return $oEvent.opts
EndFunc

Func _MoGraph_EventSetOptions($oEvent, $oEventOpts)
	$oEvent.opts = $oEventOpts
EndFunc

#EndRegion

#Region EventOpts

Func _MoGraph_EventOptionsCreate($sName1 = "", $vValue1 = 0, $sName2 = "", $vValue2 = 0, $sName3 = "", $vValue3 = 0, $sName4 = "", $vValue4 = 0, $sName5 = "", $vValue5 = 0, $sName6 = "", $vValue6 = 0, $sName7 = "", $vValue7 = 0, $sName8 = "", $vValue8 = 0)
	Local $oEventOpts = _AutoItObject_Create()

	For $i = 1 To (@NumParams/2)
		$sName = Eval("sName"&$i)
		$vValue = Eval("vValue"&$i)

		_AutoItObject_AddProperty($oEventOpts, $sName, $ELSCOPE_PUBLIC, $vValue)
	Next

	Return $oEventOpts
EndFunc

#EndRegion