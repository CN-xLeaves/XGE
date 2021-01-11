' include XGE header file
#LibPath "lib"
#Include "src\sdk\xge.bi"



' Import SDK [develop good classification habits]
' #Include "src\sdk\xx.bi"



' Import global define [develop good classification habits]
' #Include "src\app\global\mycode.bi"



' Import object class [develop good classification habits]
' #Include "src\app\class\mycode.bi"



' Import scene [develop good classification habits]
' #Include "src\app\scene\mycode.bi"





' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Select Case msg
		Case XGE_MSG_FRAME				' frame Logic processing
			
		Case XGE_MSG_DRAW				' draw
			
		Case XGE_MSG_MOUSE_MOVE			' mouse move
			
		Case XGE_MSG_MOUSE_DOWN			' mouse down
			
		Case XGE_MSG_MOUSE_UP			' mouse up
			
		Case XGE_MSG_MOUSE_CLICK		' mouse click
			
		Case XGE_MSG_MOUSE_DCLICK		' mouse double click
			
		Case XGE_MSG_MOUSE_WHELL		' mouse whell
			
		Case XGE_MSG_KEY_DOWN			' keyboard down
			
		Case XGE_MSG_KEY_UP				' keyboard up
			
		Case XGE_MSG_KEY_REPEAT			' keyboard hold
			
		Case XGE_MSG_GOTFOCUS			' got focus
			
		Case XGE_MSG_LOSTFOCUS			' lost focus
			
		Case XGE_MSG_MOUSE_ENTER		' mouse enter
			
		Case XGE_MSG_MOUSE_EXIT			' mouse leave
			
		Case XGE_MSG_LOADRES			' load resources
			
		Case XGE_MSG_FREERES			' unload resources
			
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



' Init xywh Game Engine
xge.Init(800, 600, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "MyGame - Power By XGE")

' Start a scene (40fps)
xge.Scene.Start(@MainScene, 40)

' release menory by XGE
xge.Unit()
