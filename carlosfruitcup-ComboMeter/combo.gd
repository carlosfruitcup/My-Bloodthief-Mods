extends Node

var timer : Timer
var combo : int
var high_combo : int

@onready var scene = preload("res://mods-unpacked/carlosfruitcup-ComboMeter/UI_comboMeter.tscn")

var UI : Node
var m_theme : Theme

func _ready():
	Signals.player_hit_enemy.connect(player_hit_enemy)
	Signals.level_restarted.connect(handle_quick_restart)
	GameManager.player.hurt_and_collide_component.taking_damage.connect(player_hurt)

	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(timeout)

	find(GameManager.player.pause_screen_control)
	UI = scene.instantiate()
	add_child(UI)
	UI.get_node("Label").set_theme(m_theme)
	

func find(parent):
	for i in parent.get_children():
		if i.get_theme() != null:
			m_theme = i.get_theme()
			break
			
		find(i)


func player_hit_enemy(_attack: Attack) -> void:
	combo += 1

	#Color() uses 0.0 - 1.0, if you want the 0-255, use Color8()
	UI.get_node("Label").modulate = Color(
		randf_range(0,1),
		randf_range(0,1),
		randf_range(0,1),
		1.0
	)

	if combo > high_combo:
		high_combo = combo


	UI.get_node("Label").text = str(combo)
	UI.playAdded()

	timer.start(5)

func player_hurt(_attack: Attack, _new_health: int):
	resetCombo()

func resetCombo():
	combo = 0
	timer.stop()
	UI.playLost()
	await UI.anim.animation_finished
	UI.get_node("Label").text = ""
	UI.get_node("Label").modulate = Color(
		1.0,
		1.0,
		1.0,
		1.0
	)

func timeout() -> void:
	resetCombo()

func handle_quick_restart():
	resetCombo()

