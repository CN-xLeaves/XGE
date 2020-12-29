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
	Sub XGE_EXPORT_Shape_Pixel(sf As xge.Surface Ptr, x As Integer, y As Integer, c As Integer) XGE_EXPORT_ALL
		If sf Then
			PSet sf->img, (x, y), c
		Else
			PSet (x, y), c
		EndIf
	End Sub
	
	' ����
	Sub XGE_EXPORT_Shape_Lines(sf As xge.Surface Ptr, x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer) XGE_EXPORT_ALL
		If sf Then
			Line sf->img, (x1,y1)-(x2,y2), c
		Else
			Line (x1,y1)-(x2,y2), c
		EndIf
	End Sub
	
	' ���� [����ָ���������]
	Sub XGE_EXPORT_Shape_LinesEx(sf As xge.Surface Ptr, x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, s As Integer) XGE_EXPORT_ALL
		If sf Then
			Line sf->img, (x1,y1)-(x2,y2), c, , s
		Else
			Line (x1,y1)-(x2,y2), c, , s
		EndIf
	End Sub
	
	' ������
	Sub XGE_EXPORT_Shape_Rect(sf As xge.Surface Ptr, x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer) XGE_EXPORT_ALL
		If sf Then
			Line sf->img, (x1,y1)-(x2,y2), c, B
		Else
			Line (x1,y1)-(x2,y2), c, B
		EndIf
	End Sub
	
	' ������ [����ָ���������]
	Sub XGE_EXPORT_Shape_RectEx(sf As xge.Surface Ptr, x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, s As Integer) XGE_EXPORT_ALL
		If sf Then
			Line sf->img, (x1,y1)-(x2,y2), c, B, s
		Else
			Line (x1,y1)-(x2,y2), c, B, s
		EndIf
	End Sub
	
	' ��������
	Sub XGE_EXPORT_Shape_RectFull(sf As xge.Surface Ptr, x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer) XGE_EXPORT_ALL
		If sf Then
			Line sf->img, (x1,y1)-(x2,y2), c, BF
		Else
			Line (x1,y1)-(x2,y2), c, BF
		EndIf
	End Sub
	
	' ��Բ
	Sub XGE_EXPORT_Shape_Circ(sf As xge.Surface Ptr, x As Integer, y As Integer, r As Integer, c As Integer) XGE_EXPORT_ALL
		If sf Then
			Circle sf->img, (x,y), r, c
		Else
			Circle (x,y), r, c
		EndIf
	End Sub
	
	' ��ʵ��Բ
	Sub XGE_EXPORT_Shape_CircFull(sf As xge.Surface Ptr, x As Integer, y As Integer, r As Integer, c As Integer) XGE_EXPORT_ALL
		If sf Then
			Circle sf->img, (x,y), r, c, , , , F
		Else
			Circle (x,y), r, c, , , , F
		EndIf
	End Sub
	
	' ��Բ [����ָ������]
	Sub XGE_EXPORT_Shape_CircEx(sf As xge.Surface Ptr, x As Integer, y As Integer, r As Integer, c As Integer, a As Single) XGE_EXPORT_ALL
		If sf Then
			Circle sf->img, (x,y), r, c, , , a
		Else
			Circle (x,y), r, c, , , a
		EndIf
	End Sub
	
	' ��ʵ��Բ [����ָ������]
	Sub XGE_EXPORT_Shape_CircFullEx(sf As xge.Surface Ptr, x As Integer, y As Integer, r As Integer, c As Integer, a As Single) XGE_EXPORT_ALL
		If sf Then
			Circle sf->img, (x,y), r, c, , , a, F
		Else
			Circle (x,y), r, c, , , a, F
		EndIf
	End Sub
	
	' ��Բ��
	Sub XGE_EXPORT_Shape_CircArc(sf As xge.Surface Ptr, x As Integer, y As Integer, r As Integer, c As Integer, s As Integer, e As Integer, a As Single) XGE_EXPORT_ALL
		If sf Then
			Circle sf->img, (x,y), r, c, (s Mod 360) / 360 * PI * 2, (e Mod 360) / 360 * PI * 2, a
		Else
			Circle (x,y), r, c, (s Mod 360) / 360 * PI * 2, (e Mod 360) / 360 * PI * 2, a
		EndIf
	End Sub
	
	' �����ɫ
	Sub XGE_EXPORT_Shape_Full(sf As xge.Surface Ptr, x As Integer, y As Integer, c As Integer, f As Integer) XGE_EXPORT_ALL
		If sf Then
			Paint sf->img, (x,y), c, f
		Else
			Paint (x,y), c, f
		EndIf
	End Sub
	
	' ���ͼ�� [ʹ��ͼ���ı�]
	Sub XGE_EXPORT_Shape_FullEx(sf As xge.Surface Ptr, x As Integer, y As Integer, p As ZString Ptr, f As Integer) XGE_EXPORT_ALL
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