#include-once

#Region Renderer

Func _MoGraph_RendererCreate($oScene, $oRenderSettings, $fnRenderingFunction, $iStartTime = 0)
	Local $oRenderer = _AutoItObject_Create()

	_AutoItObject_AddProperty($oRenderer, "scene", $ELSCOPE_PUBLIC, $oScene)
	_AutoItObject_AddProperty($oRenderer, "time", $ELSCOPE_PUBLIC, $iStartTime)
	_AutoItObject_AddProperty($oRenderer, "settings", $ELSCOPE_PUBLIC, $oRenderSettings)

	_AutoItObject_AddProperty($oRenderer, "timer", $ELSCOPE_PUBLIC, 0)
	_AutoItObject_AddProperty($oRenderer, "fps", $ELSCOPE_PUBLIC, 0)

	_AutoItObject_AddProperty($oRenderer, "events", $ELSCOPE_PUBLIC, LinkedList())

	_AutoItObject_AddProperty($oRenderer, "renderFunc", $ELSCOPE_PUBLIC, (IsFunc($fnRenderingFunction) ? FuncName($fnRenderingFunction) : $fnRenderingFunction))

	_AutoItObject_AddMethod($oRenderer, "render", "__MoGraph_RendererRenderFunc")

	Return $oRenderer
EndFunc

Func _MoGraph_RendererGetFps($oRenderer)
	Return $oRenderer.fps
EndFunc

Func _MoGraph_RendererSetFps($oRenderer, $fFps)
	$oRenderer.fps = $fFps
EndFunc

Func _MoGraph_RendererGetTime($oRenderer)
	Return $oRenderer.time
EndFunc

Func _MoGraph_RendererSetTime($oRenderer, $iTime)
	$oRenderer.time = $iTime
EndFunc

Func _MoGraph_RendererRenderFrame($oRenderer)
	Return $oRenderer.render()
EndFunc

Func _MoGraph_RendererRenderFrameNext($oRenderer)
	Local $vReturn = $oRenderer.render()
	If $oRenderer.fps <> 0 Then
		If $oRenderer.timer = 0 Then
			$oRenderer.timer = TimerInit()
		Else
			$oRenderer.time += (TimerDiff($oRenderer.timer)*$oRenderer.fps)/1000
			$oRenderer.timer = TimerInit()
		EndIf
	Else
		$oRenderer.time += 1
	EndIf

	Return $vReturn
EndFunc

Func _MoGraph_RendererGetScene($oRenderer)
	Return $oRenderer.scene
EndFunc

Func _MoGraph_RendererSetScene($oRenderer, $oScene)
	$oRenderer.scene = $oScene
EndFunc

Func _MoGraph_RendererAddEvent($oRenderer, $oEvent)
	$oRenderer.events.add($oEvent)
	Return $oRenderer.events.count-1
EndFunc

Func _MoGraph_RendererDeleteEvent($oRenderer, $iIndex)
	$oRenderer.events.remove($iIndex)
	Return $oRenderer.events.count
EndFunc

Func __MoGraph_RendererRenderFunc($oRenderer)
	Call($oRenderer.renderFunc, $oRenderer)

	For $oEvent In $oRenderer.events
		Switch $oEvent.type
			Case $MOGRAPH_EV_TIMEEQUAL
				If $oRenderer.time = $oEvent.opts.time Then $oEvent($oEvent.opts, $oRenderer)
			Case $MOGRAPH_EV_TIMELESS
				If $oRenderer.time < $oEvent.opts.time Then $oEvent($oEvent.opts, $oRenderer)
			Case $MOGRAPH_EV_TIMELESSEQUAL
				If $oRenderer.time <= $oEvent.opts.time Then $oEvent($oEvent.opts, $oRenderer)
			Case $MOGRAPH_EV_TIMEGREATER
				If $oRenderer.time > $oEvent.opts.time Then $oEvent($oEvent.opts, $oRenderer)
			Case $MOGRAPH_EV_TIMEGREATEREQUAL
				If $oRenderer.time >= $oEvent.opts.time Then $oEvent($oEvent.opts, $oRenderer)
		EndSwitch
	Next
EndFunc

#EndRegion

#Region GraphicsRenderer

Global $tagMOGRAPH_GRAPHICSRENDERERSETTINGS = "int graphics; int clearColor; int width; int height;"

Func _MoGraph_GraphicsRendererCreate($oScene, $oSettings, $iStartTime = 0)
	Return _MoGraph_RendererCreate($oScene, $oSettings, _MoGraph_GraphicsRendererRender, $iStartTime)
EndFunc

Func _MoGraph_GraphicsRendererRender($oRenderer)
	Local $hBmp = _GDIPlus_BitmapCreateFromScan0($oRenderer.settings.width, $oRenderer.settings.height)
	Local $hGpx = _GDIPlus_ImageGetGraphicsContext($hBmp)
	Local $hBrush = _GDIPlus_BrushCreateSolid($oRenderer.settings.clearColor)
	_GDIPlus_GraphicsFillRect($hGpx, 0, 0, $oRenderer.settings.width, $oRenderer.settings.height, $hBrush)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsSetSmoothingMode($hGpx, 5)
	_GDIPlus_GraphicsSetPixelOffsetMode($hGpx, $GDIP_PIXELOFFSETMODE_HIGHQUALITY)

	$oRenderer.scene.render($hGpx, $oRenderer.time)

	_GDIPlus_GraphicsDispose($hGpx)
	_GDIPlus_GraphicsDrawImage($oRenderer.settings.graphics, $hBmp, 0, 0)
	_GDIPlus_BitmapDispose($hBmp)
