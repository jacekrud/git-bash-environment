1) Add current folder to PATH variable:
	
	On Windows:
			Edit PATH manually
		OR
			!!! CAUTION: SETX command may break your PATH variable, be careful, make backup
			open cmd as administrator
			execute command: SETX /M path "%path%;%cd%\

2) Run install.bash which will update .bashrc