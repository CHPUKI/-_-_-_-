extends Node2D

var moveTimer := 0.0
const menu : PackedScene = preload("res://MENUIGRI/menu.tscn")

func _ready() -> void:
	$Timer.timeout.connect(timeout)

func timeout() -> void:
	if Global.foxyProcess < 4:
		if randi_range(1,20) <= Global.AI["foxy"]:
			if moveTimer <= 0.0:
				Global.foxyProcess += 1
				print(Global.foxyProcess)
				if Global.foxyProcess == 4:
					$"../camera/Sprite".play("west hall fo")
					$"../camera/RunningOnDirtPathZjv8Hbed".play()
					await get_tree().create_timer(3.74).timeout
					Global.foxyProcess = 5
	print(Global.foxyProcess)

func _process(delta: float) -> void:
	if moveTimer > 0.0:
		moveTimer -= 60 * delta
		
	if Global.camUp == true:
		moveTimer = randi_range(50,1049)
	
	if Global.foxyProcess == 5:
		if $"../left door".frame == 7:
			Global.foxyProcess = randi_range(0,1)
			$"../camera/DobrynyaOtkryvayteNikogdaNeOtkryvayut".play()
		if $"../left door".frame == 0:
			Global.foxyProcess = 6
			$"../office/Kl".play()
			jumpscare()


func jumpscare() -> void:
	if Global.foxyProcess == 6:
		$"../office".play("jumpscare foxy")
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
		$"../GUI/panel".play_backwards("default")
		$"../camera".visible = false
		$"../mystery".visible = false
		await get_tree().create_timer(8.00).timeout
		get_tree().change_scene_to_packed(menu)
