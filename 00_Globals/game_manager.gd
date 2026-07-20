extends Node

signal tilemap_bounds_changed(bounds: Array[Vector2])
signal interact_pressed

const PLAYER_INV: InvData = preload("uid://cwnsslw6xg6hr")
const START = preload("uid://b1cxc80n1r8l3")

var current_tilemap_bounds: Array[Vector2]
var start_dialogue_played: bool = false

func _ready() -> void:
	SproutyDialogs.dialog_ended.connect(_dialog_ended)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		interact_pressed.emit()

func change_tilemap_bounds(bounds: Array[Vector2]) -> void:
	current_tilemap_bounds = bounds
	tilemap_bounds_changed.emit(bounds)

func _dialog_ended() -> void:
	start_dialogue_played = true

func start_game_dialogue() -> void:
	if start_dialogue_played == true:
		return
	SproutyDialogs.start_dialog(START, "0")

func end_game_dialogue() -> void:
	SproutyDialogs.start_dialog(START, "1")
