extends StaticBody2D
class_name Crate

#signal looted

@export var loot: ItemData
@export var quantity: int = 1

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var interact_area: Area2D = $InteractArea

var is_full: bool = true

func _ready() -> void:
	interact_area.area_entered.connect(_area_entered)
	interact_area.area_exited.connect(area_exited)

func _area_entered(_a: Node2D) -> void:
	GameManager.interact_pressed.connect(_player_interact)

func area_exited(_a: Node2D) -> void:
	GameManager.interact_pressed.disconnect(_player_interact)

func _player_interact() -> void:
	if !is_full:
		return
	
	is_full = false
	if loot && quantity > 0:
		GameManager.PLAYER_INV.add_item(loot, quantity)
	#looted.emit()
	anim.play("empty")
