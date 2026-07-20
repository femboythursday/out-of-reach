extends Area2D

func _ready() -> void:
	body_entered.connect(_end_the_game)

func _end_the_game(b: Node2D) -> void:
	if b is Player:
		GameManager.end_game_dialogue()
