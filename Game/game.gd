extends Node

signal updateLife
signal game_over
signal update_score

@export var life = 10 : set = _setLife

var score = 0 : set = _setScore

func _setLife(value):
	life = value
	emit_signal("updateLife")
	if value <= 0:
		emit_signal("game_over")
		
func _setScore(score_value):
	score = score_value
	emit_signal("update_score")
