extends Sprite2D

const menu : PackedScene = preload("res://MENUIGRI/menu.tscn")
var canSkip : bool = false

func _ready() -> void:
	$Timer.connect("timeout", timerTimeout)
	$Animation.connect("animation_finished", animDone)
	$Animation.play("fade in")
	
func timerTimeout() -> void:
	$Animation.play("fade out")

func animDone(animName : StringName) -> void:
	if animName == "fade in":
		canSkip = true
		$Timer.start()
	if animName == "fade out":
		get_tree().change_scene_to_packed(menu)

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("skip warning") and canSkip == true:
		$Animation.play("fade out")
