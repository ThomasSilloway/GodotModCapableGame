extends Node

@export_range(-80, 6) var crash_volume_db: float = 0.0
@export_range(-80, 6) var jump_volume_db: float = 0.0

var crash_sound: AudioStreamPlayer
var jump_sound: AudioStreamPlayer

func _ready() -> void:
	# Set up crash sound
	crash_sound = AudioStreamPlayer.new()
	add_child(crash_sound)
	crash_sound.stream = load("res://flappy_bird_clone/audio/crash.wav")
	crash_sound.bus = "SFX"
	crash_sound.volume_db = crash_volume_db
	
	# Set up jump sound
	jump_sound = AudioStreamPlayer.new()
	add_child(jump_sound)
	jump_sound.stream = load("res://flappy_bird_clone/audio/jump_up.wav")
	jump_sound.bus = "SFX"
	jump_sound.volume_db = jump_volume_db

func play_crash() -> void:
	crash_sound.volume_db = crash_volume_db
	crash_sound.play()

func play_jump() -> void:
	jump_sound.volume_db = jump_volume_db
	jump_sound.play()

