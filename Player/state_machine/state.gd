extends Node
class_name State

static var player: Player
static var state_machine: PlayerStateMachine

## What happens when the state is initialised
func init() -> void:
	pass

## What happens when player enters state
func enter_state() -> void:
	pass

## What happens when player exits state
func exit_state() -> void:
	pass

## What happens during _process in state
func process(_delta: float) -> State:
	return null

## What happens during _physics_process in state
func physics(_delta: float) -> State:
	return null

## What happens with InputEvents in state
func handle_input(_event: InputEvent) -> State:
	return null
