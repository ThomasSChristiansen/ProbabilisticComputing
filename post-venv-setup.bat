@echo off
setlocal

:: Define project root and activation scripts
set PROJECT_ROOT=%CD%
set ACTIVATE_BAT=%PROJECT_ROOT%\.venv\Scripts\activate.bat
set ACTIVATE_PS1=%PROJECT_ROOT%\.venv\Scripts\Activate.ps1

:: Append PYTHONPATH setting to activate.bat (CMD)
echo set PYTHONPATH=%PROJECT_ROOT% >> "%ACTIVATE_BAT%"

:: Append PYTHONPATH setting to activate.ps1 (PowerShell)
echo $env:PYTHONPATH="%PROJECT_ROOT%" >> "%ACTIVATE_PS1%"

echo PYTHONPATH has been added to both activate.bat and activate.ps1!
endlocal