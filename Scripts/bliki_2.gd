extends AnimatedSprite2D

func _ready() -> void:
	$rest.connect("timeout", restTimeOut)
	$twitch.connect("timeout", twitchTimeout)
	restStart()
#Дёргание
func restTimeOut() -> void:
	visible = true
	twitchStart()	

func twitchTimeout() -> void:
	visible=false
	restStart()

func restStart() -> void:
	$rest.wait_time = randf_range(1, 3)
	$rest.start()

func twitchStart() -> void:
	$twitch.wait_time = randf_range(0.1, 0.4)
	$twitch.start()
