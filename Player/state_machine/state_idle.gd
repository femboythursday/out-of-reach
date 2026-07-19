extends State

@onready var walk: State = $"../Walk"
@onready var chop: State = $"../Chop"

## What happens when the state is initialised
func init() -> void:
	pass

## What happens when player enters state
func enter_state() -> void:
	player.update_animation("idle")

## What happens when player exits state
func exit_state() -> void:
	pass

## What happens during _process in state
func process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	
	return null

## What happens during _physics_process in state
func physics(_delta: float) -> State:
	return null

## What happens with InputEvents in state
func handle_input(_event: InputEvent) -> State:
	if _event.is_action_pressed("use_tool"):
		return chop
		#if player.current_tool == DataTypes.Tools.PICKAXE:
			#return mine
	
	return null
