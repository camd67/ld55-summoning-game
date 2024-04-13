@tool
extends Node2D

@onready var hurt_area: Area2D = $HurtArea
@onready var player_summons: Node2D = $PlayerSummons
const a_summon = preload("res://summon/summon_a.tscn")
const s_summon = preload("res://summon/summon_s.tscn")
const summon_d = preload("res://summon/summon_d.tscn")

var summon_area := Rect2(0, 0, 400, 600)

func _input(event: InputEvent) -> void:
	# We're not a key event, ignore
	if not event is InputEventKey:
		return

	# We're not in our summoning rect, ignore
	var mouse_pos := get_viewport().get_mouse_position()
	if not summon_area.has_point(mouse_pos):
		return

	# Only summon if we're a valid key
	if event.is_action_pressed("summon_a"):
		var summon := a_summon.instantiate()
		summon.global_position = mouse_pos
		player_summons.add_child(summon)
		GlobalEvent.emit_player_summoned(summon)
	elif event.is_action_pressed("summon_s"):
		var summon := s_summon.instantiate()
		summon.global_position = mouse_pos
		player_summons.add_child(summon)
		GlobalEvent.emit_player_summoned(summon)
	elif event.is_action_pressed("summon_d"):
		var summon := summon_d.instantiate()
		summon.global_position = mouse_pos
		player_summons.add_child(summon)
		GlobalEvent.emit_player_summoned(summon)


func _draw() -> void:
	if Engine.is_editor_hint():
		draw_rect(summon_area, Color.hex(0x0099b36b))
		queue_redraw()
