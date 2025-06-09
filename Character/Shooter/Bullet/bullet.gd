extends CharacterBody2D

@export var speed = 800
@export var damage = 1

@onready var sprite:= $AnimatedSprite2D
@onready var cartridge_constructor = preload("res://Static/Cartridge/Cartridge.tscn")

func _ready():
	sprite.play("default")

func _physics_process(delta):
	var direction = Vector2(sin(rotation), -cos(rotation))
	move_and_collide(direction.normalized() * speed * delta)
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.life -= damage
	if body.life <= 0:
		body.queue_free()
		var cartridge = cartridge_constructor.instantiate()
		cartridge.global_position = global_position
		get_parent().add_child(cartridge)
	queue_free()
