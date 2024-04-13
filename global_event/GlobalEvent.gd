extends Node

signal player_summoned(player_summon: Node2D)

func emit_player_summoned(player_summon: Node2D) -> void:
	player_summoned.emit(player_summon)
