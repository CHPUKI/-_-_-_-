extends Camera2D

var screenWidth = ProjectSettings.get_setting("display/window/size/viewport_width")

@export var scrollArea : float
@export var scrollSpeed : float
@export var officeSprite : AnimatedSprite2D
@export var scrollDivisions : int


var officeWidth : float
var distance : float
var divisionSize : float
var SpeedMultiplier : float

func _ready() -> void:
	if scrollDivisions == 0:
		scrollDivisions = 1
		divisionSize = scrollArea / scrollDivisions
	if officeSprite:
		officeWidth = officeSprite.sprite_frames.get_frame_texture(&"default", 0).get_width() * officeSprite.scale.x
		position.x = (officeWidth - screenWidth) / 2

func _process(delta: float) -> void:
	if get_local_mouse_position().x < scrollArea:
		distance = scrollArea - get_local_mouse_position().x
		getSpeedMultiplier()
		position.x -= (scrollSpeed * SpeedMultiplier) * delta
	if get_local_mouse_position().x > screenWidth - scrollArea:
		distance = get_local_mouse_position().x - (screenWidth - scrollArea)
		getSpeedMultiplier()
		position.x += (scrollSpeed * SpeedMultiplier) * delta
		
func getSpeedMultiplier() -> void:
	SpeedMultiplier = clamp(floor(distance / divisionSize)+ 1, 1, scrollDivisions)
	SpeedMultiplier /= scrollDivisions
