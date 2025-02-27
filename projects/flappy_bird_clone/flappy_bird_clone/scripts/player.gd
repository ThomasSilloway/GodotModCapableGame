extends CharacterBody2D

@export var settings: FlappyBirdSettings
@onready var audio_manager = $"../AudioManager"

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
        # Play jump sound
        if audio_manager:
            audio_manager.play_jump()
    
    # Move the character and check for collisions
    var collision = move_and_collide(velocity * delta)
    if collision:
        # If we hit the floor, play crash sound and restart
        if collision.get_collider() is StaticBody2D:
            if audio_manager:
                audio_manager.play_crash()
            get_tree().reload_current_scene()
    else:
        # If no collision occurred, apply the regular movement
        move_and_slide() 
