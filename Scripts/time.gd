extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.timeout.connect(timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = "0" + str(Global.don) + ":" + Global.dun
	Global.dap = text

func timeout() -> void:
	if Global.ban >= 0:
		Global.ban += 1
		if Global.ban < 10:
			Global.dun = "0" + str(Global.ban)
		elif Global.ban >= 10:
			Global.dun = str(Global.ban)
			if Global.ban == 60:
				Global.ban = 0
				Global.dun = "0" + str(Global.ban)
				Global.don +=1
