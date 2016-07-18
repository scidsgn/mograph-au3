#include-once

Func _MoGraph_SceneCreate()
	Local $oScene = _AutoItObject_Create()

	_AutoItObject_AddProperty($oScene, "objects", $ELSCOPE_PUBLIC, LinkedList())

	_AutoItObject_AddMethod($oScene, "render", "_MoGraph_SceneRender")

	Return $oScene
EndFunc

Func _MoGraph_SceneGetObjectCount($oScene)
	Return $oScene.objects.count
EndFunc

Func _MoGraph_SceneGetObject($oScene, $iIndex)
	Return $oScene.objects.at($iIndex)
EndFunc

Func _MoGraph_SceneGetObjectById($oScene, $iUID)
	For $i = 0 To ($oScene.objects.count-1)
		If ($oScene.objects.at($i)).uid = $iUID Then
			Return $oScene.objects.at($i)
		EndIf
	Next
	Return 0
EndFunc

Func _MoGraph_SceneAddObject($oScene, $oObject)
	$oScene.objects.add($oObject)
	Return $oObject.uid
EndFunc

Func _MoGraph_SceneDeleteObject($oScene, $iIndex)
	$oScene.objects.remove($iIndex)
	Return $oScene.objects.count
EndFunc

Func _MoGraph_SceneDeleteObjectById($oScene, $iUID)
	For $i = 0 To ($oScene.objects.count-1)
		If ($oScene.objects.at($i)).uid = $iUID Then
			$oScene.objects.remove($i)
			ExitLoop
		EndIf
	Next
	Return $oScene.objects.count
EndFunc

Func _MoGraph_SceneRender($oScene, $hGraphics, $iTime)
	For $oObject In $oScene.objects
		$oObject.render($hGraphics, $iTime)
	Next
EndFunc