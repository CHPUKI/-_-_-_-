extends Node2D

const menu : PackedScene = preload("res://MENUIGRI/menu.tscn")

func _ready() -> void:
	$Timer.timeout.connect(timeout)

func _process(_delta: float) -> void:
	loweredCam()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func timeout() -> void:
	if randi_range(1,20) <= Global.AI["chica"]:
		move()

func move() -> void:
	match Global.chicaPos:
		"stage":
			if Global.bonniePos == "dining area" or Global.bonniePos =="dining area":
				Global.chicaPos = "kitchen"
			else:
				Global.chicaPos = "dining area"
		"kitchen":
			if Global.bonniePos == "dining area" or Global.bonniePos =="dining area":
				Global.chicaPos = ["kitchen", "east hall"].pick_random()
			else:
				Global.chicaPos = "dining area"
		"dining area":
			Global.chicaPos = ["kitchen" , "east hall"].pick_random()
		"east hall":
			Global.chicaPos = ["kitchen", "east hall corner",].pick_random()
		"east hall corner":
			Global.chicaPos = ["east hall", "right door"].pick_random()
		"right door":
			if Global.rightDoorClosed == true:
				Global.chicaPos = "kitchen"
			else:
				if Global.camUp == true:
					$"../GUI/panel".play_backwards()
					Global.chicaPos = "office"
					$"../office/Uf".play()
				else:
					Global.chicaPos = "office"
					$"../office/Uf".play()
	print("chica " + Global.chicaPos)
	if Global.chicaPos == "right door" and Global.b <2:
		Global.b += 2
	if Global.chicaPos != "right door":
		Global.b = 0

func loweredCam() -> void:
	if Global.chicaPos == "office":
		$"../office".play("jumpscare chica")
		$"../office/Окно1".visible = false
		$"../office/Окно2".visible = false
		$"../office/Стекло1".visible = false
		$"../office/Стекло2".visible = false
		$"../GUI/TextureRect".visible = false
		$"../Хомяк".visible = false
		$"../boing".visible = false
		$"../right button".visible = false
		$"../left button".visible = false
		$"../right door".visible = false 
		$"../left door".visible = false
		$"../telephone".visible = false
		$"../office/Eq".stop()
		$"../camera".visible = false
		$"../GUI/Povorotcm".stop()
		$"../mystery".visible = false
		await get_tree().create_timer(8.00).timeout
		get_tree().change_scene_to_packed(menu)
