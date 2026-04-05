extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.restart == 1:
		Global.restart = 0
		Global.leftDoorClosed=false
		Global.leftLightOn=false
		Global.rightDoorClosed=false
		Global.rightLightOn=false
		Global.camUp=false
		Global.freddyPos = "stage"
		Global.bonniePos = "stage"
		Global.chicaPos = "stage"
		Global.foxyPos = "root"
		Global.currentCamera = "stage"
		Global.disableLight = " "
		Global.foxyProcess = 0
		Global.restart = 0
		Global.usage  = 1.0
		Global.power  = 100.0
		Global.a = 0
		Global.b = 0
		Global.don = 0
		Global.dun = "00"
		Global.dap = " "
		Global.ban = 0
		get_tree().reload_current_scene()
