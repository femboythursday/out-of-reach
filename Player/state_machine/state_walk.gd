extends State

@export var walk_speed: float = 50.0

@onready var idle: State = $"../Idle"
@onready var chop: State = $"../Chop"

## What happens when the state is initialised
func init() -> void:
	pass

## What happens when player enters state
func enter_state() -> void:
	player.update_animation("walk")

## What happens when player exits state
func exit_state() -> void:
	pass

## What happens during _process in state
func process(_delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * walk_speed
	if player.set_direction():
		player.update_animation("walk")
	return null

## What happens during _physics_process in state
func physics(_delta: float) -> State:
	return null

## What happens with InputEvents in state
func handle_input(_event: InputEvent) -> State:
	if _event.is_action_pressed("use_tool"):
		return chop
	#if _event.is_action_pressed("use_tool"):
		#if player.current_tool == DataTypes.Tools.PICKAXE:
			#return mine
	
	return null
