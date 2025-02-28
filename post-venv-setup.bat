@echo off
setlocal

:: Define the project root and activation script path
set PROJECT_ROOT=%CD%
set ACTIVATE_SCRIPT=%PROJECT_ROOT%\.venv\Scripts\activate.bat

:: Append PYTHONPATH to the activation script
echo set PYTHONPATH=%PROJECT_ROOT% >> "%ACTIVATE_SCRIPT%"

echo ✅ PYTHONPATH has been added to the virtual environment!
endlocal