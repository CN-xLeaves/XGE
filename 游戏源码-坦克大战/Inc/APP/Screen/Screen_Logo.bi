'==================================================================================
	'�� Logo ���뵭����ʾ����
	'#-------------------------------------------------------------------------------
	'# ���� : �����������뵭����ʾһ��ͼƬ�����
	'# ˵�� : Surface �� Param ��ʽ���� , ���������� Surface �ᱻ�Զ��ͷ�
	'# ���� : �쳣�������� 0 [�����û��ر��˴���] , ����ִ����Ϸ��� -1
'==================================================================================



Function LogoScreen(ByVal message As Integer,ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Static As Integer LogoX,LogoY,AlphaValue,IsHide
	Static sf As Surface
	Select Case message
		Case xge_msg_draw					' ��ͼ
			xge.Clear()
			If IsHide=0 Then
				AlphaValue += 3
				Put (LogoX,LogoY),sf,Alpha,AlphaValue
				If AlphaValue > 250 Then IsHide = -1
			Else
				AlphaValue -= 3
				Put (LogoX,LogoY),sf,Alpha,AlphaValue
				If AlphaValue < 5 Then xge.Stop(-1)
			EndIf
		Case xge_msg_loadres			' ������Դ
			sf = Cast(Any Ptr,Param)
			If sf Then
				LogoX = (640 - sf->Width) \ 2
				LogoY = (480 - sf->Height) \ 2
			Else
				xge.Stop(0)
			EndIf
		Case xge_msg_close				' ���ڹر�
			Return -1
	End Select
End Function