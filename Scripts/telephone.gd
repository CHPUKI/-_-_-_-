extends AnimatedSprite2D


func _ready() -> void:
	$sloman.input_event.connect(slomanInput)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func slomanInput(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("guiClick"):
		$"../telephone".play("sloman")
		$"Buuuuuuuuuuuuuuuuuuuuuuuuum7Sun4Owf".play()
		$"sloman".process_mode=Node.PROCESS_MODE_DISABLED
