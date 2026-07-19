extends GridContainer
class_name InvUI

const INV_SLOT: PackedScene = preload("uid://chlepjt2juyx8")

@export var inv_data: InvData

func _ready() -> void:
	PlayerHud.inventory_shown.connect(update_inv)
	PlayerHud.inventory_hidden.connect(clear_inv)
	inv_data.changed.connect(on_inv_changed)
	clear_inv()

func clear_inv() -> void:
	for c in get_children():
		c.queue_free()

func update_inv() -> void:
	clear_inv()
	
	for s in inv_data.slots:
		var new_slot: InvSlotUI = INV_SLOT.instantiate()
		add_child(new_slot)
		new_slot.set_slot_data(s)

func on_inv_changed() -> void:
	update_inv()
