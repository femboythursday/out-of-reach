extends StaticBody2D

@export var plank: ItemData
@export var rope: ItemData

@onready var broken: NinePatchRect = $Broken
@onready var fixed: NinePatchRect = $Fixed
@onready var area: Area2D = $Area2D
@onready var anim: AnimationPlayer = $AnimationPlayer

var is_broken: bool = true

func _ready() -> void:
	area.area_entered.connect(_area_entered)
	area.area_exited.connect(_area_exited)
	PlayerHud.fix_bridge.connect(fix_bridge)
	broken.show()
	fixed.hide()

func fix_bridge() -> void:
	is_broken = false
	broken.hide()
	fixed.show()
	PlayerHud.bridge_panel.queue_free()
	anim.play("fixed")
	Player.inventory.remove_item(plank, 3)
	Player.inventory.remove_item(rope, 3)
	PlayerHud.inventory_shown.emit()

func _area_entered(_a: Node2D) -> void:
	GameManager.interact_pressed.connect(_player_interact)

func _area_exited(_a: Node2D) -> void:
	GameManager.interact_pressed.disconnect(_player_interact)

func _player_interact() -> void:
	if !is_broken:
		return
	
	PlayerHud.bridge_panel.show()
	if Player.inventory.get_held_item_count(plank) >= 3 && Player.inventory.get_held_item_count(rope) >= 3:
		PlayerHud.bridge_can_be_fixed.emit()
