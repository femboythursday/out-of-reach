extends StaticBody2D
class_name Flax

const ITEM_DROP: PackedScene = preload("uid://bah47wcua4pyr")

@export var loot: ItemData = preload("uid://h6p8gouexsos")

@onready var hurt_box: HurtBox = $HurtBox
@onready var baby: Sprite2D = $Baby
@onready var grown: Sprite2D = $Grown
@onready var timer: Timer = $Timer

var hp: int = 1

func _ready() -> void:
	timer.timeout.connect(_grow)
	hurt_box.damaged.connect(_take_damage)
	grown.show()

func _take_damage(hit_box: HitBox) -> void:
	hp -= hit_box.damage
	if hp <= 0:
		harvest()

func growth_timer() -> void:
	timer.start(randf_range(8, 16))

func _grow() -> void:
	grown.show()
	hurt_box.set_deferred("monitorable", true)

func harvest() -> void:
	grown.hide()
	hurt_box.set_deferred("monitorable", false)
	var item_drop: ItemDrop = ITEM_DROP.instantiate()
	item_drop.loot = loot
	call_deferred("add_sibling", item_drop)
	item_drop.global_position = global_position + Vector2(randf_range(-16, 16), randf_range(-16, 16))
	growth_timer()
