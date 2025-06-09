extends Node2D

@onready var lifeBar : ProgressBar = $ProgressBar

func _ready():
	lifeBar.max_value = Game.life
	lifeBar.value = Game.life
	Game.updateLife.connect(_updateLife)
	
func _updateLife():
	lifeBar.value = Game.life
