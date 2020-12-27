'==================================================================================
	'★ BASS 2.4 音频库头文件
	'#-------------------------------------------------------------------------------
	'# 功能 : XGE使用 BASS 2.4 播放音频 , 此文件为 BASS 库定义
	'# 说明 : 
'==================================================================================



#Include Once "Windows.bi"

#Define xywh_library_bass

#Define BASSVERSION				&H204				' API 版本
#Define BASSVERSIONTEXT		"2.4"

Type HMUSIC As UInteger				' MOD music handle
Type HSAMPLE As UInteger			' sample handle
Type HCHANNEL As UInteger			' playing sample's channel handle
Type HSTREAM As UInteger			' sample stream handle
Type HRECORD As UInteger			' recording handle
Type HSYNC As UInteger				' synchronizer handle
Type HDSP As UInteger					' DSP handle
Type HFX As UInteger					' DX8 effect handle
Type HPLUGIN As UInteger			' Plugin handle

' Error codes returned by BASS_ErrorGetCode
#Define BASS_OK							0		' all is OK
#Define BASS_ERROR_MEM			1		' memory error
#Define BASS_ERROR_FILEOPEN	2		' can't open the file
#Define BASS_ERROR_DRIVER		3		' can't find a free/valid driver
#Define BASS_ERROR_BUFLOST	4		' the sample buffer was lost
#Define BASS_ERROR_HANDLE		5		' invalid handle
#Define BASS_ERROR_FORMAT		6		' unsupported sample format
#Define BASS_ERROR_POSITION	7		' invalid position
#Define BASS_ERROR_INIT			8		' BASS_Init has not been successfully called
#Define BASS_ERROR_START		9		' BASS_Start has not been successfully called
#Define BASS_ERROR_ALREADY	14	' already initialized/paused/whatever
#Define BASS_ERROR_NOCHAN		18	' can't get a free channel
#Define BASS_ERROR_ILLTYPE	19	' an illegal type was specified
#Define BASS_ERROR_ILLPARAM	20	' an illegal parameter was specified
#Define BASS_ERROR_NO3D			21	' no 3D support
#Define BASS_ERROR_NOEAX		22	' no EAX support
#Define BASS_ERROR_DEVICE		23	' illegal device number
#Define BASS_ERROR_NOPLAY		24	' not playing
#Define BASS_ERROR_FREQ			25	' illegal sample rate
#Define BASS_ERROR_NOTFILE	27	' the stream is not a file stream
#Define BASS_ERROR_NOHW			29	' no hardware voices available
#Define BASS_ERROR_EMPTY		31	' the MOD music has no sequence data
#Define BASS_ERROR_NONET		32	' no internet connection could be opened
#Define BASS_ERROR_CREATE		33	' couldn't create the file
#Define BASS_ERROR_NOFX			34	' effects are not available
#Define BASS_ERROR_NOTAVAIL	37	' requested data is not available
#Define BASS_ERROR_DECODE		38	' the channel is a "decoding channel"
#Define BASS_ERROR_DX				39	' a sufficient DirectX version is not installed
#Define BASS_ERROR_TIMEOUT	40	' connection timedout
#Define BASS_ERROR_FILEFORM	41	' unsupported file format
#Define BASS_ERROR_SPEAKER	42	' unavailable speaker
#Define BASS_ERROR_VERSION	43	' invalid BASS version (used by add-ons)
#Define BASS_ERROR_CODEC		44	' codec is not available/supported
#Define BASS_ERROR_ENDED		45	' the channel/file has ended
#Define BASS_ERROR_BUSY			46	' the device is busy
#Define BASS_ERROR_UNKNOWN	-1	' some other mystery problem

' BASS_SetConfig options
#Define BASS_CONFIG_BUFFER					0
#Define BASS_CONFIG_UPDATEPERIOD		1
#Define BASS_CONFIG_GVOL_SAMPLE			4
#Define BASS_CONFIG_GVOL_STREAM			5
#Define BASS_CONFIG_GVOL_MUSIC			6
#Define BASS_CONFIG_CURVE_VOL				7
#Define BASS_CONFIG_CURVE_PAN				8
#Define BASS_CONFIG_FLOATDSP				9
#Define BASS_CONFIG_3DALGORITHM			10
#Define BASS_CONFIG_NET_TIMEOUT			11
#Define BASS_CONFIG_NET_BUFFER			12
#Define BASS_CONFIG_PAUSE_NOPLAY		13
#Define BASS_CONFIG_NET_PREBUF			15
#Define BASS_CONFIG_NET_PASSIVE			18
#Define BASS_CONFIG_REC_BUFFER			19
#Define BASS_CONFIG_NET_PLAYLIST		21
#Define BASS_CONFIG_MUSIC_VIRTUAL		22
#Define BASS_CONFIG_VERIFY					23
#Define BASS_CONFIG_UPDATETHREADS		24
#Define BASS_CONFIG_DEV_BUFFER			27
#Define BASS_CONFIG_VISTA_TRUEPOS		30
#Define BASS_CONFIG_IOS_MIXAUDIO		34
#Define BASS_CONFIG_DEV_DEFAULT			36
#Define BASS_CONFIG_NET_READTIMEOUT	37
#Define BASS_CONFIG_VISTA_SPEAKERS	38
#Define BASS_CONFIG_IOS_SPEAKER			39
#Define BASS_CONFIG_HANDLES					41
#Define BASS_CONFIG_UNICODE					42
#Define BASS_CONFIG_SRC							43
#Define BASS_CONFIG_SRC_SAMPLE			44

' BASS_SetConfigPtr options
#Define BASS_CONFIG_NET_AGENT		16
#Define BASS_CONFIG_NET_PROXY		17

' BASS_Init flags
#Define BASS_DEVICE_8BITS				1				' 8 bit resolution, else 16 bit
#Define BASS_DEVICE_MONO				2				' mono, else stereo
#Define BASS_DEVICE_3D					4				' enable 3D Functionality
#Define BASS_DEVICE_LATENCY			0x100		' calculate device latency (BASS_INFO struct)
#Define BASS_DEVICE_CPSPEAKERS	0x400		' detect speakers via Windows control panel
#Define BASS_DEVICE_SPEAKERS		0x800		' force enabling of speaker assignment
#Define BASS_DEVICE_NOSPEAKER		0x1000	' ignore speaker arrangement
#Define BASS_DEVICE_DMIX				0x2000	' use ALSA "dmix" plugin
#Define BASS_DEVICE_FREQ				0x4000	' set device sample rate

' DirectSound interfaces (for use with BASS_GetDSoundObject)
#Define BASS_OBJECT_DS		1		' IDirectSound
#Define BASS_OBJECT_DS3DL	2		' IDirectSound3DListener

' Device info structure
Type BASS_DEVICEINFO
	thename As ZString Ptr		' description
	driver As ZString Ptr			' driver
	flags As UInteger
End Type

' BASS_DEVICEINFO flags
#Define BASS_DEVICE_ENABLED		1
#Define BASS_DEVICE_DEFAULT		2
#Define BASS_DEVICE_INIT			4

