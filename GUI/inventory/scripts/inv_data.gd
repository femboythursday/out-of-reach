extends Resource
class_name InvData

@export var slots: Array[SlotData]

func _init() -> void:
	connect_slots()

func add_item(item: ItemData, count: int = 1) -> bool:
	for s in slots:
		if s:
			if s.item_data == item:
				s.quantity += count
				PlayerHud.inventory_shown.emit()
				print("item added to stack: ", s.item_data.name)
				return true
			elif s.item_data && s.item_data != item:
				continue
			else:
				s.item_data = item
				s.quantity = count
				PlayerHud.inventory_shown.emit()
				print("new item added: ", s.item_data.name)
				return true
		else:
			var new = SlotData.new()
			new.item_data = item
			new.quantity = count
			s = new
			new.changed.connect(slot_changed)
			print("new slot added: ", s.item_data.name)
			return true
	push_error("add_item() failed!")
	return false

func connect_slots() -> void:
	for s in slots:
		if s:
			s.changed.connect(slot_changed)

func slot_changed() -> void:
	for s in slots:
		if s:
			if s.quantity < 1:
				s.changed.disconnect(slot_changed)
				var index = slots.find(s)
				slots[index] = null
				emit_changed()

func use_item(item: ItemData, count: int = 1) -> bool:
	for s in slots:
		if s:
			if s.item_data == item:
				if s.quantity >= count:
					s.quantity -= count
					print(item.name, " removed")
					return true
	print("use_item failed!")
	return false

func remove_item(item: ItemData) -> void:
	for s in slots:
		if s.item_data == item:
			s.quantity -= 1
			print("gay")
