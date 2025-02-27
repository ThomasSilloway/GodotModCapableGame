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
    
    # Move the character and check for collisions
    var collision = move_and_collide(velocity * delta)
    if collision:
        # If we hit the floor, restart the game
        if collision.get_collider() is StaticBody2D:
            get_tree().reload_current_scene()
    else:
        # If no collision occurred, apply the regular movement
        move_and_slide() 
