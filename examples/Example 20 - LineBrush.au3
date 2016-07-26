#AutoIt3Wrapper_Run_AU3Check=n
#include "..\MoGraphics.au3"

_AutoItObject_Startup()
_GDIPlus_Startup()

$hGUI = GUICreate("Example 20 - LineBrush", 400, 400)
GUISetState()

$hGpx = _GDIPlus_GraphicsCreateFromHWND($hGUI)

$oScene = _MoGraph_SceneCreate()

$oRect = _MoGraph_ShapeCreateRectangle(0, 0, 400, 400, _MoGraph_LineBrushCreate(0, 0, 400, 0, 255, 255, 255, 255, 255, 0, 0, 255))
_MoGraph_SceneAddObject($oScene, $oRect)

$oRect2 = _MoGraph_ShapeCreateRectangle(0, 0, 400, 400, _MoGraph_LineBrushCreate(0, 0, 0, 400, 0, 0, 0, 0, 0, 0, 0, 255))
_MoGraph_SceneAddObject($oScene, $oRect2)

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