Type BASS_INFO
	flags As UInteger				' device capabilities (DSCAPS_xxx flags)
	hwsize As UInteger			' size of total device hardware memory
	hwfree As UInteger			' size of free device hardware memory
	freesam As UInteger			' number of free sample slots in the hardware
	free3d As UInteger			' number of free 3D sample slots in the hardware
	minrate As UInteger			' min sample rate supported by the hardware
	maxrate As UInteger			' max sample rate supported by the hardware
	eax As BOOL							' device supports EAX? (always FALSE if BASS_DEVICE_3D was not used)
	minbuf As UInteger			' recommended minimum buffer length in ms (requires BASS_DEVICE_LATENCY)
	dsver As UInteger				' DirectSound version
	latency As UInteger			' delay (in ms) before start of playback (requires BASS_DEVICE_LATENCY)
	initflags As UInteger		' BASS_Init "flags" parameter
	speakers As UInteger		' number of speakers available
	freq As UInteger				' current output rate
End Type

' BASS_INFO flags (from DSOUND.H)
#Define DSCAPS_CONTINUOUSRATE		0x00000010	' supports all sample rates between min/maxrate
#Define DSCAPS_EMULDRIVER				0x00000020	' device does NOT have hardware DirectSound support
#Define DSCAPS_CERTIFIED				0x00000040	' device driver has been certified by Microsoft
#Define DSCAPS_SECONDARYMONO		0x00000100	' mono
#Define DSCAPS_SECONDARYSTEREO	0x00000200	' stereo
#Define DSCAPS_SECONDARY8BIT		0x00000400	' 8 bit
#Define DSCAPS_SECONDARY16BIT		0x00000800	' 16 bit

' Recording device info structure
Type BASS_RECORDINFO
	flags As UInteger			' device capabilities (DSCCAPS_xxx flags)
	formats As UInteger		' supported standard formats (WAVE_FORMAT_xxx flags)
	inputs As UInteger		' number of inputs
	singlein As BOOL			' TRUE = only 1 input can be set at a time
	freq As UInteger			' current input rate
End Type

' BASS_RECORDINFO flags (from DSOUND.H)
#Define DSCCAPS_EMULDRIVER	DSCAPS_EMULDRIVER		' device does NOT have hardware DirectSound recording support
#Define DSCCAPS_CERTIFIED	DSCAPS_CERTIFIED			' device driver has been certified by Microsoft

' defines for formats field of BASS_RECORDINFO (from MMSYSTEM.H)
#ifndef WAVE_FORMAT_1M08
	#Define WAVE_FORMAT_1M08       0x00000001       /' 11.025 kHz, Mono,   8-bit  '/
	#Define WAVE_FORMAT_1S08       0x00000002       /' 11.025 kHz, Stereo, 8-bit  '/
	#Define WAVE_FORMAT_1M16       0x00000004       /' 11.025 kHz, Mono,   16-bit '/
	#Define WAVE_FORMAT_1S16       0x00000008       /' 11.025 kHz, Stereo, 16-bit '/
	#Define WAVE_FORMAT_2M08       0x00000010       /' 22.05  kHz, Mono,   8-bit  '/
	#Define WAVE_FORMAT_2S08       0x00000020       /' 22.05  kHz, Stereo, 8-bit  '/
	#Define WAVE_FORMAT_2M16       0x00000040       /' 22.05  kHz, Mono,   16-bit '/
	#Define WAVE_FORMAT_2S16       0x00000080       /' 22.05  kHz, Stereo, 16-bit '/
	#Define WAVE_FORMAT_4M08       0x00000100       /' 44.1   kHz, Mono,   8-bit  '/
	#Define WAVE_FORMAT_4S08       0x00000200       /' 44.1   kHz, Stereo, 8-bit  '/
	#Define WAVE_FORMAT_4M16       0x00000400       /' 44.1   kHz, Mono,   16-bit '/
	#Define WAVE_FORMAT_4S16       0x00000800       /' 44.1   kHz, Stereo, 16-bit '/
#endif

' Sample info structure
Type BASS_SAMPLE
	freq As UInteger				' default playback rate
	volume As Single				' default volume (0-1)
	pan As Single						' default pan (-1=left, 0=middle, 1=right)
	flags As UInteger				' BASS_SAMPLE_xxx flags
	length As UInteger			' length (in bytes)
	max As UInteger					' maximum simultaneous playbacks
	origres As UInteger			' original resolution bits
	chans As UInteger				' number of channels
	mingap As UInteger			' minimum gap (ms) between creating channels
	mode3d As UInteger			' BASS_3DMODE_xxx mode
	mindist As Single				' minimum distance
	maxdist As Single				' maximum distance
	iangle As UInteger			' angle of inside projection cone
	oangle As UInteger			' angle of outside projection cone
	outvol As Single				' delta-volume outside the projection cone
	vam As UInteger					' voice allocation/management flags (BASS_VAM_xxx)
	priority As UInteger		' priority (0=lowest, 0xffffffff=highest)
End Type

#Define BASS_SAMPLE_8BITS			1					' 8 bit
#Define BASS_SAMPLE_FLOAT			256				' 32-bit floating-point
#Define BASS_SAMPLE_MONO			2					' mono
#Define BASS_SAMPLE_LOOP			4					' looped
#Define BASS_SAMPLE_3D				8					' 3D Functionality
#Define BASS_SAMPLE_SOFTWARE	16				' not using hardware mixing
#Define BASS_SAMPLE_MUTEMAX		32				' mute at max distance (3D only)
#Define BASS_SAMPLE_VAM				64				' DX7 voice allocation & management
#Define BASS_SAMPLE_FX				128				' old implementation of DX8 effects
#Define BASS_SAMPLE_OVER_VOL	0x10000		' override lowest volume
#Define BASS_SAMPLE_OVER_POS	0x20000		' override longest playing
#Define BASS_SAMPLE_OVER_DIST	0x30000 	' override furthest from listener (3D only)

#Define BASS_STREAM_PRESCAN		0x20000 	' enable pin-point seeking/length (MP3/MP2/MP1)
#Define BASS_MP3_SETPOS				BASS_STREAM_PRESCAN
#Define BASS_STREAM_AUTOFREE	0x40000		' automatically free the stream when it stop/ends
#Define BASS_STREAM_RESTRATE	0x80000		' restrict the download rate of internet file streams
#Define BASS_STREAM_BLOCK			0x100000	' download/play internet file stream in small blocks
#Define BASS_STREAM_DECODE		0x200000	' don't play the stream, only decode (BASS_ChannelGetData)
#Define BASS_STREAM_STATUS		0x800000	' give server status info (HTTP/ICY tags) in DOWNLOADPROC

