extends Area2D

var canFlip=true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(mouseEntered)
	mouse_exited.connect(mouseExited)
	$"../panel".animation_finished.connect(panelAnimation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func mouseEntered() -> void:
	if canFlip == true:
		canFlip = false
		Global.camUp = !Global.camUp
		if Global.camUp == true:
			Global.usage += 1
			$"../panel".play("default")
			$"../Opencm".play()
			$"../Povorotcm".play()
			$"../../office/Eq".stop()
		else:
			Global.usage -= 1
			$"../panel".play_backwards("default")
			$"../Closecm".play()
			$"../../office/Eq".play()
			$"../Povorotcm".stop()
			$"../../camera".visible = false

func mouseExited() -> void:
	pass

func panelAnimation() -> void:
	canFlip = true
	if Global.camUp == true:
		$"../../camera/Sprite".play("stage bcf")
		$"../../camera".visible = true
		Global.switchedCamera.emit()
