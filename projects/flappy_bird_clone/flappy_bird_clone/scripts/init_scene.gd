extends Node

func _ready() -> void:
	print("Flappy Bird mod ready")
	
	# If we're in the editor, we won't have a ConfigManager
	if OS.has_feature("editor"):
		register_game_scene()
	else:
		# Get the config manager and register our game scene
		var config_manager = get_tree().root.get_node_or_null("ConfigManager")
		if config_manager != null:
			# Set the game scene path in config
			config_manager.config.game_scene = "res://flappy_bird_clone/flappy_bird_game.tscn"
			print("Flappy Bird mod: Game scene registered successfully")
		else:
			printerr("Flappy Bird mod - could not find config manager")

func register_game_scene() -> void:
	# This is called when running in the editor
	# You can add any editor-specific initialization here
	print("Flappy Bird mod: Running in editor mode") 