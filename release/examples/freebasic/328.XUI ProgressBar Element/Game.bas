' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui
	Static As xui.ProgressBar Ptr pb1, pb2, pb3
	Select Case msg
		Case XGE_MSG_FRAME				' frame Logic processing
			' Set numerical value
			pb1->Value += 1
			pb2->Value += 1
			pb3->Value += 1
			' When you reach the maximum, start all over again
			If pb1->Value > pb1->Max Then
				pb1->Value = pb1->Min
			EndIf
			If pb2->Value > pb2->Max Then
				pb2->Value = pb2->Min
			EndIf
			If pb3->Value > pb3->Max Then
				pb3->Value = pb3->Min
			EndIf
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			ui->Draw(NULL)
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
			xge.Text.LoadFont("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)
			ui = xui.GetRootElement()
			
			' Create progress bar elements
			pb1 = xui.CreateProgressBar(, 100, 100, 440, 24)
			pb2 = xui.CreateProgressBar(, 100, 200, 440, 24)
			pb3 = xui.CreateProgressBar(, 100, 300, 440, 24)
			
			' Set different text display mode
			pb1->ShowMode = XUI_PROGRESSBAR_HIDE
			pb2->ShowMode = XUI_PROGRESSBAR_PERCENT
			pb3->ShowMode = XUI_PROGRESSBAR_VALUE
			
			' Apply layout
			ui->Childs.AddElement(pb1)
			ui->Childs.AddElement(pb2)
			ui->Childs.AddElement(pb3)
			xui.LayoutApply()
			
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - XUI ProgressBar Element")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
