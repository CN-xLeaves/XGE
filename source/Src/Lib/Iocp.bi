'==================================================================================
	'★ xywh Game Engine 引擎头文件
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



#Ifndef xywh_library_iocp
	#Define xywh_library_iocp
	#Inclib "iocp_socket"
	
	
	
	/' -------------------------- 基础头文件 -------------------------- '/
	#Include Once "Crt.bi"
	#Include Once "Windows.bi"
	#Include Once "Win\WinSock2.bi"
	
	
	
	/' -------------------------- 数据定义 -------------------------- '/
	#Define IOCP_END				0				' 套接字属性回调
	#Define IOCP_START				1				' 套接字属性回调
	#Define IOCP_TCP_ACCEPT			1				' 服务端-客户进入
	#Define IOCP_TCP_CONNECT		1				' 客户端-连接成功
	#Define IOCP_TCP_DISCONNECT		0				' 共用-连接断开
	#Define IOCP_TCP_ECONNECT		-2				' 客户端-连接失败
	#Define IOCP_TCP_ESEND			-3				' 共用-发送失败
	#Define IOCP_TCP_RECV			2				' 共用-数据到达
	#Define IOCP_TCP_SEND			3				' 共用-发送成功
	#Define IOCP_UDP_ESEND			-3				' 发送失败
	#Define IOCP_UDP_RECV			2				' 数据到达
	#Define IOCP_UDP_SEND			3				' 发送成功
	
	
	
	/' -------------------------- 类型定义 -------------------------- '/
	Type Iocp_Sock As Any Ptr
	Type Iocp_Link As Any Ptr
	Type ClientInfo
		ip As ZString Ptr
		port As UShort
	End Type
	
	
	
	/' -------------------------- API 定义 -------------------------- '/
	Extern "C"
		' 安装 返回句柄
		Declare Function Packet_In StdCall() As Integer
		
		' 释放数据指针 [句柄] [数据指针]
		Declare Sub Packet_Packend StdCall(lpPacket As Any Ptr, lpData As Any Ptr)
		
		' 返回数据指针 [句柄] [数据指针] [数据长度] [返回数据大小]
		Declare Function Packet_Packing StdCall(lpPacket As Any Ptr, lpData As Any Ptr, DataLen As Integer, Rlen As Integer) As Any Ptr
		
		' 卸载 [句柄]
		Declare Sub Packet_Un StdCall(lpPacket As Any Ptr)
		
		' 0失败 1成功 [句柄] [数据指针] [数据长度] [回调函数 无返回值，参数1 数据指针，参数2 数据长度，参数3 自定义] [自定义]
		Declare Function Packet_Unpack StdCall(lpPacket As Any Ptr, lpData As Any Ptr, DataLen As Integer, lpUnpackCallBack As Any Ptr, Custom As Integer) As Integer
		
		' 客户端连接完毕 [客户端句柄] [重叠地址]
		Declare Sub TCP_Client_ConnectEnd StdCall(hClient As Any Ptr, lpOverlapped As Iocp_Link)
		
		' 客户端连接开始 返回重叠地址（阻塞模式回调事件内不进行通知） [客户端句柄] [欲连接的IP地址] [端口号] [绑定数据] [阻塞方式 0异步 1阻塞]
		Declare Function TCP_Client_ConnectStart StdCall(hClient As Any Ptr, IPv4 As ZString Ptr, Port As UShort, Bind As Any Ptr, Blocking As Integer) As Iocp_Sock
		
		' 创建客户端 [套接字属性设置回调 结构：返回值 整数型，参数1：类型 整数型，参数2：套接字句柄 整数型（不设置填写 0）]
		' [事件处理函数的地址 结构：无返回值，参数1：客户端句柄 整数型，参数2：事件类型 整数型，参数3：重叠地址 整数型，参数4：数据长度 整数型，参数5：自定义 整数型，参数6：绑定数据 整数型]
		' [最大连接数] [线程数] [自定义]
		Declare Function TCP_Client_Create StdCall(lpSetSockoptCallBack As Any Ptr, lpClientCallBack As Any Ptr, MaxConnect As Integer, WorkerThreadNumber As Integer, Custom As Any Ptr) As Iocp_Sock
		
		' 创建客户端 [客户端句柄]
		Declare Sub TCP_Client_Destroy StdCall(hClient As Any Ptr)
		
		' 断开连接 [重叠地址]
		Declare Sub TCP_CloseSocket StdCall(lpOverlapped As Iocp_Link)
		
		' 取绑定数据 [重叠地址]
		Declare Function TCP_GetBindData StdCall(lpOverlapped As Iocp_Link) As Integer
		
		' 取线程许可证 [重叠地址]
		Declare Function TCP_GetCriticalSection StdCall(lpOverlapped As Iocp_Link) As Integer
		
		' 取套接字句柄 [重叠地址]
		Declare Function TCP_GetSocket StdCall(lpOverlapped As Iocp_Link) As Integer
		
		' 取到达数据指针 [重叠地址]
		Declare Function TCP_Read StdCall(lpOverlapped As Iocp_Link) As ZString Ptr
		
		' 创建服务端 返回服务端句柄 [欲绑定的IP地址] [本服务的端口号]
		' [套接字属性设置回调 结构：返回值 整数型，参数1：类型 整数型，参数2：套接字句柄 整数型（不设置填写 0）]
		' [事件处理函数的地址 结构：无返回值，参数1：服务器句柄 整数型，参数2：事件类型 整数型，参数3：重叠地址 整数型，参数4：数据长度 整数型，参数5：自定义 整数型，参数6：绑定数据 整数型]
		' [最大连接数] [线程数] [自定义]
		Declare Function TCP_Server_Create StdCall(IPv4 As ZString Ptr, Port As UShort, lpSetSockoptCallBack As Any Ptr, lpServerCallBack As Any Ptr, MaxConnect As Integer, WorkerThreadNumber As Integer, Custom As Any Ptr) As Iocp_Sock
		
		' 销毁服务器 [服务端句柄]
		Declare Sub TCP_Server_Destroy StdCall(hServer As Any Ptr)
		
		' 获取客户信息 [服务端句柄] [重叠地址] [保存客户信息的缓冲区 ip：4字节指针 port：2字节 端口]
		Declare Sub TCP_Server_GetClientInfo StdCall(hServer  As Any Ptr, lpOverlapped As Iocp_Link, lpClientInfo As ClientInfo Ptr)
		
		' 绑定数据 [重叠地址] [数据]
		Declare Sub TCP_SetBindData StdCall(lpOverlapped As Iocp_Link, Bind As Integer)
		
		' 发送数据 返回重叠地址（阻塞模式返回发送字节，回调事件内不进行通知，失败返回-1） [重叠地址] [数据指针] [数据长度] [阻塞方式 0异步 1阻塞]
		Declare Function TCP_Write StdCall(lpOverlapped As Iocp_Link, lpData As Any Ptr, DataLen As Integer, Blocking As Integer) As Integer
		
		' 创建UDP [欲绑定的IP地址] [本服务的端口号]
		' [套接字属性设置回调 结构：返回值 整数型，参数1：类型 整数型，参数2：套接字句柄 整数型（不设置填写 0）]
		' [事件处理函数的地址 结构：无返回值，参数1：UDP句柄 整数型，参数2：事件类型 整数型，参数3：重叠地址 整数型，参数4：数据长度 整数型，参数5：自定义 整数型]
		' [线程数] [自定义]
		Declare Function UDP_Create StdCall(IPv4 As ZString Ptr, Port As UShort, lpSetSockoptCallBack As Any Ptr, lpUdpCallBack As Any Ptr, WorkerThreadNumber As Integer, Custom As Integer) As Iocp_Sock
		
		' 销毁UDP [UDP句柄]
		Declare Sub UDP_Destroy StdCall(hUdp As Iocp_Sock)
		
		' 取到达数据指针与地址 [重叠地址] [IP地址] [端口]
		Declare Function UDP_Read StdCall(lpOverlapped As Iocp_Link, ByRef lpIPv4 As ZString Ptr, ByRef lpPort As UShort) As ZString Ptr
		
		' 发送数据 返回重叠地址（阻塞模式返回发送字节，回调事件内不进行通知，失败返回-1） [UDP句柄] [数据指针] [数据长度] [IP地址] [端口] [阻塞方式 0异步 1阻塞]
		Declare Function UDP_Write StdCall(hUdp As Iocp_Sock, lpData As Any Ptr, DataLen As Integer, IPv4 As ZString Ptr, Port As UShort, Blocking As Integer) As Integer
	End Extern
#EndIf










