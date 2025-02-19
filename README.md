# GodotModCapableGame
Creating a game template that is set up for mod support from the beginning

Inspired by: https://www.youtube.com/watch?v=tTdToEu6x8U and https://www.youtube.com/watch?v=K3MnEvrC8TA

## Purpose

Build the game as a bunch of mods to make sure mod support works the entire way through

## Tech Details

- Each mod is a separate godot project
- `main` is the mod loader project that does nothing except load mods. It'll probably handle global things too like Settings or Config
- `main_menu` is the first mod that will display the main menu for the project.  First commit just has a hello world print

## Usage - Manual

- Export `main` project as an .exe (Turning on Export Console Wrapper is handy for testing)
  - Export folder: build
- Export `main_menu` project as a .zip and put it into the 
  - Export folder: build/mods

- Run the `main` executable and view the logs to see the main menu is loaded (first commit)

## Usage - Automated
- Update `scripts/build.bat` to match your paths
- Run the build batch file to automatically create versioned builds
