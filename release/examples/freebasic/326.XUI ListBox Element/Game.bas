' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' global elements (Because it needs to be accessed outside the scene function)
Dim Shared labEvent As xui.Label Ptr
Dim Shared lb As xui.ListBox Ptr

Dim Shared strEvent As ZString * 256
Dim Shared ListText(100) As ZString * 64



' List select change event
Sub OnSelectChange(ele As xui.ListBox Ptr, iOld As UInteger)
	strEvent = "SelectChange : Pos = " & ele->ListIndex & " (OldPos = " & iOld & !")\nSel Item Text : " & *ele->List.Text(ele->ListIndex)
	labEvent->Text = @strEvent
End Sub

' Remove button click event
Sub btnRemove_OnClick(ele As xui.Button Ptr)
	' Valid item positions start at 1
	If lb->ListIndex > 0 Then
		lb->List.Remove(lb->ListIndex)
	EndIf
End Sub

' Change button click event
Sub btnChange_OnClick(ele As xui.Button Ptr)
	If lb->ListIndex > 0 Then
		Dim text As ZString Ptr = lb->List.Text(lb->ListIndex)
		*text = "Item Text Change"
	EndIf
End Sub



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui
	Static As xui.Button Ptr btnRemove, btnChange
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
			xge.Text.LoadFont("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)
			ui = xui.GetRootElement()
			
			' Create listbox element
			lb = xui.CreateListBox(, 50, 50, 240, 380)
			
			' Create label element (used to show event details)
			labEvent = xui.CreateLabel(, 320, 50, 320, 32, !"Try operate the ListBox\n", &HFF00FF00)
			
			' Create button elements
			btnRemove = xui.CreateButton(, 320, 406, 80, 24, "Remove")
			btnChange = xui.CreateButton(, 420, 406, 80, 24, "Change")
			
			' add list item
			For i As Integer = 1 To 100
				ListText(i) = "List Item ID : " & i
				lb->List.Append(ListText(i))
			Next
			
			' Apply layout
			ui->Childs.AddElement(lb)
			ui->Childs.AddElement(labEvent)
			ui->Childs.AddElement(btnRemove)
			ui->Childs.AddElement(btnChange)
			xui.LayoutApply()
			
			' set events
			lb->Event.OnSelectChange = Cast(Any Ptr, @OnSelectChange)
			btnRemove->Event.OnClick = Cast(Any Ptr, @btnRemove_OnClick)
			btnChange->Event.OnClick = Cast(Any Ptr, @btnChange_OnClick)
			
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - XUI ListBox Element")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
