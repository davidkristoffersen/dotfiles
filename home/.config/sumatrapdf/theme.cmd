@echo off
set cmd="SumatraPDF"
set appdata="C:\Users\divad\AppData\Local\SumatraPDF"
cd C:\Program Files\SumatraPDF

if "%~1"=="" (
	start "" %cmd%.exe
) else if "%~2"=="" (
	start "" %cmd%-%1.exe -appdata "%appdata%\%1"
) else (
	start "" %cmd%-%1.exe -appdata "%appdata%\%1" -page "%2" "%3"
)

exit