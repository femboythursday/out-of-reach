extends Node2D
class_name ItemDrop

@export var loot: ItemData
@export var quantity: int = 1

@onready var sprite: Sprite2D = $Sprite2D
@onready var area: Area2D = $Area2D

func _ready() -> void:
	if loot:
		sprite.texture = loot.texture
	area.body_entered.connect(_body_entered)

func _body_entered(b: Node2D) -> void:
	if b is Player:
		GameManager.PLAYER_INV.add_item(loot, quantity)
		queue_free()
