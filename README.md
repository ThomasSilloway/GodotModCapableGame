# GodotModCapableGame
Creating a game template that is set up for mod support from the beginning

Inspired by: https://www.youtube.com/watch?v=tTdToEu6x8U and https://www.youtube.com/watch?v=K3MnEvrC8TA

## Purpose

Build the game as a bunch of mods to make sure mod support works the entire way through

## Versions

[Basic Skeleton](https://github.com/ThomasSilloway/GodotModCapableGame/tree/release/2024.02.19-Basic-Skeleton-Framework)
 - Basic version that loads a single mod and prints a hello world message. Can be used as a solid baseline for custom implementation

[Full Game Mod (Flappy Bird Clone)](https://github.com/ThomasSilloway/GodotModCapableGame/releases/tag/build-2024-02-27-v01)
 - Complete working example of a modular game built entirely with mods
 - Demonstrates two different modding approaches:
   1. Injection: The Settings mod shows how to inject new UI elements into existing scenes (adds a settings button to main menu)
   2. Overwriting: The Crazy Bird mod demonstrates how to override existing game files to modify gameplay (changes assets and behavior of the Flappy Bird clone)
 - Includes a functional Flappy Bird clone as the base game
 - Features a clean mod loading system with automatic mod discovery
 - Shows how to handle mod dependencies and load order

## Tech Details

- Each mod is a separate godot project
- `main` is the mod loader project that does nothing except load mods. Handles global things too like Settings, Config
- `mainmenu` is the first mod that displays the main menu for the project.
- `settings_menu` is the mod that injects a settings button into the main menu which opens a settings menu
  - The settings menu updates the values in the `SettingsManager` in the `main` project automatically by having its own placeholder `SettingsManager` autoloaded which is not included in the exported project. Surprisingly having a file in the auto load that is not included in the exported project doesn't break anything.
- `flappy_bird_clone` is the mod that contains the flappy bird clone game
  - Serves as the base game that other mods can modify
  - Includes complete game logic, assets, and sound effects
  - Demonstrates how to structure a game as a mod that can be extended
- `crazy_bird_mod` demonstrates file overwriting by replacing assets and scripts in the flappy bird clone
  - Shows how to override audio files and modify game behavior without changing the original mod
  - Uses the same folder structure as `flappy_bird_clone` to specify which files to replace

## Usage - Manual

- Export `main` project as an .exe (Turning on Export Console Wrapper is handy for testing)
  - Export folder: build
- Export `main_menu`, `settings_menu`, `flappy_bird_clone`, `crazy_bird_mod` projects as a .zip and put it into the 
  - Export folder: build/mods

- Run the `main` executable and view the logs to see the main menu is loaded (first commit)

## Usage - Automated
- Update `scripts/build.bat` to match your paths
- Run the build batch file to automatically create versioned builds
- There's also individual build batch files for each mod that can be run to build just that mod and copy the previous builds files into this build

## Credits

### Audio
- Music and sound effects from:
  - [Pixabay.com](https://pixabay.com)
  - [Zapsplat.com](https://www.zapsplat.com)

