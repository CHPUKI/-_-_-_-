extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$door.input_event.connect(doorInput)
	$light.input_event.connect(lightInput)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func doorInput(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("guiClick"):
		if $"../left door".frame == 0 or $"../left door".frame == 7:
			$"DoorRoomsFloorDoorOpen".play()
			if name == "left button":
				if $"../left door".frame == 0:
					$"../left door".play("close")
				else:
					$"../left door".play_backwards("close")

func lightInput (_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	pass
