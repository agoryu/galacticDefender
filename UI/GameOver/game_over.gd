extends Control

func _on_retry_button_up() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_exit_button_up() -> void:
	get_tree().paused = false
	get_tree().quit()

func _on_visibility_changed() -> void:
	if visible:
		$Button/Retry.grab_focus()
