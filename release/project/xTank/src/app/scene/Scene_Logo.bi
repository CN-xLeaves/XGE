'==================================================================================
	'�� Logo ���뵭����ʾ����
	'#-------------------------------------------------------------------------------
	'# ���� : �����������뵭����ʾһ��ͼƬ�����
	'# ˵�� : Surface �� Param ��ʽ���� , ���������� Surface �ᱻ�Զ��ͷ�
	'# ���� : �쳣�������� 0 [�����û��ر��˴���] , ����ִ����Ϸ��� -1
'==================================================================================



' Scene function
Function LogoScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Static img As xge.Surface Ptr
	Static As Integer LogoX, LogoY, AlphaValue, IsHide
	Select Case msg
		Case XGE_MSG_DRAW				' draw
			xge.Clear()
			If IsHide=0 Then
				AlphaValue += 9
				img->Draw_Alpha2(LogoX, LogoY, AlphaValue)
				If AlphaValue > 250 Then IsHide = -1
			Else
				AlphaValue -= 9
				img->Draw_Alpha2(LogoX, LogoY, AlphaValue)
				If AlphaValue < 5 Then xge.Scene.Stop()
			EndIf
		Case XGE_MSG_LOADRES			' load resources
			img = Cast(Any Ptr, param)
			If img Then
				LogoX = (640 - img->Width) \ 2
				LogoY = (480 - img->Height) \ 2
			Else
				xge.Scene.Stop()
			EndIf
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function
