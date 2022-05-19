@echo off
cd "C:\Program Files\SumatraPDF"

if "%~1"=="" (
	start "" "SumatraPDF.exe"
) else if "%~2"=="" (
	start "" "SumatraPDF-%1.exe" -appdata "C:\Users\divad\AppData\Local\SumatraPDF\%1"
) else (
	start "" "SumatraPDF-%1.exe" -appdata "C:\Users\divad\AppData\Local\SumatraPDF\%1" -page "%2" "%3"
)

exit