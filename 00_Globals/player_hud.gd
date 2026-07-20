extends CanvasLayer

signal inventory_shown
signal inventory_hidden
signal bridge_can_be_fixed
signal fix_bridge

@onready var menu_button: MenuButton = $Control/MenuButton
@onready var inventory_panel: DraggablePanel = $Control/InventoryPanel
@onready var crafting_panel: DraggablePanel = $Control/CraftingPanel
@onready var bridge_panel: DraggablePanel = $Control/BridgePanel
@onready var end_panel: DraggablePanel = $Control/EndPanel
@onready var credits_panel: DraggablePanel = $Control/CreditsPanel

func _ready() -> void:
	menu_button.get_popup().id_pressed.connect(_menu_item_pressed)
	inventory_panel.hide()
	crafting_panel.hide()
	bridge_panel.hide()
	end_panel.hide()
	credits_panel.hide()

func _menu_item_pressed(id: int) -> void:
	match id:
		0:
			inventory_panel.show()
			inventory_shown.emit()
		1:
			credits_panel.show()
		2: 
			crafting_panel.show()

func end() -> void:
	get_tree().paused = true
	end_panel.show()
