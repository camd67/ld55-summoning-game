@tool
extends Node2D

@onready var enemy_summons: Node2D = $EnemySummons

const summon_rect = Rect2(400, 0, 400, 600)
const summon_scene = preload("res://summon/summon.tscn")
const j_texture = preload("res://summon/j.png")
const k_texture = preload("res://summon/k.png")
const l_texture = preload("res://summon/l.png")

func _ready() -> void:
	GlobalEvent.player_summoned.connect(func(player_summon: Summon) -> void:
		var summon = summon_scene.instantiate() as Summon
		var player_pos = player_summon.global_position
		var center = Vector2(400,300)
		var distance_to_mid = center - player_pos
		summon.global_position = center + distance_to_mid
		summon.letter_texture = j_texture
		summon.friendly_to_player = false
		enemy_summons.add_child(summon)
	)

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_rect(summon_rect, Color.hex(0xb311006b))
