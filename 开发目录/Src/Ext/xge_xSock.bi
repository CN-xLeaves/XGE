'==================================================================================
	'★ xywh Game Engine 网络模块
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



Extern XGE_EXTERNCLASS
	'#Ifdef XGE_BUILD_USEOOP
		Namespace xSock
	'#EndIf
	
	
	
	' 服务端共用回调
	Sub xSock_TCP_Server_Proc(Hdr As Integer, Event As Integer, lpOverlapped As Iocp_Link, Size As Integer, Custom As xServer Ptr, binddata As Integer)
		Select Case Event
			Case IOCP_TCP_RECV			' 收到消息
				Dim RecvPack As ZString Ptr
				RecvPack = TCP_Read(lpOverlapped)
				If RecvPack Then
					'RecvPack[Size] = 0
					If Custom->Event.Recv Then
						Custom->Event.Recv(lpOverlapped, RecvPack, Size)
					EndIf
				EndIf
			Case IOCP_TCP_SEND			' 消息发送成功
				If Custom->Event.Send Then
					Custom->Event.Send(lpOverlapped, 0)
				EndIf
			Case IOCP_TCP_ESEND			' 消息发送失败
				If Custom->Event.Send Then
					Custom->Event.Send(lpOverlapped, 1)
				EndIf
			Case IOCP_TCP_ACCEPT		' 新连接
				Custom->AcceptProc(lpOverlapped)
			Case IOCP_TCP_DISCONNECT	' 断开连接
				Custom->DisconnProc(lpOverlapped)
		End Select
	End Sub
	
	
	
	' 析构
	Destructor xServer() XGE_EXPORT_LIB
		Destroy()
	End Destructor
	
	' 创建
	Function xServer.Create(ip As ZString Ptr, port As UShort, max As UInteger = 1000, ThreadCountt As UInteger = 1) As Integer XGE_EXPORT_LIB
		If h_Socket Then
			Destroy()
		EndIf
		' 创建 Socket
		h_Socket = TCP_Server_Create(ip, port, NULL, @xSock_TCP_Server_Proc, max, ThreadCountt, @This)
		If h_Socket Then
			' 申请客户端列表
			c_List = CAllocate(max, SizeOf(HANDLE))
			If c_List = NULL Then
				Destroy()
				Return FALSE
			EndIf
			' 初始化 Section
			InitializeCriticalSection(@Section)
			' 设置统计数据
			c_Max = max
			c_Conn = 0
			c_Enter = 0
			c_Leave = 0
			' 返回成功
			Return TRUE
		EndIf
	End Function
	
	' 销毁
	Sub xServer.Destroy() XGE_EXPORT_LIB
		' 释放 Socket
		If h_Socket Then
			TCP_Server_Destroy(h_Socket)
			h_Socket = NULL
		EndIf
		' 释放客户端列表
		If c_List Then
			DeAllocate(c_List)
			c_List = NULL
		EndIf
		' 删除临界区
		DeleteCriticalSection(@Section)
		' 重置统计数据
		c_Max = 0
		c_Conn = 0
		c_Enter = 0
		c_Leave = 0
		' 重置客户端迭代器数据
		c_FindCursor = 0
	End Sub
	
	' 状态
	Function xServer.Status() As Integer XGE_EXPORT_LIB
		If h_Socket Then
			Return TRUE
		EndIf
	End Function
	
	' 发送
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
	
	' 遍历客户端
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
	
	' 获取客户端信息
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
	
	' 内部事件函数 [连接]
	Sub xServer.AcceptProc(client As HANDLE)
		EnterCriticalSection(@Section)
		If AddClientList(client) = FALSE Then
			TCP_CloseSocket(client)
		EndIf
		LeaveCriticalSection(@Section)
	End Sub
	
	' 内部事件函数 [断开]
	Sub xServer.DisconnProc(client As HANDLE)
		EnterCriticalSection(@Section)
		DelClientList(client)
		If Event.Disconn Then
			Event.Disconn(client)
		EndIf
		LeaveCriticalSection(@Section)
	End Sub
	
	' 添加到客户端列表
	Function xServer.AddClientList(client As HANDLE) As Integer
		c_Enter += 1
		c_Conn += 1
		' 记录客户端句柄到列表
		If c_AddIndex < c_Max Then
			c_List[c_AddIndex] = client
			c_AddIndex += 1
			If Event.Accept Then
				Event.Accept(client)
			EndIf
			Return TRUE
		Else
			' 句柄表已经用完 [循环找空闲句柄]
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
	
	' 从客户端列表删除
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
	
	
	
	
	
	' 客户端共用回调
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
	
	
	
	' 引用计数
	Dim Shared xSock_Client_RefCount As Integer
	' 最大客户端数量
	Dim Shared xSock_Client_MaxCount As Integer = 16
	' 最大线程数量
	Dim Shared xSock_Client_ThreadCount As Integer = 1
	' 初始化状态
	Dim Shared xSock_Client_InitState As Integer
	' 全局的 Socket 句柄
	Dim Shared xSock_Client_hSocket As HANDLE
	
	
	
	' 初始化 [自动增加引用计数]
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
	
	' 卸载 [引用计数为0才真正卸载]
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
	
	' 设置最大客户端数量
	Sub SetClientMaxCount(c As UInteger) XGE_EXPORT_LIB
		xSock_Client_MaxCount = c
	End Sub
	
	' 设置最大线程数量
	Sub SetClientThreadCount(c As UInteger) XGE_EXPORT_LIB
		xSock_Client_ThreadCount = c
	End Sub
	
	
	
	' 析构
	Destructor xClient() XGE_EXPORT_LIB
		Close()
	End Destructor
	
	' 连接
	Function xClient.Connect(ip As ZString Ptr, port As UShort) As Integer XGE_EXPORT_LIB
		If h_Client Then
			Close()
		EndIf
		' 创建客户端 [引用计数]
		Dim hSocket As HANDLE = xSock_Client_Init()
		If hSocket Then
			' 连接服务端
			h_Client = TCP_Client_ConnectStart(hSocket, ip, port, @This, TRUE)
			If h_Client = NULL Then
				xSock_Client_Unit()
				Return FALSE
			EndIf
			' 初始化 Section
			InitializeCriticalSection(@Section)
			' 连接完毕
			TCP_Client_ConnectEnd(hSocket, h_Client)
			Return TRUE
		EndIf
	End Function
	
	' 断开
	Sub xClient.Close() XGE_EXPORT_LIB
		If h_Client Then
			' 关闭连接
			EnterCriticalSection(@Section)
			TCP_CloseSocket(h_Client)
			h_Client = NULL
			LeaveCriticalSection(@Section)
			' 删除临界区
			DeleteCriticalSection(@Section)
			' 卸载客户端 [引用计数]
			xSock_Client_Unit()
		EndIf
	End Sub
	
	' 状态
	Function xClient.Status() As Integer XGE_EXPORT_LIB
		If h_Client Then
			Return TRUE
		EndIf
	End Function
	
	' 发送
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
