extends TextureButton

@export var link: String

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	if link == "":
		return
	OS.shell_open(link)
