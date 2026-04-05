extends AnimatedSprite2D

@onready var blipFlash : AnimatedSprite2D = $"../blipflash"
@onready var detector : Area2D = $detector
@export var camera : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	detector.input_event.connect(_on_detector_input_event)
	Global.switchedCamera.connect(switchedCamera)

func _on_detector_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("leftMouse"):
		Global.currentCamera = camera
		Global.switchedCamera.emit()
		blipFlash.play("default")
		$"../MinidvCameraBeepChimeUp".play()
	if camera == "kitchen" and Global.chicaPos == "kitchen":
		$"../NiamNiamNiam".play()
	elif camera == "kitchen" and Global.freddyPos == "kitchen":
		$"../NiamNiamNiam2".play()

func switchedCamera() -> void:
	if Global.currentCamera == camera:
		play("pressed")
	else:
		play("unpressed")
