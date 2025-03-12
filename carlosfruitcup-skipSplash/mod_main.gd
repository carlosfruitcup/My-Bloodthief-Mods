extends "res://addons/ModLoader/mod_node.gd"


var skipScenes = ["CanvasLayer", "EpilepsyWarningScreen"]

func init():
	ModLoader.mod_log("Skip Splash loaded")

func _process(_delta: float) -> void:
	if get_tree().current_scene.name in skipScenes:
		GameManager.change_to_non_level_scene("MainScreen")
		ModLoader.mod_log("Skipped " + get_tree().current_scene.name + " gonna disable my self now")
		set_process(false)
		return
