


#Inclib "cityhash"



Extern "Windows"
	Declare Function CityHash32(pAddr As Any Ptr, iSize As UInteger) As UInteger
	Declare Function CityHash64(pAddr As Any Ptr, iSize As UInteger) As ULongInt
	Declare Function CityHash64WithSeed(pAddr As Any Ptr, iSize As UInteger, seed As ULongInt) As ULongInt
	Declare Function CityHash64WithSeeds(pAddr As Any Ptr, iSize As UInteger, seed0 As ULongInt, seed1 As ULongInt) As ULongInt
End Extern
