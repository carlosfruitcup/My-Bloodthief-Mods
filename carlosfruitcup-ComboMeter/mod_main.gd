extends "res://addons/ModLoader/mod_node.gd"

var newScript = preload("res://mods-unpacked/carlosfruitcup-ComboMeter/combo.gd")
var allLeversInLevel = []

func init():
	ModLoader.mod_log("Skip Splash loaded")

	Signals.level_loaded.connect(createComboMeter)
	add_to_group("restartable")

func createComboMeter() -> void:
	var comboMeter = Node.new()
	comboMeter.set_script(newScript)
	get_tree().current_scene.add_child(comboMeter)
	comboMeter._ready()


