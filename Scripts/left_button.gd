extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$door.input_event.connect(doorInput)
	$light.input_event.connect(lightInput)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func doorInput(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("guiClick"):
		if name == "left button":
			if $"../left door".frame == 0 or $"../left door".frame == 7:
				Global.leftDoorClosed = !Global.leftDoorClosed
				$"DoorRoomsFloorDoorOpen".play()
				if Global.leftDoorClosed == true:
					Global.usage += 1
					$"../left door".play("close")
					frame += 1
				else:
					$"../left door".play_backwards("close")
					frame -= 1
					Global.usage -= 1

func lightInput (_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("guiClick"):
		if name == "left button":
			Global.leftLightOn = !Global.leftLightOn
			if Global.leftLightOn == true:
				Global.usage += 1
				$"../office".frame = 0
				$"../office".frame += 1 + Global.a
				frame += 2
				if Global.rightLightOn == true:
					Global.rightLightOn = false
					$"../right button".frame -= 2
					Global.usage -= 1
			else:
				$"../office".frame -= 1 + Global.a
				frame -= 2
				Global.usage -= 1
