# GodotModCapableGame
Creating a game template that is set up for mod support from the beginning

Inspired by: https://www.youtube.com/watch?v=tTdToEu6x8U and https://www.youtube.com/watch?v=K3MnEvrC8TA

## Purpose

Build the game as a bunch of mods to make sure mod support works the entire way through

## Tech Details

- Each mod is a separate godot project
- `main` is the mod loader project that does nothing except load mods. It'll probably handle global things too like Settings or Config
- `mainmenu` is the first mod that will display the main menu for the project.  First commit just has a hello world print

## Usage

- Export `main` project as an .exe (Turning on Export Console Wrapper is handy for testing)
- Export `mainmenu` project as a .zip 

- Run the `main` executable and view the logs to see the main menu is loaded (first commit)

## Future Updates

- Add a batch file that auto exports each project for testing
- Add an actual main menu and settings from an example project to see what issues might arise
- Add a mod that adds a button to the main menu via injection
- Add a separate mod for a main game sample project that is loaded by the main menu
- Add a mod that updates the functionality of the sample project via both overwriting and injection

