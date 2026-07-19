extends Button
class_name InvSlotUI

@onready var item_icon: TextureRect = $ItemIcon
@onready var quantity_label: Label = $QuantityLabel

var slot_data: SlotData: set = set_slot_data

func _ready() -> void:
	item_icon.texture = null
	quantity_label.text = ""

func set_slot_data(value: SlotData) -> void:
	slot_data = value
	if !slot_data.item_data:
		item_icon.texture = null
		quantity_label.text = ""
		return
	
	item_icon.texture = slot_data.item_data.texture
	if slot_data.quantity > 1:
		quantity_label.text = str(slot_data.quantity)
	else:
		quantity_label.text = ""
