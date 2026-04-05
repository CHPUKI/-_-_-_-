extends AnimatedSprite2D

func _process(_delta: float) -> void:
	frame = Global.usage -1
	print(Global.usage)
