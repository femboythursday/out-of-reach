extends Button

func _ready() -> void:
	pressed.connect(_fix_pressed)

func _fix_pressed() -> void:
	PlayerHud.fix_bridge.emit()
