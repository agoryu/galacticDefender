extends CharacterBody2D

@export var speed = 800
@export var damage = 1

@onready var sprite:= $AnimatedSprite2D

func _ready():
	sprite.play("default")

func _physics_process(delta):
	var direction = Vector2(sin(rotation), -cos(rotation))
	move_and_collide(direction.normalized() * speed * delta)
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
