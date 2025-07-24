extends Node2D

signal activate_boost
signal desactivate_boot

@onready var particles : GPUParticles2D = $GPUParticles2D

func _on_boost_station_area_body_entered(body: Node2D) -> void:
	particles.modulate = Color(1., 1., 0.5)
	emit_signal("activate_boost")

func _on_boost_station_area_body_exited(body: Node2D) -> void:
	particles.modulate = Color(1., 1., 1.)
	emit_signal("desactivate_boot")
