#AutoIt3Wrapper_Run_AU3Check=n
#include "..\MoGraphics.au3"

_AutoItObject_Startup()
_GDIPlus_Startup()

$hGUI = GUICreate("Example 10 - Time", 400, 400)
GUISetState()

$hGpx = _GDIPlus_GraphicsCreateFromHWND($hGUI)

$oScene = _MoGraph_SceneCreate()

$oOutline = _MoGraph_OutlineCreate(0, 8)

$oValue = _MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(0, 360, 0, 100), 0, 100)

$oArc1 = _MoGraph_ShapeCreateArc(20, 20, 100, 100, $oValue, 60, $oOutline)
_MoGraph_SceneAddObject($oScene, $oArc1)

$oLabel1 = _MoGraph_TextCreate("No transformation", 20, 130)
_MoGraph_SceneAddObject($oScene, $oLabel1)

$oArc2 = _MoGraph_ShapeCreateArc(140, 20, 100, 100, _MoGraph_TimeTransformCreate($oValue, 0, 2), 60, $oOutline)
_MoGraph_SceneAddObject($oScene, $oArc2)

$oLabel2 = _MoGraph_TextCreate("2x faster", 140, 130)
_MoGraph_SceneAddObject($oScene, $oLabel2)

$oArc3 = _MoGraph_ShapeCreateArc(260, 20, 100, 100, _MoGraph_TimeTransformCreate($oValue, 0, 0.5), 60, $oOutline)
_MoGraph_SceneAddObject($oScene, $oArc3)

$oLabel3 = _MoGraph_TextCreate("2x slower", 260, 130)
_MoGraph_SceneAddObject($oScene, $oLabel3)

$oSettings = _MoGraph_GraphicsRendererCreateSettings($hGpx, 400, 400, 0xFFFFFFFF)
$oRenderer = _MoGraph_GraphicsRendererCreate($oScene, $oSettings)

While 1
	_MoGraph_RendererRenderFrameNext($oRenderer)

	Switch GUIGetMsg()
		Case -3
			ExitLoop
	EndSwitch
WEnd

_GDIPlus_GraphicsDispose($hGpx)

_GDIPlus_Shutdown()
_AutoItObject_Shutdown()
