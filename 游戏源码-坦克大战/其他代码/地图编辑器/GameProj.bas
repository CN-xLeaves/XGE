'==================================================================================
	'�� �������ļ�
	'#-------------------------------------------------------------------------------
	'# ���� : Э�� XGE �����뿪����ܹ���һ������
	'# ˵�� : ������Ҫֱ�ӸĶ����ļ� , ������ҿ�ܿ����ṹ
'==================================================================================

#LibPath "Lib"


#Define XGE_USE_XPK				' ʹ�� xywhPackL �ļ���
'#Define XGE_USE_XPF				' ʹ�� xywh Point Font ��������
#Define XGE_USE_SFM				' ʹ�� Surface ������
'#Define XGE_USE_SOM				' ʹ�� Sound ������
'#Define XGE_USE_GUI				' ʹ�� xywhFastGameUI ��ϷUIϵͳ [GUIϵͳĿǰû���]
#Define XGE_USE_GDI				' ʹ�� GDI ͼ��֧��
#Define XGE_USE_DDS				' ʹ�� ��̬���ֻ��ƿ�

#Define Use_xywhFSO				' ʹ�� xywh File System Object �����ļ�
#Define Use_xywhSDK				' ʹ�� xywhSDK


#Ifdef Use_xywhFSO
	#Include "Inc\SDK\File.bi"
#EndIf
#Ifdef Use_xywhSDK
	#Include "Inc\SDK\xywhSDK.bi"
#EndIf

#Include "Inc\XGE\xywhGameEngine.bi"
#Include "GameProj.bi"
