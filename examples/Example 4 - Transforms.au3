#AutoIt3Wrapper_Run_AU3Check=n
#include "..\MoGraphics.au3"

_AutoItObject_Startup()
_GDIPlus_Startup()

$hGUI = GUICreate("Example 4 - Transforms", 400, 400)
GUISetState()

$hGpx = _GDIPlus_GraphicsCreateFromHWND($hGUI)

$oScene = _MoGraph_SceneCreate()

$oRotate = _MoGraph_TransformCreateRotate(_MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(0, 365, 0, 100), 0, 100))
_MoGraph_SceneAddObject($oScene, $oRotate)

$oTranslate = _MoGraph_TransformCreateTranslate(200, 200)
_MoGraph_SceneAddObject($oScene, $oTranslate)

$oRectangle1 = _MoGraph_ShapeCreateRectangle(-50, -50, 20, 20)
_MoGraph_SceneAddObject($oScene, $oRectangle1)

$oRectangle2 = _MoGraph_ShapeCreateRectangle(30, 30, 20, 20)
_MoGraph_SceneAddObject($oScene, $oRectangle2)

$oEllipse1 = _MoGraph_ShapeCreateEllipse(-80, 60, 20, 20)
_MoGraph_SceneAddObject($oScene, $oEllipse1)

$oEllipse2 = _MoGraph_ShapeCreateEllipse(60, -80, 20, 20)
_MoGraph_SceneAddObject($oScene, $oEllipse2)

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