#Define BASS_MUSIC_FLOAT			BASS_SAMPLE_FLOAT
#Define BASS_MUSIC_MONO				BASS_SAMPLE_MONO
#Define BASS_MUSIC_LOOP				BASS_SAMPLE_LOOP
#Define BASS_MUSIC_3D					BASS_SAMPLE_3D
#Define BASS_MUSIC_FX					BASS_SAMPLE_FX
#Define BASS_MUSIC_AUTOFREE		BASS_STREAM_AUTOFREE
#Define BASS_MUSIC_DECODE			BASS_STREAM_DECODE
#Define BASS_MUSIC_PRESCAN		BASS_STREAM_PRESCAN		' calculate playback length
#Define BASS_MUSIC_CALCLEN		BASS_MUSIC_PRESCAN
#Define BASS_MUSIC_RAMP				0x200				' normal ramping
#Define BASS_MUSIC_RAMPS			0x400				' sensitive ramping
#Define BASS_MUSIC_SURROUND		0x800				' surround sound
#Define BASS_MUSIC_SURROUND2	0x1000			' surround sound (mode 2)
#Define BASS_MUSIC_FT2MOD			0x2000			' play .MOD as FastTracker 2 does
#Define BASS_MUSIC_PT1MOD			0x4000			' play .MOD as ProTracker 1 does
#Define BASS_MUSIC_NONINTER		0x10000			' non-interpolated sample mixing
#Define BASS_MUSIC_SINCINTER	0x800000		' sinc interpolated sample mixing
#Define BASS_MUSIC_POSRESET		0x8000			' stop all notes when moving position
#Define BASS_MUSIC_POSRESETEX	0x400000		' stop all notes and reset bmp/etc when moving position
#Define BASS_MUSIC_STOPBACK		0x80000			' stop the music on a backwards jump effect
#Define BASS_MUSIC_NOSAMPLE		0x100000		' don't load the samples

' Speaker assignment flags
#Define BASS_SPEAKER_FRONT	0x1000000		' front speakers
#Define BASS_SPEAKER_REAR		0x2000000		' rear/side speakers
#Define BASS_SPEAKER_CENLFE	0x3000000		' center & LFE speakers (5.1)
#Define BASS_SPEAKER_REAR2	0x4000000		' rear center speakers (7.1)
#Define BASS_SPEAKER_N(n)		((n)<<24)		' n'th pair of speakers (max 15)
#Define BASS_SPEAKER_LEFT		0x10000000	' modifier: left
#Define BASS_SPEAKER_RIGHT	0x20000000	' modifier: right
#Define BASS_SPEAKER_FRONTLEFT		BASS_SPEAKER_FRONT Or BASS_SPEAKER_LEFT
#Define BASS_SPEAKER_FRONTRIGHT		BASS_SPEAKER_FRONT Or BASS_SPEAKER_RIGHT
#Define BASS_SPEAKER_REARLEFT			BASS_SPEAKER_REAR Or BASS_SPEAKER_LEFT
#Define BASS_SPEAKER_REARRIGHT		BASS_SPEAKER_REAR Or BASS_SPEAKER_RIGHT
#Define BASS_SPEAKER_CENTER				BASS_SPEAKER_CENLFE Or BASS_SPEAKER_LEFT
#Define BASS_SPEAKER_LFE					BASS_SPEAKER_CENLFE Or BASS_SPEAKER_RIGHT
#Define BASS_SPEAKER_REAR2LEFT		BASS_SPEAKER_REAR2 Or BASS_SPEAKER_LEFT
#Define BASS_SPEAKER_REAR2RIGHT		BASS_SPEAKER_REAR2 Or BASS_SPEAKER_RIGHT

#Define BASS_UNICODE			0x80000000

#Define BASS_RECORD_PAUSE		0x8000	' start recording paused

' DX7 voice allocation & management flags
#Define BASS_VAM_HARDWARE			1
#Define BASS_VAM_SOFTWARE			2
#Define BASS_VAM_TERM_TIME		4
#Define BASS_VAM_TERM_DIST		8
#Define BASS_VAM_TERM_PRIO		16

' Channel info structure
Type BASS_CHANNELINFO
	freq As UInteger						' default playback rate
	chans As UInteger						' channels
	flags As UInteger						' BASS_SAMPLE/STREAM/MUSIC/SPEAKER flags
	ctype As UInteger						' type of channel
	origres As UInteger					' original resolution
	plugin As HPLUGIN						' plugin
	sample As HSAMPLE						' sample
	filename As ZString Ptr			' filename
End Type

' BASS_CHANNELINFO types
#Define BASS_CTYPE_SAMPLE						1
#Define BASS_CTYPE_RECORD						2
#Define BASS_CTYPE_STREAM						0x10000
#Define BASS_CTYPE_STREAM_OGG				0x10002
#Define BASS_CTYPE_STREAM_MP1				0x10003
#Define BASS_CTYPE_STREAM_MP2				0x10004
#Define BASS_CTYPE_STREAM_MP3				0x10005
#Define BASS_CTYPE_STREAM_AIFF			0x10006
#Define BASS_CTYPE_STREAM_CA				0x10007
#Define BASS_CTYPE_STREAM_MF				0x10008
#Define BASS_CTYPE_STREAM_WAV				0x40000		' WAVE flag, LOWORD=codec
#Define BASS_CTYPE_STREAM_WAV_PCM		0x50001
#Define BASS_CTYPE_STREAM_WAV_FLOAT	0x50003
#Define BASS_CTYPE_MUSIC_MOD				0x20000
#Define BASS_CTYPE_MUSIC_MTM				0x20001
#Define BASS_CTYPE_MUSIC_S3M				0x20002
#Define BASS_CTYPE_MUSIC_XM					0x20003
#Define BASS_CTYPE_MUSIC_IT					0x20004
#Define BASS_CTYPE_MUSIC_MO3				0x00100		' MO3 flag

Type BASS_PLUGINFORM
	ctype As UInteger					' channel Type
	thename As ZString Ptr		' format description
	exts As ZString Ptr				' file extension filter (*.ext1;*.ext2;etc...)
End Type

Type BASS_PLUGININFO
	version As UInteger							' version (same form as BASS_GetVersion)
	formatc As UInteger							' number of formats
	formats As BASS_PLUGINFORM Ptr	' the array of formats
End Type

' 3D vector (for 3D positions/velocities/orientations)
Type BASS_3DVECTOR
	x As Single		' +=right, -=left
	y As Single		' +=up, -=down
	z As Single		' +=front, -=behind
End Type

' 3D channel modes
#Define BASS_3DMODE_NORMAL		0		' normal 3D processing
#Define BASS_3DMODE_RELATIVE	1		' position is relative to the listener
#Define BASS_3DMODE_OFF				2		' no 3D processing

' software 3D mixing algorithms (used with BASS_CONFIG_3DALGORITHM)
#Define BASS_3DALG_DEFAULT	0
#Define BASS_3DALG_OFF			1
#Define BASS_3DALG_FULL			2
#Define BASS_3DALG_LIGHT		3

