extends PanelContainer
class_name DraggablePanel

enum PanelType {
	INVENTORY,
	CRAFTING,
	BRIDGE,
	END,
	CREDITS
}

@export var panel_type: PanelType
@export var drag_button: Button
@export var close_button: TextureButton

var button_pressed: bool
var previous_mouse_position: Vector2

func _ready() -> void:
	drag_button.button_down.connect(_on_drag_start)
	drag_button.button_up.connect(_on_drag_end)
	close_button.pressed.connect(_close)

func _process(_delta: float) -> void:
	if button_pressed:
		var current_mouse_position: Vector2 = get_viewport().get_mouse_position()
		## the difference between mouse positions
		var mouse_delta: Vector2 = current_mouse_position - previous_mouse_position
		position += mouse_delta
		previous_mouse_position = current_mouse_position

func _on_drag_start() -> void:
	button_pressed = true
	previous_mouse_position = get_viewport().get_mouse_position()

func _on_drag_end() -> void:
	button_pressed = false

func _close() -> void:
	hide()
	match panel_type:
		PanelType.INVENTORY:
			PlayerHud.inventory_hidden.emit()
