'==================================================================================
	'�� Logo �ȴ���Ӧ����
	'#-------------------------------------------------------------------------------
	'# ���� : ������������ʾһ��ͼƬ , ���û����¼���������󷵻�
	'# ˵�� : Surface �� Param ��ʽ���� , ���������� Surface �ᱻ�Զ��ͷ�
	'# ���� : �쳣�������� 0 [�����û��ر��˴���] , ����ִ����Ϸ��� -1
'==================================================================================



' Scene function
Function PauseScene(msg As Integer, param As Integer, eve As XGE_EVENT Ptr) As Integer
	Select Case msg
		Case XGE_MSG_KEY_DOWN			' keyboard down
			xge.Scene.Stop()
		Case XGE_MSG_LOADRES			' load resources
			Dim img As xge.Surface Ptr = Cast(Any Ptr, param)
			If img Then
				Dim As Integer LogoX, LogoY
				LogoX = (640 - img->Width) \ 2
				LogoY = (480 - img->Height) \ 2
				xge.Clear
				img->Draw_Trans(LogoX, LogoY)
			Else
				xge.Scene.Stop()
			EndIf
		Case XGE_MSG_CLOSE				' window closing
			Return -1
	End Select
End Function