' EAX environments, use with BASS_SetEAXParameters
Enum
	EAX_ENVIRONMENT_GENERIC
	EAX_ENVIRONMENT_PADDEDCELL
	EAX_ENVIRONMENT_ROOM
	EAX_ENVIRONMENT_BATHROOM
	EAX_ENVIRONMENT_LIVINGROOM
	EAX_ENVIRONMENT_STONEROOM
	EAX_ENVIRONMENT_AUDITORIUM
	EAX_ENVIRONMENT_CONCERTHALL
	EAX_ENVIRONMENT_CAVE
	EAX_ENVIRONMENT_ARENA
	EAX_ENVIRONMENT_HANGAR
	EAX_ENVIRONMENT_CARPETEDHALLWAY
	EAX_ENVIRONMENT_HALLWAY
	EAX_ENVIRONMENT_STONECORRIDOR
	EAX_ENVIRONMENT_ALLEY
	EAX_ENVIRONMENT_FOREST
	EAX_ENVIRONMENT_CITY
	EAX_ENVIRONMENT_MOUNTAINS
	EAX_ENVIRONMENT_QUARRY
	EAX_ENVIRONMENT_PLAIN
	EAX_ENVIRONMENT_PARKINGLOT
	EAX_ENVIRONMENT_SEWERPIPE
	EAX_ENVIRONMENT_UNDERWATER
	EAX_ENVIRONMENT_DRUGGED
	EAX_ENVIRONMENT_DIZZY
	EAX_ENVIRONMENT_PSYCHOTIC
	EAX_ENVIRONMENT_COUNT			' total number of environments
End Enum

' EAX presets, usage: BASS_SetEAXParameters(EAX_PRESET_xxx)
#Define EAX_PRESET_GENERIC         EAX_ENVIRONMENT_GENERIC,0.5F,1.493F,0.5F
#Define EAX_PRESET_PADDEDCELL      EAX_ENVIRONMENT_PADDEDCELL,0.25F,0.1F,0.0F
#Define EAX_PRESET_ROOM            EAX_ENVIRONMENT_ROOM,0.417F,0.4F,0.666F
#Define EAX_PRESET_BATHROOM        EAX_ENVIRONMENT_BATHROOM,0.653F,1.499F,0.166F
#Define EAX_PRESET_LIVINGROOM      EAX_ENVIRONMENT_LIVINGROOM,0.208F,0.478F,0.0F
#Define EAX_PRESET_STONEROOM       EAX_ENVIRONMENT_STONEROOM,0.5F,2.309F,0.888F
#Define EAX_PRESET_AUDITORIUM      EAX_ENVIRONMENT_AUDITORIUM,0.403F,4.279F,0.5F
#Define EAX_PRESET_CONCERTHALL     EAX_ENVIRONMENT_CONCERTHALL,0.5F,3.961F,0.5F
#Define EAX_PRESET_CAVE            EAX_ENVIRONMENT_CAVE,0.5F,2.886F,1.304F
#Define EAX_PRESET_ARENA           EAX_ENVIRONMENT_ARENA,0.361F,7.284F,0.332F
#Define EAX_PRESET_HANGAR          EAX_ENVIRONMENT_HANGAR,0.5F,10.0F,0.3F
#Define EAX_PRESET_CARPETEDHALLWAY EAX_ENVIRONMENT_CARPETEDHALLWAY,0.153F,0.259F,2.0F
#Define EAX_PRESET_HALLWAY         EAX_ENVIRONMENT_HALLWAY,0.361F,1.493F,0.0F
#Define EAX_PRESET_STONECORRIDOR   EAX_ENVIRONMENT_STONECORRIDOR,0.444F,2.697F,0.638F
#Define EAX_PRESET_ALLEY           EAX_ENVIRONMENT_ALLEY,0.25F,1.752F,0.776F
#Define EAX_PRESET_FOREST          EAX_ENVIRONMENT_FOREST,0.111F,3.145F,0.472F
#Define EAX_PRESET_CITY            EAX_ENVIRONMENT_CITY,0.111F,2.767F,0.224F
#Define EAX_PRESET_MOUNTAINS       EAX_ENVIRONMENT_MOUNTAINS,0.194F,7.841F,0.472F
#Define EAX_PRESET_QUARRY          EAX_ENVIRONMENT_QUARRY,1.0F,1.499F,0.5F
#Define EAX_PRESET_PLAIN           EAX_ENVIRONMENT_PLAIN,0.097F,2.767F,0.224F
#Define EAX_PRESET_PARKINGLOT      EAX_ENVIRONMENT_PARKINGLOT,0.208F,1.652F,1.5F
#Define EAX_PRESET_SEWERPIPE       EAX_ENVIRONMENT_SEWERPIPE,0.652F,2.886F,0.25F
#Define EAX_PRESET_UNDERWATER      EAX_ENVIRONMENT_UNDERWATER,1.0F,1.499F,0.0F
#Define EAX_PRESET_DRUGGED         EAX_ENVIRONMENT_DRUGGED,0.875F,8.392F,1.388F
#Define EAX_PRESET_DIZZY           EAX_ENVIRONMENT_DIZZY,0.139F,17.234F,0.666F
#Define EAX_PRESET_PSYCHOTIC       EAX_ENVIRONMENT_PSYCHOTIC,0.486F,7.563F,0.806F

Type STREAMPROC As Function(ByVal handle As HSTREAM,ByVal buffer As Any Ptr,ByVal length As UInteger,ByVal user As Any Ptr) As UInteger
/' User stream callback Function. NOTE: A stream Function should obviously be as quick
as possible, other streams (and MOD musics) can't be mixed until it's finished.
handle : The stream that needs writing
buffer : Buffer to write the samples in
length : Number of bytes to write
user   : The 'user' parameter value given when calling BASS_StreamCreate
RETURN : Number of bytes written. Set the BASS_STREAMPROC_END flag to end
         the stream. '/

#Define BASS_STREAMPROC_END		0x80000000	' end of user stream flag

' special STREAMPROCs
#Define STREAMPROC_DUMMY		(STREAMPROC*)0		' "dummy" stream
#Define STREAMPROC_PUSH			(STREAMPROC*)-1		' push stream

' BASS_StreamCreateFileUser file systems
#Define STREAMFILE_NOBUFFER		0
#Define STREAMFILE_BUFFER		1
#Define STREAMFILE_BUFFERPUSH	2

' User file stream callback Functions
Type FILECLOSEPROC As Sub(ByVal user As Any Ptr)
Type FILELENPROC As Function(ByVal user As Any Ptr) As ULongInt
Type FILEREADPROC As Function(ByVal buffer As Any Ptr,ByVal length As UInteger,ByVal user As Any Ptr) As UInteger
Type FILESEEKPROC As Function(ByVal offset As ULongInt,ByVal user As Any Ptr) As BOOL

Type BASS_FILEPROCS
	Close As FILECLOSEPROC Ptr
	length As FILELENPROC Ptr
	Read As FILEREADPROC Ptr
	Seek As FILESEEKPROC Ptr
End Type

' BASS_StreamPutFileData options
#Define BASS_FILEDATA_END		0	' end & close the file

