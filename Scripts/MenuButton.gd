extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(mouseEntered)
	$"../newspaper/Animation".animation_finished.connect(newspaperDone)

func  mouseEntered() -> void:
	if $"../AROW".position.y != position.y:
		$"../knopka".play()
	$"../AROW".position.y = position.y

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("guiClick"):
		get_tree().paused = true
		$"../newspaper".visible = true
		$"../newspaper/Animation".play("show newspaper")

func newspaperDone(_animName : StringName) -> void:
	if name == "NEW GAME":
		get_tree().paused = false
		var scene : PackedScene	= load("res://scens/night_start.tscn")
		get_tree().change_scene_to_packed(scene)
