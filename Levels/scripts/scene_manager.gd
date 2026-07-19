extends Node2D
class_name SceneManager

signal fade_out_finished

@onready var world_2d: Node2D = $World2D
@onready var anim: AnimationPlayer = $SceneTransition/AnimationPlayer

var next_scene_path: String

func _ready() -> void:
	anim.play("fade_in")

func transition_to_scene(new_scene: String) -> void:
	next_scene_path = new_scene
	anim.play("fade_out")
	await anim.animation_finished
	finished_fading()

func finished_fading() -> void:
	world_2d.get_child(0).queue_free()
	world_2d.add_child(load(next_scene_path).instantiate())
	fade_out_finished.emit()
	anim.play("fade_in")
