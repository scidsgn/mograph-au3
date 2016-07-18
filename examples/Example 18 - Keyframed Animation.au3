#AutoIt3Wrapper_Run_AU3Check=n
#include "..\MoGraphics.au3"

_AutoItObject_Startup()
_GDIPlus_Startup()

$hGUI = GUICreate("Example 18 - Keyframed Animation", 400, 400)
GUISetState()

$hGpx = _GDIPlus_GraphicsCreateFromHWND($hGUI)

$oScene = _MoGraph_SceneCreate()

Global $aKeyframes[4][2] = [[0, 10], [25, 370], [50, 10], [100, 370]]

$oEllipse = _MoGraph_ShapeCreateEllipse(_MoGraph_KeyframedValueCreate($aKeyframes), _MoGraph_EaseValueCreate(10, 370, 0, 100), 20, 20)
_MoGraph_SceneAddObject($oScene, $oEllipse)

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
