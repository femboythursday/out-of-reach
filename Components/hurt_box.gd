extends Area2D
class_name HurtBox

signal damaged(hit_box: HitBox)

@export var tool: Player.Tools

func take_damage(hit_box: HitBox) -> void:
	damaged.emit(hit_box)
