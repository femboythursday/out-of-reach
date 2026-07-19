extends Area2D
class_name HitBox

signal did_damage

@export var tool: Player.Tools
@export var damage: int = 1

func _ready() -> void:
	area_entered.connect(_area_entered)

func _area_entered(a: Area2D) -> void:
	if a is HurtBox:
		if a.tool == tool:
			did_damage.emit()
			a.take_damage(self)
