'==================================================================================
	'�� xywh Game Engine ����ģ��
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================



Extern XGE_EXTERNCLASS
	'#Ifdef XGE_BUILD_USEOOP
		Namespace xSock
	'#EndIf
	
	
	
	' ����˹��ûص�
	Sub xSock_TCP_Server_Proc(Hdr As Integer, Event As Integer, lpOverlapped As Iocp_Link, Size As Integer, Custom As xServer Ptr, binddata As Integer)
		Select Case Event
			Case IOCP_TCP_RECV			' �յ���Ϣ
				Dim RecvPack As ZString Ptr
				RecvPack = TCP_Read(lpOverlapped)
				If RecvPack Then
					'RecvPack[Size] = 0
					If Custom->Event.Recv Then
						Custom->Event.Recv(lpOverlapped, RecvPack, Size)
					EndIf
				EndIf
			Case IOCP_TCP_SEND			' ��Ϣ���ͳɹ�
				If Custom->Event.Send Then
					Custom->Event.Send(lpOverlapped, 0)
				EndIf
			Case IOCP_TCP_ESEND			' ��Ϣ����ʧ��
				If Custom->Event.Send Then
					Custom->Event.Send(lpOverlapped, 1)
				EndIf
			Case IOCP_TCP_ACCEPT		' ������
				Custom->AcceptProc(lpOverlapped)
			Case IOCP_TCP_DISCONNECT	' �Ͽ�����
				Custom->DisconnProc(lpOverlapped)
		End Select
	End Sub
	
	
	
	' ����
	Destructor xServer() XGE_EXPORT_LIB
		Destroy()
	End Destructor
	
	' ����
	Function xServer.Create(ip As ZString Ptr, port As UShort, max As UInteger = 1000, ThreadCountt As UInteger = 1) As Integer XGE_EXPORT_LIB
		If h_Socket Then
			Destroy()
		EndIf
		' ���� Socket
		h_Socket = TCP_Server_Create(ip, port, NULL, @xSock_TCP_Server_Proc, max, ThreadCountt, @This)
		If h_Socket Then
			' ����ͻ����б�
			c_List = CAllocate(max, SizeOf(HANDLE))
			If c_List = NULL Then
				Destroy()
				Return FALSE
			EndIf
			' ��ʼ�� Section
			InitializeCriticalSection(@Section)
			' ����ͳ������
			c_Max = max
			c_Conn = 0
			c_Enter = 0
			c_Leave = 0
			' ���سɹ�
			Return TRUE
		EndIf
	End Function
	
	' ����
	Sub xServer.Destroy() XGE_EXPORT_LIB
		' �ͷ� Socket
		If h_Socket Then
			TCP_Server_Destroy(h_Socket)
			h_Socket = NULL
		EndIf
		' �ͷſͻ����б�
		If c_List Then
			DeAllocate(c_List)
			c_List = NULL
		EndIf
		' ɾ���ٽ���
		DeleteCriticalSection(@Section)
		' ����ͳ������
		c_Max = 0
		c_Conn = 0
		c_Enter = 0
		c_Leave = 0
		' ���ÿͻ��˵���������
		c_FindCursor = 0
	End Sub
	
	' ״̬
	Function xServer.Status() As Integer XGE_EXPORT_LIB
		If h_Socket Then
			Return TRUE
		EndIf
	End Function
	
	' ����
	Function xServer.Send(Client As HANDLE, pack As Any Ptr, size As UInteger, sync As Integer = TRUE) As Integer XGE_EXPORT_LIB
		If h_Socket Then
			If size = 0 Then
				size = strlen(pack)
			EndIf
			EnterCriticalSection(@Section)
			Function = TCP_Write(Client, pack, size, sync)
			LeaveCriticalSection(@Section)
		EndIf
	End Function
	
	' �����ͻ���
	Function xServer.EnumClient(first As HANDLE) As HANDLE XGE_EXPORT_LIB
		If h_Socket Then
			If first Then
				For i As Integer = c_FindCursor To c_Max - 1
					If c_List[i] Then
						c_FindCursor = i + 1
						Return c_List[i]
					EndIf
				Next
			Else
				c_FindCursor = 0
				Return EnumClient(Cast(HANDLE, -1))
			EndIf
		EndIf
	End Function
	
	' ��ȡ�ͻ�����Ϣ
	Function xServer.GetClientInfo(client As HANDLE, ip As ZString Ptr Ptr, port As UInteger Ptr) As Integer XGE_EXPORT_LIB
		If h_Socket Then
			Dim cinfo As ClientInfo
			TCP_Server_GetClientInfo(h_Socket, client, @cinfo)
			If ip Then
				*ip = cinfo.ip
			EndIf
			If port Then
				*port = cinfo.port
			EndIf
			Return TRUE
		EndIf
	End Function
	
	' �ڲ��¼����� [����]
	Sub xServer.AcceptProc(client As HANDLE)
		EnterCriticalSection(@Section)
		If AddClientList(client) = FALSE Then
			TCP_CloseSocket(client)
		EndIf
		LeaveCriticalSection(@Section)
	End Sub
	
	' �ڲ��¼����� [�Ͽ�]
	Sub xServer.DisconnProc(client As HANDLE)
		EnterCriticalSection(@Section)
		DelClientList(client)
		If Event.Disconn Then
			Event.Disconn(client)
		EndIf
		LeaveCriticalSection(@Section)
	End Sub
	
	' ��ӵ��ͻ����б�
	Function xServer.AddClientList(client As HANDLE) As Integer
		c_Enter += 1
		c_Conn += 1
		' ��¼�ͻ��˾�����б�
		If c_AddIndex < c_Max Then
			c_List[c_AddIndex] = client
			c_AddIndex += 1
			If Event.Accept Then
				Event.Accept(client)
			EndIf
			Return TRUE
		Else
			' ������Ѿ����� [ѭ���ҿ��о��]
			For i As Integer = 0 To c_Max - 1
				If c_List[i] = NULL Then
					c_List[i] = client
					If Event.Accept Then
						Event.Accept(client)
					EndIf
					Return TRUE
				EndIf
			Next
		EndIf
	End Function
	
	' �ӿͻ����б�ɾ��
	Function xServer.DelClientList(client As HANDLE) As Integer
		c_Leave += 1
		c_Conn -= 1
		For i As Integer = 0 To c_Max - 1
			If c_List[i] = client Then
				c_List[i] = NULL
				Exit For
			EndIf
		Next
		Return TRUE
	End Function
	
	
	
	
	
	' �ͻ��˹��ûص�
	Sub xSock_TCP_Client_Proc(Hdr As Integer, Event As Integer, lpOverlapped As Iocp_Link, Size As Integer, Custom As Integer, pClient As xClient Ptr)
		Select Case Event
			Case IOCP_TCP_RECV
				Dim RecvPack As ZString Ptr
				RecvPack = TCP_Read(lpOverlapped)
				If RecvPack Then
					'RecvPack[Size] = 0
					If pClient->Event.Recv Then
						pClient->Event.Recv(RecvPack, Size)
					EndIf
				EndIf
			Case IOCP_TCP_SEND
				If pClient->Event.Send Then
					pClient->Event.Send(0)
				EndIf
			Case IOCP_TCP_ESEND
				If pClient->Event.Send Then
					pClient->Event.Send(1)
				EndIf
			Case IOCP_TCP_DISCONNECT
				If pClient->Event.Disconn Then
					pClient->Event.Disconn()
				EndIf
		End Select
	End Sub
	
	
	
	' ���ü���
	Dim Shared xSock_Client_RefCount As Integer
	' ���ͻ�������
	Dim Shared xSock_Client_MaxCount As Integer = 16
	' ����߳�����
	Dim Shared xSock_Client_ThreadCount As Integer = 1
	' ��ʼ��״̬
	Dim Shared xSock_Client_InitState As Integer
	' ȫ�ֵ� Socket ���
	Dim Shared xSock_Client_hSocket As HANDLE
	
	
	
	' ��ʼ�� [�Զ��������ü���]
	Function xSock_Client_Init() As HANDLE
		If xSock_Client_InitState = FALSE Then
			xSock_Client_hSocket = TCP_Client_Create(NULL, @xSock_TCP_Client_Proc, xSock_Client_MaxCount, xSock_Client_ThreadCount, 0)
		EndIf
		If xSock_Client_hSocket Then
			xSock_Client_RefCount += 1
			xSock_Client_InitState = TRUE
			Return xSock_Client_hSocket
		EndIf
	End Function
	
	' ж�� [���ü���Ϊ0������ж��]
	Sub xSock_Client_Unit()
		xSock_Client_RefCount -= 1
		If xSock_Client_RefCount <= 0 Then
			If xSock_Client_hSocket Then
				TCP_Client_Destroy(xSock_Client_hSocket)
				xSock_Client_hSocket = NULL
			EndIf
			xSock_Client_InitState = FALSE
		EndIf
	End Sub
	
	' �������ͻ�������
	Sub SetClientMaxCount(c As UInteger) XGE_EXPORT_LIB
		xSock_Client_MaxCount = c
	End Sub
	
	' ��������߳�����
	Sub SetClientThreadCount(c As UInteger) XGE_EXPORT_LIB
		xSock_Client_ThreadCount = c
	End Sub
	
	
	
	' ����
	Destructor xClient() XGE_EXPORT_LIB
		Close()
	End Destructor
	
	' ����
	Function xClient.Connect(ip As ZString Ptr, port As UShort) As Integer XGE_EXPORT_LIB
		If h_Client Then
			Close()
		EndIf
		' �����ͻ��� [���ü���]
		Dim hSocket As HANDLE = xSock_Client_Init()
		If hSocket Then
			' ���ӷ����
			h_Client = TCP_Client_ConnectStart(hSocket, ip, port, @This, TRUE)
			If h_Client = NULL Then
				xSock_Client_Unit()
				Return FALSE
			EndIf
			' ��ʼ�� Section
			InitializeCriticalSection(@Section)
			' �������
			TCP_Client_ConnectEnd(hSocket, h_Client)
			Return TRUE
		EndIf
	End Function
	
	' �Ͽ�
	Sub xClient.Close() XGE_EXPORT_LIB
		If h_Client Then
			' �ر�����
			EnterCriticalSection(@Section)
			TCP_CloseSocket(h_Client)
			h_Client = NULL
			LeaveCriticalSection(@Section)
			' ɾ���ٽ���
			DeleteCriticalSection(@Section)
			' ж�ؿͻ��� [���ü���]
			xSock_Client_Unit()
		EndIf
	End Sub
	
	' ״̬
	Function xClient.Status() As Integer XGE_EXPORT_LIB
		If h_Client Then
			Return TRUE
		EndIf
	End Function
	
	' ����
	Function xClient.Send(pack As Any Ptr, size As UInteger, sync As Integer = TRUE) As Integer XGE_EXPORT_LIB
		If h_Client Then
			If size = 0 Then
				size = strlen(pack)
			EndIf
			EnterCriticalSection(@Section)
			Function = TCP_Write(h_Client, pack, size, sync)
			LeaveCriticalSection(@Section)
		EndIf
	End Function
	
	
	
	'#Ifdef XGE_BUILD_USEOOP
		End Namespace
	'#EndIf
End Extern
