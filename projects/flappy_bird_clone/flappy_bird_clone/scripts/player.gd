extends CharacterBody2D

@export var settings: FlappyBirdSettings

func _ready() -> void:
    # Ensure settings resource exists
    if not settings:
        settings = FlappyBirdSettings.new()

func _physics_process(delta: float) -> void:
    # Apply gravity
    velocity.y += settings.gravity * delta
    
    # Handle jump input
    if Input.is_action_just_pressed("jump") or Input.is_key_pressed(KEY_SPACE):
        velocity.y = settings.jump_force
    
    # Move the character
    move_and_slide() 
