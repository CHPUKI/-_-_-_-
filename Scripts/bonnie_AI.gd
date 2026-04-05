extends Node2D

const menu : PackedScene = preload("res://MENUIGRI/menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.timeout.connect(timeout)

func _process(_delta: float) -> void:
	loweredCam()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func timeout() -> void:
	if randi_range(1,20) <= Global.AI["bonnie"]:
		move()


func move() -> void:
	match Global.bonniePos:
		"stage":
			if Global.chicaPos == "dining area" or Global.bonniePos =="dining area":
				Global.bonniePos = ["backstage", "west hall"].pick_random()
			else:
				Global.bonniePos = "dining area"
		"backstage":
			if Global.chicaPos == "dining area" or Global.bonniePos =="dining area":
				Global.bonniePos = ["west hall","closet"].pick_random()
			else:
				Global.bonniePos = "dining area"
		"dining area":
			Global.bonniePos = ["west hall" , "backstage"].pick_random()
		"west hall":
			Global.bonniePos = ["closet", "west hall corner"].pick_random()
		"closet":
			if Global.chicaPos == "dining area" or Global.bonniePos =="dining area":
				Global.bonniePos = ["west hall corner", "left door"].pick_random()
			else:
				Global.bonniePos = "dining area"
		"west hall corner":
			Global.bonniePos = ["closet", "left door"].pick_random()
		"left door":
			if Global.leftDoorClosed == true:
				Global.bonniePos = "backstage"
			else:
				if Global.camUp == true:
					$"../GUI/panel".play_backwards()
					Global.bonniePos = "office"
					$"../office/Kl".play()
				else:
					Global.bonniePos = "office"
					$"../office/Kl".play()
	print("bonnie " + Global.bonniePos)
	if Global.bonniePos == "left door" and Global.a <2:
		Global.a += 2
	elif Global.bonniePos != "left door":
		Global.a = 0
	else:
		Global.a += 0

func loweredCam() -> void:
	if Global.bonniePos == "office":
		$"../office".play("jumpscare bonnie")
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
