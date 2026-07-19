extends CharacterBody2D
class_name Player

signal direction_changed

enum Tools {
	NONE,
	AXE
}

const DIR_4: Array = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

static var main: Player
static var inventory: InvData = preload("uid://cwnsslw6xg6hr")

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var state_machine: PlayerStateMachine = $StateMachine

var direction: Vector2
var cardinal_direction: Vector2
var tool: Tools = Tools.NONE

func _ready() -> void:
	main = self
	state_machine.initialise(self)

func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis("walk_left", "walk_right"),
		Input.get_axis("walk_up", "walk_down")
		).normalized()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	var direction_id: int = get_direction_index(direction, cardinal_direction, DIR_4.size())
	var new_dir: Vector2 = DIR_4[direction_id]
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	direction_changed.emit(new_dir)
	return true

func get_direction_index(_dir: Vector2, _cardinal_dir: Vector2, dir_size: int) -> int:
	var direction_bias: float = 0.1
	var angle: float = (direction + cardinal_direction * direction_bias).angle()
	var round_angle: float = angle/TAU
	var dir_index: int = int(round(round_angle * dir_size))
	return dir_index

func update_animation(state: String) -> void:
	anim.play(state + "_" + anim_direction())

func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	elif cardinal_direction == Vector2.LEFT:
		return "left"
	elif cardinal_direction == Vector2.RIGHT:
		return "right"
	else:
		return "down"

func set_player_position(new_pos: Vector2) -> void:
	global_position = new_pos
