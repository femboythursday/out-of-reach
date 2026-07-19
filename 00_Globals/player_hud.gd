extends CanvasLayer

signal inventory_shown
signal inventory_hidden
signal fix_bridge

@onready var menu_button: MenuButton = $Control/MenuButton
@onready var inventory_panel: DraggablePanel = $Control/InventoryPanel
@onready var crafting_panel: DraggablePanel = $Control/CraftingPanel
@onready var bridge_panel: DraggablePanel = $Control/BridgePanel

func _ready() -> void:
	menu_button.get_popup().id_pressed.connect(_menu_item_pressed)
	inventory_panel.hide()
	crafting_panel.hide()
	bridge_panel.hide()

func _menu_item_pressed(id: int) -> void:
	match id:
		0:
			inventory_panel.show()
			inventory_shown.emit()
		1:
			pass
		2: 
			crafting_panel.show()
