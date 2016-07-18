#AutoIt3Wrapper_Run_AU3Check=n
#include "..\MoGraphics.au3"

_AutoItObject_Startup()
_GDIPlus_Startup()

$hGUI = GUICreate("Example 8 - Paragraph Text", 400, 400)
GUISetState()

$hGpx = _GDIPlus_GraphicsCreateFromHWND($hGUI)

$oScene = _MoGraph_SceneCreate()

$oText = _MoGraph_TextCreate("Lorem ipsum dolor sit amet", 10, 10, 380, 0, "Impact", 48, 0)
_MoGraph_SceneAddObject($oScene, $oText)

$oText2 = _MoGraph_TextCreate("Functions in AutoIt are first class objects. Among other things, that means you can assign a function to a variable, pass it around as an argument or return from another function. Aside from certain specific scope-regarding declaration rules (being that the names of the built-in functions are reserved and of UDFs' can be overwritten only locally), the names of functions do not have special status in the language.", 15, 140, 370, 0, "Arial", 18, 0)
_MoGraph_SceneAddObject($oScene, $oText2)

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
