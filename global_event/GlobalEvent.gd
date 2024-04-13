extends Node

signal player_summoned(player_summon: Summon)

func emit_player_summoned(player_summon: Summon) -> void:
	player_summoned.emit(player_summon)
