extends "res://addons/ModLoader/mod_node.gd"

var allLeversInLevel = []

func init():
	ModLoader.mod_log("Simple Fixes loaded")

	#Connects to the level loaded signal, which only activates once.
	Signals.level_loaded.connect(getLevers)
	
	
	Signals.level_restarted.connect(handle_quick_restart)


func getLevers() -> void:
	allLeversInLevel = [] #Just to make sure we don't try to access Levers from other maps
	find(get_tree().current_scene)

func handle_quick_restart():
	lever_fix()
	player_water_spawn_fix()

#This bug occurs due to the game setting the Player's state to
#in_air_state for some reason. 

#This fix simply just checks if the Player is in water (is_body_fully_in_water())
#and sets the state correctly with state_machine.change_states()
func player_water_spawn_fix() -> void:
	await GameManager.player #Wait for the Player to fully load in
	
	
	if GameManager.player.is_body_fully_in_water():
		GameManager.player.state_machine.change_states(GameManager.player.in_water_state.name,self)
		GameManager.player.in_water_state.enter("",{})

#This bug occurs due to the game not resetting the Lever's state on restart,
#probably due to this being an unused asset.

#This fix just goes through all the levers in the level (if there are any) and sets 'is_pulled' to false
func lever_fix() -> void:
	for i in allLeversInLevel:
		i.is_pulled = false

#Goes through the children recursively and checks if they're Lever
func find(parent):
	for i in parent.get_children():
		
		if i is Lever:
			allLeversInLevel.append(i)
