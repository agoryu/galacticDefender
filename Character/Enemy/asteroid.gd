extends CharacterBody2D

@export var speed = 100
@export var rotationSpeed = 0.1
@export var damage = 1
@export var life = 3
@export var orientation = 0.6
@export var fire_scale = 1.0

var direction
var fire_step = 0.05

@onready var explosion_constructor = preload("res://FX/Explosion/Explosion.tscn")
@onready var fire : Sprite2D = $Fire

func _ready():
	rotationSpeed = randf_range(-rotationSpeed, rotationSpeed)
	direction = Vector2(randf_range(-orientation, orientation), 1).normalized()
	fire.rotation = PI - direction.x

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	$Sprite2D.rotation += rotationSpeed
	anim_engine()
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$Timer.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	Game.life -= damage
	explode()
	queue_free()

func explode() -> void:
	var explosion = explosion_constructor.instantiate()
	explosion.global_position = global_position
	get_tree().root.add_child(explosion)

func anim_engine():
	if fire and speed > 0:
		if (fire_scale > 1.4 and fire_step > 0):
			fire_step = -0.01
		elif (fire_scale < 0.9 and fire_step < 0):
			fire_step = 0.01
		fire_scale += fire_step
		fire.scale = Vector2.ONE * 0.15 * fire_scale

func _on_timer_timeout() -> void:
	if not visible:
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if not $Timer.is_stopped():
		$Timer.stop()
