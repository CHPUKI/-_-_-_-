extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$door.input_event.connect(doorInput)
	$light.input_event.connect(lightInput)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func doorInput(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("guiClick"):
		if name == "right button":
			if $"../right door".frame == 0 or $"../right door".frame == 7:
				Global.rightDoorClosed = !Global.rightDoorClosed
				$"DoorRoomsFloorDoorOpen".play()
				if Global.rightDoorClosed == true:
					Global.usage += 1
					$"../right door".play("close")
					frame += 1
				else:
					$"../right door".play_backwards("close")
					frame -= 1
					Global.usage -= 1

func lightInput (_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("guiClick"):
		if name == "right button":
			Global.rightLightOn = !Global.rightLightOn
			if Global.rightLightOn == true:
				Global.usage += 1
				$"../office".frame = 0
				$"../office".frame += 2 +Global.b
				frame += 2
				if Global.leftLightOn == true:
					Global.leftLightOn = false
					$"../left button".frame -= 2
					Global.usage -= 1
			else:
				$"../office".frame -= 2 + Global.b
				frame -= 2
				Global.usage -= 1
