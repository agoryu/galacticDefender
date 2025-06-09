extends Node2D

@onready var canon : CharacterBody2D = $Canon
@onready var fire_timer : Timer = $FireTimer
@onready var bullet_constructor = preload("res://Character/Shooter/Bullet/Bullet.tscn")

@export var speed = 0.5

func _physics_process(delta: float) -> void:
	update_shoot_direction()

func update_shoot_direction():
	var shoot_direction = get_gamepad_direction()
	canon.rotation_degrees += speed * shoot_direction
	canon.rotation_degrees = clamp(canon.rotation_degrees, -90, 90)
	if Input.is_action_pressed("ui_accept") and fire_timer.is_stopped():
		var bullet = bullet_constructor.instantiate()
		bullet.global_position = $Canon/Spawner.global_position
		bullet.rotation = $Canon.rotation
		get_parent().add_child(bullet)
		fire_timer.start()

func get_gamepad_direction():
	if Input.is_action_pressed("ui_left"):
		return -1
	if Input.is_action_pressed("ui_right"):
		return 1
	return 0
