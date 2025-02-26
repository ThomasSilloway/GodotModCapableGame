extends GutTest

# Reference to the player scene/script
var Player = load("res://flappy_bird_clone/scripts/player.gd")
var _player = null

func before_each():
	# Create a fresh player instance before each test
	_player = Player.new()
	add_child_autofree(_player)
	
	# Wait a couple frames to ensure the player is properly initialized
	await wait_frames(2)

func after_each():
	_player = null

func test_player_applies_falling_force():
	# Store initial vertical velocity
	var initial_velocity = _player.velocity.y
	
	# Wait a few frames to let gravity take effect
	await wait_frames(3)
	
	# Check that player is falling (velocity.y has increased)
	assert_gt(_player.velocity.y, initial_velocity, 
		"Player should have a greater downward velocity due to gravity")

func test_player_jump():
	# Store initial vertical velocity
	var initial_velocity = _player.velocity.y
	
	# Simulate jump input
	Input.action_press("jump")
	await wait_frames(1)
	Input.action_release("jump")
	await wait_frames(2)
	# Check that player moved upward (negative velocity in Godot's coordinate system)
	assert_lt(_player.velocity.y, initial_velocity, 
		"Player should have upward velocity after jump")
	
	# Wait a few frames to ensure jump force was properly applied
	await wait_frames(2)
	assert_lt(_player.velocity.y, 0, 
		"Player should maintain upward velocity briefly after jump")

func test_consecutive_jumps_have_same_force():
	# First jump
	Input.action_press("jump")
	await wait_frames(1)
	Input.action_release("jump")
	await wait_frames(2)
	var first_jump_velocity = _player.velocity.y
	
	# Wait for player to fall a bit
	await wait_frames(10)
	
	# Second jump
	Input.action_press("jump")
	await wait_frames(1)
	Input.action_release("jump")
	await wait_frames(2)
	var second_jump_velocity = _player.velocity.y
	
	# Check that both jumps had the same force
	assert_eq(first_jump_velocity, second_jump_velocity,
		"Consecutive jumps should apply the same upward force") 
