' include XGE header file
#LibPath "lib"
#Include "src\sdk\xge.bi"



' Import SDK [develop good classification habits]
#Include "src\sdk\Public.bi"



' Import global define [develop good classification habits]
#Include "src\app\global\Define.bi"
#Include "src\app\global\Module.bi"
#Include "src\app\global\Language.bi"



' Import object class [develop good classification habits]
#Include "src\app\class\Class_Ammo.bi"
#Include "src\app\class\Class_Tank.bi"
#Include "src\app\class\Class_Map.bi"
#Include "src\app\class\Class_Game.bi"



' Import scene [develop good classification habits]
#Include "src\app\scene\Scene_Logo.bi"
#Include "src\app\scene\Scene_Pause.bi"
#Include "src\app\scene\Scene_Game.bi"
#Include "src\app\scene\Scene_Menu.bi"



' Import Game Controller
#Include "src\app\Game.bi"



' Application Entry Point
AppInit()
AppUint()
