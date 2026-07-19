extends TileMapLayer

@export var tile_size: int = 16

func _ready() -> void:
	GameManager.change_tilemap_bounds(get_tilemap_bounds())

func get_tilemap_bounds() -> Array[Vector2]:
	var bounds: Array[Vector2]
	## top left corner
	bounds.append(Vector2(get_used_rect().position * tile_size) + position)
	## bottom right corner
	bounds.append(Vector2(get_used_rect().end * tile_size) + position)
	
	return bounds
