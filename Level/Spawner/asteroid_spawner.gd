extends Path2D

@onready var path_follow : PathFollow2D = $PathFollow2D
@onready var asteroid_constructor = preload("res://Character/Enemy/Asteroid.tscn")

func spawn() -> void:
	var asteroid = asteroid_constructor.instantiate()
	path_follow.progress_ratio = randf()
	asteroid.position = path_follow.global_position
	get_parent().add_child(asteroid)


func _on_timer_timeout() -> void:
	spawn()
