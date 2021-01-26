fbc.exe -s gui "Game.bas" "Game.rc" -x "..\bin\302.XUI Layout.exe"
@echo;
@echo;
@echo;
@echo     Program compiled to [ ..\bin\302.XUI Layout.exe ]
@echo;
@echo;
@echo;
@echo     If compilation fails, add the directory where [ fbc.exe ] is located to the environment variable.
@echo;
@echo;
@echo;
@echo     Some dependent files are in other directories, and changing the folder may make the example unable to run normally,
@echo     so it is necessary to modify the source code to change the path of the dependent files.
@echo;
@echo;
@echo;
@echo     Press any key to run the compiled program. (Please close this window if you don't want to do this)
@pause > nul
@cd ..\bin\
@"302.XUI Layout.exe"
