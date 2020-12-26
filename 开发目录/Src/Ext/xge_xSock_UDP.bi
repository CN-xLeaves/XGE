'==================================================================================
	'★ xywh Game Engine 网络模块 (UDP)
	'#-------------------------------------------------------------------------------
	'# 功能 : 
	'# 说明 : 
'==================================================================================



Extern XGE_EXTERNCLASS
	'#Ifdef XGE_BUILD_USEOOP
		Namespace xSock
	'#EndIf
	
	
	
	' 共用回调
	Sub xSock_UDP_Proc(Hdr As Integer, Event As Integer, lpOverlapped As Iocp_Link, Size As Integer, Custom As xUDP Ptr)
		Select Case Event
			Case IOCP_UDP_RECV
				Dim RecvPack As ZString Ptr
				Dim RecvIP As ZString Ptr
				Dim RecvPort As UShort
				RecvPack = UDP_Read(lpOverlapped, RecvIP, RecvPort)
				If RecvPack Then
					'RecvPack[Size] = 0
					If Custom->RecvEvent Then
						Custom->RecvEvent(RecvPack, Size, RecvIP, RecvPort)
					EndIf
				EndIf
			Case IOCP_UDP_SEND
				If Custom->SendEvent Then
					Custom->SendEvent(0)
				EndIf
			Case IOCP_UDP_ESEND
				If Custom->SendEvent Then
					Custom->SendEvent(1)
				EndIf
		End Select
	End Sub
	
	' 析构
	Destructor xUDP() XGE_EXPORT_LIB
		Destroy()
	End Destructor
	
	' 创建
	Function xUDP.Create(ip As ZString Ptr, port As UShort, ThreadCountt As UInteger = 1) As Integer XGE_EXPORT_LIB
		h_Socket = UDP_Create(ip, port, NULL, @xSock_UDP_Proc, ThreadCountt,Cast(Integer, @This))
		If h_Socket Then
			Return TRUE
		Else
			Return FALSE
		EndIf
	End Function
	
	' 销毁
	Sub xUDP.Destroy() XGE_EXPORT_LIB
		If h_Socket Then
			UDP_Destroy(h_Socket)
			h_Socket = NULL
		EndIf
	End Sub
	
	' 状态 [已创建=TRUE]
	Function xUDP.Status() As Integer XGE_EXPORT_LIB
		If h_Socket Then
			Return TRUE
		EndIf
	End Function
	
	' 发送
	Function xUDP.Send(pack As Any Ptr, size As UInteger, ip As ZString Ptr, port As UShort, sync As Integer = TRUE) As Integer XGE_EXPORT_LIB
		If h_Socket Then
			If size = 0 Then
				size = strlen(pack)
			EndIf
			Return UDP_Write(h_Socket, pack, size, ip, port, Sync)
		EndIf
	End Function
	
	
	
	'#Ifdef XGE_BUILD_USEOOP
		End Namespace
	'#EndIf
End Extern
