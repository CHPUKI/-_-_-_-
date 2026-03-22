extends Node

var leftDoorClosed=false
var leftLightOn=false
var rightDoorClosed=false
var rightLightOn=false
var camUp=false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	

func officePan() -> void:
	print(1)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_ESCAPE:
				get_tree().quit()
