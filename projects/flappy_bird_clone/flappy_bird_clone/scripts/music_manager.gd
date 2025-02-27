extends Node

@export_range(-80, 6) var music_volume_db: float = 0.0
var music_player: AudioStreamPlayer

func _ready() -> void:
	# Create audio player for background music
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	# Load and set up background music
	var music = load("res://flappy_bird_clone/audio/background_music.mp3")
	music_player.stream = music
	music_player.bus = "Music"
	music_player.volume_db = music_volume_db
	
	# Start playing music on loop
	music_player.play()
