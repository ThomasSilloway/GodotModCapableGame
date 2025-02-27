extends Node

signal score_updated(new_score: int)

var current_score: int = 0
@onready var score_label: Label = $"../HUD/ScoreBackground/ScoreLabel"

func _ready() -> void:
	# Initialize score display
	update_score_display()
	
	# Connect to all existing obstacles' scoring areas
	for obstacle in get_tree().get_nodes_in_group("obstacles"):
		var scoring_area = obstacle.get_node("ScoringArea")
		scoring_area.body_entered.connect(_on_scoring_area_entered)

func _on_scoring_area_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		increment_score()

func increment_score() -> void:
	current_score += 1
	update_score_display()
	score_updated.emit(current_score)

func update_score_display() -> void:
	if score_label:
		score_label.text = str(current_score)

func reset_score() -> void:
	current_score = 0
	update_score_display() 