' include XGE header file
#LibPath "..\..\..\library"
#Include "..\..\..\include\xge.bi"



' Init xywh Game Engine
xge.InitW(640, 480, XGE_INIT_WINDOW Or XGE_INIT_ALPHA, "XGE - Draw Image")

' load image
Dim pic1 As xge.Surface Ptr = New xge.Surface("..\..\..\res\1.bmp", 0)
Dim back As xge.Surface Ptr = New xge.Surface("..\..\..\res\back.xgi", 0)

' draw Background
back->Draw(NULL, 0, 0)

' The first line is drawn in trans and pset mode
' Trans mode will remove the mask color from the original image [&HFFFF00FF]
' PSet mode draws the original picture completely, covering the target area
pic1->DrawEx_Trans(NULL, 10, 100, 0, 0, 32, 48)
pic1->DrawEx_Trans(NULL, 110, 100, 32, 0, 32, 48)
pic1->DrawEx_PSet(NULL, 500, 100, 64, 0, 32, 48)
pic1->DrawEx_PSet(NULL, 600, 100, 96, 0, 32, 48)
' The second line is drawn using ADD, AND, OR, XOR
' Add mode is suitable for light effects
' And mode is used to remove part of the color from the target position
' Or mode is used to add parts to the target location
' Xor mode is used to display or eliminate the same pixels as the original image
pic1->DrawEx_Add(NULL, 10, 200, 0, 48, 32, 48)
pic1->DrawEx_And(NULL, 110, 200, 32, 48, 32, 48)
pic1->DrawEx_Or(NULL, 500, 200, 64, 48, 32, 48)
pic1->DrawEx_Xor(NULL, 600, 200, 96, 48, 32, 48)
' The third line uses Alpha blending, the last one uses Alpha channel
pic1->DrawEx_Alpha2(NULL, 10, 300, 0, 96, 32, 48, 64)
pic1->DrawEx_Alpha2(NULL, 110, 300, 32, 96, 32, 48, 128)
pic1->DrawEx_Alpha2(NULL, 500, 300, 64, 96, 32, 48, 192)
pic1->DrawEx_Alpha(NULL, 600, 300, 96, 96, 32, 48)
' The fourth line is drawn using grayscale and mirroring processing
' Mirror processing supports horizontal, vertical and full mirroring
pic1->DrawEx_Gray(NULL, 10, 400, 0, 144, 32, 48)
pic1->DrawEx_Mirr(NULL, 110, 400, 32, 144, 32, 48, XGE_BLEND_MIRR_H)
pic1->DrawEx_Mirr(NULL, 500, 400, 64, 144, 32, 48, XGE_BLEND_MIRR_V)
pic1->DrawEx_Mirr(NULL, 600, 400, 96, 144, 32, 48, XGE_BLEND_MIRR_HV)

' free memory it's a good habit
Delete pic1
Delete back

' wait 5s
Sleep 5000

' release menory by XGE
xge.Unit()
