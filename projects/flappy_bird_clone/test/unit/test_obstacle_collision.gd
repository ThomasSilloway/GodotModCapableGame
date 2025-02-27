extends GutTest

var ObstacleHalfScene = preload("res://flappy_bird_clone/obstacle_half.tscn")
var PlayerScene = preload("res://flappy_bird_clone/scripts/player.gd")
var Settings = preload("res://flappy_bird_clone/default_settings.tres")

var _obstacle_half: ColorRect
var _player: CharacterBody2D

func before_each() -> void:
	_obstacle_half = add_child_autofree(ObstacleHalfScene.instantiate())
	
	# Create player with proper script and settings
	_player = add_child_autofree(CharacterBody2D.new())
	_player.set_script(PlayerScene)
	_player.settings = Settings
	_player.add_to_group("player")
	
	# Add collision shape to player
	var collision = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 25.0
	collision.shape = shape
	_player.add_child(collision)
	
	# Position player and obstacle for testing
	_obstacle_half.position = Vector2(400, 300)
	_player.position = Vector2(300, 300)
	
	# Ensure Area2D is monitoring and has correct collision settings
	var collider = _obstacle_half.get_node("Collider")
	collider.monitorable = true
	collider.monitoring = true
	collider.collision_layer = 1
	collider.collision_mask = 1
	
	# Set player collision settings
	_player.collision_layer = 1
	_player.collision_mask = 1
	
	gut.p("Initial positions - Player: " + str(_player.position) + ", Obstacle: " + str(_obstacle_half.position))
	gut.p("Collider monitoring: " + str(collider.monitoring) + ", monitorable: " + str(collider.monitorable))
	gut.p("Player collision layer: " + str(_player.collision_layer) + ", mask: " + str(_player.collision_mask))
	gut.p("Collider collision layer: " + str(collider.collision_layer) + ", mask: " + str(collider.collision_mask))
	gut.p("Collider global position: " + str(collider.global_position))
	gut.p("Collider shape position: " + str(collider.get_node("CollisionShape2D").position))

func test_collision_emits_signal() -> void:
	# Watch for the player_hit signal
	watch_signals(_obstacle_half)
	
	# Wait for initial physics setup
	await wait_frames(3)
	
	# Log initial positions
	gut.p("Pre-collision positions - Player: " + str(_player.position) + ", Obstacle: " + str(_obstacle_half.position))
	
	# Move player directly into obstacle's collision area
	for i in range(10):
		_player.position.x += 10
		await wait_frames(1)
		gut.p("Player position during movement: " + str(_player.position))
	
	# Wait for collision to be processed
	await wait_frames(3)
	
	# Log final positions and collision info
	gut.p("Final positions - Player: " + str(_player.position) + ", Obstacle: " + str(_obstacle_half.position))
	
	# Verify the signal was emitted
	assert_signal_emitted(_obstacle_half, "player_hit",
		"Obstacle should emit player_hit signal on collision") 