' BASS_StreamGetFilePosition modes
#Define BASS_FILEPOS_CURRENT		0
#Define BASS_FILEPOS_DECODE			BASS_FILEPOS_CURRENT
#Define BASS_FILEPOS_DOWNLOAD		1
#Define BASS_FILEPOS_END				2
#Define BASS_FILEPOS_START			3
#Define BASS_FILEPOS_CONNECTED	4
#Define BASS_FILEPOS_BUFFER			5
#Define BASS_FILEPOS_SOCKET			6

Type DOWNLOADPROC As Sub(ByVal buffer As Any Ptr,ByVal length As UInteger,ByVal user As Any Ptr)
/' Internet stream download callback Function.
buffer : Buffer containing the downloaded data... NULL=end of download
length : Number of bytes in the buffer
user   : The 'user' parameter value given when calling BASS_StreamCreateURL
 '/

' BASS_ChannelSetSync types
#Define BASS_SYNC_POS					0
#Define BASS_SYNC_END					2
#Define BASS_SYNC_META				4
#Define BASS_SYNC_SLIDE				5
#Define BASS_SYNC_STALL				6
#Define BASS_SYNC_DOWNLOAD		7
#Define BASS_SYNC_FREE				8
#Define BASS_SYNC_SETPOS			11
#Define BASS_SYNC_MUSICPOS		10
#Define BASS_SYNC_MUSICINST		1
#Define BASS_SYNC_MUSICFX			3
#Define BASS_SYNC_OGG_CHANGE	12
#Define BASS_SYNC_MIXTIME			0x40000000	' FLAG: sync at mixtime, else at playtime
#Define BASS_SYNC_ONETIME			0x80000000	' FLAG: sync only once, else continuously

Type SYNCPROC As Sub(ByVal handle As HSYNC,ByVal channel As UInteger,ByVal theData As UInteger,ByVal user As Any Ptr)
/' Sync callback Function. NOTE: a sync callback Function should be very
quick as other syncs can't be processed until it has finished. If the sync
is a "mixtime" sync, then other streams and MOD musics can't be mixed until
it's finished either.
handle : The sync that has occured
channel: Channel that the sync occured in
data   : Additional data associated with the sync's occurance
user   : The 'user' parameter given when calling BASS_ChannelSetSync 
'/

Type DSPPROC As Sub(ByVal handle As HDSP,ByVal channel As UInteger,ByVal buffer As Any Ptr,ByVal length As UInteger,ByVal user As Any Ptr)
/' DSP callback Function. NOTE: A DSP Function should obviously be as quick as
possible... other DSP Functions, streams and MOD musics can not be processed
until it's finished.
handle : The DSP handle
channel: Channel that the DSP is being applied to
buffer : Buffer to apply the DSP to
length : Number of bytes in the buffer
user   : The 'user' parameter given when calling BASS_ChannelSetDSP 
'/

Type RECORDPROC As Function(ByVal handle As HRECORD,ByVal buffer As Any Ptr,ByVal length As UInteger,ByVal user As Any Ptr) As BOOL
/' Recording callback Function.
handle : The recording handle
buffer : Buffer containing the recorded sample data
length : Number of bytes
user   : The 'user' parameter value given when calling BASS_RecordStart
RETURN : TRUE = continue recording, FALSE = stop '/

' BASS_ChannelIsActive return values
#Define BASS_ACTIVE_STOPPED	0
#Define BASS_ACTIVE_PLAYING	1
#Define BASS_ACTIVE_STALLED	2
#Define BASS_ACTIVE_PAUSED	3

' Channel attributes
#Define BASS_ATTRIB_FREQ							1
#Define BASS_ATTRIB_VOL								2
#Define BASS_ATTRIB_PAN								3
#Define BASS_ATTRIB_EAXMIX						4
#Define BASS_ATTRIB_NOBUFFER					5
#Define BASS_ATTRIB_CPU								7
#Define BASS_ATTRIB_SRC								8
#Define BASS_ATTRIB_MUSIC_AMPLIFY			0x100
#Define BASS_ATTRIB_MUSIC_PANSEP			0x101
#Define BASS_ATTRIB_MUSIC_PSCALER			0x102
#Define BASS_ATTRIB_MUSIC_BPM					0x103
#Define BASS_ATTRIB_MUSIC_SPEED				0x104
#Define BASS_ATTRIB_MUSIC_VOL_GLOBAL	0x105
#Define BASS_ATTRIB_MUSIC_VOL_CHAN		0x200		' + channel #
#Define BASS_ATTRIB_MUSIC_VOL_INST		0x300		' + instrument #

' BASS_ChannelGetData flags
#Define BASS_DATA_AVAILABLE				0						' query how much data is buffered
#Define BASS_DATA_FLOAT						0x40000000	' flag: return floating-point sample data
#Define BASS_DATA_FFT256					0x80000000	' 256 sample FFT
#Define BASS_DATA_FFT512					0x80000001	' 512 FFT
#Define BASS_DATA_FFT1024					0x80000002	' 1024 FFT
#Define BASS_DATA_FFT2048					0x80000003	' 2048 FFT
#Define BASS_DATA_FFT4096					0x80000004	' 4096 FFT
#Define BASS_DATA_FFT8192					0x80000005	' 8192 FFT
#Define BASS_DATA_FFT16384				0x80000006	' 16384 FFT
#Define BASS_DATA_FFT_INDIVIDUAL	0x10				' FFT flag: FFT for each channel, else all combined
#Define BASS_DATA_FFT_NOWINDOW		0x20				' FFT flag: no Hanning window
#Define BASS_DATA_FFT_REMOVEDC		0x40				' FFT flag: pre-remove DC bias

' BASS_ChannelGetTags types : what's returned
#Define BASS_TAG_ID3						0					' ID3v1 tags : TAG_ID3 structure
#Define BASS_TAG_ID3V2					1					' ID3v2 tags : variable length block
#Define BASS_TAG_OGG						2					' OGG comments : series of null-terminated UTF-8 strings
#Define BASS_TAG_HTTP						3					' HTTP headers : series of null-terminated ANSI strings
#Define BASS_TAG_ICY						4					' ICY headers : series of null-terminated ANSI strings
#Define BASS_TAG_META						5					' ICY metadata : ANSI string
#Define BASS_TAG_APE						6					' APE tags : series of null-terminated UTF-8 strings
#Define BASS_TAG_MP4 						7					' MP4/iTunes metadata : series of null-terminated UTF-8 strings
#Define BASS_TAG_VENDOR					9					' OGG encoder : UTF-8 string
#Define BASS_TAG_LYRICS3				10				' Lyric3v2 tag : ASCII string
#Define BASS_TAG_CA_CODEC				11				' CoreAudio codec info : TAG_CA_CODEC structure
#Define BASS_TAG_MF							13				' Media Foundation tags : series of null-terminated UTF-8 strings
#Define BASS_TAG_WAVEFORMAT			14				' WAVE format : WAVEFORMATEEX structure
#Define BASS_TAG_RIFF_INFO			0x100			' RIFF "INFO" tags : series of null-terminated ANSI strings
#Define BASS_TAG_RIFF_BEXT			0x101			' RIFF/BWF "bext" tags : TAG_BEXT structure
#Define BASS_TAG_RIFF_CART			0x102			' RIFF/BWF "cart" tags : TAG_CART structure
#Define BASS_TAG_RIFF_DISP			0x103			' RIFF "DISP" text tag : ANSI string
#Define BASS_TAG_APE_BINARY			0x1000		' + index #, binary APE tag : TAG_APE_BINARY structure
#Define BASS_TAG_MUSIC_NAME			0x10000		' MOD music name : ANSI string
#Define BASS_TAG_MUSIC_MESSAGE	0x10001		' MOD message : ANSI string
#Define BASS_TAG_MUSIC_ORDERS		0x10002		' MOD order list : BYTE array of pattern numbers
#Define BASS_TAG_MUSIC_INST			0x10100		' + instrument #, MOD instrument name : ANSI string
#Define BASS_TAG_MUSIC_SAMPLE		0x10300		' + sample #, MOD sample name : ANSI string

