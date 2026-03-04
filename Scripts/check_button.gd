extends CheckButton

func _on_toggled(toggled_on: bool) -> void:
	if button_pressed == true:
		DisplayServer.window_get_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_get_mode(DisplayServer.WINDOW_MODE_WINDOWED)
