extends Area2D
class_name LevelTransition

@export_file("*.tscn") var next_scene: String
@export var spawn_location: Vector2

var scene_manager: SceneManager

func _ready() -> void:
	body_entered.connect(_body_entered)
	scene_manager = get_node("/root/SceneManager")

func _body_entered(b: Node2D) -> void:
	if b is Player:
		scene_manager.transition_to_scene(next_scene)
		await scene_manager.fade_out_finished
		Player.main.set_position(spawn_location)
