#AutoIt3Wrapper_Run_AU3Check=n
#include <GUIConstants.au3>
#include "..\MoGraphics.au3"

_AutoItObject_Startup()
_GDIPlus_Startup()

$hGUI = GUICreate("Example 7 - LayeredWindowRenderer", 400, 400, -1, -1, $WS_POPUP, $WS_EX_LAYERED)
GUIRegisterMsg($WM_NCHITTEST, "WM_NCHITTEST")
GUISetState()

$oScene = _MoGraph_SceneCreate()

$oRotate = _MoGraph_TransformCreateRotate(_MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(0, 179, 0, 100), 0, 100))
_MoGraph_SceneAddObject($oScene, $oRotate)

$oTranslate = _MoGraph_TransformCreateTranslate(200, 200)
_MoGraph_SceneAddObject($oScene, $oTranslate)

$oOutline = _MoGraph_OutlineCreate(0, 6)
$oOutline2 = _MoGraph_OutlineCreate(_MoGraph_SolidBrushCreate(0, 0, 0, _MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(255, 0, 0, 60), 0, 100)), _MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(6, 0, 0, 60), 0, 100))

$oEllipse = _MoGraph_ShapeCreateEllipse(-200, -200, 400, 400, _MoGraph_SolidBrushCreate(255, 255, 255, 150))
_MoGraph_SceneAddObject($oScene, $oEllipse)

$oEllipseOutline = _MoGraph_ShapeCreateEllipse(-200, -200, 400, 400, _MoGraph_OutlineCreate())
_MoGraph_SceneAddObject($oScene, $oEllipseOutline)

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

$oSettings = _MoGraph_LayeredWindowRendererCreateSettings($hGUI)
$oRenderer = _MoGraph_LayeredWindowRendererCreate($oScene, $oSettings)

While 1
	_MoGraph_RendererRenderFrameNext($oRenderer)

	Switch GUIGetMsg()
		Case -3
			ExitLoop
	EndSwitch
WEnd

_GDIPlus_Shutdown()
_AutoItObject_Shutdown()

Func WM_NCHITTEST($hWnd, $iMsg, $iParam, $lParam)
	#forceref $hWnd, $iMsg, $iParam, $lParam
	Return $HTCAPTION
EndFunc
