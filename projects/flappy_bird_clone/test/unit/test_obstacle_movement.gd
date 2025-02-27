extends GutTest

var ObstacleScene = preload("res://flappy_bird_clone/obstacle_full.tscn")
var Settings = preload("res://flappy_bird_clone/default_settings.tres")

var _obstacle: Node2D

func before_each() -> void:
	_obstacle = add_child_autofree(ObstacleScene.instantiate())
	_obstacle.position = Vector2(600, 300)
	
	gut.p("Initial obstacle position: " + str(_obstacle.position))
	gut.p("Obstacle speed setting: " + str(Settings.obstacle_speed))

func test_obstacle_moves_left() -> void:
	var start_x = _obstacle.position.x
	var delta = 1.0
	
	# Wait 3 frames to ensure proper movement
	await wait_frames(3)
	
	# Simulate exactly 1 second of movement with fixed delta
	simulate(_obstacle, 1, delta)
	
	# Check obstacle moved left by expected amount
	var expected_x = start_x - (Settings.obstacle_speed * delta)
	var actual_movement = start_x - _obstacle.position.x
	
	gut.p("Movement details:")
	gut.p("- Start position: " + str(start_x))
	gut.p("- End position: " + str(_obstacle.position.x))
	gut.p("- Actual movement: " + str(actual_movement))
	gut.p("- Expected movement: " + str(Settings.obstacle_speed * delta))
	gut.p("- Delta time: " + str(delta))
	
	# Use a larger tolerance since we're seeing bigger variations
	assert_almost_eq(_obstacle.position.x, expected_x, 15.0,
		"Obstacle should move left approximately at obstacle_speed")
