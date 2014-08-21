@echo off

for /f %%i in ('dir /b *.jpg') do (
    @echo %%i
    bmeps -c %%i %%~ni.eps
    @echo Finished
    )

for /f %%i in ('dir /b *.bmp') do (
    @echo %%i
    bmeps -c %%i %%~ni.eps
    @echo Finished
    )

for /f %%i in ('dir /b *.png') do (
    @echo %%i
    bmeps -c %%i %%~ni.eps
    @echo Finished
    )

pause
