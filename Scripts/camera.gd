extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	updateCamera(Global.currentCamera)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func updateCamera(view: String) -> void:
	modulate = Color.html("ffffff")
	match view:
		"stage":
			if Global.freddyPos == "stage":
				if Global.bonniePos == "stage":
					if Global.chicaPos == "stage":
						animation = "stage bcf"
					else:
						animation = "stage bf"
				else:
					if Global.chicaPos == "stage":
						animation = "stage cf"
					else:
						animation = "stage f"
			else:
				animation = "stage"
		"kitchen":
			modulate = Color.html("000000")
		"dining area":
			if Global.chicaPos == "dining area":
				play("dining area c")
			elif Global.freddyPos == "dining area":
				play("dining area f")
			elif Global.bonniePos == "dining area":
				play("dining area b")
			else:
				play("dining area")
		"east hall":
			if Global.chicaPos == "east hall":
				if randi_range(1,1000) <= 10:
					play("east hall c2")
				else:
					play("east hall c")
			elif Global.freddyPos == "east hall":
				play("east hall f")
			else :
				play("east hall")
		"east hall corner":
			if Global.chicaPos == "east hall corner":
				play("east hall corner c")
			elif Global.freddyPos == "east hall corner":
				play("east hall corner f")
			else:
				play("east hall corner")
		"backstage":
			if Global.bonniePos == "backstage":
				play("backstage b")
			else:
				play("backstage")
		"west hall":
			if Global.bonniePos == "west hall":
				play("west hall b")
			else:
				play("west hall")
		"west hall corner":
			if Global.bonniePos == "west hall corner":
				play("west hall corner b")
			else:
				play("west hall corner")
		"closet":
			if Global.bonniePos == "closet":
				play("closet b")
			else:
				play("closet")
		"root":
			if Global.foxyProcess <= 3:
				play(["root","cove f", "cove f2","cove3"][Global.foxyProcess])
			else:
				play("cove3")
		_:
			play(Global.currentCamera)
