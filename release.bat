@echo 更新头文件
@echo;
@copy /B /Y ".\source\Src\xge_oop.bi" ".\release\include\xge.bi"
@copy /B /Y ".\source\Src\xge_oop.bi" ".\release\templet\FreeBASIC\FbEdit\src\sdk\xge.bi"
@copy /B /Y ".\source\Src\xge_oop.bi" ".\release\project\xTank\src\sdk\xge.bi"
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
@copy /B /Y ".\release\library\libxge.dll.a" ".\release\templet\FreeBASIC\FbEdit\Lib\libxge.dll.a"
@copy /B /Y ".\release\library\xge.dll" ".\release\templet\FreeBASIC\FbEdit\release\xge.dll"
@copy /B /Y ".\release\library\bass.dll" ".\release\templet\FreeBASIC\FbEdit\release\bass.dll"
@echo;
@copy /B /Y ".\release\library\libxge.dll.a" ".\release\project\xTank\lib\libxge.dll.a"
@copy /B /Y ".\release\library\xge.dll" ".\release\project\xTank\release\xge.dll"
@copy /B /Y ".\release\library\bass.dll" ".\release\project\xTank\release\bass.dll"
@echo;
@echo;
@pause