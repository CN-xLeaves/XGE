' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Declare class
Namespace xui
	Type ImageView Extends xui.ScrollView
		image As xge.Surface Ptr
		Declare Constructor(sPath As ZString Ptr)
		Declare Destructor()
	End Type
End Namespace



' ScrollView draw event
Sub ImageView_OnDrawView(ele As xui.ImageView Ptr, px As Integer, py As Integer, x As Integer, y As Integer, w As Integer, h As Integer)
	ele->image->DrawEx(ele->DrawBuffer, px, py, x, y, w, h)
End Sub



' ScrollView is a element for secondary development
' and you must improve it before you can use it
' Fortunately, this is not complicated
Namespace xui
	' Constructor and Destructor are used to load and release image
	Constructor ImageView(sPath As ZString Ptr)
		image = New xge.Surface(sPath)
	End Constructor
	Destructor ImageView()
		Delete image
	End Destructor
	
	' Use this function to make your user interface element mass-produce
	Function CreateImageView(iLayoutRuler As Integer = XUI_LAYOUT_RULER_PIXEL, x As Integer = 0, y As Integer = 0, w As Integer = 80, h As Integer = 24, sImagePath As ZString Ptr, sIdentifier As ZString Ptr = NULL) As xui.ImageView Ptr
		Dim ele As xui.ImageView Ptr = New xui.ImageView(sImagePath)
		' Set basic attributes of elements
		ele->InitElement(iLayoutRuler, x, y, w, h, XUI_LAYOUT_COORD, sIdentifier)
		' Set the view size
		ele->View.w = ele->image->Width
		ele->View.h = ele->image->Height
		' Set draw event
		ele->ViewEvent.OnDrawView = Cast(Any Ptr, @ImageView_OnDrawView)
		Return ele
	End Function
End Namespace



' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static As xui.Element Ptr ui
	Static sv As xui.ScrollView Ptr
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
			
			' Create ImageView (ScrollView)
			sv = xui.CreateImageView(, 100, 100, 440, 280, "..\..\..\res\back.bmp")
			
			' Apply layout
			ui->Childs.AddElement(sv)
			xui.LayoutApply()
			
		Case XGE_MSG_FREERES			' unload resources
			xge.Text.RemoveFont(1)
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function



xge.Init(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - XUI ScrollView Element")
xge.Scene.Start(@MainScene, 40)
xge.Unit()
