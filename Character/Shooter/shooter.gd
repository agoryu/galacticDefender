extends Node2D

@onready var canon : CharacterBody2D = $Canon
@onready var fire_timer : Timer = $FireTimer
@onready var bullet_constructor = preload("res://Character/Shooter/Bullet/Bullet.tscn")
@onready var bulletsProgressBar : ProgressBar = $"../BulletsCrate/BulletsProgressBar"

@export var speed = 0.5
@export var bonus_speed = 0.2
@export var bonus_speed_fire = 0.5
@export var particles : GPUParticles2D

var num_canon = 1

func _physics_process(delta: float) -> void:
	update_shoot_direction()
	if bulletsProgressBar.value > 0:
		if Input.is_action_pressed("p1_accept") and fire_timer.is_stopped():
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
			
	$Canon/Line2D.visible = Game.is_observe

func update_shoot_direction():
	var shoot_direction = get_gamepad_direction()
	canon.rotation_degrees += speed * shoot_direction
	canon.rotation_degrees = clamp(canon.rotation_degrees, -90, 90)

func get_gamepad_direction():
	if Input.is_action_pressed("p1_left"):
		return -1
	if Input.is_action_pressed("p1_right"):
		return 1
	return 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.reserve_bar.value > 0:
		bulletsProgressBar.value += body.reserve_bar.value
		body.reserve_bar.value = 0

func _on_boost_station_area_body_entered(body: Node2D) -> void:
	speed += bonus_speed
	fire_timer.wait_time -= bonus_speed_fire
	modulate = Color(1., 1., 0.3)
	particles.modulate = Color(1., 1., 0.5)


func _on_boost_station_area_body_exited(body: Node2D) -> void:
	speed -= bonus_speed
	fire_timer.wait_time += bonus_speed_fire
	modulate = Color(1., 1., 1.)
	particles.modulate = Color(1., 1., 1.)
