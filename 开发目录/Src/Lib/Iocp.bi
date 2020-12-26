'==================================================================================
	'�� xywh Game Engine ����ͷ�ļ�
	'#-------------------------------------------------------------------------------
	'# ���� : 
	'# ˵�� : 
'==================================================================================



#Ifndef xywh_library_iocp
	#Define xywh_library_iocp
	#Inclib "iocp_socket"
	
	
	
	/' -------------------------- ����ͷ�ļ� -------------------------- '/
	#Include Once "Crt.bi"
	#Include Once "Windows.bi"
	#Include Once "Win\WinSock2.bi"
	
	
	
	/' -------------------------- ���ݶ��� -------------------------- '/
	#Define IOCP_END				0				' �׽������Իص�
	#Define IOCP_START				1				' �׽������Իص�
	#Define IOCP_TCP_ACCEPT			1				' �����-�ͻ�����
	#Define IOCP_TCP_CONNECT		1				' �ͻ���-���ӳɹ�
	#Define IOCP_TCP_DISCONNECT		0				' ����-���ӶϿ�
	#Define IOCP_TCP_ECONNECT		-2				' �ͻ���-����ʧ��
	#Define IOCP_TCP_ESEND			-3				' ����-����ʧ��
	#Define IOCP_TCP_RECV			2				' ����-���ݵ���
	#Define IOCP_TCP_SEND			3				' ����-���ͳɹ�
	#Define IOCP_UDP_ESEND			-3				' ����ʧ��
	#Define IOCP_UDP_RECV			2				' ���ݵ���
	#Define IOCP_UDP_SEND			3				' ���ͳɹ�
	
	
	
	/' -------------------------- ���Ͷ��� -------------------------- '/
	Type Iocp_Sock As Any Ptr
	Type Iocp_Link As Any Ptr
	Type ClientInfo
		ip As ZString Ptr
		port As UShort
	End Type
	
	
	
	/' -------------------------- API ���� -------------------------- '/
	Extern "C"
		' ��װ ���ؾ��
		Declare Function Packet_In StdCall() As Integer
		
		' �ͷ�����ָ�� [���] [����ָ��]
		Declare Sub Packet_Packend StdCall(lpPacket As Any Ptr, lpData As Any Ptr)
		
		' ��������ָ�� [���] [����ָ��] [���ݳ���] [�������ݴ�С]
		Declare Function Packet_Packing StdCall(lpPacket As Any Ptr, lpData As Any Ptr, DataLen As Integer, Rlen As Integer) As Any Ptr
		
		' ж�� [���]
		Declare Sub Packet_Un StdCall(lpPacket As Any Ptr)
		
		' 0ʧ�� 1�ɹ� [���] [����ָ��] [���ݳ���] [�ص����� �޷���ֵ������1 ����ָ�룬����2 ���ݳ��ȣ�����3 �Զ���] [�Զ���]
		Declare Function Packet_Unpack StdCall(lpPacket As Any Ptr, lpData As Any Ptr, DataLen As Integer, lpUnpackCallBack As Any Ptr, Custom As Integer) As Integer
		
		' �ͻ���������� [�ͻ��˾��] [�ص���ַ]
		Declare Sub TCP_Client_ConnectEnd StdCall(hClient As Any Ptr, lpOverlapped As Iocp_Link)
		
		' �ͻ������ӿ�ʼ �����ص���ַ������ģʽ�ص��¼��ڲ�����֪ͨ�� [�ͻ��˾��] [�����ӵ�IP��ַ] [�˿ں�] [������] [������ʽ 0�첽 1����]
		Declare Function TCP_Client_ConnectStart StdCall(hClient As Any Ptr, IPv4 As ZString Ptr, Port As UShort, Bind As Any Ptr, Blocking As Integer) As Iocp_Sock
		
		' �����ͻ��� [�׽����������ûص� �ṹ������ֵ �����ͣ�����1������ �����ͣ�����2���׽��־�� �����ͣ���������д 0��]
		' [�¼��������ĵ�ַ �ṹ���޷���ֵ������1���ͻ��˾�� �����ͣ�����2���¼����� �����ͣ�����3���ص���ַ �����ͣ�����4�����ݳ��� �����ͣ�����5���Զ��� �����ͣ�����6�������� ������]
		' [���������] [�߳���] [�Զ���]
		Declare Function TCP_Client_Create StdCall(lpSetSockoptCallBack As Any Ptr, lpClientCallBack As Any Ptr, MaxConnect As Integer, WorkerThreadNumber As Integer, Custom As Any Ptr) As Iocp_Sock
		
		' �����ͻ��� [�ͻ��˾��]
		Declare Sub TCP_Client_Destroy StdCall(hClient As Any Ptr)
		
		' �Ͽ����� [�ص���ַ]
		Declare Sub TCP_CloseSocket StdCall(lpOverlapped As Iocp_Link)
		
		' ȡ������ [�ص���ַ]
		Declare Function TCP_GetBindData StdCall(lpOverlapped As Iocp_Link) As Integer
		
		' ȡ�߳����֤ [�ص���ַ]
		Declare Function TCP_GetCriticalSection StdCall(lpOverlapped As Iocp_Link) As Integer
		
		' ȡ�׽��־�� [�ص���ַ]
		Declare Function TCP_GetSocket StdCall(lpOverlapped As Iocp_Link) As Integer
		
		' ȡ��������ָ�� [�ص���ַ]
		Declare Function TCP_Read StdCall(lpOverlapped As Iocp_Link) As ZString Ptr
		
		' ��������� ���ط���˾�� [���󶨵�IP��ַ] [������Ķ˿ں�]
		' [�׽����������ûص� �ṹ������ֵ �����ͣ�����1������ �����ͣ�����2���׽��־�� �����ͣ���������д 0��]
		' [�¼��������ĵ�ַ �ṹ���޷���ֵ������1����������� �����ͣ�����2���¼����� �����ͣ�����3���ص���ַ �����ͣ�����4�����ݳ��� �����ͣ�����5���Զ��� �����ͣ�����6�������� ������]
		' [���������] [�߳���] [�Զ���]
		Declare Function TCP_Server_Create StdCall(IPv4 As ZString Ptr, Port As UShort, lpSetSockoptCallBack As Any Ptr, lpServerCallBack As Any Ptr, MaxConnect As Integer, WorkerThreadNumber As Integer, Custom As Any Ptr) As Iocp_Sock
		
		' ���ٷ����� [����˾��]
		Declare Sub TCP_Server_Destroy StdCall(hServer As Any Ptr)
		
		' ��ȡ�ͻ���Ϣ [����˾��] [�ص���ַ] [����ͻ���Ϣ�Ļ����� ip��4�ֽ�ָ�� port��2�ֽ� �˿�]
		Declare Sub TCP_Server_GetClientInfo StdCall(hServer  As Any Ptr, lpOverlapped As Iocp_Link, lpClientInfo As ClientInfo Ptr)
		
		' ������ [�ص���ַ] [����]
		Declare Sub TCP_SetBindData StdCall(lpOverlapped As Iocp_Link, Bind As Integer)
		
		' �������� �����ص���ַ������ģʽ���ط����ֽڣ��ص��¼��ڲ�����֪ͨ��ʧ�ܷ���-1�� [�ص���ַ] [����ָ��] [���ݳ���] [������ʽ 0�첽 1����]
		Declare Function TCP_Write StdCall(lpOverlapped As Iocp_Link, lpData As Any Ptr, DataLen As Integer, Blocking As Integer) As Integer
		
		' ����UDP [���󶨵�IP��ַ] [������Ķ˿ں�]
		' [�׽����������ûص� �ṹ������ֵ �����ͣ�����1������ �����ͣ�����2���׽��־�� �����ͣ���������д 0��]
		' [�¼��������ĵ�ַ �ṹ���޷���ֵ������1��UDP��� �����ͣ�����2���¼����� �����ͣ�����3���ص���ַ �����ͣ�����4�����ݳ��� �����ͣ�����5���Զ��� ������]
		' [�߳���] [�Զ���]
		Declare Function UDP_Create StdCall(IPv4 As ZString Ptr, Port As UShort, lpSetSockoptCallBack As Any Ptr, lpUdpCallBack As Any Ptr, WorkerThreadNumber As Integer, Custom As Integer) As Iocp_Sock
		
		' ����UDP [UDP���]
		Declare Sub UDP_Destroy StdCall(hUdp As Iocp_Sock)
		
		' ȡ��������ָ�����ַ [�ص���ַ] [IP��ַ] [�˿�]
		Declare Function UDP_Read StdCall(lpOverlapped As Iocp_Link, ByRef lpIPv4 As ZString Ptr, ByRef lpPort As UShort) As ZString Ptr
		
		' �������� �����ص���ַ������ģʽ���ط����ֽڣ��ص��¼��ڲ�����֪ͨ��ʧ�ܷ���-1�� [UDP���] [����ָ��] [���ݳ���] [IP��ַ] [�˿�] [������ʽ 0�첽 1����]
		Declare Function UDP_Write StdCall(hUdp As Iocp_Sock, lpData As Any Ptr, DataLen As Integer, IPv4 As ZString Ptr, Port As UShort, Blocking As Integer) As Integer
	End Extern
#EndIf










