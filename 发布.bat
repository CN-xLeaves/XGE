@echo ����ͷ�ļ�
@echo;
@copy /B /Y ".\����Ŀ¼\Src\xge_oop.bi" ".\����Ŀ¼\include\xge.bi"
@copy /B /Y ".\����Ŀ¼\Src\xge_oop.bi" ".\����Ŀ¼\templet\FreeBASIC\OOP\src\sdk\xge.bi"
@echo;
@echo;
@echo ���¿��ļ�
@echo;
@copy /B /Y ".\����Ŀ¼\xge.dll" ".\����Ŀ¼\library\xge.dll"
@copy /B /Y ".\����Ŀ¼\libxge.dll.a" ".\����Ŀ¼\library\libxge.dll.a"
@echo;
@copy /B /Y ".\����Ŀ¼\library\xge.dll" ".\����Ŀ¼\examples\freebasic\bin\xge.dll"
@copy /B /Y ".\����Ŀ¼\library\bass.dll" ".\����Ŀ¼\examples\freebasic\bin\bass.dll"
@echo;
@copy /B /Y ".\����Ŀ¼\library\libxge.dll.a" ".\����Ŀ¼\templet\FreeBASIC\OOP\Lib\libxge.dll.a"
@copy /B /Y ".\����Ŀ¼\library\xge.dll" ".\����Ŀ¼\templet\FreeBASIC\OOP\release\xge.dll"
@copy /B /Y ".\����Ŀ¼\library\bass.dll" ".\����Ŀ¼\templet\FreeBASIC\OOP\release\bass.dll"
@echo;
@copy /B /Y ".\����Ŀ¼\library\xge.dll" ".\����Ŀ¼\examples\FreeBASIC\bin\xge.dll"
@copy /B /Y ".\����Ŀ¼\library\bass.dll" ".\����Ŀ¼\examples\FreeBASIC\bin\bass.dll"
@echo;
@echo;
@pause