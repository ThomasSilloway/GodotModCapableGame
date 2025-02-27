extends ColorRect

signal player_hit

func _ready() -> void:
	# Connect collision detection
	var collider = $Collider
	collider.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_hit.emit()
		# Get game manager and handle crash
		var game_manager = get_tree().get_root().get_node("FlappyBirdGame/GameManager")
		if game_manager:
			game_manager.handle_crash() 
