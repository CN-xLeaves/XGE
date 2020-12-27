@echo 更新头文件
@echo;
@copy /B /Y ".\source\Src\xge_oop.bi" ".\release\include\xge.bi"
@copy /B /Y ".\source\Src\xge_oop.bi" ".\release\templet\FreeBASIC\OOP\src\sdk\xge.bi"
@echo;
@echo;
@echo 更新库文件
@echo;
@copy /B /Y ".\source\xge.dll" ".\release\library\xge.dll"
@copy /B /Y ".\source\libxge.dll.a" ".\release\library\libxge.dll.a"
@echo;
@copy /B /Y ".\release\library\xge.dll" ".\release\examples\freebasic\bin\xge.dll"
@copy /B /Y ".\release\library\bass.dll" ".\release\examples\freebasic\bin\bass.dll"
@echo;
@copy /B /Y ".\release\library\libxge.dll.a" ".\release\templet\FreeBASIC\OOP\Lib\libxge.dll.a"
@copy /B /Y ".\release\library\xge.dll" ".\release\templet\FreeBASIC\OOP\release\xge.dll"
@copy /B /Y ".\release\library\bass.dll" ".\release\templet\FreeBASIC\OOP\release\bass.dll"
@echo;
@copy /B /Y ".\release\library\xge.dll" ".\release\examples\FreeBASIC\bin\xge.dll"
@copy /B /Y ".\release\library\bass.dll" ".\release\examples\FreeBASIC\bin\bass.dll"
@echo;
@echo;
@pause