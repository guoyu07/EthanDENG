@echo off

for /f %%i in ('dir /b *.jpg *.jpeg *.bmp *.png') do (
    @echo %%i
    bmeps -c %%i %%~ni.eps
    @echo Finished
    )

pause
