extends Node

signal tilemap_bounds_changed(bounds: Array[Vector2])
signal interact_pressed

const PLAYER_INV: InvData = preload("uid://cwnsslw6xg6hr")

var current_tilemap_bounds: Array[Vector2]

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		interact_pressed.emit()

func change_tilemap_bounds(bounds: Array[Vector2]) -> void:
	current_tilemap_bounds = bounds
	tilemap_bounds_changed.emit(bounds)
