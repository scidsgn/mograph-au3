#include-once

#include <GDIPlus.au3>
#include "LinkedList.au3"
#include "AutoItObject.au3"

; #INDEX# =======================================================================================================================
; Title .........: Motion Graphics UDF
; AutoIt Version : 3.3.14.2
; Language ......: English
; Description ...: Functions for creating animations with GDI+.
; Author(s) .....: scintilla4evr
; ===============================================================================================================================

#include "MoGraphics\Constants.au3"

#include "MoGraphics\Brush.au3"
#include "MoGraphics\Object.au3"
#include "MoGraphics\Renderer.au3"
#include "MoGraphics\Scene.au3"
#include "MoGraphics\Value.au3"
#include "MoGraphics\Events.au3"
#include "MoGraphics\String.au3"
#include "MoGraphics\Transform.au3"

; Objects
#include "MoGraphics\Objects\Transforms.au3"
#include "MoGraphics\Objects\Shapes.au3"
#include "MoGraphics\Objects\Text.au3"
#include "MoGraphics\Objects\Clipping.au3"
#include "MoGraphics\Objects\Image.au3"

Global $__g_MOGRAPH_OBJECTID = 1