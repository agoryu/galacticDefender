extends Camera2D

@onready var timer: Timer = $Timer

@export var shake_amount : float = 5.0
@export var character : CharacterBody2D

func _ready():
	reparent(character)
	limit_right = get_viewport_rect().size.x
	limit_bottom = get_viewport_rect().size.y
	Game.updateLife.connect(_update_life)

func _process(delta) -> void:
	global_position = character.global_position
	if not timer.is_stopped():
		offset = Vector2(
			randf_range(-1.0, 1.0) * shake_amount,
			randf_range(-1.0, 1.0) * shake_amount
		)
	else:
		offset = Vector2.ZERO
		
	if Game.is_observe and zoom.x > 1:
		var tween = create_tween()
		tween.tween_property(self, "zoom", Vector2(1., 1.), 0.5)
	if not Game.is_observe and zoom.x < 1.4:
		var tween = create_tween()
		tween.tween_property(self, "zoom", Vector2(1.5, 1.5), 2.)

func _update_life(diff: int):
	if diff > 0:
		take_damage()

func take_damage():
	timer.start()
	Input.start_joy_vibration(0, 0.5, 0.5)
	Input.start_joy_vibration(1, 0.5, 0.5)

func _on_timer_timeout() -> void:
	Input.stop_joy_vibration(0)
	Input.stop_joy_vibration(1)
