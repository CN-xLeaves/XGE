@echo 更新头文件
@echo;
@copy /B /Y ".\开发目录\Src\xge_oop.bi" ".\发布目录\include\xge.bi"
@copy /B /Y ".\开发目录\Src\xge_oop.bi" ".\发布目录\templet\FreeBASIC\OOP\src\sdk\xge.bi"
@echo;
@echo;
@echo 更新库文件
@echo;
@copy /B /Y ".\开发目录\xge.dll" ".\发布目录\library\xge.dll"
@copy /B /Y ".\开发目录\libxge.dll.a" ".\发布目录\library\libxge.dll.a"
@echo;
@copy /B /Y ".\发布目录\library\xge.dll" ".\发布目录\examples\freebasic\bin\xge.dll"
@copy /B /Y ".\发布目录\library\bass.dll" ".\发布目录\examples\freebasic\bin\bass.dll"
@echo;
@copy /B /Y ".\发布目录\library\libxge.dll.a" ".\发布目录\templet\FreeBASIC\OOP\Lib\libxge.dll.a"
@copy /B /Y ".\发布目录\library\xge.dll" ".\发布目录\templet\FreeBASIC\OOP\release\xge.dll"
@copy /B /Y ".\发布目录\library\bass.dll" ".\发布目录\templet\FreeBASIC\OOP\release\bass.dll"
@echo;
@copy /B /Y ".\发布目录\library\xge.dll" ".\发布目录\examples\FreeBASIC\bin\xge.dll"
@copy /B /Y ".\发布目录\library\bass.dll" ".\发布目录\examples\FreeBASIC\bin\bass.dll"
@echo;
@echo;
@pause