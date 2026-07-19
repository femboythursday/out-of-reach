extends State

@onready var idle: State = $"../Idle"
@onready var walk: State = $"../Walk"
@onready var axe: Area2D = $"../../Interactions/Axe"

var chopping: bool

## What happens when the state is initialised
func init() -> void:
	pass

## What happens when player enters state
func enter_state() -> void:
	player.anim.animation_finished.connect(_end_chop)
	player.update_animation("chop")
	chopping = true
	axe.monitoring = true

## What happens when player exits state
func exit_state() -> void:
	player.anim.animation_finished.disconnect(_end_chop)
	chopping = false
	axe.monitoring = false
	player.tool = player.Tools.NONE

## What happens during _process in state
func process(_delta: float) -> State:
	player.velocity = Vector2.ZERO
	if !chopping:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

## What happens during _physics_process in state
func physics(_delta: float) -> State:
	return null

## What happens with InputEvents in state
func handle_input(_event: InputEvent) -> State:
	return null

func _end_chop(_anim: String) -> void:
	chopping = false
