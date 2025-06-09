extends CharacterBody2D

@export var speed = 100
@export var rotationSpeed = 0.1
@export var damage = 1
@export var life = 1
@export var orientation = 0.6
var direction

@onready var explosion_constructor = preload("res://FX/Explosion/Explosion.tscn")

func _ready():
	rotationSpeed = randf_range(-rotationSpeed, rotationSpeed)
	direction = Vector2(randf_range(-orientation, orientation), 1).normalized()

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	rotation += rotationSpeed
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	Game.life -= damage
	explode()
	queue_free()

func explode() -> void:
	var explosion = explosion_constructor.instantiate()
	explosion.global_position = global_position
	get_tree().root.add_child(explosion)
