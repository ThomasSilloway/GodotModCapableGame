extends Node2D

@export var settings: FlappyBirdSettings

func _ready() -> void:
    # Load default settings if none provided
    if not settings:
        settings = load("res://flappy_bird_clone/default_settings.tres")

func _process(delta: float) -> void:
    # Move obstacle left at constant speed
    position.x -= settings.obstacle_speed * delta 