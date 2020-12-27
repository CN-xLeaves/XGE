'==================================================================================
	'�� xywh Game Engine ����ͼ����Ⱦģ��
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================



Extern XGE_EXTERNMODULE
	#Ifdef XGE_BUILD_USEOOP
		Namespace xge
			Namespace Shape
	#EndIf
	
	
	' ����
	Sub XGE_EXPORT_Shape_Pixel(x As Integer, y As Integer, c As Integer, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		If sf Then
			PSet sf->img, (x, y), c
		Else
			PSet (x, y), c
		EndIf
	End Sub
	
	' ����
	Sub XGE_EXPORT_Shape_Lines(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		If sf Then
			Line sf->img, (x1,y1)-(x2,y2), c
		Else
			Line (x1,y1)-(x2,y2), c
		EndIf
	End Sub
	
	' ���� [����ָ���������]
	Sub XGE_EXPORT_Shape_LinesEx(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, s As Integer, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		If sf Then
			Line sf->img, (x1,y1)-(x2,y2), c, , s
		Else
			Line (x1,y1)-(x2,y2), c, , s
		EndIf
	End Sub
	
	' ������
	Sub XGE_EXPORT_Shape_Rect(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		If sf Then
			Line sf->img, (x1,y1)-(x2,y2), c, B
		Else
			Line (x1,y1)-(x2,y2), c, B
		EndIf
	End Sub
	
	' ������ [����ָ���������]
	Sub XGE_EXPORT_Shape_RectEx(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, s As Integer, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		If sf Then
			Line sf->img, (x1,y1)-(x2,y2), c, B, s
		Else
			Line (x1,y1)-(x2,y2), c, B, s
		EndIf
	End Sub
	
	' ��������
	Sub XGE_EXPORT_Shape_RectFull(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		If sf Then
			Line sf->img, (x1,y1)-(x2,y2), c, BF
		Else
			Line (x1,y1)-(x2,y2), c, BF
		EndIf
	End Sub
	
	' ��Բ
	Sub XGE_EXPORT_Shape_Circ(x As Integer, y As Integer, r As Integer, c As Integer, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		If sf Then
			Circle sf->img, (x,y), r, c
		Else
			Circle (x,y), r, c
		EndIf
	End Sub
	
	' ��ʵ��Բ
	Sub XGE_EXPORT_Shape_CircFull(x As Integer, y As Integer, r As Integer, c As Integer, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		If sf Then
			Circle sf->img, (x,y), r, c, , , , F
		Else
			Circle (x,y), r, c, , , , F
		EndIf
	End Sub
	
	' ��Բ [����ָ������]
	Sub XGE_EXPORT_Shape_CircEx(x As Integer, y As Integer, r As Integer, c As Integer, a As Single, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		If sf Then
			Circle sf->img, (x,y), r, c, , , a
		Else
			Circle (x,y), r, c, , , a
		EndIf
	End Sub
	
	' ��ʵ��Բ [����ָ������]
	Sub XGE_EXPORT_Shape_CircFullEx(x As Integer, y As Integer, r As Integer, c As Integer, a As Single, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		If sf Then
			Circle sf->img, (x,y), r, c, , , a, F
		Else
			Circle (x,y), r, c, , , a, F
		EndIf
	End Sub
	
	' ��Բ��
	Sub XGE_EXPORT_Shape_CircArc(x As Integer, y As Integer, r As Integer, c As Integer, s As Integer, e As Integer, a As Single, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		If sf Then
			Circle sf->img, (x,y), r, c, (s Mod 360) / 360 * PI * 2, (e Mod 360) / 360 * PI * 2, a
		Else
			Circle (x,y), r, c, (s Mod 360) / 360 * PI * 2, (e Mod 360) / 360 * PI * 2, a
		EndIf
	End Sub
	
	' �����ɫ
	Sub XGE_EXPORT_Shape_Full(x As Integer, y As Integer, c As Integer, f As Integer, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		If sf Then
			Paint sf->img, (x,y), c, f
		Else
			Paint (x,y), c, f
		EndIf
	End Sub
	
	' ���ͼ�� [ʹ��ͼ���ı�]
	Sub XGE_EXPORT_Shape_FullEx(x As Integer, y As Integer, p As ZString Ptr, f As Integer, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		If sf Then
			Paint sf->img, (x,y), *p, f
		Else
			Paint (x,y), *p, f
		EndIf
	End Sub
	
	
	#Ifdef XGE_BUILD_USEOOP
			End Namespace
		End Namespace
	#EndIf
End Extern