'==================================================================================
	'�� Logo �ȴ���Ӧ����
	'#-------------------------------------------------------------------------------
	'# ���� : ������������ʾһ��ͼƬ , ���û����¼���������󷵻�
	'# ˵�� : Surface �� Param ��ʽ���� , ���������� Surface �ᱻ�Զ��ͷ�
	'# ���� : �쳣�������� 0 [�����û��ر��˴���] , ����ִ����Ϸ��� -1
'==================================================================================



Function PauseScreen(ByVal message As Integer,ByVal Param As Integer,ByVal Event As NewEvent Ptr) As Integer
	Static As Integer LogoX,LogoY
	Static sf As Surface
	Select Case message
		Case xge_msg_key_dowm			' ���̰���
			xge.Stop(-1)
		Case xge_msg_loadres			' ������Դ
			sf = Cast(Any Ptr,Param)
			If sf Then
				Dim As Integer LogoX,LogoY
				LogoX = (640 - sf->Width) \ 2
				LogoY = (480 - sf->Height) \ 2
				xge.Clear
				Put (LogoX,LogoY),sf,Trans
			Else
				xge.Stop(0)
			EndIf
		Case xge_msg_close				' ���ڹر�
			Return -1
	End Select
End Function