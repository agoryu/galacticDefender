extends Node

signal updateLife

@export var life = 10 : set = _setLife

func _setLife(value):
	life = value
	emit_signal("updateLife")
