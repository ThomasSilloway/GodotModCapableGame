@echo off
REM Run GUT tests for Flappy Bird Clone
REM Adjust the Godot path if needed

REM Get the directory of the batch file
set "PROJECT_PATH=%~dp0"
REM Remove trailing backslash
set "PROJECT_PATH=%PROJECT_PATH:~0,-1%"

REM Run all tests in the test/unit directory
"C:\Godot\Godot_v4.4-beta4_win64.exe" -d -s --path "%PROJECT_PATH%" "res://addons/gut/gut_cmdln.gd" -gdir=res://test/unit -glog=3 -gexit

REM Check if tests failed
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Tests failed!
    pause
    exit /b 1
) else (
    echo.
    echo All tests passed!
    pause
    exit /b 0
) 