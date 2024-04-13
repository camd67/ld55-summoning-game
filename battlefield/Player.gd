@tool
extends Node2D

@onready var hurt_area: Area2D = $HurtArea
@onready var player_summons: Node2D = $PlayerSummons
const a_texture = preload("res://summon/a.png")
const d_texture = preload("res://summon/d.png")
const s_texture = preload("res://summon/s.png")

var summon_area = Rect2(0, 0, 400, 600)
const summon_scene := preload("res://summon/summon.tscn")

func _input(event: InputEvent) -> void:
	# We're not a key event, ignore
	if not event is InputEventKey:
		return

	# We're not in our summoning rect, ignore
	var mouse_pos = get_viewport().get_mouse_position()
	if not summon_area.has_point(mouse_pos):
		print("outside summon area %s" % mouse_pos)
		return

	# Only summon if we're a valid key
	if event.is_action_pressed("summon_a"):
		var summon = summon_scene.instantiate() as Summon
		summon.global_position = mouse_pos
		summon.letter_texture = a_texture
		player_summons.add_child(summon)
		GlobalEvent.emit_player_summoned(summon)
	elif event.is_action_pressed("summon_s"):
		var summon = summon_scene.instantiate() as Summon
		summon.global_position = mouse_pos
		summon.letter_texture = s_texture
		player_summons.add_child(summon)
		GlobalEvent.emit_player_summoned(summon)
	elif event.is_action_pressed("summon_d"):
		var summon = summon_scene.instantiate() as Summon
		summon.global_position = mouse_pos
		summon.letter_texture = d_texture
		player_summons.add_child(summon)
		GlobalEvent.emit_player_summoned(summon)


func _draw() -> void:
	if Engine.is_editor_hint():
		draw_rect(summon_area, Color.hex(0x0099b36b))
