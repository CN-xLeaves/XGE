' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



Dim Shared As xui.LineEdit Ptr txtUserName, txtPassWord



' Scene function
Function GameScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static img As xge.Surface Ptr
	Select Case msg
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			img->Draw(NULL, 0, 0)
		Case XGE_MSG_LOADRES			' load resources
			img = New xge.Surface("..\..\..\res\back.bmp", 0)
		Case XGE_MSG_FREERES			' unload resources
			Delete img
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



' button click events
Sub btnLogin_OnClick(ele As xui.Button Ptr)
	If wcscmp(txtUserName->Text, A2W("admin")) = 0 Then
		If wcscmp(txtPassWord->Text, A2W("admin")) = 0 Then
			xge.Scene.Cut(@GameScene, 40)
			Return
		EndIf
	EndIf
	MessageBox(xge.hWnd, "Login fail!", "XGE", MB_ICONERROR)
End Sub

Sub btnClose_OnClick(ele As xui.Button Ptr)
	xge.Scene.StopAll()
End Sub

' Line Edit events
Sub txtUserName_OnTab(ele As xui.LineEdit Ptr)
	xui.ActiveElement(txtPassWord)
End Sub

Sub txtPassWord_OnTab(ele As xui.LineEdit Ptr)
	xui.ActiveElement(txtUserName)
End Sub



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui
	Static As xui.Window Ptr winLogin
	Static As xui.Label Ptr labUserName, labPassWord
	Static As xui.Button Ptr btnLogin, btnClose
	Static As xui.Image Ptr imgBanner
	Static As xge.Surface Ptr banner, imgBack
	Select Case msg
		Case XGE_MSG_FRAME				' frame Logic processing
			
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			imgBack->Draw(NULL, 0, 0)
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
			xge.Text.LoadFont("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)
			ui = xui.GetRootElement()
			
			' Create window element
			winLogin = xui.CreateBaseWindow(160, 120, 320, 240, XUI_LAYOUT_COORD, "Login Game", &HFFFFFFFF, 2)
			
			' Create image element
			banner = New xge.Surface("..\..\..\res\banner.bmp")
			imgBanner = xui.CreateImage(, 4, 26, 312, 60, banner)
			
			' Create label elements
			labUserName = xui.CreateLabel(, 40, 120, 60, 12, "UserName :")
			labPassWord = xui.CreateLabel(, 40, 150, 60, 12, "PassWord :")
			
			' Create LineEdit elements
			txtUserName = xui.CreateLineEdit(, 110, 116, 170, 20, "")
			txtPassWord = xui.CreatePassWordEdit(, 110, 146, 170, 20, "")
			
			' Disable IME
			txtUserName->EnableIME = FALSE
			
			' Create button elements
			btnLogin = xui.CreateButton(, 70, 192, 80, 24, "Login")
			btnClose = xui.CreateButton(, 170, 192, 80, 24, "Close")
			
			' Apply layout
			winLogin->Childs.AddElement(imgBanner)
			winLogin->Childs.AddElement(labUserName)
			winLogin->Childs.AddElement(labPassWord)
			winLogin->Childs.AddElement(txtUserName)
			winLogin->Childs.AddElement(txtPassWord)
			winLogin->Childs.AddElement(btnLogin)
			winLogin->Childs.AddElement(btnClose)
			ui->Childs.AddElement(winLogin)
			xui.LayoutApply()
			
			' Set events
			txtUserName->Event.OnTab = Cast(Any Ptr, @txtUserName_OnTab)
			txtPassWord->Event.OnTab = Cast(Any Ptr, @txtPassWord_OnTab)
			txtUserName->Event.OnSubmit = Cast(Any Ptr, @txtUserName_OnTab)
			txtPassWord->Event.OnSubmit = Cast(Any Ptr, @btnLogin_OnClick)
			btnLogin->Event.OnClick = Cast(Any Ptr, @btnLogin_OnClick)
			btnClose->Event.OnClick = Cast(Any Ptr, @btnClose_OnClick)
			
			imgBack = New xge.Surface("..\..\..\res\001-Title01.bmp", 0)	
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - GameLogin")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
