extends Resource
class_name ItemData

enum Type {
	MATERIAL
}

@export var name: String
@export var type: Type
@export var texture: Texture2D
