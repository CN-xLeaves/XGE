' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' global label element (Because it needs to be accessed outside the scene function)
Dim Shared labEvent As xui.Label Ptr
Dim Shared As xui.LineEdit Ptr ed, pw

Dim Shared strEvent As ZString * 256



' Submie event
Sub OnSubmit(ele As Any Ptr)
	strEvent = "Submit : " & *W2A(ed->Text) & !"\n" & *W2A(pw->Text)
	labEvent->Text = @strEvent
End Sub

' Tab event
Sub ed_OnTab(ele As Any Ptr)
	xui.ActiveElement(pw)
End Sub
Sub pw_OnTab(ele As Any Ptr)
	xui.ActiveElement(ed)
End Sub



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui
	Select Case msg
		Case XGE_MSG_FRAME				' frame Logic processing
			
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
			xge.Text.LoadFont("..\..\..\res\font\xrf\simsun_12px_ucs2.xrf", 0)
			ui = xui.GetRootElement()
			
			' Create common line edit element (edit element unicode encoding must be used)
			' This is to take care of many languages, and XGE can support many languages well
			ed = xui.CreateLineEdit(, 100, 100, 440, 20, A2W("default Text"))
			
			' Create password edit element
			pw = xui.CreatePassWordEdit(, 100, 300, 440, 20, A2W("12345678"))
			
			' Create label element
			labEvent = xui.CreateLabel(, 100, 200, 440, 32, !"The floolwing keys are supported: BackSpace, Delete, Left, Right, Home,\nEnd, Enter, Tab, Ctrl + A, Ctrl + X, Ctrl + C, Ctrl + V", &HFF00FF00)
			
			' Apply layout
			ui->Childs.AddElement(ed)
			ui->Childs.AddElement(pw)
			ui->Childs.AddElement(labEvent)
			xui.LayoutApply()
			
			' Set Events
			ed->Event.OnSubmit = Cast(Any Ptr, @OnSubmit)
			pw->Event.OnSubmit = Cast(Any Ptr, @OnSubmit)
			ed->Event.OnTab = Cast(Any Ptr, @ed_OnTab)
			pw->Event.OnTab = Cast(Any Ptr, @pw_OnTab)
			
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - XUI LineEdit Element")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
