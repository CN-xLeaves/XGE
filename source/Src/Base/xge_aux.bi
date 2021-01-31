'==================================================================================
	'�� xywh Game Engine ������ģ��
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================



Extern XGE_EXTERNMODULE
	#Ifdef XGE_BUILD_USEOOP
		Namespace xge
			Namespace Aux
	#EndIf
	
	
	' ��ͼ
	Function XGE_EXPORT_Aux_ScreenShot() As xge.Surface Ptr XGE_EXPORT_ALL
		Dim NewSurface As xge.Surface Ptr = New xge.Surface(xge_global_width, xge_global_height)
		If NewSurface->img Then
			memcpy(NewSurface->PixAddr, XGE_PROC_PixAddr, XGE_PROC_PixSize)
			Return NewSurface
		Else
			Delete(NewSurface)
		EndIf
	End Function
	
	' ȡɫ
	Function XGE_EXPORT_Aux_GetPixel(sf As xge.Surface Ptr, x As Integer, y As Integer) As UInteger XGE_EXPORT_ALL
		If sf Then
			Return Point(x, y, sf->img)
		Else
			Return Point(x, y)
		EndIf
	End Function
	
	' ��ɫת��
	Function XGE_EXPORT_Aux_RGB2BGR(c As UInteger) As UInteger XGE_EXPORT_ALL
		Asm
			mov eax,[c]
			bswap eax
			ror eax,8
			mov [c],eax
		End Asm
		Return c
	End Function
	
	' ��ȡ�����
	Function XGE_EXPORT_Aux_RandInt(min As UInteger = 0, max As UInteger = &HFFFFFFFF) As Integer XGE_EXPORT_ALL
		Dim uint As UInteger = (Rnd * (max - min)) + min
		Return Cast(Integer, uint)
	End Function
	Function XGE_EXPORT_Aux_RandDouble() As Double XGE_EXPORT_ALL
		Return Rnd()
	End Function
	
	' �ı䴰�ڱ���
	Sub XGE_EXPORT_Aux_SetTitleA(title As ZString Ptr) XGE_EXPORT_ALL
		WindowTitle(*title)
	End Sub
	
	' �ı䴰�ڱ���
	Sub XGE_EXPORT_Aux_SetTitleW(title As WString Ptr) XGE_EXPORT_ALL
		Dim st As ZString Ptr = UnicodeToAsci(title)
		WindowTitle(*st)
		DeAllocate(st)
	End Sub
	
	' ���ÿ�������
	Sub XGE_EXPORT_Aux_SetView(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer, f As Integer) XGE_EXPORT_ALL
		View (x1, y1) - (x2, y2), c, f
	End Sub
	
	' ���������������
	Sub XGE_EXPORT_Aux_ReSetView() XGE_EXPORT_ALL
		View
	End Sub
	
	' ��������ϵ
	Sub XGE_EXPORT_Aux_SetCoodr(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, c As Integer = 0) XGE_EXPORT_ALL
		If c Then
			Window (x1, y1) - (x2, y2)
		Else
			Window Screen (x1, y1) - (x2, y2)
		EndIf
	End Sub
	
	' �������ϵ����
	Sub XGE_EXPORT_Aux_ReSetCoodr() XGE_EXPORT_ALL
		Window
	End Sub
	
	' ��ȡ����ӳ���ϵ
	Function XGE_EXPORT_Aux_MapCoodr(coodr As Integer, tpe As Integer) As Integer XGE_EXPORT_ALL
		Return PMap(coodr, tpe)
	End Function
	
	' �������
	Function XGE_EXPORT_Aux_LockMouse() As Integer XGE_EXPORT_ALL
		Return SetMouse( , , , 1)
	End Function
	
	' �������
	Function XGE_EXPORT_Aux_UnLockMouse() As Integer XGE_EXPORT_ALL
		Return SetMouse( , , , 0)
	End Function
	
	' ���ع��
	Function XGE_EXPORT_Aux_HideCursor() As Integer XGE_EXPORT_ALL
		Return SetMouse( , , 0)
	End Function
	
	' ��ʾ���
	Function XGE_EXPORT_Aux_ShowCursor() As Integer XGE_EXPORT_ALL
		Return SetMouse( , , 1)
	End Function
	
	
	#Ifdef XGE_BUILD_USEOOP
			End Namespace
		End Namespace
	#EndIf
End Extern