' ID3v1 tag structure
Type TAG_ID3
	id As ZString * 3
	title As ZString * 30
	artist As ZString * 30
	album As ZString * 30
	Year As ZString * 4
	comment As ZString * 30
	genre As Byte
End Type

' Binary APE tag structure
Type TAG_APE_BINARY
	key As ZString Ptr
	Data As Any Ptr
	length As UInteger
End Type

' BWF "bext" tag structure
Type TAG_BEXT
	Description As ZString * 256
	Originator As ZString * 32
	OriginatorReference As ZString * 32
	OriginationDate As ZString * 10
	OriginationTime As ZString * 8
	TimeReference As ULongInt
	Version As UShort
	UMID(0 to 64-1) As BYTE
	Reserved(0 to 190-1) As BYTE
	CodingHistory As ZString * 1
End Type

' BWF "cart" tag structures
Type TAG_CART_TIMER
	dwUsage As UInteger		' FOURCC timer usage ID
	dwValue As UInteger		' timer value in samples from head
End Type

Type TAG_CART
	Version As ZString * 4										' version of the data structure
	Title As ZString * 64											' title of cart audio sequence
	Artist As ZString * 64										' artist or creator name
	CutID As ZString * 64											' cut number identification
	ClientID As ZString * 64									' client identification
	Category As ZString * 64									' category ID, PSA, NEWS, etc
	Classification As ZString * 64						' classification or auxiliary key
	OutCue As ZString * 64										' out cue text
	StartDate As ZString * 10									' yyyy-mm-dd
	StartTime As ZString * 8									' 
	EndDate As ZString * 10										' yyyy-mm-dd
	EndTime As ZString * 8										' hh:mm:ss
	ProducerAppID As ZString * 64							' name of vendor or application
	ProducerAppVersion As ZString * 64				' version of producer application
	UserDef As ZString * 64										' user defined text
	dwLevelReference As UInteger							' sample value for 0 dB reference
	PostTimer(0 To 8-1) As TAG_CART_TIMER			' 8 time markers after head
	Reserved As ZString * 276									' 
	URL As ZString * 1024											' uniform resource locator
	TagText As ZString * 1										' free form text for scripts or tags
End Type

' CoreAudio codec info structure
Type TAG_CA_CODEC
	ftype As UInteger			' file format
	atype As UInteger			' audio format
	Name As ZString Ptr		' description
End Type

Type WAVEFORMATEX
	wFormatTag As UShort
	nChannels As UShort
	nSamplesPerSec As UInteger
	nAvgBytesPerSec As UInteger
	nBlockAlign As UShort
	wBitsPerSample As UShort
	cbSize As UShort
End Type

' BASS_ChannelGetLength/GetPosition/SetPosition modes
#Define BASS_POS_BYTE					0						' byte position
#Define BASS_POS_MUSIC_ORDER	1						' order.row position, MAKELONG(order,row)
#Define BASS_POS_DECODE				0x10000000	' flag: get the decoding (not playing) position
#Define BASS_POS_DECODETO			0x20000000	' flag: decode to the position instead of seeking

' BASS_RecordSetInput flags
#Define BASS_INPUT_OFF		0x10000
#Define BASS_INPUT_ON			0x20000

#Define BASS_INPUT_TYPE_MASK			0xff000000
#Define BASS_INPUT_TYPE_UNDEF			0x00000000
#Define BASS_INPUT_TYPE_DIGITAL		0x01000000
#Define BASS_INPUT_TYPE_LINE			0x02000000
#Define BASS_INPUT_TYPE_MIC				0x03000000
#Define BASS_INPUT_TYPE_SYNTH			0x04000000
#Define BASS_INPUT_TYPE_CD				0x05000000
#Define BASS_INPUT_TYPE_PHONE			0x06000000
#Define BASS_INPUT_TYPE_SPEAKER		0x07000000
#Define BASS_INPUT_TYPE_WAVE			0x08000000
#Define BASS_INPUT_TYPE_AUX				0x09000000
#Define BASS_INPUT_TYPE_ANALOG		0x0a000000

' DX8 effect types, use with BASS_ChannelSetFX
Enum
	BASS_FX_DX8_CHORUS
	BASS_FX_DX8_COMPRESSOR
	BASS_FX_DX8_DISTORTION
	BASS_FX_DX8_ECHO
	BASS_FX_DX8_FLANGER
	BASS_FX_DX8_GARGLE
	BASS_FX_DX8_I3DL2REVERB
	BASS_FX_DX8_PARAMEQ
	BASS_FX_DX8_REVERB
End Enum

Type BASS_DX8_CHORUS
	fWetDryMix As Single
	fDepth As Single
	fFeedback As Single
	fFrequency As Single
	lWaveform As UInteger		' 0=triangle, 1=sine
	fDelay As Single
	lPhase As UInteger			' BASS_DX8_PHASE_xxx
End Type

Type BASS_DX8_COMPRESSOR
	fGain As Single
	fAttack As Single
	fRelease As Single
	fThreshold As Single
	fRatio As Single
	fPredelay As Single
End Type

Type BASS_DX8_DISTORTION
	fGain As Single
	fEdge As Single
	fPostEQCenterFrequency As Single
	fPostEQBandwidth As Single
	fPreLowpassCutoff As Single
End Type

Type BASS_DX8_ECHO
	fWetDryMix As Single
	fFeedback As Single
	fLeftDelay As Single
	fRightDelay As Single
	lPanDelay As BOOL
End Type

Type BASS_DX8_FLANGER
	fWetDryMix As Single
	fDepth As Single
	fFeedback As Single
	fFrequency As Single
	lWaveform As UInteger		' 0=triangle, 1=sine
	fDelay As Single
	lPhase As UInteger			' BASS_DX8_PHASE_xxx
End Type

Type BASS_DX8_GARGLE
	dwRateHz As UInteger				' Rate of modulation in hz
	dwWaveShape As UInteger			' 0=triangle, 1=square
End Type

