## xywh Game Engine

This is a game development framework that supports FreeBasic and C++.

Currently only supports Win32 platform, support for Win64 and Linux is already in the pipeline, the future will also support the use of mobile device systems such as Android.

## Advantages

- Open source, the project is currently active, you can work with me to improve it.
- Commercial use is free, licensed under the zlib license, and can be used and modified at will.
- Easy to use, very well packaged for a source code development engine, you can quickly start making games.
- Full functionality, graphic rendering, text rendering, sound playback, network communication, graphic UI, etc.
- Rich in examples, with dozens of sample code, easy to learn.
- Excellent performance, measured to achieve 2-50 times the efficiency of similar graphics engines.
- Two-dimensional coordinates, pixel-based coordinate system, easy to learn and understand.
- Multi-language support: API interface with Unicode and ANSI versions.

## Capabilities

- Graphics rendering: points, lines, rectangles, circles, etc.
- Image rendering: Support PSet, Trans, Alpha, Or, And, Xor, Gray rendering methods, expandable.
- Text rendering: support for typography, ttf, xrf, GDI(windows only), etc.
- Image formats: support BMP, PNG, GIF, JPG, TAG, XGI, etc.
- Device input: support keyboard, mouse, joystick.
- Network: Network module based on IOCP technology, easy to use TCP Server, TCP Client and UDP objects.
- GUI: It has a complete typesetting system. With common element, Easy to extend.
- Scene system: split the game into multiple simple scenes to reduce the development difficulty.
- GDI interaction: support creating GDI layers and drawing images using GDI and GDIPlus.
- File package system: load files directly from file packages (under development)
- Other functions: coordinate system adjustment, view adjustment, screenshot, file reading and writing, etc.

## Other

These functions are concentrated in a smaller DLL (365KB for version 1.1)

The audio part is implemented using BASS.dll, which requires an additional 100KB+ of space.

Very often, smaller means less coupling, fewer errors, and more speed.

## Released Versions

### Ver 1.1 ：
https://github.com/CN-xLeaves/XGE/releases/tag/1.1

### Ver 1.0 ：
https://github.com/CN-xLeaves/XGE/releases/tag/1.0

## Files Structure

+ help project (Help file project directory in chm format)
+ library project (XGE dependent source code and library)
+ release (Content released to the public)
    * examples (Examples of XGE usage)
    * include (Referenced headers)
    * library (Binary files and linked libraries)
    * project (Full project demo with source code for a tank game)
    * res (Resources used in the example)
    * templet (Develop templates, usually copy one and start working)
    * tools (Compiled tools)
+ source (Source code of XGE)
+ tool project (Source code of the tools)
    + FontMaker (xywh Raster Font Generation Tool)
    + image conv (Image format conversion tool)
    + shade tool (Transition animation data generation tool)
+ release.bat (After the XGE source code is compiled, copy them everywhere)

## Compile source code

Use the FreeBasic compiler (my version is 1.07.3), add the compiler directory to the environment variable path (some machines need to reboot after adding environment variables to take effect), and run the Build.bat in the corresponding directory to compile.

If you are using FbEdit for development, it's even easier to compile, just open the corresponding fbp project file and compile.

Each project has only one bas file, and some projects come with an rc file for storing resources, so the source code can be easily compiled using a command like this.

```
fbc.exe -s gui "Game.bas" "Game.rc"
```

## Gallery

