extends AnimatedSprite2D

func _ready() -> void:
	$rest.connect("timeout", restTimeOut)
	$twitch.connect("timeout", twitchTimeout)
	$fade.connect("timeout", fadeTimeout)
	restStart()
#Дёргание
func restTimeOut() -> void:
	frame = randi_range(1,73)
	twitchStart()	

func twitchTimeout() -> void:
	frame = 0
	restStart()

func restStart() -> void:
	$rest.wait_time = randf_range(0.5, 0.9)
	$rest.start()

func twitchStart() -> void:
	$twitch.wait_time = randf_range(0.09, 0.12)
	$twitch.start()
#fade
func fadeTimeout() -> void:
	modulate.a = randf_range(0.3,1.0)
	$"../Bliki".material.a =randf_range(0.4,0.6)
