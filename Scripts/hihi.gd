extends Area2D

@onready var audio_player = $HiHiHiHaClashRoyale  # Имя должно совпадать с узлом в сцене

func _ready():
	# Убедимся, что область реагирует на ввод
	input_pickable = true

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		# Проверяем: нажата ЛКМ И именно нажатие (не отпускание)
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			audio_player.play()
