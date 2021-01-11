' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Init xywh Game Engine
xge.Init(640, 480, XGE_INIT_WINDOW, XGE_INIT_ALL, "XGE - Font Driver")

' if you also have a good font renderer, you can integeate it into XGE
' and demonstrate it with GDI here.

' xywh Game Engine hope that developers can use it more simply
' and at the same time they don't lack the ability to expand
' they can't let game developers change the engine because they can't do it

' first, we need to be able to draw at least one character, it
Sub DrawWord_ANSI(fd As xge.Text.FontDriver Ptr, sf As xge.Surface Ptr, px As Integer, py As Integer, w As Integer, h As Integer, iCode As UInteger, iColor As UInteger, Style As Integer)
	' create a gdi image for drawing characters
	Dim img As xge.GdiSurface Ptr = New xge.GdiSurface(100, 100)
	
	' draw text on an image
	img->PrintText(0, 0, 100, 100, "Arial", 32, XGE_ALIGN_LEFT Or XGE_ALIGN_TOP, iColor, Chr(iCode))
	
	' then draw the contents of the image onto the target image
	img->Draw(sf, px, py)
	
	' free memory it's a good habit
	Delete img
End Sub

' then, we want to implement a text size measuring tool
Sub InfoWord_ANSI(fd As xge.Text.FontDriver Ptr, iCode As Integer, Style As Integer, w As Integer Ptr, h As Integer Ptr)
	' this is just a demonstration, so we don't really get the text size and return a fixed value
	*w = 18
	*h = 32
End Sub

' then, we need to define a font loader and add it to XGE.
Function MyFontLoad(fd As xge.Text.FontDriver Ptr, Addr As ZString Ptr, iSize As UInteger, param As Any Ptr) As Integer
	' fd is a font driver pointer
	' addr has multiple meanings. then iSize is 0, it represents the file path of font
	' otherwise it ia a memoty pointer, represents loading font form memory.
	' the images, sounds and fonts used by XGE can be loaded form memory.
	
	' because of GDI, we don't really need to read a font file
	
	' register our functions
	' use Cast to eliminate warnings
	fd->DrawWordA = Cast(Any Ptr, @DrawWord_ANSI)
	fd->WordInfoA = Cast(Any Ptr, @InfoWord_ANSI)
	
	' this is a function that outputs unicode characters, 
	' we didn't implement it, so we replaced it with ansi version
	fd->DrawWord = Cast(Any Ptr, @DrawWord_ANSI)
	fd->WordInfo = Cast(Any Ptr, @DrawWord_ANSI)
	
	' these are unnecessary implementations and can be left blank
	fd->FreeFont = NULL
	fd->DrawLine_Fast = NULL
	fd->DrawLineA_Fast = NULL
	fd->DrawRect_Fast = NULL
	fd->DrawRectA_Fast = NULL
	
	' set the calculation height of font to help XGE typeseting
	fd->HeightInt = 32
	
	' return -1 it means we succeeded
	Return -1
End Function

' Everything is ready, let XGE try the new font loader
xge.Hook.SetFontLoadProc(Cast(Any Ptr, @MyFontLoad))

' create a font, enter as long as the font does not exist, so that the built-in loader cannot work
xge.Text.LoadFont("it's just something that doesn't exist anyway", 0)

' because we didn't pass rhe correct text size, the drawing effect was a bit strange, but it worked well.
xge.Text.DrawA(NULL, 100, 50, "you are very clever!", 0, &HFF00FF00, 1)

' wait 5s
Sleep 5000

' release menory by XGE
xge.Unit()
