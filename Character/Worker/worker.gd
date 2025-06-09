extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_velocity: float = -400.0
@export var max_mun = 6

@onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var mun = 0

func _physics_process(delta):
	var velocity = self.velocity

	# Mouvement gauche/droite
	var direction = Input.get_action_strength("p2_right") - Input.get_action_strength("p2_left")
	velocity.x = direction * speed
	if direction != 0:
		$Sprite2D.flip_h = direction < 0

	# Appliquer la gravité
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Saut
		if Input.is_action_just_pressed("p2_accept"):
			velocity.y = jump_velocity

	self.velocity = velocity
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.value + mun <= max_mun:
		mun += body.value
		body.queue_free()