Type BASS_DX8_I3DL2REVERB
	lRoom As Integer								' [-10000, 0]      default: -1000 mB
	lRoomHF As Integer							' [-10000, 0]      default: 0 mB
	flRoomRolloffFactor As Single		' [0.0, 10.0]      default: 0.0
	flDecayTime As Single						' [0.1, 20.0]      default: 1.49s
	flDecayHFRatio As Single				' [0.1, 2.0]       default: 0.83
	lReflections As Integer					' [-10000, 1000]   default: -2602 mB
	flReflectionsDelay As Single		' [0.0, 0.3]       default: 0.007 s
	lReverb As Integer							' [-10000, 2000]   default: 200 mB
	flReverbDelay As Single					' [0.0, 0.1]       default: 0.011 s
	flDiffusion As Single						' [0.0, 100.0]     default: 100.0 %
	flDensity As Single							' [0.0, 100.0]     default: 100.0 %
	flHFReference As Single					' [20.0, 20000.0]  default: 5000.0 Hz
End Type

Type BASS_DX8_PARAMEQ
	fCenter As Single
	fBandwidth As Single
	fGain As Single
End Type

Type BASS_DX8_REVERB
	fInGain As Single								' [-96.0,0.0]            default: 0.0 dB
	fReverbMix As Single						' [-96.0,0.0]            default: 0.0 db
	fReverbTime As Single						' [0.001,3000.0]         default: 1000.0 ms
	fHighFreqRTRatio As Single			' [0.001,0.999]          default: 0.001
End Type

#Define BASS_DX8_PHASE_NEG_180        0
#Define BASS_DX8_PHASE_NEG_90         1
#Define BASS_DX8_PHASE_ZERO           2
#Define BASS_DX8_PHASE_90             3
#Define BASS_DX8_PHASE_180            4



#Inclib "bass"

