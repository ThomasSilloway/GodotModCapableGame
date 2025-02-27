extends Node

signal game_over

var crash_timer: Timer

func _ready() -> void:
	# Set up crash timer
	crash_timer = Timer.new()
	crash_timer.one_shot = true
	crash_timer.wait_time = 1.0
	crash_timer.timeout.connect(_on_crash_timer_timeout)
	# Make sure timer works even when game is paused
	crash_timer.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(crash_timer)

func handle_crash() -> void:
	# Emit game over signal
	game_over.emit()
	
	# Play crash sound
	var audio_manager = get_node_or_null("../AudioManager")
	if audio_manager:
		audio_manager.play_crash()
	
	# Pause the game and start the timer
	get_tree().paused = true
	crash_timer.start()

func _on_crash_timer_timeout() -> void:
	# Unpause before reloading
	get_tree().paused = false
	get_tree().reload_current_scene() 