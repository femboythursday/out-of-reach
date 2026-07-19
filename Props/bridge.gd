extends StaticBody2D

@onready var broken: NinePatchRect = $Broken
@onready var fixed: NinePatchRect = $Fixed
@onready var blocked_entry: CollisionShape2D = $BlockedEntry
@onready var area: Area2D = $Area2D

var is_broken: bool = true

func _ready() -> void:
	area.area_entered.connect(_area_entered)
	area.area_exited.connect(_area_exited)
	PlayerHud.fix_bridge.connect(fix_bridge)
	broken.show()
	fixed.hide()

func fix_bridge() -> void:
	is_broken = false
	broken.hide()
	fixed.show()
	blocked_entry.disabled = true

func _area_entered(_a: Node2D) -> void:
	GameManager.interact_pressed.connect(_player_interact)

func _area_exited(_a: Node2D) -> void:
	GameManager.interact_pressed.disconnect(_player_interact)

func _player_interact() -> void:
	if !is_broken:
		return
	
	PlayerHud.bridge_panel.show()
