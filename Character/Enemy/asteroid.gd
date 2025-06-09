extends CharacterBody2D

@onready var speed = 2
@onready var damage = 2
@onready var life = 3

func _physics_process(delta: float) -> void:
	position.y += speed

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
