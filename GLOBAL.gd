extends Node


var leftDoorClosed=false
var leftLightOn=false
var rightDoorClosed=false
var rightLightOn=false
var camUp=false
var freddyPos = "stage"
var bonniePos = "stage"
var chicaPos = "stage"
var foxyPos = "root"
var currentCamera = "stage"
var disableLight = " "
var foxyProcess := 0
var restart := 0
var usage : float = 1.0
var power : float = 100.0
var a: int = 0
var b: int = 0
var don := 0
var dun = "00"
var dap = " "
var ban := 0
@warning_ignore("unused_signal")
signal switchedCamera(currentCamera : String)
var AI: Dictionary = {
	"bonnie": 11,      # Уровень активности Бонни
	"chica": 9,       # Уровень активности Чики
	"freddy": 5,      # Уровень активности Фредди
	"foxy": 10,        # Уровень активности Фокси 
}
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func officePan() -> void:
	print(1)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_ESCAPE:
				get_tree().quit()
