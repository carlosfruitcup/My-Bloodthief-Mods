extends Lever

func _ready() -> void:
    Signals.level_restarted.connect(handle_quick_restart)

func handle_quick_restart():
    is_pulled = false

