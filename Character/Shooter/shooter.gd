extends Node2D

@onready var canon : CharacterBody2D = $Canon
@onready var fire_timer : Timer = $FireTimer
@onready var bullet_constructor = preload("res://Character/Shooter/Bullet/Bullet.tscn")
@onready var bulletsProgressBar : ProgressBar = $"../BulletsCrate/BulletsProgressBar"

@export var speed = 0.5

var num_canon = 1

func _physics_process(delta: float) -> void:
	update_shoot_direction()
	if bulletsProgressBar.value > 0:
		if Input.is_action_pressed("ui_accept") and fire_timer.is_stopped():
			var bullet = bullet_constructor.instantiate()
			bulletsProgressBar.value -= 1
			
			if num_canon % 2 == 0:
				num_canon = 1
				bullet.global_position = $Canon/Spawner1.global_position
			else:
				num_canon += 1
				bullet.global_position = $Canon/Spawner2.global_position
			bullet.rotation = $Canon.rotation
			get_tree().root.add_child(bullet)
			fire_timer.start()

func update_shoot_direction():
	var shoot_direction = get_gamepad_direction()
	canon.rotation_degrees += speed * shoot_direction
	canon.rotation_degrees = clamp(canon.rotation_degrees, -90, 90)

func get_gamepad_direction():
	if Input.is_action_pressed("ui_left"):
		return -1
	if Input.is_action_pressed("ui_right"):
		return 1
	return 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.mun > 0:
		bulletsProgressBar.value += body.mun
		body.mun = 0
