extends ColorRect

signal player_hit

func _ready() -> void:
	# Connect collision detection
	var collider = $Collider
	collider.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_hit.emit()
		# Play crash sound
		var audio_manager = get_tree().get_root().get_node("FlappyBirdGame/AudioManager")
		if audio_manager:
			audio_manager.play_crash()
		# Defer the scene reload to avoid physics callback issues
		get_tree().call_deferred("reload_current_scene") 
