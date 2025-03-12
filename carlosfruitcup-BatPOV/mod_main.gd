extends "res://addons/ModLoader/mod_node.gd"

var checkpoint_data = {}
var game_paused = false


func init():
	ModLoader.mod_log(name_pretty + " Checkpoint Mod loaded!")

	add_input_event("checkpoint_create", [KEY_Q])
	add_input_event("checkpoint_load", [KEY_E])


func _process(_delta):
	if Input.is_action_just_pressed("checkpoint_create"):
		create_checkpoint()

	elif Input.is_action_just_pressed("checkpoint_load"):
		load_checkpoint()

	if game_paused and has_input():
		resume_game()


func create_checkpoint():
	var player = GameManager.get_player()
	if not player:
		print("Player not Valid")
		return

	checkpoint_data = {
		"global_position": player.global_position,
		"velocity_y": player.velocity_y,
		"velocity": player.velocity,
		"accel": player.accel,
		"blood_amount": player.blood_amount,
		"player_camera": GameManager.get_player_camera(),
		"tick_count": GameManager.tick_count
	}

	ModLoader.mod_log("Checkpoint saved.")


func load_checkpoint():
	var player = GameManager.get_player()
	if not player or checkpoint_data.is_empty():
		print("Player not Valid")
		return

	player.ground_pound_component.disable()

	var checkpoint_variables = {
		"global_position": player.global_position,
		"velocity_y": player.velocity_y,
		"velocity": player.velocity,
		"accel": player.accel,
		"blood_amount": player.blood_amount,
		"direction": GameManager.player_camera,
		"tick_count": GameManager.tick_count,
	}

	for checkpoint_value in checkpoint_variables:
		var game_variable = checkpoint_variables[checkpoint_value]
		game_variable = checkpoint_data[checkpoint_value]
		print(game_variable)
		print(checkpoint_data[checkpoint_value])
		print(checkpoint_value)

	game_paused = true
	get_tree().paused = true

	ModLoader.mod_log("Checkpoint loaded. Press any key to resume.")


func resume_game():
	game_paused = false
	get_tree().paused = false

	ModLoader.mod_log("Game resumed.")


func has_input() -> bool:
	for action in InputMap.get_actions():
		if Input.is_action_pressed(action):
			return true
	return false
