


Function IndexSortProc Cdecl (p1 As ResManage_Item Ptr, p2 As ResManage_Item Ptr) As Integer
	If p1->ResIndex = p2->ResIndex Then
		' ����ӵ�Index���ں��棬����ȥ��
		If p1->AddOrder > p2->AddOrder Then
			Return -1
		Else
			Return 1
		EndIf
	Else
		Return p1->ResIndex - p2->ResIndex
	EndIf
End Function



Extern XGE_EXTERNMODULE
	
	Namespace xge
		
		
		
		' ���� [��]
		Constructor ResManage() XGE_EXPORT_OBJ
			PackList.StructLenght = SizeOf(xPack)
			PackList.AllocStep = 8
			IndexList.StructLenght = SizeOf(ResManage_Item)
			IndexList.AllocStep = 1024
			RangeList.StructLenght = SizeOf(ResManage_RangeMap)
			RangeList.AllocStep = 64
		End Constructor
		
		' ����
		Destructor ResManage() XGE_EXPORT_OBJ
			FreeAll()
		End Destructor
		
		
		
		' �����ļ���
		Function ResManage.AddPack(sPath As ZString Ptr) As UInteger XGE_EXPORT_OBJ
			Dim iPos As UInteger = PackList.AppendStruct()
			Dim xpk As xPack Ptr = PackList.GetPtrStruct(iPos)
			If xpk Then
				xpk->FileHdr = INVALID_HANDLE_VALUE
				xpk->HeadInfo = NULL
				If xpk->Open(sPath, TRUE) Then
					Return iPos
				Else
					' ����ʧ�ܣ�ɾ������
					PackList.StructCount -= 1
				EndIf
			EndIf
			Return 0
		End Function
		Function ResManage.AddPack(sPath As WString Ptr) As UInteger XGE_EXPORT_OBJ
			Dim iPos As UInteger = PackList.AppendStruct()
			Dim xpk As xPack Ptr = PackList.GetPtrStruct(iPos)
			If xpk Then
				xpk->FileHdr = INVALID_HANDLE_VALUE
				xpk->HeadInfo = NULL
				If xpk->Open(sPath, TRUE) Then
					Return iPos
				Else
					' ����ʧ�ܣ�ɾ������
					PackList.StructCount -= 1
				EndIf
			EndIf
			Return 0
		End Function
		
		' �ͷ��ļ���
		Sub ResManage.FreePack(iPos As UInteger) XGE_EXPORT_OBJ
			Dim xpk As xPack Ptr = PackList.GetPtrStruct(iPos)
			If xpk Then
				xpk->Close()
				PackList.DeleteStruct(iPos)
			EndIf
		End Sub
		
		' ��������
		Sub ResManage.CreateIndex() XGE_EXPORT_OBJ
			' ���ԭ��������
			ClearIndex()
			RangeList.ReInitManage()
			' ��������ļ�������
			Dim iOrder As ULongInt = 0
			For i As UInteger = 1 To PackList.StructCount
				Dim xpk As xPack Ptr = PackList.GetPtrStruct(i)
				For iPos As UInteger = 1 To xpk->LDB.StructCount
					' ������ݵ�������
					Dim FileInfo As xPack_FileInfo Ptr = xpk->LDB.GetPtrStruct(iPos)
					Dim idx As UInteger = IndexList.AppendStruct()
					Dim Item As ResManage_Item Ptr
					Item = IndexList.GetPtrStruct(idx)
					Item->ResIndex = FileInfo->FileIndex
					Item->ResPack = xpk
					Item->ResPos = iPos
					Item->AddOrder = iOrder
					iOrder += 1
				Next
			Next
			' ����������ȥ�� (�ļ�Index��С����)
			qsort(IndexList.StructMemory, IndexList.StructCount, IndexList.StructLenght, Cast(Any Ptr, @IndexSortProc))
			Dim DelList As UInteger Ptr = Allocate(IndexList.StructCount * SizeOf(UInteger))
			Dim DelPos As UInteger = 0
			Dim OldIndex As UInteger = 0
			For i As UInteger = 1 To IndexList.StructCount
				Dim Item As ResManage_Item Ptr = IndexList.GetPtrStruct(i)
				If Item->ResIndex = OldIndex Then
					DelList[DelPos] = i
					DelPos += 1
				Else
					OldIndex = Item->ResIndex
				EndIf
				' ������������ (����AddOrder)
				Dim xpk As xPack Ptr = Item->ResPack
				Dim FileInfo As xPack_FileInfo Ptr = xpk->LDB.GetPtrStruct(Item->ResPos)
				Item->ObjectCache = NULL
				Item->RefCount = 0
				Item->FileType = FileInfo->FileType
				Item->LoadType = XPACK_TYPE_BINARY
			Next
			IndexList.DeleteStructs(DelList, DelPos, FALSE)
			DeAllocate(DelList)
			' ��������Ƚϴ������������� (Ϊ����������׼��)
			If IndexList.StructCount > XGE_RM_RINDEXTV Then
				Dim Item As ResManage_Item Ptr
				Item = IndexList.GetPtrStruct(1)
				IndexMin = Item->ResIndex
				Item = IndexList.GetPtrStruct(IndexList.StructCount)
				IndexMax = Item->ResIndex
				' ������������
				Dim iPos As UInteger
				Dim ri As ResManage_RangeMap Ptr
				For i As UInteger = 1 To IndexList.StructCount Step XGE_RM_RINDEXTV
					iPos = RangeList.AppendStruct()
					ri = RangeList.GetPtrStruct(iPos)
					Item = IndexList.GetPtrStruct(i)
					ri->ResIndex = Item->ResIndex
					ri->IndexPos = i
				Next
				' �������һ����������
				iPos = RangeList.AppendStruct()
				ri = RangeList.GetPtrStruct(iPos)
				ri->ResIndex = IndexMax + 1
				ri->IndexPos = 0
			EndIf
		End Sub
		
		' �������
		Sub ResManage.ClearIndex() XGE_EXPORT_OBJ
			' �ͷŶ��󻺴�
			For i As UInteger = 1 To IndexList.StructCount
				Dim Item As ResManage_Item Ptr = IndexList.GetPtrStruct(i)
				If Item->ObjectCache Then
					Select Case Item->LoadType
						Case XPACK_TYPE_IMAGE
							Delete Cast(xge.Surface Ptr, Item->ObjectCache)
						Case XPACK_TYPE_SOUND
							Delete Cast(xge.Sound Ptr, Item->ObjectCache)
						Case XPACK_TYPE_BINARY
							DeAllocate(Item->ObjectCache)
					End Select
				EndIf
			Next
			' ���ù�����
			IndexList.ReInitManage()
		End Sub
		
		' ����������ȡ��Ϣλ��
		Function ResManage.IndexToPos(index As UInteger) As UInteger XGE_EXPORT_OBJ
			If RangeList.StructCount > 0 Then
				' ʹ������������������
				If index < IndexMin Then
					Return 0
				EndIf
				If index > IndexMax Then
					Return 0
				EndIf
				' ������ȡ��������
				For i As UInteger = 1 To RangeList.StructCount
					Dim ri As ResManage_RangeMap Ptr = RangeList.GetPtrStruct(i)
					If index < ri->ResIndex Then
						ri = RangeList.GetPtrStruct(i - 1)
						For iPos As UInteger = ri->IndexPos To IndexList.StructCount
							Dim Item As ResManage_Item Ptr = IndexList.GetPtrStruct(iPos)
							If Item->ResIndex = index Then
								Return iPos
							EndIf
						Next
						Exit For
					EndIf
				Next
			Else
				' ȫ��������
				For i As UInteger = 1 To IndexList.StructCount
					Dim Item As ResManage_Item Ptr = IndexList.GetPtrStruct(i)
					If Item->ResIndex = index Then
						Return i
					EndIf
				Next
			EndIf
			Return 0
		End Function
		Function ResManage.IndexToItem(index As UInteger) As ResManage_Item Ptr XGE_EXPORT_OBJ
			If RangeList.StructCount > 0 Then
				' ʹ������������������
				If index < IndexMin Then
					Return NULL
				EndIf
				If index > IndexMax Then
					Return NULL
				EndIf
				' ������ȡ��������
				For i As UInteger = 1 To RangeList.StructCount
					Dim ri As ResManage_RangeMap Ptr = RangeList.GetPtrStruct(i)
					If index < ri->ResIndex Then
						ri = RangeList.GetPtrStruct(i - 1)
						For iPos As UInteger = ri->IndexPos To IndexList.StructCount
							Dim Item As ResManage_Item Ptr = IndexList.GetPtrStruct(iPos)
							If Item->ResIndex = index Then
								Return Item
							EndIf
						Next
						Exit For
					EndIf
				Next
			Else
				' ȫ��������
				For i As UInteger = 1 To IndexList.StructCount
					Dim Item As ResManage_Item Ptr = IndexList.GetPtrStruct(i)
					If Item->ResIndex = index Then
						Return Item
					EndIf
				Next
			EndIf
			Return NULL
		End Function
		
		
		
		' ����ͼƬ
		Function ResManage.LoadPicture(index As UInteger) As xge.Surface Ptr XGE_EXPORT_OBJ
			Dim item As ResManage_Item Ptr = IndexToItem(index)
			If item Then
				If item->ObjectCache Then
					If item->RefCount < 65536 Then
						item->RefCount += 1
					EndIf
					Return item->ObjectCache
				Else
					Dim xpk As xPack Ptr = item->ResPack
					Dim FileInfo As xPack_FileInfo Ptr = xpk->LDB.GetPtrStruct(item->ResPos)
					If FileInfo Then
						Dim pMemory As WString Ptr = Allocate(FileInfo->FileSize)
						xpk->Private_UnPackMemory(FileInfo, pMemory)
						item->ObjectCache = New xge.Surface(pMemory, FileInfo->FileSize)
						item->LoadType = XPACK_TYPE_IMAGE
						If item->RefCount < 65536 Then
							item->RefCount += 1
						EndIf
						DeAllocate(pMemory)
						Return item->ObjectCache
					EndIf
				EndIf
			EndIf
			Return NULL
		End Function
		
		' ��������
		Function ResManage.LoadMusic(index As UInteger, flag As Integer = 0) As xge.Sound Ptr XGE_EXPORT_OBJ
			Dim item As ResManage_Item Ptr = IndexToItem(index)
			If item Then
				If item->ObjectCache Then
					If item->RefCount < 65536 Then
						item->RefCount += 1
					EndIf
					Return item->ObjectCache
				Else
					Dim xpk As xPack Ptr = item->ResPack
					Dim FileInfo As xPack_FileInfo Ptr = xpk->LDB.GetPtrStruct(item->ResPos)
					If FileInfo Then
						Dim pMemory As ZString Ptr = Allocate(FileInfo->FileSize)
						xpk->Private_UnPackMemory(FileInfo, pMemory)
						item->ObjectCache = New xge.Sound(XGE_SOUND_STREAM, flag, pMemory, FileInfo->FileSize)
						item->LoadType = XPACK_TYPE_SOUND
						If item->RefCount < 65536 Then
							item->RefCount += 1
						EndIf
						DeAllocate(pMemory)
						Return item->ObjectCache
					EndIf
				EndIf
			EndIf
			Return NULL
		End Function
		Function ResManage.LoadSample(index As UInteger, flag As Integer = 0) As xge.Sound Ptr XGE_EXPORT_OBJ
			Dim item As ResManage_Item Ptr = IndexToItem(index)
			If item Then
				If item->ObjectCache Then
					If item->RefCount < 65536 Then
						item->RefCount += 1
					EndIf
					Return item->ObjectCache
				Else
					Dim xpk As xPack Ptr = item->ResPack
					Dim FileInfo As xPack_FileInfo Ptr = xpk->LDB.GetPtrStruct(item->ResPos)
					If FileInfo Then
						Dim pMemory As ZString Ptr = Allocate(FileInfo->FileSize)
						xpk->Private_UnPackMemory(FileInfo, pMemory)
						item->ObjectCache = New xge.Sound(XGE_SOUND_SAMPLE, flag, pMemory, FileInfo->FileSize)
						item->LoadType = XPACK_TYPE_SOUND
						If item->RefCount < 65536 Then
							item->RefCount += 1
						EndIf
						DeAllocate(pMemory)
						Return item->ObjectCache
					EndIf
				EndIf
			EndIf
			Return NULL
		End Function
		
		' �������� (ͨ���ı�ģ���ͷ�)
		Function ResManage.LoadFont(index As UInteger) As UInteger XGE_EXPORT_OBJ
			Dim item As ResManage_Item Ptr = IndexToItem(index)
			If item Then
				If item->ObjectCache Then
					If item->RefCount < 65536 Then
						item->RefCount += 1
					EndIf
					Return Cast(UInteger, item->ObjectCache)
				Else
					Dim xpk As xPack Ptr = item->ResPack
					Dim FileInfo As xPack_FileInfo Ptr = xpk->LDB.GetPtrStruct(item->ResPos)
					If FileInfo Then
						Dim pMemory As WString Ptr = Allocate(FileInfo->FileSize)
						xpk->Private_UnPackMemory(FileInfo, pMemory)
						item->ObjectCache = Cast(Any Ptr, xge.Text.LoadFontW(pMemory, FileInfo->FileSize))
						item->LoadType = XPACK_TYPE_FONT
						If item->RefCount < 65536 Then
							item->RefCount += 1
						EndIf
						Return Cast(UInteger, item->ObjectCache)
					EndIf
				EndIf
			EndIf
			Return 0
		End Function
		
		' ������������
		Function ResManage.LoadBinary(index As UInteger) As Any Ptr XGE_EXPORT_OBJ
			Dim item As ResManage_Item Ptr = IndexToItem(index)
			If item Then
				If item->ObjectCache Then
					If item->RefCount < 65536 Then
						item->RefCount += 1
					EndIf
					Return item->ObjectCache
				Else
					Dim xpk As xPack Ptr = item->ResPack
					Dim FileInfo As xPack_FileInfo Ptr = xpk->LDB.GetPtrStruct(item->ResPos)
					If FileInfo Then
						item->ObjectCache = Allocate(FileInfo->FileSize)
						xpk->Private_UnPackMemory(FileInfo, item->ObjectCache)
						item->LoadType = XPACK_TYPE_BINARY
						If item->RefCount < 65536 Then
							item->RefCount += 1
						EndIf
						Return item->ObjectCache
					EndIf
				EndIf
			EndIf
			Return NULL
		End Function
		
		' �ͷ���Դ
		Sub ResManage.FreeAll() XGE_EXPORT_OBJ
			For i As UInteger = 1 To PackList.StructCount
				Dim xpk As xPack Ptr = PackList.GetPtrStruct(i)
				xpk->Close()
			Next
			PackList.ReInitManage()
			ClearIndex()
			RangeList.ReInitManage()
		End Sub
		Sub ResManage.FreeRes(index As UInteger) XGE_EXPORT_OBJ
			Dim item As ResManage_Item Ptr = IndexToItem(index)
			If item Then
				If item->RefCount = 0 Then
					item->RefCount = 1
				EndIf
				item->RefCount -= 1
				If item->RefCount = 0 Then
					If Item->ObjectCache Then
						Select Case Item->LoadType
							Case XPACK_TYPE_IMAGE
								Delete Cast(xge.Surface Ptr, Item->ObjectCache)
							Case XPACK_TYPE_SOUND
								Delete Cast(xge.Sound Ptr, Item->ObjectCache)
							Case XPACK_TYPE_BINARY
								DeAllocate(Item->ObjectCache)
						End Select
					EndIf
				EndIf
			EndIf
		End Sub
		
		
		
	End Namespace
	
End Extern