Extern "Windows-MS"
	Declare Function BASS_SetConfig(ByVal opt as UInteger,ByVal value as UInteger) as Integer
	Declare Function BASS_GetConfig(ByVal opt as UInteger) as UInteger
	Declare Function BASS_SetConfigPtr(ByVal opt as UInteger,ByVal value as any ptr) as Integer
	Declare Function BASS_GetConfigPtr(ByVal opt as UInteger) as any ptr
	Declare Function BASS_GetVersion() as UInteger
	Declare Function BASS_ErrorGetCode() as Integer
	Declare Function BASS_GetDeviceInfo(ByVal device as UInteger,ByVal info as BASS_DEVICEINFO ptr) as Integer
	Declare Function BASS_Init(ByVal device as integer,ByVal freq as UInteger,ByVal flags as UInteger,ByVal win as any ptr,ByVal dsguid as any ptr) as Integer
	Declare Function BASS_SetDevice(ByVal device as UInteger) as Integer
	Declare Function BASS_GetDevice() as UInteger
	Declare Function BASS_Free() as Integer
	Declare Function BASS_GetInfo(ByVal info as BASS_INFO ptr) as Integer
	Declare Function BASS_Update(ByVal length as UInteger) as Integer
	Declare Function BASS_GetCPU() as single
	Declare Function BASS_Start() as Integer
	Declare Function BASS_Stop() as Integer
	Declare Function BASS_Pause() as Integer
	Declare Function BASS_SetVolume(ByVal volume as single) as Integer
	Declare Function BASS_GetVolume() as single
	Declare Function BASS_PluginLoad(ByVal file as zstring ptr,ByVal flags as UInteger) as HPLUGIN
	Declare Function BASS_PluginFree(ByVal handle as HPLUGIN) as Integer
	Declare Function BASS_PluginGetInfo(ByVal handle as HPLUGIN) as BASS_PLUGININFO ptr
	Declare Function BASS_Set3DFactors(ByVal distf as single,ByVal rollf as single,ByVal doppf as single) as Integer
	Declare Function BASS_Get3DFactors(ByVal distf as single ptr,ByVal rollf as single ptr,ByVal doppf as single ptr) as Integer
	Declare Function BASS_Set3DPosition(ByVal pos as BASS_3DVECTOR ptr,ByVal vel as BASS_3DVECTOR ptr,ByVal front as BASS_3DVECTOR ptr,ByVal top as BASS_3DVECTOR ptr) as Integer
	Declare Function BASS_Get3DPosition(ByVal pos as BASS_3DVECTOR ptr,ByVal vel as BASS_3DVECTOR ptr,ByVal front as BASS_3DVECTOR ptr,ByVal top as BASS_3DVECTOR ptr) as Integer
	Declare Function BASS_Apply3D As Sub()
	Declare Function BASS_MusicLoad(ByVal mem as Integer,ByVal file as any ptr,ByVal offset as ULongInt,ByVal length as UInteger,ByVal flags as UInteger,ByVal freq as UInteger) as HMUSIC
	Declare Function BASS_MusicFree(ByVal handle as HMUSIC) as Integer
	Declare Function BASS_SampleLoad(ByVal mem as Integer,ByVal file as any ptr,ByVal offset as ULongInt,ByVal length as UInteger,ByVal max as UInteger,ByVal flags as UInteger) as HSAMPLE
	Declare Function BASS_SampleCreate(ByVal length as UInteger,ByVal freq as UInteger,ByVal chans as UInteger,ByVal max as UInteger,ByVal flags as UInteger) as HSAMPLE
	Declare Function BASS_SampleFree(ByVal handle as HSAMPLE) as Integer
	Declare Function BASS_SampleSetData(ByVal handle as HSAMPLE,ByVal buffer as any ptr) as Integer
	Declare Function BASS_SampleGetData(ByVal handle as HSAMPLE,ByVal buffer as any ptr) as Integer
	Declare Function BASS_SampleGetInfo(ByVal handle as HSAMPLE,ByVal info as BASS_SAMPLE ptr) as Integer
	Declare Function BASS_SampleSetInfo(ByVal handle as HSAMPLE,ByVal info as BASS_SAMPLE ptr) as Integer
	Declare Function BASS_SampleGetChannel(ByVal handle as HSAMPLE,ByVal onlynew as Integer) as HCHANNEL
	Declare Function BASS_SampleGetChannels(ByVal handle as HSAMPLE,ByVal channels as HCHANNEL ptr) as UInteger
	Declare Function BASS_SampleStop(ByVal handle as HSAMPLE) as Integer
	Declare Function BASS_StreamCreate(ByVal freq as UInteger,ByVal chans as UInteger,ByVal flags as UInteger,ByVal proc as STREAMPROC ptr,ByVal user as any ptr) as HSTREAM
	Declare Function BASS_StreamCreateFile(ByVal mem as Integer,ByVal file as any ptr,ByVal offset as ULongInt,ByVal length as ULongInt,ByVal flags as UInteger) as HSTREAM
	Declare Function BASS_StreamCreateURL(ByVal url as zstring ptr,ByVal offset as UInteger,ByVal flags as UInteger,ByVal proc as DOWNLOADPROC ptr,ByVal user as any ptr) as HSTREAM
	Declare Function BASS_StreamCreateFileUser(ByVal system as UInteger,ByVal flags as UInteger,ByVal proc as BASS_FILEPROCS ptr,ByVal user as any ptr) as HSTREAM
	Declare Function BASS_StreamFree(ByVal handle as HSTREAM) as Integer
	Declare Function BASS_StreamGetFilePosition(ByVal handle as HSTREAM,ByVal mode as UInteger) as ULongInt
	Declare Function BASS_StreamPutData(ByVal handle as HSTREAM,ByVal buffer as any ptr,ByVal length as UInteger) as UInteger
	Declare Function BASS_StreamPutFileData(ByVal handle as HSTREAM,ByVal buffer as any ptr,ByVal length as UInteger) as UInteger
	Declare Function BASS_RecordGetDeviceInfo(ByVal device as UInteger,ByVal info as BASS_DEVICEINFO ptr) as Integer
	Declare Function BASS_RecordInit(ByVal device as integer) as Integer
	Declare Function BASS_RecordSetDevice(ByVal device as UInteger) as Integer
	Declare Function BASS_RecordGetDevice() as UInteger
	Declare Function BASS_RecordFree() as Integer
	Declare Function BASS_RecordGetInfo(ByVal info as BASS_RECORDINFO ptr) as Integer
	Declare Function BASS_RecordGetInputName(ByVal input as integer) as zstring ptr
	Declare Function BASS_RecordSetInput(ByVal input as integer,ByVal flags as UInteger,ByVal volume as single) as Integer
	Declare Function BASS_RecordGetInput(ByVal input as integer,ByVal volume as single ptr) as UInteger
	Declare Function BASS_RecordStart(ByVal freq as UInteger,ByVal chans as UInteger,ByVal flags as UInteger,ByVal proc as RECORDPROC ptr,ByVal user as any ptr) as HRECORD
	Declare Function BASS_ChannelBytes2Seconds(ByVal handle as UInteger,ByVal pos as ULongInt) as double
	Declare Function BASS_ChannelSeconds2Bytes(ByVal handle as UInteger,ByVal pos as double) as ULongInt
	Declare Function BASS_ChannelGetDevice(ByVal handle as UInteger) as UInteger
	Declare Function BASS_ChannelSetDevice(ByVal handle as UInteger,ByVal device as UInteger) as Integer
	Declare Function BASS_ChannelIsActive(ByVal handle as UInteger) as UInteger
	Declare Function BASS_ChannelGetInfo(ByVal handle as UInteger,ByVal info as BASS_CHANNELINFO ptr) as Integer
	Declare Function BASS_ChannelGetTags(ByVal handle as UInteger,ByVal tags as UInteger) as zstring ptr
	Declare Function BASS_ChannelFlags(ByVal handle as UInteger,ByVal flags as UInteger,ByVal mask as UInteger) as UInteger
	Declare Function BASS_ChannelUpdate(ByVal handle as UInteger,ByVal length as UInteger) as Integer
	Declare Function BASS_ChannelLock(ByVal handle as UInteger,ByVal lock as Integer) as Integer
	Declare Function BASS_ChannelPlay(ByVal handle as UInteger,ByVal restart as Integer) as Integer
	Declare Function BASS_ChannelStop(ByVal handle as UInteger) as Integer
	Declare Function BASS_ChannelPause(ByVal handle as UInteger) as Integer
	Declare Function BASS_ChannelSetAttribute(ByVal handle as UInteger,ByVal attrib as UInteger,ByVal value as single) as Integer
	Declare Function BASS_ChannelGetAttribute(ByVal handle as UInteger,ByVal attrib as UInteger,ByVal value as single ptr) as Integer
	Declare Function BASS_ChannelSlideAttribute(ByVal handle as UInteger,ByVal attrib as UInteger,ByVal value as single,ByVal time as UInteger) as Integer
	Declare Function BASS_ChannelIsSliding(ByVal handle as UInteger,ByVal attrib as UInteger) as Integer
	Declare Function BASS_ChannelSet3DAttributes(ByVal handle as UInteger,ByVal mode as integer,ByVal min as single,ByVal max as single,ByVal iangle as integer,ByVal oangle as integer,ByVal outvol as single) as Integer
	Declare Function BASS_ChannelGet3DAttributes(ByVal handle as UInteger,ByVal mode as UInteger ptr,ByVal min as single ptr,ByVal max as single ptr,ByVal iangle as UInteger ptr,ByVal oangle as UInteger ptr,ByVal outvol as single ptr) as Integer
	Declare Function BASS_ChannelSet3DPosition(ByVal handle as UInteger,ByVal pos as BASS_3DVECTOR ptr,ByVal orient as BASS_3DVECTOR ptr,ByVal vel as BASS_3DVECTOR ptr) as Integer
	Declare Function BASS_ChannelGet3DPosition(ByVal handle as UInteger,ByVal pos as BASS_3DVECTOR ptr,ByVal orient as BASS_3DVECTOR ptr,ByVal vel as BASS_3DVECTOR ptr) as Integer
	Declare Function BASS_ChannelGetLength(ByVal handle as UInteger,ByVal mode as UInteger) as ULongInt
	Declare Function BASS_ChannelSetPosition(ByVal handle as UInteger,ByVal pos as ULongInt,ByVal mode as UInteger) as Integer
	Declare Function BASS_ChannelGetPosition(ByVal handle as UInteger,ByVal mode as UInteger) as ULongInt
	Declare Function BASS_ChannelGetLevel(ByVal handle as UInteger) as UInteger
	Declare Function BASS_ChannelGetData(ByVal handle as UInteger,ByVal buffer as any ptr,ByVal length as UInteger) as UInteger
	Declare Function BASS_ChannelSetSync(ByVal handle as UInteger,ByVal type as UInteger,ByVal param as ULongInt,ByVal proc as SYNCPROC ptr,ByVal user as any ptr) as HSYNC
	Declare Function BASS_ChannelRemoveSync(ByVal handle as UInteger,ByVal sync as HSYNC) as Integer
	Declare Function BASS_ChannelSetDSP(ByVal handle as UInteger,ByVal proc as DSPPROC ptr,ByVal user as any ptr,ByVal priority as integer) as HDSP
	Declare Function BASS_ChannelRemoveDSP(ByVal handle as UInteger,ByVal dsp as HDSP) as Integer
	Declare Function BASS_ChannelSetLink(ByVal handle as UInteger,ByVal chan as UInteger) as Integer
	Declare Function BASS_ChannelRemoveLink(ByVal handle as UInteger,ByVal chan as UInteger) as Integer
	Declare Function BASS_ChannelSetFX(ByVal handle as UInteger,ByVal type as UInteger,ByVal priority as integer) as HFX
	Declare Function BASS_ChannelRemoveFX(ByVal handle as UInteger,ByVal fx as HFX) as Integer
	Declare Function BASS_FXSetParameters(ByVal handle as HFX,ByVal params as any ptr) as Integer
	Declare Function BASS_FXGetParameters(ByVal handle as HFX,ByVal params as any ptr) as Integer
	Declare Function BASS_FXReset(ByVal handle as HFX) as Integer
End Extern