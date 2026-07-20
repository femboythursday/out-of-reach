extends Button

func _ready() -> void:
	pressed.connect(_fix_pressed)
	PlayerHud.bridge_can_be_fixed.connect(_enable)
	disabled = true

func _fix_pressed() -> void:
	PlayerHud.fix_bridge.emit()

func _enable() -> void:
	disabled = false
