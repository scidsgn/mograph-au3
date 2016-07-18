#AutoIt3Wrapper_Run_AU3Check=n
#include "..\MoGraphics.au3"

_AutoItObject_Startup()
_GDIPlus_Startup()

$hGUI = GUICreate("Example 13 - Clipping Rect", 400, 370)
GUISetState()

$hGpx = _GDIPlus_GraphicsCreateFromHWND($hGUI)

$oScene = _MoGraph_SceneCreate()

$oClipRect = _MoGraph_ClipCreateRect(30, 30, 340, 310)
_MoGraph_SceneAddObject($oScene, $oClipRect)

$oRectangle = _MoGraph_ShapeCreateRectangle(0, 0, 400, _MoGraph_EaseValueCreate(0, 370, 0, 30))
_MoGraph_SceneAddObject($oScene, $oRectangle)

$oText = _MoGraph_TextCreate("TEST", -10, _MoGraph_EaseValueCreate(-10, 50, 0, 30), 0, 0, "Segoe UI", 160, 1, _MoGraph_SolidBrushCreate(255, 255, 255))
_MoGraph_SceneAddObject($oScene, $oText)

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
