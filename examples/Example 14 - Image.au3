#AutoIt3Wrapper_Run_AU3Check=n
#include "..\MoGraphics.au3"

_AutoItObject_Startup()
_GDIPlus_Startup()

$hGUI = GUICreate("Example 14 - Image", 640, 360)
GUISetState()

$hGpx = _GDIPlus_GraphicsCreateFromHWND($hGUI)
$hImg = _GDIPlus_ImageLoadFromFile("img.jpg")

$oScene = _MoGraph_SceneCreate()

$oImg = _MoGraph_ImageCreate($hImg, 0, _MoGraph_EaseValueCreate(-200, 0, 0, 50), 640, 360, _MoGraph_EaseValueCreate(0, 255, 0, 50))
_MoGraph_SceneAddObject($oScene, $oImg)

$oSettings = _MoGraph_GraphicsRendererCreateSettings($hGpx, 640, 360, 0xFFFFFFFF)
$oRenderer = _MoGraph_GraphicsRendererCreate($oScene, $oSettings)

While 1
	_MoGraph_RendererRenderFrameNext($oRenderer)

	Switch GUIGetMsg()
		Case -3
			ExitLoop
	EndSwitch
WEnd

_GDIPlus_ImageDispose($hImg)
_GDIPlus_GraphicsDispose($hGpx)

_GDIPlus_Shutdown()
_AutoItObject_Shutdown()
