extends StaticBody2D
class_name PineTree

const ITEM_DROP: PackedScene = preload("uid://bah47wcua4pyr")

@export var loot: ItemData = preload("uid://bqs6sbkrakclj")

@onready var hurt_box: HurtBox = $HurtBox

var hp: int = 3

func _ready() -> void:
	hurt_box.damaged.connect(_take_damage)

func _take_damage(hit_box: HitBox) -> void:
	hp -= hit_box.damage
	if hp <= 0:
		var item_drop: ItemDrop = ITEM_DROP.instantiate()
		item_drop.loot = loot
		call_deferred("add_sibling", item_drop)
		item_drop.global_position = global_position + Vector2(randf_range(-16, 16), randf_range(-16, 16))
		queue_free()
