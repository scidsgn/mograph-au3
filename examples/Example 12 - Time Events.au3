#AutoIt3Wrapper_Run_AU3Check=n
#include "..\MoGraphics.au3"

_AutoItObject_Startup()
_GDIPlus_Startup()

$hGUI = GUICreate("Example 12 - Time Events", 400, 400)

$cidCtrl = GUICtrlCreateLabel("", 0, 0, 400, 400)

GUISetState()

$hGpx = _GDIPlus_GraphicsCreateFromHWND($hGUI)

$oScene = _MoGraph_SceneCreate()

$oLabel1 = _MoGraph_TextCreate("Click anywhere"&@CRLF&"Thanks to time events, objects will be removed from the scene after they disappear.", 20, 20, 360)
_MoGraph_SceneAddObject($oScene, $oLabel1)

$oSettings = _MoGraph_GraphicsRendererCreateSettings($hGpx, 400, 400, 0xFFFFFFFF)
$oRenderer = _MoGraph_GraphicsRendererCreate($oScene, $oSettings)

While 1
	_MoGraph_RendererRenderFrameNext($oRenderer)

	WinSetTitle($hGUI, "", "Example 12 - Time Events, object count: "&_MoGraph_SceneGetObjectCount($oScene))

	Switch GUIGetMsg()
		Case -3
			ExitLoop
		Case $cidCtrl
			$cInfo = GUIGetCursorInfo()
			$x = $cInfo[0]
			$y = $cInfo[1]

			$iTime = _MoGraph_RendererGetTime($oRenderer)

			$oEllipse = _MoGraph_ShapeCreateEllipse($x-10, $y-10, 20, 20, _MoGraph_SolidBrushCreate(0, 0, 0, _MoGraph_EaseValueCreate(255, 0, $iTime, $iTime+50)))
			$iEllipseID = _MoGraph_SceneAddObject($oScene, $oEllipse)

			_MoGraph_RendererAddEvent($oRenderer, _MoGraph_EventCreate(_DeleteEllipse, $MOGRAPH_EV_TIMEEQUAL, _MoGraph_EventOptionsCreate("time", $iTime + 50, "objId", $iEllipseID)))
	EndSwitch
WEnd

_GDIPlus_GraphicsDispose($hGpx)

_GDIPlus_Shutdown()
_AutoItObject_Shutdown()

Func _DeleteEllipse($oEvent, $oOptions, $oRenderer)
	_MoGraph_SceneDeleteObjectById($oRenderer.scene, $oOptions.objId)
EndFunc
