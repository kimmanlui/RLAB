@echo off
set "TEMPDIR=%USERPROFILE%\AppData\Local\Temp"
for /F "skip=90 delims=" %%D in ('dir "%TEMPDIR%" /AD /B /O-D 2^>nul') do (
    echo "DEL %TEMPDIR%\%%D"
    rd /Q /S "%TEMPDIR%\%%D"
)


