extends GutTest

var ObstacleFull = preload("res://flappy_bird_clone/obstacle_full.tscn")
var FlappyBirdSettings = preload("res://flappy_bird_clone/default_settings.tres")

var _obstacle: Node2D
var _screen_edge_collider: Area2D

func before_each():
	_obstacle = add_child_autofree(ObstacleFull.instantiate())
	_obstacle.settings = FlappyBirdSettings
	
	# Position obstacle somewhere reasonable
	_obstacle.position = Vector2(500, 300)
	
	# Create screen edge collider for testing
	_screen_edge_collider = Area2D.new()
	_screen_edge_collider.name = "ScreenEdgeCollider"
	var collision_shape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.size = Vector2(85, 948) # Match the size in the scene
	collision_shape.shape = shape
	_screen_edge_collider.add_child(collision_shape)
	add_child_autofree(_screen_edge_collider)
	
	print("\nTest setup complete:")
	print("- Obstacle position:", _obstacle.position)
	print("- ScoringArea global position:", _obstacle.get_node("ScoringArea").global_position)
	print("- ScreenEdgeCollider position:", _screen_edge_collider.position)

func trigger_collision():
	var scoring_area = _obstacle.get_node("ScoringArea")
	var collision_pos = scoring_area.global_position + Vector2(165, 6)
	_screen_edge_collider.global_position = collision_pos
	simulate(_obstacle, 1, 0.0) # Use delta of 0 to prevent movement during simulation
	await wait_frames(3)

func test_obstacle_resets_position_on_screen_edge_collision():
	_obstacle.set_process(false)
	var initial_x = _obstacle.position.x
	
	await trigger_collision()
	
	assert_eq(_obstacle.position.x, initial_x + FlappyBirdSettings.obstacle_reset_distance,
		"Obstacle should move right by obstacle_reset_distance when colliding with screen edge")

func test_obstacle_can_reset_again_after_flag_cleared():
	_obstacle.set_process(false)
	var initial_x = _obstacle.position.x
	
	# First collision
	await trigger_collision()
	var first_reset_x = _obstacle.position.x
	
	# Clear the collision detection flag
	_obstacle._screen_edge_collider_detected = false
	
	# Second collision
	await trigger_collision()
	
	assert_eq(_obstacle.position.x, first_reset_x + FlappyBirdSettings.obstacle_reset_distance,
		"Obstacle should be able to reset again after collision flag is cleared") 
