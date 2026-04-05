extends RichTextLabel

const menu : PackedScene = preload("res://MENUIGRI/menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.timeout.connect(timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = "[font_size={40}]" + str(Global.power) + "[font_size={20}]%"

func timeout() -> void:
	if Global.power > 0:
		Global.power -= Global.usage / 20
		Global.power = snapped(Global.power, 0.01)
	if Global.power <= 0:
		$Timer.stop()
		$"../../office/HiHiHiHaClashRoyale".play()
		loweredCam()

func loweredCam() -> void:
	$"../../office".play("jumpscare freddy")
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
	$"..".visible = false
	await get_tree().create_timer(8.00).timeout
	get_tree().change_scene_to_packed(menu)