![](https://i.postimg.cc/HLSBhdm5/1.png)
![](https://i.postimg.cc/NjqYky7m/3.png)
![](https://i.postimg.cc/HxhvVHPH/7.png)
![](https://i.postimg.cc/JnHTnh8G/2021-01-05-180228.png)
![](https://i.postimg.cc/CxBBzfM8/2.png)
![](https://i.postimg.cc/FHNFQddm/8.png)

## Usage examples

### Hello World:
```
' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"

' Init xywh Game Engine
xge.Init(800, 600, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - Hello World")

' load font
xge.Text.LoadFont("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)
xge.Text.LoadFont("c:\windows\fonts\simsun.ttc", 0)

' change font size
xge.Text.SetFontSize(2, 32)

' draw text
xge.Text.DrawRectA(NULL, 0, 100, 800, 200, !"Hello World\n你好，世界\n\nxywh Game Engine\nUse freebasic to develop", &HFF00, 1, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, 1, 6)
xge.Text.DrawRectA(NULL, 0, 300, 800, 200, !"Hello World\n你好，世界\n\nxywh Game Engine\nUse freebasic to develop", &HFF00, 2, 0, XGE_ALIGN_CENTER Or XGE_ALIGN_MIDDLE, 1, 6)

' wait 5s
Sleep 5000

' release menory by XGE
xge.Unit()
```

### Draw Image:
```
' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"

' Init xywh Game Engine
xge.Init(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - Draw Image")

' load image
' XGE supports loading common file formats
' PNG, JPG, GIF, BMP, TGA and XGI
' XGI format is a compressed image format dedicated to XGE
' It has extremely fast loading speed and reasonable compression ratio (LZ4 compression)
Dim img As xge.Surface Ptr = New xge.Surface("..\..\..\res\back.xgi", 0)

' draw image
img->Draw(0,0)

' free memory it's a good habit
Delete img

' wait 5s
Sleep 5000

' release menory by XGE
xge.Unit()
```

### Play Sound:
```
' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"

' Init xywh Game Engine
xge.Init(640, 480, XGE_INIT_WINDOW, XGE_INIT_ALL, "XGE - Play Sound")

' load font
xge.Text.LoadFont("..\..\..\res\font\xrf\simsun_16px_ucs2.xrf", 0)

' draw text
xge.Text.DrawRectA(NULL, 0, 0, 640, 480, "Press ESC to exit", &HFF00)

' load music
Dim bgm As xge.Sound Ptr = New xge.Sound(XGE_SOUND_STREAM, 0, "..\..\..\res\bgm.mp3")

' play music
bgm->Play()

' Wait, press ESC to exit
Do
   Sleep(15)
Loop Until xge.xInput.KeyStatus(SC_ESCAPE)

' free memory it's a good habit
Delete bgm

' release menory by XGE
xge.Unit()
```

### The above code shows the basic function, which is a sample scenario, excluding the template code is still very simple.
```
' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"

' Scene is an important function of XGE
' With it, you can deal with different scenes in the game more easily
' You don't have to write all the code together or deal with them extra
' The following function is the standard scene processing template
' It only does one thing, that is, it exits the game when the close button in the window is pressed
' So you'll see a black window, but you don't have to exit regularly, or write code and press the key to exit

' Scene function
Function MainScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
   Select Case msg
      Case XGE_MSG_FRAME            ' frame Logic processing
         
      Case XGE_MSG_DRAW            ' draw
         
      Case XGE_MSG_MOUSE_MOVE         ' mouse move
         
      Case XGE_MSG_MOUSE_DOWN         ' mouse down
         
      Case XGE_MSG_MOUSE_UP         ' mouse up
         
      Case XGE_MSG_MOUSE_CLICK      ' mouse click
         
      Case XGE_MSG_MOUSE_DCLICK      ' mouse double click
         
      Case XGE_MSG_MOUSE_WHELL      ' mouse whell
         
      Case XGE_MSG_KEY_DOWN         ' keyboard down
         
      Case XGE_MSG_KEY_UP            ' keyboard up
         
      Case XGE_MSG_KEY_REPEAT         ' keyboard hold
         
      Case XGE_MSG_GOTFOCUS         ' got focus
         
      Case XGE_MSG_LOSTFOCUS         ' lost focus
         
      Case XGE_MSG_MOUSE_ENTER      ' mouse enter
         
      Case XGE_MSG_MOUSE_EXIT         ' mouse leave
         
      Case XGE_MSG_LOADRES         ' load resources
         
      Case XGE_MSG_FREERES         ' unload resources
         
      Case XGE_MSG_CLOSE            ' window closing
         Return -1
   End Select
End Function

' Init xywh Game Engine
xge.Init(800, 600, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, XGE_INIT_ALL, "XGE - Scene")

' Start a scene (40fps)
xge.Scene.Start(@MainScene, 40)

' release menory by XGE
xge.Unit()
```
