#AutoIt3Wrapper_Run_AU3Check=n
#include "..\MoGraphics.au3"

_AutoItObject_Startup()
_GDIPlus_Startup()

$hGUI = GUICreate("Example 5 - Brush Animation", 400, 400)
GUISetState()

$hGpx = _GDIPlus_GraphicsCreateFromHWND($hGUI)

$oScene = _MoGraph_SceneCreate()

$oRotate = _MoGraph_TransformCreateRotate(_MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(0, 179, 0, 100), 0, 100))
_MoGraph_SceneAddObject($oScene, $oRotate)

$oTranslate = _MoGraph_TransformCreateTranslate(200, 200)
_MoGraph_SceneAddObject($oScene, $oTranslate)

$oEllipse1 = _MoGraph_ShapeCreateEllipse(-80, 40, 40, 40, _MoGraph_OutlineCreate(_MoGraph_SolidBrushCreate(_MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(0, 255, 0, 100), 0, 100), _MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(255, 0, 0, 100), 0, 100)), _MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(1, 10, 0, 100), 0, 100)))
_MoGraph_SceneAddObject($oScene, $oEllipse1)

$oEllipse2 = _MoGraph_ShapeCreateEllipse(40, -80, 40, 40, _MoGraph_OutlineCreate(_MoGraph_SolidBrushCreate(_MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(255, 0, 0, 100), 0, 100), _MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(0, 255, 0, 100), 0, 100)), _MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(10, 1, 0, 100), 0, 100)))
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
