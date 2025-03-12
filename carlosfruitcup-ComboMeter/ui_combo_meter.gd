extends Control
@onready var anim :AnimationPlayer= $Label/AnimationPlayer

func playAdded() -> void:
	anim.play("add")

func playLost() -> void:
	anim.play("lost")
