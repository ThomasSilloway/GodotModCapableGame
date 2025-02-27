extends GutTest

var ObstacleScene = preload("res://flappy_bird_clone/obstacle_full.tscn")
var PlayerScene = preload("res://flappy_bird_clone/scripts/player.gd")
var Settings = preload("res://flappy_bird_clone/default_settings.tres")

var _obstacle: Node2D
var _player: CharacterBody2D

func before_each() -> void:
	_obstacle = add_child_autofree(ObstacleScene.instantiate())
	
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
	_obstacle.position = Vector2(500, 300)
	_player.position = Vector2(400, 100) # Start above and to the left of obstacle

func test_obstacle_moves_left() -> void:
	var start_x = _obstacle.position.x
	
	# Wait 3 frames to ensure proper movement
	await wait_frames(3)
	
	# Simulate 1 second of movement
	simulate(_obstacle, 1, 1.0)
	
	# Check obstacle moved left by expected amount
	var expected_x = start_x - Settings.obstacle_speed
	assert_eq(_obstacle.position.x, expected_x, 
		"Obstacle should move left at obstacle_speed")

func test_collision_emits_signal() -> void:
	# Watch for the player_hit signal
	watch_signals(_obstacle.get_node("ObstacleTop"))
	
	# Wait for initial physics setup
	await wait_frames(3)
	
	# Let player fall naturally towards obstacle
	simulate(_player, 20, 0.1)
	
	# Wait for collision to be processed
	await wait_frames(3)
	
	# Verify the signal was emitted
	assert_signal_emitted(_obstacle.get_node("ObstacleTop"), "player_hit",
		"Obstacle should emit player_hit signal on collision")
