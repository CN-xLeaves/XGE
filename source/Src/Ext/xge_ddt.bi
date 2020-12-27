'==================================================================================
	'¡ï xywh Game Engine ¶¯Ì¬ÎÄ±¾»æÖÆÄ£¿é
	'#-------------------------------------------------------------------------------
	'# ¹¦ÄÜ : 
	'# ËµÃ÷ : 
'==================================================================================


			/' -------------------------- Gdi»­×Ö¿â [·ÏÆúµÄÄ£¿é] -------------------------- '/
			/'
			Namespace ddt
				Declare Sub Init(mw As Integer, mh As Integer)
				Declare Sub Draw OverLoad(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, c As Integer, txt As ZString Ptr, sf As xge.Surface Ptr = NULL)
				Declare Sub Draw OverLoad(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, c As Integer, weight As Integer, txt As ZString Ptr, sf As xge.Surface Ptr = NULL)
				Declare Sub Draw OverLoad(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, c1 As Integer, c2 As Integer, weight As Integer, txt As ZString Ptr, sf As xge.Surface Ptr = NULL)
				Declare Sub Draw OverLoad(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, addr As ZString Ptr, size As Integer, txt As ZString Ptr, sf As xge.Surface Ptr = NULL)
			End Namespace
			'/

Extern XGE_EXTERNMODULE
	#Ifdef XGE_BUILD_USEOOP
		Namespace xge
			Namespace ddt
	#EndIf
	
	
	Dim Shared XGE_DDT_GdiSurface As xge.GdiSurface Ptr
	
	' ³õÊ¼»¯
	Sub XGE_EXPORT_DDT_Init(mw As Integer, mh As Integer) XGE_EXPORT_ALL
		If XGE_DDT_GdiSurface Then
			Delete XGE_DDT_GdiSurface
		EndIf
		XGE_DDT_GdiSurface = New xge.GdiSurface(mw + 8, mh)
	End Sub
	
	' Ð´×Ö
	Sub XGE_EXPORT_DDT_Draw1(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, c As Integer, txt As ZString Ptr, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		XGE_DDT_GdiSurface->Clear()
		XGE_DDT_GdiSurface->PrintText(0, 0, w, h, f, px, flag, c, txt)
		XGE_DDT_GdiSurface->DrawEx_Alpha(x, y, 0, 0, w, h, sf)
	End Sub
	
	' Ð´¿ÕÐÄ×Ö
	Sub XGE_EXPORT_DDT_Draw2(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, c As Integer, weight As Integer, txt As ZString Ptr, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		XGE_DDT_GdiSurface->Clear()
		XGE_DDT_GdiSurface->PrintText(0, 0, w, h, f, px, flag, c, weight, txt)
		XGE_DDT_GdiSurface->DrawEx_Alpha(x, y, 0, 0, w, h, sf)
	End Sub
	
	' Ð´Ãè±ß×Ö
	Sub XGE_EXPORT_DDT_Draw3(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, c1 As Integer, c2 As Integer, weight As Integer, txt As ZString Ptr, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		XGE_DDT_GdiSurface->Clear()
		XGE_DDT_GdiSurface->PrintText(0, 0, w, h, f, px, flag, c1, c2, weight, txt)
		XGE_DDT_GdiSurface->DrawEx_Alpha(x, y, 0, 0, w, h, sf)
	End Sub
	
	' Ð´±ÊË¢×Ö
	Sub XGE_EXPORT_DDT_Draw4(x As Integer, y As Integer, w As Integer, h As Integer, f As ZString Ptr, px As Integer, flag As Integer, addr As ZString Ptr, size As Integer, txt As ZString Ptr, sf As xge.Surface Ptr = NULL) XGE_EXPORT_ALL
		XGE_DDT_GdiSurface->Clear()
		XGE_DDT_GdiSurface->PrintText(0, 0, w, h, f, px, flag, addr, size, txt)
		XGE_DDT_GdiSurface->DrawEx_Alpha(x, y, 0, 0, w, h, sf)
	End Sub
	
	
	#Ifdef XGE_BUILD_USEOOP
			End Namespace
		End Namespace
	#EndIf
End Extern
