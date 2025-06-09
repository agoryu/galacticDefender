extends CanvasLayer

@onready var lifeBar : ProgressBar = $ProgressBar
@onready var game_over : Control = $GameOver

func _ready():
	lifeBar.max_value = Game.life
	lifeBar.value = Game.life
	Game.updateLife.connect(_updateLife)
	Game.game_over.connect(_game_over)
	
func _updateLife():
	lifeBar.value = Game.life
	
func _game_over():
	get_tree().paused = true
	game_over.visible = true