EndFunc

Func _MoGraph_GraphicsRendererCreateSettings($hGraphics, $iWidth, $iHeight, $iClearColor = 0xFF000000)
	Local $oSettings = _AutoItObject_DllStructCreate($tagMOGRAPH_GRAPHICSRENDERERSETTINGS)

	$oSettings.graphics = Number($hGraphics)
	$oSettings.width = Number($iWidth)
	$oSettings.height = Number($iHeight)
	$oSettings.clearColor = Number($iClearColor)

	Return $oSettings
EndFunc

#EndRegion

#Region GUIControlRenderer

Global $tagMOGRAPH_GUICONROLRENDERERSETTINGS = "int ctrlId"

Func _MoGraph_GUIControlRendererCreate($oScene, $oSettings, $iStartTime = 0)
	Return _MoGraph_RendererCreate($oScene, $oSettings, _MoGraph_GUIControlRendererRender, $iStartTime)
EndFunc

Func _MoGraph_GUIControlRendererRender($oRenderer)
	Local $hCtrl = GUICtrlGetHandle($oRenderer.settings.ctrlId)
	Local $aSize = WinGetPos($hCtrl)

	Local $hBmp = _GDIPlus_BitmapCreateFromScan0($aSize[2], $aSize[3])
	Local $hGpx = _GDIPlus_ImageGetGraphicsContext($hBmp)
	_GDIPlus_GraphicsSetSmoothingMode($hGpx, 5)
	_GDIPlus_GraphicsSetPixelOffsetMode($hGpx, $GDIP_PIXELOFFSETMODE_HIGHQUALITY)

	$oRenderer.scene.render($hGpx, $oRenderer.time)

	_GDIPlus_GraphicsDispose($hGpx)

	Local $hHBmp = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBmp)
	_WinAPI_DeleteObject(_SendMessage($hCtrl, 0x0172, 0, $hHBmp))
	_WinAPI_DeleteObject($hHBmp)

	_GDIPlus_BitmapDispose($hBmp)
EndFunc

Func _MoGraph_GUIControlRendererCreateSettings($idCtrl)
	Local $oSettings = _AutoItObject_DllStructCreate($tagMOGRAPH_GUICONROLRENDERERSETTINGS)

	$oSettings.ctrlId = Number($idCtrl)

	Return $oSettings
EndFunc

#EndRegion

#Region LayeredWindowRenderer

Global $tagMOGRAPH_LAYEREDWINDOWRENDERERSETTINGS = "hwnd window"

Func _MoGraph_LayeredWindowRendererCreate($oScene, $oSettings, $iStartTime = 0)
	Return _MoGraph_RendererCreate($oScene, $oSettings, _MoGraph_LayeredWindowRendererRender, $iStartTime)
EndFunc

Func _MoGraph_LayeredWindowRendererRender($oRenderer)
	Local $aWndSize = WinGetPos(HWnd($oRenderer.settings.window))
	Local $hBmp = _GDIPlus_BitmapCreateFromScan0($aWndSize[2], $aWndSize[3])
	Local $hGpx = _GDIPlus_ImageGetGraphicsContext($hBmp)
	_GDIPlus_GraphicsSetSmoothingMode($hGpx, 5)
	_GDIPlus_GraphicsSetPixelOffsetMode($hGpx, $GDIP_PIXELOFFSETMODE_HIGHQUALITY)

	$oRenderer.scene.render($hGpx, $oRenderer.time)

	_GDIPlus_GraphicsDispose($hGpx)

	; from AlphaBlend.au3 example
	$hScrDC = _WinAPI_GetDC(0)
	$hMemDC = _WinAPI_CreateCompatibleDC($hScrDC)
	$hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBmp)
	$hOld = _WinAPI_SelectObject($hMemDC, $hBitmap)
	$tSize = DllStructCreate($tagSIZE)
	$pSize = DllStructGetPtr($tSize)
	DllStructSetData($tSize, "X", _GDIPlus_ImageGetWidth($hBmp))
	DllStructSetData($tSize, "Y", _GDIPlus_ImageGetHeight($hBmp))
	$tSource = DllStructCreate($tagPOINT)
	$pSource = DllStructGetPtr($tSource)
	$tBlend = DllStructCreate($tagBLENDFUNCTION)
	$pBlend = DllStructGetPtr($tBlend)
	DllStructSetData($tBlend, "Alpha", 255)
	DllStructSetData($tBlend, "Format", 1)
	_WinAPI_UpdateLayeredWindow(HWnd($oRenderer.settings.window), $hScrDC, 0, $pSize, $hMemDC, $pSource, 0, $pBlend, $ULW_ALPHA)
	_WinAPI_ReleaseDC(0, $hScrDC)
	_WinAPI_SelectObject($hMemDC, $hOld)
	_WinAPI_DeleteObject($hBitmap)
	_WinAPI_DeleteDC($hMemDC)

	_GDIPlus_BitmapDispose($hBmp)
EndFunc

Func _MoGraph_LayeredWindowRendererCreateSettings($hWnd)
	Local $oSettings = _AutoItObject_DllStructCreate($tagMOGRAPH_LAYEREDWINDOWRENDERERSETTINGS)

	$oSettings.window = Number($hWnd)

	Return $oSettings
EndFunc

#EndRegion
