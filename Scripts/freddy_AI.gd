extends Node2D

var progression := 0
var  moveTimer := 0.0
const menu : PackedScene = preload("res://MENUIGRI/menu.tscn")

func _ready() -> void:
	$Timer.timeout.connect(timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func timeout() -> void:
	if randi_range(1,20) <= Global.AI["freddy"]:
		if Global.camUp == false:
			progression = 1
			
func _process(delta: float) -> void:
	loweredCam()
	if  progression == 2:
		if Global.freddyPos != "east hall corner":
			move()
		else:
			if Global.camUp == true:
				if Global.currentCamera != "east hall corner":
					move()
					
	elif  progression == 1:
		moveTimer += 60.0 * delta
		
		if moveTimer >= 1000 - (Global.AI["freddy"] * 100):
			moveTimer = 0.0
			progression = 2
	if Global.camUp == true:
		if Global.currentCamera == Global.freddyPos:
			moveTimer = 0.0


func move() -> void:
	progression = 0
	match Global.freddyPos:
		"stage":
			if not Global.bonniePos == "stage" and not Global.chicaPos == "stage":
				if Global.bonniePos == "dining area" or Global.chicaPos =="dining area":
					Global.freddyPos = "stage"
				else:
					Global.freddyPos = "dining area"
		"dining area":
			Global.freddyPos = "kitchen"
		"kitchen":
			Global.freddyPos = "east hall"
		"east hall":
			Global.freddyPos = "east hall corner"
		"east hall corner":
			if Global.rightDoorClosed == true:
				Global.freddyPos = "stage"
			else:
				if Global.camUp == true:
					$"../GUI/panel".play_backwards()
					Global.freddyPos = "office"
					$"../office/HiHiHiHaClashRoyale".play()
				else:
					Global.freddyPos = "office"
					$"../office/HiHiHiHaClashRoyale".play()
	print("freddy " + Global.freddyPos)
	
	
func loweredCam() -> void:
	if Global.freddyPos == "office":
		$"../office".play("jumpscare freddy")
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
