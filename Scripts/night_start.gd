extends Control

var scene : PackedScene = preload("res://scens/office.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label/animation.animation_finished.connect(fadeDone)
	$Label/animation.play("fade out")
	$blip.play()
	$"blip flesh".visible = true
	$"blip flesh".play("default")
	
func fadeDone(_animName :StringName) -> void:
	$clock/AnimationPlayer.animation_finished.connect(perehod)
	$clock.visible = true
	$clock/AnimationPlayer.play("krut")
	
	
func perehod(_animName :StringName) -> void:
	get_tree().change_scene_to_packed(scene)
