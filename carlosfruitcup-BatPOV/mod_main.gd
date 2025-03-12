extends "res://addons/ModLoader/mod_node.gd"

var theBat : Node3D
var toggle : bool = false

func init():
	ModLoader.mod_log("Bat POV loaded")
	
	add_input_event("toggleBatPOV",[KEY_TAB])
	
	#Connects to the level loaded signal, which only activates once.
	Signals.level_loaded.connect(look4Bat)

func _input(event: InputEvent) -> void:
	if event.is_action_released("toggleBatPOV"):
		toggle = !toggle

func look4Bat() -> void:
	theBat = null
	add_input_event("toggleBatPOV",[KEY_TAB])
	find(get_tree().current_scene)


func createCamera() -> void:
	var cam = Camera3D.new()
	cam.fov = 120
	cam.physics_interpolation_mode = true
	theBat.add_child(cam)
	cam.current = true


func find(parent):
	for i in parent.get_children():
		print(i.name)
		if i.name == "bat_combined_4_0":
			theBat = i.get_parent().get_parent()
			createCamera()
			print("FOUND")
			break

		find(i)



func _process(_delta: float) -> void:
	if is_instance_valid(theBat):
		if toggle:
			theBat.get_node("Camera3D").current = true 
			GameManager.player.camera.current = false
		else:
			theBat.get_node("Camera3D").current = false 
			GameManager.player.camera.current = true
