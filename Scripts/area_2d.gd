extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(mouseEntered)
	mouse_exited.connect(mouseExited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func mouseEntered() -> void:
	Global.camUp = !Global.camUp
	if Global.camUp == true:
		$"../panel".play("default")
		$"../Opencm".play()
		$"../Povorotcm".play()
		$"../../office/Eq".stop()
	else:
		$"../panel".play_backwards("default")
		$"../Closecm".play()
		$"../../office/Eq".play()
		$"../Povorotcm".stop()


func mouseExited() -> void:
	pass
