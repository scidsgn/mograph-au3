#AutoIt3Wrapper_Run_AU3Check=n
#include "..\MoGraphics.au3"

_AutoItObject_Startup()
_GDIPlus_Startup()

$hGUI = GUICreate("Example 15 - Animated String", 400, 400)
GUISetState()

$hGpx = _GDIPlus_GraphicsCreateFromHWND($hGUI)

$oScene = _MoGraph_SceneCreate()

$oText = _MoGraph_TextCreate(_MoGraph_AnimatedStringCreate("Lorem ipsum dolor", 0, 50, $MOGRAPH_TXTANIM_LEFTTORIGHT), 10, 10, 380, 0, "Impact", 36, 0)
_MoGraph_SceneAddObject($oScene, $oText)

$oText2 = _MoGraph_TextCreate(_MoGraph_AnimatedStringCreate("Lorem ipsum dolor", 0, 50, $MOGRAPH_TXTANIM_RIGHTTOLEFT), 10, 60, 380, 0, "Impact", 36, 0)
_MoGraph_SceneAddObject($oScene, $oText2)

$oText3 = _MoGraph_TextCreate(_MoGraph_AnimatedStringCreate("Lorem ipsum dolor", 0, 50, $MOGRAPH_TXTANIM_RANDOMLTR), 10, 110, 380, 0, "Impact", 36, 0)
_MoGraph_SceneAddObject($oScene, $oText3)

$oText4 = _MoGraph_TextCreate(_MoGraph_AnimatedStringCreate("Lorem ipsum dolor", 0, 50, $MOGRAPH_TXTANIM_RANDOMRTL), 10, 160, 380, 0, "Impact", 36, 0)
_MoGraph_SceneAddObject($oScene, $oText4)

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
