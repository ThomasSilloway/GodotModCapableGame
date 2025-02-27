extends Node2D

@export var settings: FlappyBirdSettings
var _screen_edge_collider_detected := false

func _ready() -> void:
    # Load default settings if none provided
    if not settings:
        settings = load("res://flappy_bird_clone/default_settings.tres")

    # Connect collision signal from scoring area instead of obstacle halves
    $ScoringArea.area_entered.connect(_on_area_entered)
    print("Obstacle ready. Settings:", settings)

func _process(delta: float) -> void:
    # Move obstacle left at constant speed
    position.x -= settings.obstacle_speed * delta 

func _on_area_entered(area: Area2D) -> void:
    print("Area entered: ", area.name)
    if area.name == "ScreenEdgeCollider" and not _screen_edge_collider_detected:
        print("Screen edge collision detected")
        _screen_edge_collider_detected = true
        _reset_position()

func _reset_position() -> void:
    print("Resetting position. Current x:", position.x)
    # Move the obstacle to the right by obstacle_reset_distance
    position.x += settings.obstacle_reset_distance
    print("New position x:", position.x)
    _screen_edge_collider_detected = false 
