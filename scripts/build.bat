@echo off
setlocal

:: Get the current date and time
for /f "tokens=1-7 delims=/: " %%a in ("%date% %time%") do (
	set day=%%c
	set dayofweek=%%a
	set month=%%b
	set year=%%d
	set hour=%%e
	set minute=%%f
	set second=%%g
)

:: Add leading zero to hour if less than 10
if %hour% LSS 10 set hour=0%hour%

:: Format seconds to only 2 digits
set second=%second:~0,2%

:: Format the date and time
set datetime=%year%-%month%-%day%_%hour%-%minute%-%second%

:: Define paths
set godot_path="C:\Godot\Godot_v4.4-beta1_win64.exe\Godot_v4.4-beta1_win64.exe"
set project_path=C:\GithubRepos\GodotModCapableGame\projects\
set export_path=C:\GithubRepos\GodotModCapableGame\build\%datetime%\
set export_path_file=main.exe
set main_project_path=main\

set export_path_mod=mods\
set mod_filetype=.zip
set mod_name_00=main_menu

:: Create directories
mkdir "%export_path%"
mkdir "%export_path%%export_path_mod%"

:: Export projects
%godot_path% --headless --path %project_path%%main_project_path% --export-release "Windows Desktop" %export_path%%export_path_file%
%godot_path% --headless --path %project_path%%mod_name_00% --export-pack "Windows Desktop" %export_path%%export_path_mod%%mod_name_00%%mod_filetype%

endlocal
