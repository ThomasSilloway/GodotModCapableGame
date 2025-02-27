extends ColorRect

signal player_hit

func _ready() -> void:
	# Connect collision detection
	var collider = $Collider
	collider.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_hit.emit()
		# Defer the scene reload to avoid physics callback issues
		get_tree().call_deferred("reload_current_scene") 
