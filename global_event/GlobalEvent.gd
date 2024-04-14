extends Node

signal player_summoned(player_summon: Node2D)

func emit_player_summoned(player_summon: Node2D) -> void:
	player_summoned.emit(player_summon)


signal game_over(player_won: bool)

func emit_player_won() -> void:
	game_over.emit(true)

func emit_enemy_won() -> void:
	game_over.emit(false)
