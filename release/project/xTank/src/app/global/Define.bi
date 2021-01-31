


' 全局配置
Dim Shared ViewHP As Integer
Dim Shared ViewLevel As Integer
Dim Shared ViewHP_Value As Integer
Dim Shared CheatMode As Integer



' 资源管理器
Dim Shared Res As xge.ResManage



' 图片数据
Dim Shared img_Logo As xge.Surface Ptr
Dim Shared img_MapTile As xge.Surface Ptr
Dim Shared img_Boom As xge.Surface Ptr
Dim Shared img_Tank1 As xge.Surface Ptr
Dim Shared img_Tank2 As xge.Surface Ptr
Dim Shared img_Tank3 As xge.Surface Ptr
Dim Shared img_Tank4 As xge.Surface Ptr
Dim Shared img_BackImage As xge.Surface Ptr
Dim Shared img_PassImage As xge.Surface Ptr
Dim Shared img_EndImage As xge.Surface Ptr



' 小样效果数据
Dim Shared se_Boom As xge.Sound Ptr
Dim Shared se_Fire As xge.Sound Ptr



' 地图编辑器数据
Dim Shared MapPath As ZString * 260
