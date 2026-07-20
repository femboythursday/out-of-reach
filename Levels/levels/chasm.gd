extends Node2D

@onready var bridge_block: TileMapLayer = $BridgeBlock

func _ready() -> void:
	PlayerHud.fix_bridge.connect(_remove_block)
	GameManager.start_game_dialogue()

func _remove_block() -> void:
	bridge_block.queue_free()
