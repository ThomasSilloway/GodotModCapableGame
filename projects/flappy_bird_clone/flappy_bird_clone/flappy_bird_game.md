# Godot Scene

## Nodes
- **FlappyBirdGame** (Node2D)
  - **Floor** (StaticBody2D)
    - **CollisionShape2D** (CollisionShape2D)
    - **ColorRect** (ColorRect)
  - **Camera2D** (Camera2D)
  - **Player** (CharacterBody2D)
    - script: res://flappy_bird_clone/scripts/player.gd
    - settings: res://flappy_bird_clone/default_settings.tres
    - **CollisionShape2D** (CollisionShape2D)
    - **Sprite2D** (Sprite2D)

## Connections
