@tool
extends Node2D

@onready var enemy_summons: Node2D = $EnemySummons

const summon_j = preload("res://summon/summon_j.tscn")
const summon_k = preload("res://summon/summon_k.tscn")
const summon_l = preload("res://summon/summon_l.tscn")
const summon_rect = Rect2(400, 0, 400, 600)

const summons = [summon_k]


func _ready() -> void:
	if not Engine.is_editor_hint():
		GlobalEvent.player_summoned.connect(on_player_summon)


func on_player_summon(player_summon: Node2D) -> void:
	var summon: Node2D = summons.pick_random().instantiate()
	var player_pos := player_summon.global_position
	var center := Vector2(400, 300)
	var distance_to_mid := center - player_pos
	summon.global_position = center + distance_to_mid
	enemy_summons.add_child(summon)


func _draw() -> void:
	if Engine.is_editor_hint():
		draw_rect(summon_rect, Color.hex(0xb311006b))
		queue_redraw()
