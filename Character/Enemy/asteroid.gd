extends CharacterBody2D

@export var speed = 2
@export var damage = 2
@export var life = 1

func _physics_process(delta: float) -> void:
	position.y += speed

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	Game.life -= damage
	queue_free()
