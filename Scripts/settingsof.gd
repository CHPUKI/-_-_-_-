extends Sprite2D


func _ready() -> void:
	$Area2D.input_event.connect(SettingsOf)

func SettingsOf(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("guiClick"):
		if $CanvasLayer.visible == false:
			$CanvasLayer.visible = true
		else:
			$CanvasLayer.visible = false
