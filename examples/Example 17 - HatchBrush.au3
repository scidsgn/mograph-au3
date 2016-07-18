#AutoIt3Wrapper_Run_AU3Check=n
#include <GUIConstants.au3>
#include "..\MoGraphics.au3"

_AutoItObject_Startup()
_GDIPlus_Startup()

$hGUI = GUICreate("Example 17 - HatchBrush", 400, 400)

$cidCtrl1 = GUICtrlCreateLabel("", 10, 150, 380, 40, $SS_BITMAP)

$cidCtrl2 = GUICtrlCreateLabel("", 10, 210, 380, 40, $SS_BITMAP)

GUISetState()

$hGpx = _GDIPlus_GraphicsCreateFromHWND($hGUI)

$oScene1 = _MoGraph_SceneCreate()

$oBg1 = _MoGraph_ShapeCreateRectangle(0, 0, 380, 40, _MoGraph_SolidBrushCreate(255, 255, 255))
_MoGraph_SceneAddObject($oScene1, $oBg1)

$oBgOutline1 = _MoGraph_ShapeCreateRectangle(0, 0, 380, 40, _MoGraph_OutlineCreate(_MoGraph_SolidBrushCreate(180, 180, 180)))
_MoGraph_SceneAddObject($oScene1, $oBgOutline1)

$oProgress1 = _MoGraph_ShapeCreateRectangle(0, 0, _MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(0, 380, 0, 100), 0, 100), 40, _MoGraph_HatchBrushCreate($GDIP_HATCHSTYLE_WIDEUPWARDDIAGONAL, 0, 200, 255, 255, 0, 160, 200, 255))
_MoGraph_SceneAddObject($oScene1, $oProgress1)

$oSettings1 = _MoGraph_GUIControlRendererCreateSettings($cidCtrl1)
$oRenderer1 = _MoGraph_GUIControlRendererCreate($oScene1, $oSettings1)

$oScene2 = _MoGraph_SceneCreate()

$oBg2 = _MoGraph_ShapeCreateRectangle(0, 0, 380, 40, _MoGraph_SolidBrushCreate(255, 255, 255))
_MoGraph_SceneAddObject($oScene2, $oBg2)

$oBgOutline2 = _MoGraph_ShapeCreateRectangle(0, 0, 380, 40, _MoGraph_OutlineCreate(_MoGraph_SolidBrushCreate(180, 180, 180)))
_MoGraph_SceneAddObject($oScene2, $oBgOutline2)

$oProgress2 = _MoGraph_ShapeCreateRectangle(_MoGraph_TimeLoopCreate(_MoGraph_EaseValueCreate(-150, 380, 0, 150), 0, 150), 0, 150, 40, _MoGraph_HatchBrushCreate($GDIP_HATCHSTYLE_LIGHTUPWARDDIAGONAL, 0, 200, 255, 255, 0, 160, 200, 255))
_MoGraph_SceneAddObject($oScene2, $oProgress2)

$oSettings2 = _MoGraph_GUIControlRendererCreateSettings($cidCtrl2)
$oRenderer2 = _MoGraph_GUIControlRendererCreate($oScene2, $oSettings2)

While 1
	_MoGraph_RendererRenderFrameNext($oRenderer1)
	_MoGraph_RendererRenderFrameNext($oRenderer2)

	Switch GUIGetMsg()
		Case -3
			ExitLoop
	EndSwitch
WEnd

_GDIPlus_GraphicsDispose($hGpx)

_GDIPlus_Shutdown()
_AutoItObject_Shutdown()
