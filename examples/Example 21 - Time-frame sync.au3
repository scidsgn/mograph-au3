#AutoIt3Wrapper_Run_AU3Check=n
#include "..\MoGraphics.au3"

_AutoItObject_Startup()
_GDIPlus_Startup()

$hGUI = GUICreate("Example 21 - Time-frame sync", 400, 400)
GUISetState()

$hGpx = _GDIPlus_GraphicsCreateFromHWND($hGUI)

$oScene = _MoGraph_SceneCreate()

$oLabel = _MoGraph_TextCreate("Move the window to see the effect! Also do the same on example 6!", 20, 20)
_MoGraph_SceneAddObject($oScene, $oLabel)

$oRotate = _MoGraph_TransformCreateRotate(_MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(0, 179, 0, 100), 0, 100))
_MoGraph_SceneAddObject($oScene, $oRotate)

$oTranslate = _MoGraph_TransformCreateTranslate(200, 200)
_MoGraph_SceneAddObject($oScene, $oTranslate)

$oOutline = _MoGraph_OutlineCreate(0, 6)
$oOutline2 = _MoGraph_OutlineCreate(_MoGraph_SolidBrushCreate(0, 0, 0, _MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(255, 0, 0, 60), 0, 100)), _MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(6, 0, 0, 60), 0, 100))

$oLine1 = _MoGraph_ShapeCreateLine(40, -20, 40, 20, $oOutline)
_MoGraph_SceneAddObject($oScene, $oLine1)

$oLine1Fade = _MoGraph_ShapeCreateLine(_MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(40, 140, 0, 60), 0, 100), _MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(-20, -40, 0, 60), 0, 100), _MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(40, 140, 0, 60), 0, 100), _MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(20, 40, 0, 60), 0, 100), $oOutline2)
_MoGraph_SceneAddObject($oScene, $oLine1Fade)

$oLine2 = _MoGraph_ShapeCreateLine(-40, -20, -40, 20, $oOutline)
_MoGraph_SceneAddObject($oScene, $oLine2)

$oLine2Fade = _MoGraph_ShapeCreateLine(_MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(-40, -140, 0, 60), 0, 100), _MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(-20, -40, 0, 60), 0, 100), _MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(-40, -140, 0, 60), 0, 100), _MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(20, 40, 0, 60), 0, 100), $oOutline2)
_MoGraph_SceneAddObject($oScene, $oLine2Fade)

$oLine3 = _MoGraph_ShapeCreateLine(-20, -40, 20, -40, $oOutline)
_MoGraph_SceneAddObject($oScene, $oLine3)

$oLine4 = _MoGraph_ShapeCreateLine(-20, 40, 20, 40, $oOutline)
_MoGraph_SceneAddObject($oScene, $oLine4)

$oSettings = _MoGraph_GraphicsRendererCreateSettings($hGpx, 400, 400, 0xFFFFFFFF)
$oRenderer = _MoGraph_GraphicsRendererCreate($oScene, $oSettings)

_MoGraph_RendererSetFps($oRenderer, 20)

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
