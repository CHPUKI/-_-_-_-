extends TextureRect

const menu : PackedScene = preload("res://MENUIGRI/menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.dap == "06:00":
		Global.don = 7
		$"../Chimes2".play()
		$"../UraPobedaJjs1t4y".play()
		playwin()

func playwin() -> void:
	$"..".visible = true
	$"../AnimationPlayer".play("new_animation")
	$"../../office/Окно1".visible = false
	$"../../office/Окно2".visible = false
	$"../../office/Стекло1".visible = false
	$"../../office/Стекло2".visible = false
	$"../../GUI/TextureRect".visible = false
	$"../../Хомяк".visible = false
	$"../../boing".visible = false
	$"../../right button".visible = false
	$"../../left button".visible = false
	$"../../right door".visible = false 
	$"../../left door".visible = false
	$"../../telephone".visible = false
	$"../../office/Eq".stop()
	$"../../camera".visible = false
	$"../../GUI/Povorotcm".stop()
	$"../../mystery".visible = false
	Global.chicaPos = " "
	Global.bonniePos =" "
	Global.foxyProcess = 0
	Global.freddyPos = " "
	await get_tree().create_timer(18.00).timeout
	get_tree().change_scene_to_packed(menu)
