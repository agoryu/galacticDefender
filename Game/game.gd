extends Node

signal updateLife
signal game_over

@export var life = 2 : set = _setLife

func _setLife(value):
	life = value
	emit_signal("updateLife")
	if value <= 0:
		emit_signal("game_over")
